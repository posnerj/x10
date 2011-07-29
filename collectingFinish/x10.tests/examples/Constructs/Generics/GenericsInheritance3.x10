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
 * Test inheritance and generics.
 *
 * @author nystrom 8/2008
 */
public class GenericsInheritance3 extends x10Test {
        class C implements (int) => int, (String) => int {
                public def apply(x: String): int = { return 0; }
                public def apply(x: int): int = { return 0; }
        }

	public def run(): boolean = {
		return true;
	}

	public static def main(var args: Rail[String]): void = {
		new GenericsInheritance3().execute();
	}
}
