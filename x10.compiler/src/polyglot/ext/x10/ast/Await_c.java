/*
 * Created on Dec 9, 2004
 *
 *
 */
package polyglot.ext.x10.ast;

import java.util.List;

import polyglot.ast.Expr;
import polyglot.ast.Node;
import polyglot.ast.Stmt;
import polyglot.ast.Term;
import polyglot.ext.jl.ast.Stmt_c;
import polyglot.types.SemanticException;
import polyglot.types.TypeSystem;
import polyglot.util.Position;
import polyglot.visit.CFGBuilder;
import polyglot.visit.NodeVisitor;
import polyglot.visit.TypeChecker;

/** The concrete class implementing the X10 construct await (c);
 * TODO: fill out the methods and the passes.
 * Typechecking rules: 
 * (1) expr must be a boolean condition.
 * (2) Can optimize await( true ); to the empty statement.
 * (3) Can optimize await( false ); to the DEADLOCK statement. 
 * (4) Condition must be pure -- its evaluation cannot cause side-effect.
 * (4) Pragmatic restriction in 0.5: Condition should check only a single variable. condition must be pure.
 * @author vj
 *
 * 
 */
public class Await_c extends Stmt_c implements Await {
	Expr expr;

	/**
	 * @param pos
	 */
	public Await_c(Position pos) {
		super(pos);
	}

	public Await_c(Position pos, Expr expr) {
        super( pos );
        this.expr = expr;
    }
	/* (non-Javadoc)
	 * @see polyglot.ast.Term#entry()
	 */
	public Term entry() {
		// TODO Auto-generated method stub
		return expr.entry();
	}

	/* (non-Javadoc)
	 * @see polyglot.ast.Term#acceptCFG(polyglot.visit.CFGBuilder, java.util.List)
	 */
	public List acceptCFG(CFGBuilder v, List succs) {
		v.visitCFG(expr, this);
		return succs;
	}

	/** Return a copy of this node with this.expr equal to the given expr.
	 * @see polyglot.ext.x10.ast.Await#expr(polyglot.ast.Expr)
	 */
	public Await expr( Expr expr ) {
			Await_c n = (Await_c) copy();
			n.expr = expr;
			return n;
	}
	
	  public Node typeCheck(TypeChecker tc) throws SemanticException {
    	TypeSystem ts = tc.typeSystem();
    	
    	/*
    	 if (! ts.isSubtype(expr.type(), ts.Object()) ) {
    	 throw new SemanticException(
    	 "Cannot synchronize on an expression of type \"" +
    	 expr.type() + "\".", expr.position());
    	 }
    	 */
    	return this;
    }


	/** Visit the children of the statement. */
	public Node visitChildren( NodeVisitor v ) {
		Expr expr = (Expr) visitChild(this.expr, v);
		return expr(expr);
	}
}
