// (C) Copyright IBM Corporation 2006-2008.
// This file is part of X10 Language.

package x10.array;

class U {

    public static def pr(s: String): void {
        System.out.println(s);
    }

    public static def xxx(s: String): void {
        System.out.println("xxx " + s);
    }

    public static def where(s: String): void {
        new Exception(s).printStackTrace();
    }

    public static def unsupported(o: Object, op: String): RuntimeException {
        return unsupported(o/*.getClass().getName()*/ + " does not support " + op);
    }

    public static def illegal(): RuntimeException {
        return illegal("illegal operation");
    }

    public static def unsupported(msg: String): RuntimeException {
        return new UnsupportedOperationException(msg);
    }

    public static def illegal(msg: String): RuntimeException {
        return new IllegalOperationException(msg);
    }
}
