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

package x10.ast;

import java.util.List;

import polyglot.ast.Node;
import polyglot.ast.Term;
import polyglot.ast.Stmt_c;
import polyglot.types.SemanticException;
import polyglot.types.TypeSystem;
import polyglot.util.Position;
import polyglot.visit.CFGBuilder;
import polyglot.visit.ContextVisitor;
import x10.types.X10Context;

public class Next_c extends Stmt_c implements Next {


    public Next_c(Position p) {
        super(p);
    }

    


    public Term firstChild() {
        // TODO:
        return null;
    }

    public <S> List<S> acceptCFG(CFGBuilder v, List<S> succs) {
        // TODO:
        return succs;
    }
    public Node typeCheck(ContextVisitor tc) throws SemanticException {    	
    	X10Context c = (X10Context) tc.context();
    	if (c.inNonBlockingCode())
    		throw new SemanticException("The next statement cannot be used in nonblocking code.", position());
    	return super.typeCheck(tc);
    }
}
