/*
 *
 * (C) Copyright IBM Corporation 2006-2008
 *
 *  This file is part of X10 Language.
 *
 */
/*
 * Created on Oct 5, 2004
 */
package polyglot.ext.x10.ast;

import java.util.List;

import polyglot.ast.Expr;
import polyglot.ast.Node;
import polyglot.ast.Stmt;
import polyglot.ast.Term;
import polyglot.ast.Stmt_c;
import polyglot.ext.x10.types.X10Context;
import polyglot.ext.x10.types.X10NamedType;
import polyglot.ext.x10.types.X10TypeSystem;
import polyglot.types.Context;
import polyglot.types.SemanticException;
import polyglot.types.Type;
import polyglot.types.TypeSystem;
import polyglot.util.CodeWriter;
import polyglot.util.Position;
import polyglot.visit.AscriptionVisitor;
import polyglot.visit.CFGBuilder;
import polyglot.visit.ContextVisitor;
import polyglot.visit.NodeVisitor;
import polyglot.visit.PrettyPrinter;

/**
 * @author Philippe Charles
 * @author vj
 */
public class Atomic_c extends Stmt_c 
implements Atomic {
	
	public Stmt body;
	
	public Atomic_c(Position p, Expr place, Stmt body) {
		super(p);
		this.body = body;
	}
	
	public Atomic_c(Position p) {
		super(p);
	}
	
	/* (non-Javadoc)
	 * @see polyglot.ext.x10.ast.Future#body()
	 */
	public Stmt body() {
		return body;
	}
	
	/** Set the body of the statement. */
	public Atomic body(Stmt body) {
		Atomic_c n = (Atomic_c) copy();
		n.body = body;
		return n;
	}
	/** Reconstruct the statement. */
	protected Atomic reconstruct( Stmt body ) {
		if ( body != this.body ) {
			Atomic_c n = (Atomic_c) copy();
			n.body = body;
			return n;
		}
		
		return this;
	}
	
	/** Visit the children of the statement. */
	public Node visitChildren( NodeVisitor v ) {
		Stmt body = (Stmt) visitChild(this.body, v);
		return reconstruct(body);
	}
	
	/** Type check the statement. */
	public Node typeCheck(ContextVisitor tc) throws SemanticException {		
		/*
		 if (! ts.isSubtype(expr.type(), ts.Object()) ) {
		 throw new SemanticException(
		 "Cannot synchronize on an expression of type \"" +
		 expr.type() + "\".", expr.position());
		 }
		 */
		return this;
	}
	
	public Context enterScope(Context c) {
		X10Context cc = (X10Context) super.enterScope(c);
		 cc = cc.pushAtomicBlock();
		return cc;
		    
	}
	public String toString() {
		return "atomic " + body;
	}
	
	/** Write the statement to an output file. */
	public void prettyPrint(CodeWriter w, PrettyPrinter tr) {
		w.write("atomic ");
		printSubStmt(body, w, tr);
	}
	
	/**
	 * Return the first (sub)term performed when evaluating this
	 * term.
	 */
	public Term firstChild() {
		return body;
	}
	
	/**
	 * Visit this term in evaluation order.
	 */
	public List acceptCFG(CFGBuilder v, List succs) {
		v.push(this).visitCFG(body, this, EXIT);
		return succs;
	}
	
}
