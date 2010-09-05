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

package x10.io;

import x10.util.Builder;
import x10.compiler.Pinned;
import x10.compiler.Global;

public class ByteWriter[T] /*extends Writer*/ {
	val root = GlobalRef[ByteWriter[T]](this);
    transient val b:Builder[Byte,T];

    public def this(b: Builder[Byte,T]) { this.b = b; }

    @Global public def write(x: Byte): Void { 
    	if (here == root.home) {
    		val me = (root as GlobalRef[ByteWriter[T]]{self.home==here})();
     	   me.b.add(x); 
     	   return;
    	}
    	at (root) {
    		val me = (root as GlobalRef[ByteWriter[T]]{self.home==here})();
    	   me.b.add(x); 
    	}
    }
    @Global public incomplete def size() : Long;
    @Global public safe def toString():String { 
      if (here == root.home) 
          return (root as GlobalRef[ByteWriter[T]]{self.home==here})().toString();
      return root.toString();
    }
    @Global public def result() {
    	if (here == root.home) {
    		val me = (root as GlobalRef[ByteWriter[T]]{self.home==here})();
     	   return me.b.result();
    	}
    	return at (root) {
    	   val me = (root as GlobalRef[ByteWriter[T]]{self.home==here})();
    	   me.b.result()
    	};
    }
    @Global public def flush(): Void { }
    @Global public def close(): Void { }
}

