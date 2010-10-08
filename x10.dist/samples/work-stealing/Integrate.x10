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
 * This is an updated implementation of the Integrate program
 * from the samples/tutorial directory to be used with
 * the -WORK_STEALING compiler option.
 * <p>
 * The closure has been inlined for better performance.
 * The computation is repeated 10 times.
 * The iteration time is reported.
 * Variables that need not been saved across context switches
 * have been annotated @Ephemeral.
 */

import x10.compiler.Ephemeral;

public class Integrate { 
  static val epsilon = 1.0e-9;

  public def computeArea(left:double, right:double) {
    return recEval(left, (left*left + 1.0) * left, right, (right*right + 1.0) * right, 0);
  }

  private def recEval(l:double, fl:double, r:double, fr:double, a:double) {
    @Ephemeral val h = (r - l) / 2;
    @Ephemeral val hh = h / 2;
    val c = l + h;
    val fc = (c*c + 1.0) * c;
    val al = (fl + fc) * hh;
    val ar = (fr + fc) * hh;
    val alr = al + ar;
    if (Math.abs(alr - a) < epsilon) return alr;
    val expr1:double;
    val expr2:double;
    finish {
      async { expr1 = recEval(c, fc, r, fr, ar); };
      expr2 = recEval(l, fl, c, fc, al);
    }
    return expr1 + expr2;
  }
 
  public static def main(args:Array[String](1)) {
    val obj = new Integrate();
    val xMax = args.size > 0 ? Int.parse(args(0)) : 10;
    for (var i:Int = 0; i < 10; ++i) {
        val startTime = System.nanoTime();
        val area = obj.computeArea(0, xMax);
        val duration = ((System.nanoTime() - startTime) as Double)/1e9;
        Console.OUT.println("The area of (x*x +1) * x from 0 to "+xMax+" is "+area);
        Console.OUT.printf("Time: %7.3f\n", duration);
    }
  }
}
