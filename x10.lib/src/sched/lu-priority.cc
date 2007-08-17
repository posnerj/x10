#include <iostream>
#include <cstdlib>

#include <stdlib.h>
#include <assert.h>
#include <pthread.h>

using namespace std;

/*--------------numerics declarations---------------*/

/*Need to actually match the fortran integer. Assume int for now and
  pray. Google blas dgemm to understand the arguments.  */ 
typedef int Integer;

extern "C" {
void dgemm_(char *TRANSA, char *TRANSB, 
	    Integer *M, Integer *N, Integer *K, 
	    double *ALPHA, double* A, Integer *LDA,
	    double *B, Integer *LDB, 
	    double *BETA, double *C, Integer *LDC);
}

#define DGEMM dgemm_

/*---------------support routines--------------------*/

static double format(double v, int precision){
  int scale=1;
  for(int i=0; i<precision; i++)
    scale *= 10;
  return ((int)(v*scale))*1.0/scale;
}
static int max(int a, int b) {
  return a > b ? a : b;
}
static double max(double a, double b) {
  return a > b ? a : b;
}
static double fabs(double v){
  return  v > 0 ? v : -v;
}
static int min(int a, int b) {
  return a > b ? b : a;
}
static double flops(int n) {
  return ((4.0 *  n - 3.0) *  n - 1.0) * n / 6.0;
}

inline long long nanoTime() {
  struct timespec ts;
  // clock_gettime is POSIX!
  ::clock_gettime(CLOCK_REALTIME, &ts);
  return (long long)(ts.tv_sec * 1000000000LL + ts.tv_nsec);
}


/*--------Dense 2-D block and operations on it-------------*/

class TwoDBlockCyclicArray;

/**
 * A B*B array of doubles, whose top left coordinate is i,j).
 * get/set operate on the local coordinate system, i.e.
 * (i,j) is treated as (0,0).
 * @author VijaySaraswat
 *
 * The data within the blocks is stored in column-major order to
 * reduce the hassle in actually using fortran blas routine
 *
 */
class Block {
public:
  double *A;
  TwoDBlockCyclicArray *const M; //Array of which this block is part
    
  volatile bool ready;
  // counts the number of phases left for this
  // block to finish its processing;
private:
  const int maxCount;
  int count;
public:
  const int I,J, B;
  Block(int sI, int sJ, int sB, TwoDBlockCyclicArray *const sM)
  : I(sI), J(sJ), B(sB), M(sM), maxCount(min(sI,sJ)), ready(false), count(0) {
    A = new double[B*B];
    assert( A != NULL);
  }
  Block(const Block &b) 
    : I(b.I), J(b.J), B(b.B), M(b.M), maxCount(b.maxCount), ready(b.ready), count(0) {
    assert(maxCount == min(I,J));
    A = new double[B*B];
    assert(A != NULL);
    //also copy the data
    for(int i=0; i<B*B; i++)
      A[i] = b.A[i];
  }
  ~Block() { delete [] A; }

  Block *copy() {
    return new Block(*this);
  }
  /*printing in row-major order for laymen like me*/
  void display() {
    //cout<<"I="<<I<<" J="<<J<<endl;
    for(int i=0; i<B; i++) {
      for(int j=0; j<B; j++) {
	cout<<format(A[i+j*B],6) << " ";
      }
      //cout<<endl;;
    }
  }
  void init() {
    for (int i=0; i < B*B; i++)
      A[i] = format(rand()*10.0/RAND_MAX, 4);
    if (I==J) {
      for (int i=0; i < B; i++) 
	A[i+i*B] = format(rand()*20.0/RAND_MAX + 10.0, 4);
    }
  }
  bool step();
    
