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

package x10.types;

import polyglot.ast.FlagsNode;
import polyglot.types.Flags;
import polyglot.types.Type;
import polyglot.types.NullType_c;
import polyglot.types.TypeSystem;
import polyglot.util.InternalCompilerError;

/** Every X10 term must have a type. This is the type of the X10 term null.
 * 
 * Note that there is no X10 type called Null; only the term null.
 * 
 * Extends Polyglot's NullType_c with methods necessary for X10Type.
 * @author vj
 *
 */
public class X10NullType_c extends NullType_c implements X10NullType {
    public X10NullType_c( TypeSystem ts ) {super(ts);}
    
    public boolean isSafe() { return true;}
    public boolean isRooted() { return false; }
    public boolean isProto() { return false; }
    public boolean isX10Struct() { return false; }
    public boolean equalsNoFlag(Type t2) { return this == t2; }
    public boolean permitsNull() { return true;}
}