// (C) Copyright IBM Corporation 2006
// This file is part of X10 Test.

import harness.x10Test;

/**
 * A field of a struct can be accessed anywhere.
 * @author vj
 * @author bdlucas
 */

public class FutureFieldAccessStruct extends x10Test {

    struct C[S] {
        property p:int = 0;
        val x:S;
        def foo() {}
        def foo(x:S) {}
        final def foo[T](x:T) {}
        def this(s:S) {
            x = s;
        }
    }

    val c = C[String]("1");

    public def run02(): boolean = {
    		val p = Place.places(1);
    		val cc = this.c;
            val f = future (p) {
            	// cannot access a field that is not global
                val a = cc.x;
            return true;
        };
        return f.force();
    }

    public def run(): boolean {
    	if (Place.MAX_PLACES == 1) {
    		x10.io.Console.OUT.println("not enough places to run this test");
    		return false;
    	}
    	return run02();
	}

    public static def main(Rail[String]) {
        new FutureFieldAccessStruct().execute();
    }
}