  void lower(Block *diag) {
    for(int i=0; i<B; i++)
      for(int j=0; j<B; j++) {
	double r = 0.0;
	for(int k=0; k<j; k++)
	  r += get(i,k)*diag->get(k,j);
	negAdd(i,j,r);
	set(i,j,get(i,j)/diag->get(j,j));
      }
  }
  void backSolve(Block *diag) {
    for (int i = 0; i < B; i++) {
      for (int j = 0; j < B; j++) {
	double r = 0.0;
	for (int k = 0; k < i; k++) {
	  r += diag->get(i, k) * get(k, j);
	}
	negAdd(i, j, r);
      }
    }
  }
  void mulsub(Block *left, Block *upper) {
#if 0
    for(int i=0; i<B; i++)
      for(int j=0; j<B; j++) {
	double r=0;
	for(int k=0; k<B; k++)
	  r += left->get(i, k) * upper->get(k, j);
	negAdd(i,j,r);
      }
#else
    double *mA = left->A;
    double *mB = upper->A;
    double *mC = A;

    char transa = 'N', transb = 'N';
    Integer M=B, N=B, K=B;
    double alpha = -1.0;
    Integer lda = B, ldb = B, ldc = B;
    double beta = 1.0;

    DGEMM(&transa, &transb, &M, &N, &K, &alpha, mA, &lda,
	  mB, &ldb, &beta, mC, &ldc);

#endif
  }
  void LU() {
    for (int k = 0; k < B; k++)
      for (int i = k + 1; i < B; i++) {
	set(i,k, get(i,k)/get(k,k));
	double a = get(i,k);
	for(int j=k+1; j<B; j++)
	  negAdd(i,j, a*get(k,j));
      }
  }
  int ord(int i, int j) {
    return i+j*B;
  }
  double get(int i, int j) {
    return A[ord(i,j)];
  }
  void set(int i, int j, double v) {
    A[ord(i,j)] = v;
  }
  void negAdd(int i, int j, double v) {
    A[ord(i,j)] -= v;
  }
  void posAdd(int i, int j, double v) {
    A[ord(i,j)] += v;
  }
};

/*---------2-D block-cyclic array of blocks-------------*/

class TwoDBlockCyclicArray {
public:
  Block **A; /*array of block pointers. Note that we are using a 1-d
	       array of all the blocks. The processor dimension is
	       merged with the per-process data*/ 
  const int px,py, nx,ny,B;
  const int N;

public:
  TwoDBlockCyclicArray(int spx, int spy, int snx, int sny,int sB) 
    : px(spx), py(spy), nx(snx), ny(sny), B(sB), N(spx*snx*sB) {

    assert(px*nx==py*ny);
    A = new Block* [px*py*nx*ny];
    assert(A != NULL);

    int ctr=0;
    for(int pi=0; pi<px; pi++) {
      for(int pj=0; pj<py; pj++) {
	for(int i=0; i<nx; i++) {
	  for(int j=0; j<ny; j++) {
	    A[ctr] = new Block(i*px+pi, j*py+pj, B, this);
	    assert(A[ctr] != NULL);
	    A[ctr]->init();
	    ++ctr;
	  }
	}
      }
    }
  }
  TwoDBlockCyclicArray(const TwoDBlockCyclicArray &arr) 
    : px(arr.px), py(arr.py), nx(arr.nx), ny(arr.ny), B(arr.B), N(arr.N)  {

    assert(px*nx==py*ny);
    A = new Block *[px*py*nx*ny];
    assert(A != NULL);
    int ctr=0;
    for(int pi=0; pi<px; pi++) {
      for(int pj=0; pj<py; pj++) {
	for(int i=0; i<nx; i++) {
	  for(int j=0; j<ny; j++) {
	    A[ctr] = arr.A[ctr]->copy();
	    assert( A[ctr] != NULL );
	    ++ctr;
	  }
	}
      }
    }
  }

  ~TwoDBlockCyclicArray() {
    for(int i=0; i<px*py*nx*ny; i++) {
      delete A[i];
    }
    delete [] A;
  }
    
