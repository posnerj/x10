/*
 *
 * (C) Copyright IBM Corporation 2006-2008
 *
 *  This file is part of X10 Language.
 *
 */
package polyglot.ext.x10.ast;

import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import polyglot.ast.Expr;
import polyglot.ast.Formal;
import polyglot.ast.Node;
import polyglot.ast.Stmt;
import polyglot.ast.Stmt_c;
import polyglot.ast.Term;
import polyglot.ext.x10.types.X10Context;
import polyglot.ext.x10.types.X10MethodDef;
import polyglot.ext.x10.types.X10TypeSystem;
import polyglot.main.Report;
import polyglot.types.Context;
import polyglot.types.Ref;
import polyglot.types.SemanticException;
import polyglot.types.Type;
import polyglot.util.CodeWriter;
import polyglot.util.CollectionUtil;
import polyglot.util.Position;
import polyglot.visit.AscriptionVisitor;
import polyglot.visit.CFGBuilder;
import polyglot.visit.ContextVisitor;
import polyglot.visit.FlowGraph;
import polyglot.visit.NodeVisitor;
import polyglot.visit.PrettyPrinter;
import x10.constraint.XConstraint;
import x10.constraint.XConstraint_c;
import x10.constraint.XFailure;
import x10.constraint.XTerm;
import x10.constraint.XTerms;

/**
 * Created on Oct 5, 2004
 *
 * @author Christian Grothoff
 * @author Philippe Charles
 * @author vj
 */

public class Async_c extends Stmt_c implements Async {

	public Expr place;
	public Stmt body;
	protected List clocks;

	public Async_c(Position pos, Expr place, List clocks, Stmt body) {
		super(pos);
		this.place = place;
		this.clocks = clocks;
		this.body = body;
	}

	public Async_c(Position p) {
		super(p);
	}

	/* (non-Javadoc)
	 * @see polyglot.ext.x10.ast.Future#body()
	 */
	public Stmt body() {
		return body;
	}

	/** Expression */
	public List clocks() {
		return this.clocks;
	}

	/** clock */
	public Clocked clocks(List clocks) {
		Async_c n = (Async_c) copy();
		n.clocks = clocks;
		return n;
	}

	/**
	 * Set the body of the statement.
	 */
	public Async body(Stmt body) {
		Async_c n = (Async_c) copy();
		n.body = body;
		return n;
	}

	/** Get the RemoteActivity's place. */
	public Expr place() {
		return place;
	}

	/** Set the RemoteActivity's place. */
	public RemoteActivityInvocation place(Expr place) {
        if (place != this.place) {
            Async_c n = (Async_c) copy();
            n.place = place;
           return n;
        }
		
		return this;
	}

	/** Reconstruct the statement. */
	protected Async reconstruct(Expr place, List clocks, Stmt body) {
		if (place != this.place || body != this.body || clocks != this.clocks) {
			Async_c n = (Async_c) copy();
			n.place = place;
			n.clocks = clocks;
			n.body = body;
			return n;
		}
		return this;
	}


	/** Visit the children of the statement. */
	public Node visitChildren(NodeVisitor v) {
		Expr place = (Expr) visitChild(this.place, v);
		List clocks = (List) visitList(this.clocks, v);
		Stmt body = (Stmt) visitChild(this.body, v);
		return reconstruct(place, clocks, body);
	}

	/**
	 * The evaluation of place and list of clocks is not in the scope of the async.
	 */
	public Context enterChildScope(Node child, Context c) {
	    if (Report.should_report(TOPICS, 5))
	        Report.report(5, "enter async scope");
	    X10Context xc = (X10Context) c;
	    if (child == this.body) {
	        X10TypeSystem ts = (X10TypeSystem) c.typeSystem();
	        X10MethodDef asyncInstance = (X10MethodDef) ts.asyncCodeInstance(c.inStaticContext());
	        if (xc.currentCode() instanceof X10MethodDef) {
	            X10MethodDef outer = (X10MethodDef) c.currentCode();
	            List<Ref<? extends Type>> capturedTypes = outer.typeParameters();
	            if (!capturedTypes.isEmpty()) {
	                asyncInstance = ((X10MethodDef) asyncInstance.copy());
	                asyncInstance.setTypeParameters(capturedTypes);
	            }
	        }
	        xc = (X10Context) xc.pushCode(asyncInstance);

                /*
	        
	        // Change the place constraint to here==p
	        if (xc == c)
	            xc = (X10Context) xc.pushBlock();

	        XConstraint_c pc = new XConstraint_c();
	        XTerm here = ts.xtypeTranslator().transHere();
	        XTerm there = null;
	        try {
	            if (place != null)
	                there = ts.xtypeTranslator().trans(pc, place, xc);
	            else
	                there = ts.xtypeTranslator().transHere();
	        }
	        catch (SemanticException e) {
	            // The place cannot be represented as a constraint term.
	        }

	        if (there == null)
	            there = pc.genEQV(XTerms.makeFreshName("place"), false);
	        
	        try {
	            pc.addBinding(here, there);
	        }
	        catch (XFailure e) {
	        }
	        
	        xc.setCurrentPlaceConstraint(pc);

                */
	    }
	    return xc;
	}

