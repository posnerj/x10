/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2006-2014.
 *  (C) Copyright Australian National University 2009-2010.
 */

import harness.x10Test;
import x10.util.*;

/**
 * Test operator redefinition.
 * @author mandel
 */

class For12 extends x10Test {

    public operator for(min:Long, max:Long, body:(Long)=>void) {
	for (i in min..max) {
	    body(i);
	}
    }

    public def run() : boolean {
	val cpt = new Cell[Long](0);
	this.for (i:Long in 1, 10) {
	    cpt() = cpt() + 1;
	}
	return (cpt() == 55);
    }

    public static def main(Rail[String]) {
        new For12().execute();
    }
}
