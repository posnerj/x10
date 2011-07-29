// (C) Copyright IBM Corporation 2008
// This file is part of X10 Test. *

import harness.x10Test;

/**
 * @author bdlucas 12/2008
 */

class XTENLANG_265 extends x10Test {

    public def run(): boolean = {
            
        val d = Dist.makeUnique();
        ateach (p:Point in d)
            ;

        return true;
    }

    public static def main(Rail[String]) {
        new XTENLANG_265().execute();
    }
}