	public Node typeCheck(ContextVisitor tc) throws SemanticException {
		X10TypeSystem ts = (X10TypeSystem) tc.typeSystem();
		X10NodeFactory nf = (X10NodeFactory) tc.nodeFactory();

		Type placeType = place.type();
		Expr newPlace = place;
		boolean placeIsPlace = ts.isImplicitCastValid(placeType, ts.Place(), tc.context());
		if (! placeIsPlace) {
                        throw new SemanticException(
                            "Place expression of async must be of type \"" +
                            ts.Place() + "\", not \"" + place.type() + "\".",
                            place.position());
		}
		X10Context c = (X10Context) tc.context();
		if (c.inSequentialCode())
			throw new SemanticException("async may not be invoked in sequential code.", position());
			
        for (Iterator i = clocks().iterator(); i.hasNext(); ) {
            Expr tn = (Expr) i.next();
            Type t = tn.type();
            if (! t.isSubtype(ts.Clock(), tc.context())) {
                throw new SemanticException("Type \"" + t + "\" must be x10.lang.clock.",
                    tn.position());
            }
        }

		return (Node) place(newPlace);
	}

	
	public Type childExpectedType(Expr child, AscriptionVisitor av) {
		X10TypeSystem ts = (X10TypeSystem) av.typeSystem();
		if (child == place) {
			return ts.Place();
		}
		return child.type();
	}

	public String toString() {
		return "async (" + place + ") { ... }";
	}

	/** Write the statement to an output file. */
	public void prettyPrint(CodeWriter w, PrettyPrinter tr) {
		w.write("async (");
		printBlock(place, w, tr);
		w.write(") ");
		if (clocks != null && ! clocks.isEmpty()) {
			w.write("clocked (");
			w.begin(0);

			for (Iterator i = clocks.iterator(); i.hasNext(); ) {
			    Formal f = (Formal) i.next();
			    print(f, w, tr);

			    if (i.hasNext()) {
				w.write(",");
				w.allowBreak(0, " ");
			    }
			}

			w.end();
			w.write(")");
			
		}
		printSubStmt(body, w, tr);
	}

	/**
	 * Return the first (sub)term performed when evaluating this
	 * term.
	 */
	public Term firstChild() {
                if (place != null) {
                        return place;
                }
		
		if (clocks() == null || clocks().isEmpty()) {
                        return body;
		} else {
                        return (Term) clocks().get(0);
		}
	}

	 

	/**
	 * Visit this term in evaluation order.
	 * [IP] Treat this as a conditional to make sure the following
	 *      statements are always reachable.
	 * FIXME: We should really build our own CFG, push a new context,
	 * and disallow uses of "continue", "break", etc. in asyncs.
	 */
	public List acceptCFG(CFGBuilder v, List succs) {
		
                if (place != null) {
                    v.visitCFG(place, FlowGraph.EDGE_KEY_TRUE, body,
                                      ENTRY, FlowGraph.EDGE_KEY_FALSE, this, EXIT);
                }
		
		if (clocks() == null || clocks().isEmpty()) {
			v.visitCFG(body, this, EXIT);
		} else {
			v.visitCFGList(clocks, body, ENTRY);
			v.visitCFG(body, this, EXIT);
		}
		
		return succs;
	}

	private static final Collection TOPICS =
		CollectionUtil.list(Report.types, Report.context);
}
