/* Current test harness gets confused by packages, but it would be in package functions2_oh_no;
*/

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

 import x10.util.*;

public class Functions50 extends x10Test {
   public def run() : boolean = (new Hook()).run();
   public static def main(var args: Array[String](1)): void = {
        new Functions50().execute();
    }


// file Functions line 206
 static  class Finder {
 static

def find[T](f: (T) => Boolean, xs: List[T], absent:T): T = {
  for (x: T in xs)
    if (f(x)) return x;
  absent
  }
 }

 static class Hook {
   def run():Boolean = true;
}

}