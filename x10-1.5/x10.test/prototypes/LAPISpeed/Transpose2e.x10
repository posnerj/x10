public class Transpose2e {


   final static int INIT_PHASE = 0;
   final static int TRANSPOSE_PHASE=1;
   final static int STARTUP_PHASE=2;
   final static int TOTAL_TIME=3;
   final static int ARRAY_CONSTRUCTION=4;
   final static int NUM_TIMERS=5;
   final static double A_BILLION = 1000000000.0;

   final static long _totalTime[];
   final static long _startTimer[];

   // Write optimistic equivalent to global arrays--goal is
   // to have global arrays eventually end up in this form
   final static java.lang.Object  _srcMatrix[];
   final static java.lang.Object  _destMatrix[];
   // maintain P * Q global arrays, each mapped to a single place
   // keep an array of global arrays so we can access them
   private boolean _debug;
   final private int _x;
   final private int _y;
   final private int _P;
   final private int _Q;
   final int[] _transposeMap;// keep a local copy at each place
   final int _numBlocks;
   final int _numBlocksPerPlace;
   
   static {
     _totalTime = new long[NUM_TIMERS];
     _startTimer = new long[NUM_TIMERS];
     _srcMatrix = new java.lang.Object[place.MAX_PLACES];
     _destMatrix = new java.lang.Object[place.MAX_PLACES];
  }
   static void startTimer(int PhaseID){
      _startTimer[PhaseID] = System.nanoTime();
   }

   static void stopTimer(int PhaseID){
      long stop = System.nanoTime();
      _totalTime[PhaseID] += stop - _startTimer[PhaseID];
   }
 static void reportTimes(int iterCount){
      System.out.println("Startup time:"+(_totalTime[STARTUP_PHASE]/A_BILLION));
      System.out.println("Array construction time:"+(_totalTime[ARRAY_CONSTRUCTION]/A_BILLION));
      System.out.println("Initialization time:"+(_totalTime[INIT_PHASE]/A_BILLION));
      System.out.println("Total Transpose time:"+(_totalTime[TRANSPOSE_PHASE]/A_BILLION));
      System.out.println("Average Transpose time:"+(_totalTime[TRANSPOSE_PHASE]/(iterCount*A_BILLION)));
      System.out.println("Elapsed time:"+(_totalTime[TOTAL_TIME]/A_BILLION));
   }
 
   // a simplified example of array transpose.  Assumes number of places is even.
   // each place represents one row of matrix elements.  Entire blocks will be exchanged, and then
   // transposed remotely.  
   // Each block is x by y elements, and there are P by Q blocks--this constitutes the matrix layout
   // that is, each block is
   //
   // (0,0), (0,1), ..., (0,x-1)
   // (1,0), (1,1), ..., (1,x-1)
   //         ...
   // (y-1,0),(y-1,1),..,(y-1,x-1)
   //
   // Note that (y-1,1) = (y-1)*x + 1
   //
   // and the blocks are ordered and places mapped sequentially:
   //
   // 0,               1,         2, ...,     Q-1
   // Q,             Q+1,       Q+2, ...,   2*Q-1
   // 2*Q,         2*Q+1,     2*Q+2, ....,  3*Q-1
   //  .              .          .             .
   //  .              .          .             .
   // (P-1)*Q, (P-1)*Q+1, (P-1)*Q+2, ..., (P*Q)-1
//
   // It's assumed that blocks are not split between places
   // The inter-place communication will swap entire blocks, and then the
   // receiving place will transpose the block itself
   // the places are transposed and end up as:
   // 0 ,            1,    2,  ... , (P-1)
   // P ,          P+1,  P+2,  ... , 2*P-1,
   // 2*P,         2*P+1,  ...,  ... , 3P-1
   //     ...
   // (Q-1)*P, (Q-1)*P+1,  ...,      , (Q*P)-1

   // so a single dimension mapping array is constructed and used to
   // determine the destination of a given block e.g.
   // if there is a 8x8 (P=Q=8) grid (64 places), place 10 (places are zero based)
   // would correspond to index 10 (8+2) would map to place(2*8+1) = 17

  // Program constructs an array of target places
    public static void main(String[] args) {
       
        int dimX,dimY,blockP,blockQ;
        dimX=dimY=blockP=blockQ=0;
        boolean debug = false;

        int N=10;

        startTimer(STARTUP_PHASE);
        startTimer(TOTAL_TIME);
        for (int i = 0; i < args.length; ++i) {
            if (args[i].charAt(0) == '-') {
                if (args[i].equals("-debug")) {
                    debug = true;
                }
                else if (args[i].equals("-P")) {
	            blockP = java.lang.Integer.parseInt(args[++i]);
                }
                else if (args[i].equals("-Q")) {
                    blockQ = java.lang.Integer.parseInt(args[++i]);
                }
                else if (args[i].equals("-x")) {
                    dimX = java.lang.Integer.parseInt(args[++i]);
                }
                else if (args[i].equals("-y")) {
                    dimY = java.lang.Integer.parseInt(args[++i]);
                }
                else if (args[i].equals("-N")) {
                    N = java.lang.Integer.parseInt(args[++i]);
                }
                
            } else {
                System.out.println("Usage: -x <numElements> -y <numElements> -P <blockSize> -Q <blockSize>");
                x10.lang.Runtime.setExitCode(99);
                return;
            }
          }	
          if(!checkVal(dimX,"-x <size>")) return;
          if(!checkVal(dimY,"-y <size>")) return;
          if(!checkVal(blockQ,"-Q <size>")) return;
          if(!checkVal(blockP,"-P <size>")) return;

          
          System.out.println("block sizes:"+dimX+" x "+dimY+" block distribution:"+
                              blockP+"x"+blockQ+"="+(blockP*blockQ)+" iteration count:"+N+" num Places:"+place.MAX_PLACES);

          Transpose2e trans = new Transpose2e(dimX,dimY,blockP,blockQ,debug);

          stopTimer(STARTUP_PHASE);
	
	  for(int i=0;i < N;++i){
	    trans.initialize();
            trans.transpose();
          }

          stopTimer(TOTAL_TIME);
          if (debug){
            trans.dumpSrc();
            trans.dumpDest();
          }
	  reportTimes(N);
	    
        }

   void swapAndTranspose(final int destIndex,int srcIndex){

       long srcArray[] = (long []) _srcMatrix[srcIndex];
     
       if(_debug) System.out.println("Moving Block "+srcIndex+" to "+destIndex);
       // special knowledge: entire row is allocated to a place
       if(destIndex == srcIndex){//special case of diagonal--don't bother with the async
         long destArray[] = (long []) _destMatrix[destIndex];
         transposeBlock(destArray,srcArray);
       }
       else {
         // src block is read only--can do an asynchronous send
         final long[] copyBlock = srcArray;
	 x10.runtime.Place[] placeArray = x10.lang.Runtime.places();
         place destPlace = placeArray[destIndex];

         async(destPlace){
                    
            long destArray[] = (long []) _destMatrix[destIndex];
            if(_debug) System.out.println("Transposing block "+destIndex);
	    transposeBlock(destArray,copyBlock);
         }
      }
   }   
   public Transpose2e(int x, int y, int P, int Q,boolean debug){
       _debug = debug;
     	_x = x;
	_y = y;
	_P = P;
	_Q = Q;
        _numBlocks = P*Q;
        final int elementArraySize = _x * _y;
        _numBlocksPerPlace = _numBlocks/place.MAX_PLACES;

	startTimer(ARRAY_CONSTRUCTION);
         place cur_place = place.FIRST_PLACE;
          finish do {
             if(_debug) System.out.println("Launching constructor at "+cur_place.id);
             async(cur_place){
               int placeId = here.id;
	       _srcMatrix[placeId] = (java.lang.Object)(new long[elementArraySize]);
	       _destMatrix[placeId] = (java.lang.Object)(new long[elementArraySize]);
             }
             cur_place = cur_place.next();
          }while(cur_place != place.FIRST_PLACE);
        stopTimer(ARRAY_CONSTRUCTION);
        //verify we're zero based
        if(place.FIRST_PLACE.id != 0){
           throw new RuntimeException("placeid not zero based");
        }
        _transposeMap = new int[_numBlocks];
              
        for(int i = 0;i <P;++i)
          for(int j = 0; j<Q;++j){
            _transposeMap[i*Q+j] = j*P + i;
            //System.out.println("["+i+","+j+"] "+(i*Q+j)+"=>"+(j*P+i));
	  }
     }

    public Transpose2e(){ //default required for multivm
       // these stmts will be tossed
         _numBlocksPerPlace=_numBlocks=_x=_y=_P=_Q = 0;
         _transposeMap = new int [1];
    }


    public void initialize(){
         startTimer(INIT_PHASE);
         place cur_place = place.FIRST_PLACE;
          finish do {
             if(_debug) System.out.println("Launching init at "+cur_place.id);
             async(cur_place){
               int placeId = here.id;
            
	       long [] srcArray = (long [])_srcMatrix[here.id];
               for(int i = 0;i < _x;++i)
                 for(int j = 0; j < _y;++j){
                   int calculatedOffset = i*_y +j;
                   srcArray[calculatedOffset] = 1000*placeId + i*100 + j;
                 }
             }
             cur_place = cur_place.next();
          }while(cur_place != place.FIRST_PLACE);
          stopTimer(INIT_PHASE);
     }

    
    // these blocks are x * y elements big
    //
    void transposeBlock(final long[] destArray,final long[] srcBlock){
     for(int i = 0; i < _x;++i)
       for(int j = 0; j < _y;++j){
          final int calculatedSrcOffset = i*_y +j;
          final int calculatedDestOffset = j*_x+i;
          destArray[calculatedDestOffset] = srcBlock[calculatedSrcOffset];
        }
      
    }

     public void transpose(){
         startTimer(TRANSPOSE_PHASE);

          place cur_place = place.FIRST_PLACE;
          finish do {
             final int placeId = cur_place.id;
	     final long start = System.nanoTime();
             async(cur_place){
                long localStart = System.nanoTime();
                // because of my blocking factor, I know all blocks for this
        	// place are allocated contiguously
                int startIndex = placeId * _numBlocksPerPlace;
                int stopIndex = startIndex + _numBlocksPerPlace;
                if(stopIndex > _numBlocks) stopIndex=_numBlocks;
                for(int srcBlockIndex=startIndex;srcBlockIndex < stopIndex;++srcBlockIndex){
                   final int destinationBlockIndex = _transposeMap[srcBlockIndex];
                   swapAndTranspose(destinationBlockIndex,srcBlockIndex);
		}
	        long localStop = System.nanoTime();
		long elapsed =localStop - start;
	        long localElapsed = localStop - localStart; 
		if(false)System.out.println("Elapsed time for "+here.id+"    :"+(localElapsed/A_BILLION)+" total:"+(elapsed/A_BILLION));
             }
           
           cur_place = cur_place.next();
          }while(cur_place != place.FIRST_PLACE);

        stopTimer(TRANSPOSE_PHASE);
      
	}

    public void dumpSrc(){
       place cur_place = place.FIRST_PLACE;
       System.out.println("Dumping source array");
       do {
          finish async(cur_place){
            System.out.println("Dumping src block "+here.id);
            dumpBlock((long[])_srcMatrix[here.id],_x,_y);
          }
          cur_place = cur_place.next();
       }while(cur_place != place.FIRST_PLACE);
    }

    public void dumpDest(){
       System.out.println("Dumping dest array");
       place cur_place = place.FIRST_PLACE;
       do {
          finish async(cur_place){
            System.out.println("Dumping destination block "+here.id);
            dumpBlock((long [])_destMatrix[here.id],_y,_x);
          }
          cur_place = cur_place.next();
       }while(cur_place != place.FIRST_PLACE);
    }
    void dumpBlock(long[] block,int colSize,int rowSize){
        String blockRow;
        for(int i = 0;i < colSize;++i){
          blockRow = "row "+i+": ";
         
          for(int j = 0;j < rowSize;++j){
            blockRow += block[i*rowSize+j] + "   ";
          }
          System.out.println(blockRow);
        }
        System.out.println("");
    }

     public static boolean checkVal(int val,String msg){
        if(val <= 0){
          System.out.println("Invalid value "+val+" for "+msg);
          x10.lang.Runtime.setExitCode(99);
	  return false;
        }
        return true;
      }
  }