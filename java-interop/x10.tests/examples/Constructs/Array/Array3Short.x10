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
 * Ensures short arrays are implemented.
 */
public class Array3Short extends x10Test {

    public def run(): boolean = {
        val r = (1..10)*(1..10);
        val ia = new Array[Short](r, (x:Point)=>(0 as Short));
        ia(1, 1) = 42 as Short;
        return (42s == ia(1, 1));
    }

    public static def main(var args: Array[String](1)): void = {
        new Array3Short().execute();
    }
}