  void init() {}
  int pord(int i, int j) {
    return i*py+j;
  }
  int lord(int i, int j) {
    return i*ny+j;
  }
  Block *get(int i, int j) {
    return A[pord(i % px, j%py)*nx*ny + lord(i/px,j/py)];
  }

  Block *getLocal(int pi, int pj, int i, int j) {
    return A[pord(pi,pj)*nx*ny + lord(i,j)];
  }
  void set(int i, int j, Block *v) {
    A[pord(i % px, j%py)*nx*ny + lord(i/px,j/py)] = v;
  }

  TwoDBlockCyclicArray *copy() {
    return new TwoDBlockCyclicArray(*this);
  }
    
  void display(const string &msg) {
    cout<<msg<<endl;;
    cout<<"px="<<px<<" py="<<py<<" nx="<<nx<<" ny="<<ny<<" B="<<B<<endl;;

    for(int I=0; I<px*nx; I++) {
      for(int J=0; J<py*ny; J++) {
	get(I,J)->display();
      }
      //cout<<endl;
    }
    cout<<endl;
  }
};

/*------------Definitiomn after necessary forward-declarations---------------*/

/*Try to step through the next ready operation in given priority
  order. An operation is LU, backSolve, lower, or mulSub on a block. */
bool 
Block::step() {
  if(ready) return false;
  if (count == maxCount) {
    if (I==J) { LU(); ready=true; }
    else if (I < J && M->get(I, I)->ready) { backSolve(M->get(I,I)); ready=true; }
    else if(M->get(J, J)->ready) { lower(M->get(J,J)); ready=true; }
    return ready;
  }
  Block *IBuddy = M->get(I, count), *JBuddy = M->get(count,J);
  if (IBuddy->ready && JBuddy->ready) {
    mulsub(IBuddy, JBuddy);
    count++;
    return true;
  }
  return false;
}


/*------------Worker-----------------------*/

/*a thread base class using pthreads*/
class Thread {
protected:
  pthread_t thread_id;
  bool joined; /*multiple joins on same thread are undefined in pthreads*/
public:
  Thread() {
    joined = true; //no actual thread yet.
  }

  virtual void run()=0;

  void join() {
    assert(!joined);
    int res = pthread_join(thread_id, NULL);
    if(res != 0) {
      cerr<<"Could not join thread "<<thread_id<<endl;
    }
    joined = true;
  }
  void start() {
    pthread_attr_t attr;
    pthread_attr_init(&attr); 
    pthread_attr_setscope(&attr, PTHREAD_SCOPE_SYSTEM); 
	 
    int res = pthread_create(&thread_id, 
			     &attr,
			     Thread::start_thread,
			     (void *) this);
    if (res) {cout << "could not create thread"; abort(); }
    joined = false;
  }

  virtual ~Thread() {
    if(!joined) {
      cerr<<"Thread object deleted before being joined! Aborting"<<endl;
      abort();
    }
  }
private:
  static void *start_thread(void *arg) {
    Thread *th = static_cast<Thread *>(arg);
    th->run();
    return NULL;
  }
};

class Worker : public Thread {
public:
  const int pi, pj;
  TwoDBlockCyclicArray * const M;

  Worker(int spi, int spj, TwoDBlockCyclicArray *sM) 
    : pi(spi), pj(spj), M(sM) { }

  void run() {
    const int nx = M->nx;
    const int ny = M->ny;

    Block *lastBlock = M->getLocal(pi, pj, nx-1, ny-1);
    int iStart=0;
    while(!lastBlock->ready) {
      if(iStart+1<nx && iStart+1<ny && M->getLocal(pi, pj, iStart+1, iStart+1)->ready) {
	iStart += 1;
      }
      for (int i=iStart; i < max(nx,ny); i++) {
	bool doneForNow=false;
	for (int k=0; k <= i; k++) {
	  if ( i < nx && k < ny) {
	    Block *block = M->getLocal(pi, pj, i,k);
	    if(block->step()) { doneForNow=true; break; }
	  }
	  if ( k < nx && i < ny) {
	    Block *block = M->getLocal(pi, pj, k,i);
	    if(block->step()) { doneForNow=true; break; }
	  }
	}
	if(doneForNow) break;
      }
    }
  }
};


