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

package x10.core.concurrent;

import x10.core.RefI;
import x10.rtt.NamedType;
import x10.rtt.RuntimeType;
import x10.rtt.Type;

public final class AtomicInteger extends java.util.concurrent.atomic.AtomicInteger implements RefI {

	private static final long serialVersionUID = 1L;

	public AtomicInteger(java.lang.System[] $dummy) {
	    super();
	}
	public void $init() {}
	
    public AtomicInteger() {
        super();
    }

    public void $init(int initialValue) {
        // TODO
        set(initialValue);
    }
    
    public AtomicInteger(int initialValue) {
        super(initialValue);
    }
    
    //
    // Runtime type information
    //
    public static final RuntimeType<AtomicInteger> $RTT = new NamedType<AtomicInteger>(
        "x10.util.concurrent.AtomicInteger",
        AtomicInteger.class,
        new x10.rtt.Type[] { x10.rtt.Types.OBJECT }
    );
    public RuntimeType<AtomicInteger> $getRTT() {return $RTT;}
    public Type<?> $getParam(int i) {
        return null;
    }

}
