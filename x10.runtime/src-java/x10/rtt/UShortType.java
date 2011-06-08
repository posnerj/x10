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

package x10.rtt;


public class UShortType extends RuntimeType<x10.core.UShort> {

    private static final long serialVersionUID = 1L;

    // make sure deserialized RTT object is not duplicated
    private Object readResolve() throws java.io.ObjectStreamException {
        return Types.USHORT;
    }

    public UShortType() {
        super(x10.core.UShort.class,
            new Type[] {
                new ParameterizedType(Types.COMPARABLE, UnresolvedType.THIS),
        		new ParameterizedType(x10.lang.Arithmetic.$RTT, UnresolvedType.THIS),
        		new ParameterizedType(x10.lang.Bitwise.$RTT, UnresolvedType.THIS),
        		new ParameterizedType(x10.util.Ordered.$RTT, UnresolvedType.THIS),
                Types.STRUCT
            });
    }
    
    @Override
    public String typeName() {
        return "x10.lang.UShort";
    }

    // for shortcut 
    @Override
    public boolean instanceof$(Object o) {
        return o instanceof x10.core.UShort;
    }
    
    @Override
    public Object makeArray(int length) {
        return new short[length];
    }
    
    @Override
    public Object makeArray(Object... elem) {
        short[] arr = new short[elem.length];
        for (int i = 0; i < elem.length; i++) {
            arr[i] = ((Number)elem[i]).shortValue();
        }
        return arr;
    }
    
    @Override
    public x10.core.UShort getArray(Object array, int i) {
        return x10.core.UShort.$box(((short[]) array)[i]);
    }
    
//    @Override
//    public x10.core.UShort setArray(Object array, int i, x10.core.UShort v) {
//        // avoid boxing again
//        ((int[]) array)[i] = x10.core.UShort.$unbox(v);
//        return v;
//    }
    @Override
    public void setArray(Object array, int i, x10.core.UShort v) {
        ((short[]) array)[i] = x10.core.UShort.$unbox(v);
    }
    
    @Override
    public int arrayLength(Object array) {
    	return ((short[]) array).length;
    }
    
}