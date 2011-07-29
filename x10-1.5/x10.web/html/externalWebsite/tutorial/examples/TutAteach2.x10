// Multi-place version of TutForeach1.x10
public class TutAteach2 {
    public static void main(String[] args) {
        final int N = 10 * place.MAX_PLACES; // ensure that N is a multiple of MAX_PLACES
        final int[.] A = new int[ dist.factory.block([1:N,1:N]) ] (point [i,j]) { return i+j;} ;

        // For the A[i,j] = F(A[i,j]) case, both loops can execute in parallel 
        finish ateach ( point[i,j] : A.distribution ) A[i,j] = A[i,j] + 1;

        // For the A[i,j] = F(A[i,j-1]) case, only the outer loop can execute in parallel 
        finish ateach ( point[i] : dist.factory.block(A.region.rank(0)) ) 
            for ( point[j] : [(A.region.rank(1).low()+1):A.region.rank(1).high()] ) 
                A[i,j] = A[i,j-1] + 1;

        // For the A[i,j] = F(A[i-1,j]) case, only the inner loop can execute in parallel 
        for (point[i]: [(A.region.rank(0).low()+1):A.region.rank(0).high()] )
	    finish async (A.distribution.get([i,A.region.rank(1).low()])) 
		foreach ( point[j] : A.region.rank(1) ) 
                    A[i,j] = A[i-1,j] + 1;

        // For the A[i,j] = F(A[i-1,j],A[i,j-1]) case, use loop skewing to
        // enable the inner loop to execute in parallel 
        for (point[t] : [4:2*N]) {
            finish foreach (point[j] : [Math.max(2,t-N):Math.min(N,t-2)]) {
                final int i = t - j;
                System.out.print("(" + i + "," + j + ")");
                async (A.distribution.get([i,j])) A[i,j] = A[i-1,j] + A[i,j-1] + 1;
            }
            System.out.println();
        }
    } // main()
} // TutAteach2


