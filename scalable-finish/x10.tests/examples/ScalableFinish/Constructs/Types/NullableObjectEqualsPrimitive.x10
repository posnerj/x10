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

 
import x10.util.Box;
/**
 * Checks 3 is an object which can be compared to a nullable
 *
 * @author vcave
 */
public class NullableObjectEqualsPrimitive   {

	public def run(): boolean = {
		var x: Box[Any] = null;
		// This use of == must generate a compiler error
		var res1: boolean = (3).equals(x);
		return !res1;
	}

	public static def main(Rail[String]) {
		new NullableObjectEqualsPrimitive().run ();
	}
}