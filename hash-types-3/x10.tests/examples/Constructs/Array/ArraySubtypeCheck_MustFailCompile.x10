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
 */
public class ArraySubtypeCheck_MustFailCompile extends x10Test {

    class Sup {}

    class Sub extends Sup {}
    
    public def run(): boolean = {
        val R:Region = 0..3;
        var subarr00: Array[Sub] = Array.make[Sub](R->here, (Point)=>null as Sub);
        var suparr00: Array[Sup] = subarr00;
        return true;
    }

    public static def main(var args: Rail[String]): void = {
        new ArraySubtypeCheck_MustFailCompile().execute();
    }
}
