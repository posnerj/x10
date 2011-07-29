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

 

/**
 * Simple unsigned test.
 */
public class Unsigned4_MustFailCompile   {

    public def run(): boolean = {
        var a: int = 0;
        var b: uint = 1u;
        val c = a < b;
        return c;
    }

    public static def main(Rail[String]) = {
        new Unsigned4_MustFailCompile().run ();
    }
}