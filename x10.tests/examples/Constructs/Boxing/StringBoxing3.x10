/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2011.
 */

import harness.x10Test;

/**
 * Test Array[UInt]
 *
 * @author Salikh Zakirov 5/2011
 */
public class StringBoxing3 extends x10Test {

    static def makefun[X](a:Object): ()=>X = {
	() => a as X
    }

    static def makefun2[X](): (Object)=>X = {
	(a:Object) => a as X
    }

    public def run(): boolean = {
	val fs = makefun[String]("This is a string1");
	Console.OUT.println(fs());
	val fs2 = makefun2[String]();
       	Console.OUT.println(fs2("This is a string2"));
	return true;
    }

    public static def main(Array[String]) {
        new StringBoxing3().execute();
    }
}
