// (C) Copyright IBM Corporation 2008
// This file is part of X10 Test. *

import harness.x10Test;

import x10.compiler.ArithmeticOps;

/**
 * @author bdlucas 8/2008
 */

public class GenericInheritance02 extends GenericTest {

    interface I[T] {
        def m(T):int;
    }

    class A implements I[int], I[String] {
        public def m(int) = 0;
        public def m(String) = 1;
    }

    public def run() = {

        val a = new A();
        check("a.m(0)", a.m(0), 0);
        check("a.m(\"1\")", a.m("1"), 1);
        return result;
    }

    public static def main(var args: Rail[String]): void = {
        new GenericInheritance02().execute();
    }
}
