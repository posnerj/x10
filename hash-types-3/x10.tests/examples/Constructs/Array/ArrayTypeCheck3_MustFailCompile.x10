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

import harness.x10Test;

/**
 * 
 * @author vj
 */
public class ArrayTypeCheck3_MustFailCompile extends x10Test {

    public def run(): boolean = {
        val a1:Array[Int](3)  =  // should be Array[Int](2)
            Array.make[Int](Dist.makeConstant([0..2, 0..3], here), (p(i): Point)=>i);
        return true;
    }

    public static def main(var args: Rail[String]): void = {
        new ArrayTypeCheck3_MustFailCompile().execute();
    }
}
