/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2006-2010.
 */

import x10.compiler.tests.*; // err markers
import harness.x10Test;

/**
 * @author bdlucas 10/2008
 */

// OPTIONS: -STATIC_CALLS 

public class XTENLANG_2329(x:Int) extends x10Test  { // see XTENLANG_2329 (Method guards are not type checked on calls to unary operators or closures.)
	@ShouldNotBeERR public operator - this:Int {x==0} = 1; 
	public operator this * (g:XTENLANG_2329) {x==0} = 2;
	public operator this(i:Int) {x==0} = 3;
	public operator this(i:Int) = (j:Int) {x==0}  = 4;

	def test(g1:XTENLANG_2329, g2:XTENLANG_2329) {
		@ShouldBeErr val a = -g1;
		@ERR val b = g1*g2;
		@ERR val c = g1(42);
		@ERR val d = g1(42)=43;
	}
	
	def closureTest(c: (i:Int) {i==0} => Int , k:Int ) {
		@ShouldBeErr val a = c(k);
	}


    public def run()=true;

    public static def main(Array[String](1)) {
        new XTENLANG_2329(5).execute();
    }
}