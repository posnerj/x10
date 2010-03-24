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

//LIMITATION: x+y not supported in constraints

import harness.x10Test;

/**
 * @author bdlucas 9/2008
 */

class TypedefConstraint3b extends TypedefTest {

    class A(x:int) {def this(x:int):A{self.x==x} = property(x);}

    public def run(): boolean = {

        type T(x:int,y:int){x==1&&y==-1} = A{self.x==x+y};
        val a:T(1,-1) = new A(0);
        check("a.x", a.x, 0);

        return result;
    }

    public static def main(var args: Rail[String]): void = {
        new TypedefConstraint3b().execute();
    }
}