/* 

Output:

(2,2)
(3,2)(2,3)
(4,2)(3,3)(2,4)
(5,2)(4,3)(3,4)(2,5)
(6,2)(5,3)(4,4)(3,5)(2,6)
(7,2)(6,3)(5,4)(4,5)(3,6)(2,7)
(8,2)(7,3)(6,4)(5,5)(4,6)(3,7)(2,8)
(9,2)(8,3)(7,4)(6,5)(5,6)(4,7)(3,8)(2,9)
(10,2)(9,3)(8,4)(7,5)(6,6)(5,7)(4,8)(3,9)(2,10)
(11,2)(10,3)(9,4)(8,5)(7,6)(6,7)(5,8)(4,9)(3,10)(2,11)
(12,2)(11,3)(10,4)(9,5)(8,6)(7,7)(6,8)(5,9)(4,10)(3,11)(2,12)
(13,2)(12,3)(11,4)(10,5)(9,6)(8,7)(7,8)(6,9)(5,10)(4,11)(3,12)(2,13)
(14,2)(13,3)(12,4)(11,5)(10,6)(9,7)(8,8)(7,9)(6,10)(5,11)(4,12)(3,13)(2,14)
(15,2)(14,3)(13,4)(12,5)(11,6)(10,7)(9,8)(8,9)(7,10)(6,11)(5,12)(4,13)(3,14)(2,15)
(16,2)(15,3)(14,4)(13,5)(12,6)(11,7)(10,8)(9,9)(8,10)(7,11)(6,12)(5,13)(4,14)(3,15)(2,16)
(17,2)(16,3)(15,4)(14,5)(13,6)(12,7)(11,8)(10,9)(9,10)(8,11)(7,12)(6,13)(5,14)(4,15)(3,16)(2,17)
(18,2)(17,3)(16,4)(15,5)(14,6)(13,7)(12,8)(11,9)(10,10)(9,11)(8,12)(7,13)(6,14)(5,15)(4,16)(3,17)(2,18)
(19,2)(18,3)(17,4)(16,5)(15,6)(14,7)(13,8)(12,9)(11,10)(10,11)(9,12)(8,13)(7,14)(6,15)(5,16)(4,17)(3,18)(2,19)
(20,2)(19,3)(18,4)(17,5)(16,6)(15,7)(14,8)(13,9)(12,10)(11,11)(10,12)(9,13)(8,14)(7,15)(6,16)(5,17)(4,18)(3,19)(2,20)
(21,2)(20,3)(19,4)(18,5)(17,6)(16,7)(15,8)(14,9)(13,10)(12,11)(11,12)(10,13)(9,14)(8,15)(7,16)(6,17)(5,18)(4,19)(3,20)(2,21)
(22,2)(21,3)(20,4)(19,5)(18,6)(17,7)(16,8)(15,9)(14,10)(13,11)(12,12)(11,13)(10,14)(9,15)(8,16)(7,17)(6,18)(5,19)(4,20)(3,21)(2,22)
(23,2)(22,3)(21,4)(20,5)(19,6)(18,7)(17,8)(16,9)(15,10)(14,11)(13,12)(12,13)(11,14)(10,15)(9,16)(8,17)(7,18)(6,19)(5,20)(4,21)(3,22)(2,23)
(24,2)(23,3)(22,4)(21,5)(20,6)(19,7)(18,8)(17,9)(16,10)(15,11)(14,12)(13,13)(12,14)(11,15)(10,16)(9,17)(8,18)(7,19)(6,20)(5,21)(4,22)(3,23)(2,24)
(25,2)(24,3)(23,4)(22,5)(21,6)(20,7)(19,8)(18,9)(17,10)(16,11)(15,12)(14,13)(13,14)(12,15)(11,16)(10,17)(9,18)(8,19)(7,20)(6,21)(5,22)(4,23)(3,24)(2,25)
(26,2)(25,3)(24,4)(23,5)(22,6)(21,7)(20,8)(19,9)(18,10)(17,11)(16,12)(15,13)(14,14)(13,15)(12,16)(11,17)(10,18)(9,19)(8,20)(7,21)(6,22)(5,23)(4,24)(3,25)(2,26)
(27,2)(26,3)(25,4)(24,5)(23,6)(22,7)(21,8)(20,9)(19,10)(18,11)(17,12)(16,13)(15,14)(14,15)(13,16)(12,17)(11,18)(10,19)(9,20)(8,21)(7,22)(6,23)(5,24)(4,25)(3,26)(2,27)
(28,2)(27,3)(26,4)(25,5)(24,6)(23,7)(22,8)(21,9)(20,10)(19,11)(18,12)(17,13)(16,14)(15,15)(14,16)(13,17)(12,18)(11,19)(10,20)(9,21)(8,22)(7,23)(6,24)(5,25)(4,26)(3,27)(2,28)
(29,2)(28,3)(27,4)(26,5)(25,6)(24,7)(23,8)(22,9)(21,10)(20,11)(19,12)(18,13)(17,14)(16,15)(15,16)(14,17)(13,18)(12,19)(11,20)(10,21)(9,22)(8,23)(7,24)(6,25)(5,26)(4,27)(3,28)(2,29)
(30,2)(29,3)(28,4)(27,5)(26,6)(25,7)(24,8)(23,9)(22,10)(21,11)(20,12)(19,13)(18,14)(17,15)(16,16)(15,17)(14,18)(13,19)(11,21)(10,22)(9,23)(8,24)(7,25)(6,26)(5,27)(4,28)(3,29)(2,30)(12,20)
(31,2)(30,3)(29,4)(28,5)(27,6)(26,7)(25,8)(24,9)(23,10)(22,11)(21,12)(20,13)(19,14)(18,15)(17,16)(16,17)(15,18)(14,19)(13,20)(12,21)(11,22)(10,23)(9,24)(8,25)(7,26)(6,27)(5,28)(4,29)(3,30)(2,31)
(32,2)(31,3)(30,4)(29,5)(28,6)(27,7)(26,8)(25,9)(24,10)(23,11)(22,12)(21,13)(20,14)(19,15)(18,16)(17,17)(16,18)(15,19)(14,20)(13,21)(12,22)(11,23)(10,24)(9,25)(8,26)(7,27)(6,28)(5,29)(4,30)(3,31)(2,32)
(33,2)(32,3)(31,4)(30,5)(29,6)(28,7)(27,8)(26,9)(25,10)(24,11)(23,12)(22,13)(21,14)(20,15)(19,16)(18,17)(17,18)(16,19)(15,20)(14,21)(13,22)
(12,23)(11,24)(10,25)(9,26)(8,27)(7,28)(6,29)(5,30)(4,31)(3,32)(2,33)
(34,2)(33,3)(32,4)(31,5)(30,6)(29,7)(28,8)(27,9)(26,10)(25,11)(24,12)(23,13)(22,14)(21,15)(20,16)(19,17)(18,18)(17,19)(16,20)(15,21)(14,22)(13,23)(12,24)(11,25)(10,26)(9,27)(8,28)(7,29)(6,30)(5,31)(4,32)(3,33)(2,34)
(35,2)(34,3)(33,4)(32,5)(31,6)(30,7)(29,8)(28,9)(27,10)(26,11)(25,12)(24,13)(23,14)(22,15)(21,16)(20,17)(19,18)(18,19)(17,20)(16,21)(15,22)(14,23)(13,24)(12,25)(11,26)(10,27)(9,28)(8,29)(7,30)(6,31)(5,32)(4,33)(3,34)(2,35)
(36,2)(35,3)(34,4)(33,5)(32,6)(31,7)(30,8)(29,9)(28,10)(27,11)(26,12)(25,13)(24,14)(23,15)(22,16)(21,17)(20,18)(19,19)(18,20)(17,21)(16,22)(15,23)(14,24)(13,25)(12,26)(11,27)(10,28)(9,29)(8,30)(7,31)(6,32)(5,33)(4,34)(3,35)(2,36)
(37,2)(36,3)(35,4)(34,5)(33,6)(32,7)(31,8)(30,9)(29,10)(28,11)(27,12)(26,13)(25,14)(24,15)(23,16)(22,17)(21,18)(20,19)(19,20)(18,21)(17,22)(16,23)(15,24)(14,25)(13,26)(12,27)(11,28)(10,29)(9,30)(8,31)(7,32)(6,33)(5,34)(4,35)(3,36)(2,37)
(38,2)(37,3)(36,4)(35,5)(34,6)(33,7)(32,8)(31,9)(30,10)(29,11)(28,12)(27,13)(26,14)(25,15)(24,16)(23,17)(22,18)(21,19)(20,20)(19,21)(18,22)(17,23)(16,24)(15,25)(14,26)(13,27)(12,28)(11,29)(10,30)(9,31)(8,32)(7,33)(6,34)(5,35)(4,36)(3,37)(2,38)
(39,2)(38,3)(37,4)(36,5)(35,6)(34,7)(33,8)(32,9)(31,10)(30,11)(28,13)(27,14)(26,15)(25,16)(24,17)(23,18)(22,19)(21,20)(20,21)(19,22)(18,23)(17,24)(16,25)(15,26)(14,27)(13,28)(12,29)(11,30)(10,31)(9,32)(8,33)(7,34)(6,35)(5,36)(4,37)(3,38)(2,39)(29,12)
(40,2)(39,3)(38,4)(37,5)(36,6)(35,7)(34,8)(33,9)(32,10)(31,11)(30,12)(29,13)(28,14)(27,15)(26,16)(25,17)(24,18)(23,19)(22,20)(21,21)(20,22)(19,23)(18,24)(17,25)(16,26)(15,27)(14,28)(13,29)(12,30)(11,31)(10,32)(9,33)(8,34)(7,35)(6,36)(5,37)(4,38)(3,39)(2,40)
(40,3)(39,4)(38,5)(37,6)(36,7)(35,8)(34,9)(33,10)(32,11)(31,12)(30,13)(29,14)(28,15)(27,16)(26,17)(25,18)(24,19)(23,20)(22,21)(21,22)(20,23)(19,24)(18,25)(17,26)(16,27)(15,28)(14,29)(13,30)(12,31)(11,32)(10,33)(9,34)(8,35)(7,36)(6,37)(5,38)(4,39)(3,40)
(40,4)(39,5)(38,6)(37,7)(36,8)(35,9)(34,10)(33,11)(32,12)(31,13)(30,14)(29,15)(28,16)(27,17)(26,18)(25,19)(24,20)(23,21)(22,22)(21,23)(20,24)(19,25)(18,26)(17,27)(16,28)(15,29)(14,30)(13,31)(12,32)(11,33)(10,34)(9,35)(8,36)(7,37)(6,38)(5,39)(4,40)
(40,5)(39,6)(38,7)(37,8)(36,9)(35,10)(34,11)(33,12)(32,13)(31,14)(30,15)(29,16)(28,17)(27,18)(26,19)(25,20)(24,21)(23,22)(22,23)(21,24)(20,25)(19,26)(18,27)(17,28)(16,29)(15,30)(14,31)(13,32)(12,33)(11,34)(10,35)(9,36)(8,37)(7,38)(6,39)(5,40)
(40,6)(39,7)(38,8)(37,9)(36,10)(35,11)(34,12)(33,13)(32,14)(31,15)(30,16)(29,17)(28,18)(27,19)(26,20)(25,21)(24,22)(23,23)(22,24)(21,25)(20,26)(19,27)(18,28)(17,29)(16,30)(15,31)(14,32)(13,33)(12,34)(11,35)(10,36)(9,37)(8,38)(7,39)(6,40)
(40,7)(39,8)(38,9)(37,10)(36,11)(35,12)(34,13)(33,14)(32,15)(31,16)(30,17)(29,18)(28,19)(27,20)(26,21)(25,22)(24,23)(23,24)(22,25)(21,26)(20,27)(19,28)(18,29)(17,30)(16,31)(15,32)(14,33)(13,34)(12,35)(11,36)(10,37)(9,38)(8,39)(7,40)
(40,8)(39,9)(38,10)(37,11)(36,12)(35,13)(34,14)(33,15)(32,16)(31,17)(30,18)(29,19)(28,20)(27,21)(26,22)(25,23)(24,24)(23,25)(22,26)(21,27)(20,28)(19,29)(18,30)(17,31)(16,32)(15,33)(14,34)(13,35)(12,36)(11,37)(10,38)(9,39)(8,40)
(40,9)(39,10)(38,11)(37,12)(36,13)(35,14)(34,15)(33,16)(32,17)(31,18)(30,19)(29,20)(28,21)(27,22)(26,23)(25,24)(24,25)(23,26)(22,27)(21,28)(20,29)(19,30)(18,31)(17,32)(16,33)(15,34)(14,35)(13,36)(12,37)(11,38)(10,39)(9,40)
(40,10)(39,11)(38,12)(37,13)(36,14)(35,15)(34,16)(33,17)(32,18)(31,19)(30,20)(29,21)(28,22)(27,23)(26,24)(25,25)(24,26)(23,27)(22,28)(21,29)(20,30)(19,31)(18,32)(17,33)(16,34)(15,35)(14,36)(13,37)(12,38)(11,39)(10,40)
(40,11)(39,12)(38,13)(37,14)(36,15)(35,16)(34,17)(33,18)(32,19)(31,20)(30,21)(29,22)(28,23)(27,24)(26,25)(25,26)(24,27)(23,28)(22,29)(21,30)(20,31)(19,32)(18,33)(17,34)(16,35)(15,36)(14,37)(13,38)(12,39)(11,40)
(40,12)(39,13)(38,14)(37,15)(36,16)(35,17)(34,18)(33,19)(32,20)(31,21)(30,22)(29,23)(28,24)(27,25)(26,26)(25,27)(24,28)(23,29)(22,30)(21,31)(20,32)(19,33)(18,34)(17,35)(16,36)(15,37)(14,38)(13,39)(12,40)
(40,13)(39,14)(38,15)(37,16)(36,17)(35,18)(34,19)(33,20)(32,21)(31,22)(30,23)(29,24)(28,25)(27,26)(26,27)(25,28)(24,29)(23,30)(22,31)(21,32)(20,33)(19,34)(18,35)(17,36)(16,37)(15,38)(14,39)(13,40)
(40,14)(39,15)(38,16)(37,17)(36,18)(35,19)(34,20)(33,21)(32,22)(31,23)(30,24)(29,25)(28,26)(27,27)(26,28)(25,29)(24,30)(23,31)(22,32)(21,33)(20,34)(19,35)(18,36)(17,37)(16,38)(15,39)(14,40)
(40,15)(39,16)(38,17)(37,18)(36,19)(35,20)(34,21)(33,22)(32,23)(31,24)(30,25)(29,26)(28,27)(27,28)(26,29)(25,30)(24,31)(23,32)(22,33)(21,34)(20,35)(19,36)(18,37)(17,38)(16,39)(15,40)
(40,16)(39,17)(38,18)(37,19)(36,20)(35,21)(34,22)(33,23)(32,24)(31,25)(30,26)(29,27)(28,28)(27,29)(26,30)(25,31)(24,32)(23,33)(22,34)(21,35)(20,36)(19,37)(18,38)(17,39)(16,40)
(40,17)(39,18)(38,19)(37,20)(36,21)(35,22)(34,23)(33,24)(32,25)(31,26)(30,27)(29,28)(28,29)(27,30)(26,31)(24,33)(23,34)(22,35)(21,36)(20,37)(19,38)(25,32)(18,39)(17,40)
(40,18)(39,19)(38,20)(37,21)(36,22)(35,23)(34,24)(33,25)(32,26)(31,27)(30,28)(29,29)(28,30)(27,31)(26,32)(25,33)(24,34)(23,35)(22,36)(21,37)(20,38)(19,39)(18,40)
(40,19)(39,20)(38,21)(37,22)(36,23)(35,24)(34,25)(33,26)(32,27)(31,28)(30,29)(29,30)(28,31)(27,32)(26,33)(25,34)(24,35)(23,36)(22,37)(21,38)(20,39)(19,40)
(40,20)(39,21)(38,22)(37,23)(36,24)(35,25)(34,26)(33,27)(32,28)(31,29)(30,30)(29,31)(28,32)(27,33)(26,34)(25,35)(24,36)(23,37)(22,38)(21,39)(20,40)
(40,21)(39,22)(38,23)(37,24)(36,25)(35,26)(34,27)(33,28)(32,29)(31,30)(30,31)(29,32)(28,33)(27,34)(26,35)(25,36)(24,37)(23,38)(22,39)(21,40)
(40,22)(39,23)(38,24)(37,25)(36,26)(35,27)(34,28)(33,29)(32,30)(31,31)(30,32)(29,33)(28,34)(27,35)(26,36)(25,37)(24,38)(23,39)(22,40)
(40,23)(39,24)(38,25)(37,26)(36,27)(35,28)(34,29)(33,30)(32,31)(31,32)(30,33)(29,34)(28,35)(27,36)(26,37)(25,38)(24,39)(23,40)
(40,24)(39,25)(38,26)(37,27)(36,28)(35,29)(34,30)(33,31)(32,32)(31,33)(30,34)(29,35)(28,36)(27,37)(26,38)(25,39)(24,40)
(40,25)(39,26)(38,27)(37,28)(36,29)(35,30)(34,31)(33,32)(32,33)(31,34)(30,35)(29,36)(28,37)(27,38)(26,39)(25,40)
(40,26)(39,27)(38,28)(37,29)(36,30)(35,31)(34,32)(33,33)(32,34)(31,35)(30,36)(29,37)(28,38)(27,39)(26,40)
(40,27)(39,28)(38,29)(37,30)(36,31)(35,32)(34,33)(33,34)(32,35)(31,36)(30,37)(29,38)(28,39)(27,40)
(40,28)(39,29)(38,30)(37,31)(36,32)(35,33)(34,34)(33,35)(32,36)(31,37)(30,38)(29,39)(28,40)
(40,29)(39,30)(38,31)(37,32)(36,33)(35,34)(34,35)(33,36)(32,37)(31,38)(30,39)(29,40)
(40,30)(39,31)(38,32)(37,33)(36,34)(35,35)(34,36)(33,37)(32,38)(31,39)(30,40)
(40,31)(39,32)(38,33)(37,34)(36,35)(35,36)(34,37)(33,38)(32,39)(31,40)
(40,32)(39,33)(38,34)(37,35)(36,36)(35,37)(34,38)(33,39)(32,40)
(40,33)(39,34)(38,35)(37,36)(36,37)(35,38)(34,39)(33,40)
(40,34)(39,35)(38,36)(37,37)(36,38)(35,39)(34,40)
(40,35)(39,36)(38,37)(37,38)(36,39)(35,40)
(40,36)(39,37)(38,38)(37,39)(36,40)
(40,37)(39,38)(37,40)(38,39)
(40,38)(39,39)(38,40)
(40,39)(39,40)
(40,40)

*/