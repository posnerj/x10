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
import x10.util.concurrent.atomic.AtomicBoolean;

/**
 * Simple test cases for AtomicBoolean API functions.
 */
public class AtomicBooleanTest extends x10Test {

    public def run():Boolean  {
        val ab = new AtomicBoolean(true);

        var success:Boolean = ab.compareAndSet(false, false);
	chk(!success && ab.get() == true); // compareAndSet should have failed, value still true

        success = ab.compareAndSet(true, false);
	chk(success && ab.get() == false); // compareAndSet should have succeeded; value is now false.

        return true;		
    }

    public static def main(Array[String]) {
        new AtomicBooleanTest().execute();
    }
}
