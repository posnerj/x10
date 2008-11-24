/*
 *
 * (C) Copyright IBM Corporation 2006-2008
 *
 *  This file is part of X10 Language.
 *
 */
package x10.runtime.impl.java;

/**
 * @author Christian Grothoff
 * @author vj
 * @author Raj Barik, Vivek Sarkar
 * @author tardieu
 */
public class Thread extends java.lang.Thread {
	public static Thread currentThread() {
		return (Thread) java.lang.Thread.currentThread();
	}

	private int location;    // the current place
	private Object activity; // the current activity

	/**
	 * Create main x10 thread (called by native runtime only )
	 */ 
	Thread(int location, Runnable runnable, String name) {
		super(runnable, name);
		this.location = location;
	}

	/**
	 * Create additional x10 threads (called by xrx only)
	 */ 
	public Thread(final x10.core.fun.VoidFun_0_0 body, String name) {
		super(new Runnable() { public void run() { body.apply(); } }, name);
		location = currentThread().location;
	}

	/**
	 * Attach activity to thread
	 */ 
	public void activity(Object activity) {
		this.activity = activity;
	}

	/**
	 * Return current activity
	 */ 
	public Object activity() {
		return activity;
	}

	/**
	 * Update thread place (called by native runtime only)
	 */ 
	void location(int location) {
		this.location = location;
	}

	/**
	 * Return current place
	 */ 
	public int location() {
		return location;
	}
}