/*----------------Wrapper class for non-pivoting LU------------------*/

class LU {
public: 
  TwoDBlockCyclicArray *M;

  const int nx,ny,px,py,B;

public:
  /**
     Iterative version, without pivoting.
  */
  LU(int spx, int spy, int snx, int sny, int sB) 
    :  nx(snx), ny(sny), px(spx), py(spy), B(sB) {
    M = new TwoDBlockCyclicArray(px,py,nx,ny,B);
    assert( M != NULL);
  }

  void lu() {
    Thread **workers = new Thread* [px*py];
    assert(workers != NULL);

    for (int i=0; i < px; i++)
      for(int j=0; j<py; j++)
	workers[i*py+j] = new Worker(i, j, M);
  
    for (int i=0; i < px*py; i++) workers[i]->start();
    // run, run, score many runs.
    for (int i=0; i < px*py; i++) {
	workers[i]->join();
	delete workers[i];
    }
    delete [] workers;
  }
  
  bool verify(TwoDBlockCyclicArray *Input) {
    int k;
    /* Initialize test. */
    double max_diff = 0.0;

    /* Find maximum difference between any element of LU and M. */
    for (int i = 0; i < nx * px * B; i++)
      for (int j = 0; j < ny * py * B; j++) {
	const int I = i / B;
	const int J = j / B;
	double v = 0.0;
	for (k = 0; k < i && k <= j; k++) {
	  const int K = k / B;
	  v += M->get(I,K)->get(i%B, k%B) * M->get(K,J)->get(k%B, j%B);
	}
	if (k == i && k <= j) {
	  const int K = k / B;
	  v += M->get(K,J)->get(k%B, j%B);
	}
	double diff = fabs(Input->get(I,J)->get(i%B, j%B) - v);
	max_diff = max(diff, max_diff);
      }

    /* Check maximum difference against threshold. */
    if (max_diff > 0.01)
      return false;
    else
      return true;
  }  
};



int main(int argc, char *argv[]) {
  if (argc != 5) {
    cout<<"Usage: LU N b px py"<<endl;
    return 0;
  }
  const int N = atoi(argv[1]);
  const int B = atoi(argv[2]);
  const int px= atoi(argv[3]);
  const int py= atoi(argv[4]);
  const int nx = N / (px*B), ny = N/(py*B);
  assert (N % (px*B) == 0 && N % (py*B) == 0);

  LU *lu = new LU(px,py,nx,ny,B);

  TwoDBlockCyclicArray *A = lu->M->copy();

//   LU *seqlu = new LU(1,1,1,1,N);
//   for(int i=0; i<N; i++) {
//     for(int j=0; j<N; j++) {
//       int I = i/B, J = j/B;
//       seqlu->M->get(0,0)->set(i,j,lu->M->get(I,J)->get(i%B,j%B));
//     }
//   }

//   lu->M->display(string("Original array"));
//   seqlu->M->display(string("Seq array"));
  
  long long s = nanoTime();
  lu->lu();
  long long t = nanoTime();

//   seqlu->lu();
//   lu->M->display(string("After LU"));
//   seqlu->M->display(string("Seq after LU"));
  
  bool correct = lu->verify(A);

  delete lu;
  delete A;

  cout<<"N="<<N<<" px="<<px<<" py="<<py<<" B="<<B
    <<(correct?" ok":" fail")<<" time="<<(t-s)/1000000<<"ms"
      <<" Rate="<< format(flops(N)/(t-s)*1000, 3)<<"MFLOPS"
      <<endl;
}
