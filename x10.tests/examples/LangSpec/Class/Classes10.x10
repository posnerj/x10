/* Current test harness gets confused by packages, but it would be in package Classes_field_init_expr_a;
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



public class Classes10 extends x10Test {
   public def run() : boolean = (new Hook()).run();
   public static def main(var args: Array[String](1)): void = {
        new Classes10().execute();
    }


// file Classes line 143
 static class Fld{
  val a = 1;
  val b = 2+a;
}

 static class Hook {
   def run():Boolean = true;
}

}