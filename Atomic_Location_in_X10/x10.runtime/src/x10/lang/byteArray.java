package x10.lang;


/** The class of all multidimensional, distributed int arrays in X10. Has no mutable data.
 * Specialized from array by replacing the type parameter with int.
 
 * Handtranslated from the X10 code in x10/lang/ByteArray.x10
 * 
 * @author vj 12/24/2004
 */

import java.util.Iterator;

abstract public class byteArray /*( distribution distribution )*/ 
/*implements Cloneable, Serializable */
implements Indexable, Unsafe {

	public final dist distribution;
	/*parameter*/ public final /*nat*/int rank /*= distribution.rank*/;
	/*parameter*/ public final region/*(rank)*/ region /*= distribution.region*/;
	
	protected byteArray( dist D) {
		this.distribution = D;
		this.region = D.region;
		this.rank = D.rank;
	}
	
	public static interface binaryOp {
        int apply(byte r, byte s);
	}
	public static final binaryOp sub = new binaryOp() { public int apply(byte r, byte s) { return r-s;}};
	public static final binaryOp add = new binaryOp() { public int apply(byte r, byte s) { return r+s;}};
	public static final binaryOp mul = new binaryOp() { public int apply(byte r, byte s) { return r*s;}};
	public static final binaryOp div = new binaryOp() { public int apply(byte r, byte s) { return r/s;}};
	public static final binaryOp max = new binaryOp() { public int apply(byte r, byte s) { return Math.max(r,s);}};
	public static interface unaryOp {
		int apply(byte r);
	}
	public static final unaryOp abs = new unaryOp() { public int apply(byte r) { return Math.abs(r);}};
	
	public static interface pointwiseOp/*(region r)*/ {
		byte apply(point/*(r)*/ p);
	}
	
	abstract public static /*value*/ class factory {
		/** Return the unique int value array initialized with 0 
		 * and defined over the distribution 0..k-1 -> here.
		 * 
		 * @param k
		 * @return
		 */
		public byteArray byteValueArray( /*nat*/ int k) {
			return byteValueArray(k, (byte) 0);
		}
		/** Return the unique int value array initialized with initVal 
		 * and defined over the distribution 0..k-1 -> here.
		 * 
		 * @param k
		 * @return
		 */
		public byteArray/*(:rank=1)*/  byteValueArray(/*nat*/ int k, byte initVal) { 
			return byteValueArray(x10.lang.dist.factory.local(k), initVal);
		}
		/** Return the unique int value array initialized with init 
		 * and defined over the distribution 0..k-1 -> here.
		 * 
		 * @param k
		 * @return
		 */
		public byteArray/*(:rank=1)*/ byteValueArray(/*nat*/ int k, pointwiseOp init) {
			return byteValueArray( x10.lang.dist.factory.local(k), init);
		}
		
		abstract public 
		/*(distribution D)*/ byteArray/*(D)*/ byteValueArray(dist D, byte init);
		abstract public 
		/*(distribution D)*/ byteArray/*(D)*/ byteValueArray( dist D, 
				pointwiseOp/*(D.region)*/ init);
		/** Return the unique int value array initialized with 0 
		 * and defined over the distribution 0..k-1 -> here.
		 * 
		 * @param k
		 * @return
		 */
		public ByteReferenceArray ByteReferenceArray( /*nat*/ int k) {
			return ByteReferenceArray(k, (byte) 0);
		}
		/** Return the unique int value array initialized with initVal 
		 * and defined over the distribution 0..k-1 -> here.
		 * 
		 * @param k
		 * @return
		 */
		public ByteReferenceArray/*(:rank=1)*/  ByteReferenceArray(/*nat*/ int k, byte initVal) { 
			return ByteReferenceArray(x10.lang.dist.factory.local(k), initVal);
		}
		/** Return the unique int value array initialized with init 
		 * and defined over the distribution 0..k-1 -> here.
		 * 
		 * @param k
		 * @return
		 */
		public ByteReferenceArray/*(:rank=1)*/ ByteReferenceArray(/*nat*/ int k, pointwiseOp init) {
			return ByteReferenceArray( x10.lang.dist.factory.local(k), init);
		}
		
		public ByteReferenceArray ByteReferenceArray( dist D) {
			return ByteReferenceArray( D, (byte) 0);
		}
		abstract public 
		/*(distribution D)*/ ByteReferenceArray/*(D)*/ ByteReferenceArray(dist D, byte init);
		abstract public 
		/*(distribution D)*/ ByteReferenceArray/*(D)*/ ByteReferenceArray( dist D, 
				pointwiseOp/*(D.region)*/ init);
	}
	public static final factory factory = Runtime.factory.getByteArrayFactory();
	
	/** Return the value of the array at the given point in the
	 * region.
	 */
	abstract public byte get(point/*(region)*/ p);
	abstract /*value*/ public byte get(int p);
	abstract /*value*/ public byte get(int p, int q);
	abstract /*value*/ public byte get(int p, int q, int r);
	abstract /*value*/ public byte get(int p, int q, int r, int s);
    abstract public byte get(int[] p);
    
    /** Convenience method for returning the sum of the array.
     * @return sum of the array.
     */
	public int sum() {
		return reduce(add, (byte) 0);
	}
	/**
	 * Convenience method for returning the max of the array.
	 * @return
	 */
	public int max() {
		return reduce(max, (byte) 0);
	}
	/**
	 * Convenience method for returning the max of the array after applying the given fun.
	 * @param fun
	 * @return
	 */
	public int max(unaryOp fun) {
		return lift(fun).reduce(max, (byte) 0);
	}
	/**
	 * Convenience method for applying abs to each element in the array.
	 * @return
	 */
	public ByteReferenceArray abs() {
		return lift(abs);
	}
	
	/**
	 * Convenience method for subtracting another array pointwise.
	 * @return
	 */
	public ByteReferenceArray sub( byteArray s) {
		return lift(sub, s);
	}
	/**
	 * Convenience method for subtracting another array pointwise.
	 * @return
	 */
	public ByteReferenceArray add( byteArray s) {
		return lift(add, s);
	}
	/**
	 * Convenience method for subtracting another array pointwise.
	 * @return
	 */
	public ByteReferenceArray mul( byteArray s) {
		return lift(mul, s);
	}
	/**
	 * Convenience method for subtracting another array pointwise.
	 * @return
	 */
	public ByteReferenceArray div( byteArray s) {
		return lift(div, s);
	}
	
	/**
	 * Convenience method for applying max after applying abs.
	 * @return
	 */
	public int maxAbs() {
		return max(abs);
	}
    
	/** Return the value obtained by reducing the given array with the
	 function fun, which is assumed to be associative and
	 commutative. unit should satisfy fun(unit,x)=x=fun(x,unit).
	 */
	abstract public int reduce(binaryOp fun, byte unit);
	
	/** Return a ByteArray with the same distribution as this, by 
	 scanning this with the function fun, and unit unit.
	 */
	abstract public ByteReferenceArray/*(distribution)*/ scan(binaryOp fun, byte unit);
	
	/** Return an array of B@P defined on the intersection of the
	 region underlying the array and the parameter region R.
	 */
	abstract public /*(region(rank) R)*/
	ByteReferenceArray/*(distribution.restriction(R)())*/  restriction(region R);
	
	/** Return an array of B@P defined on the intersection of 
	 the region underlying this and the parametric distribution.
	 */    
	public  /*(distribution(:rank=this.rank) D)*/ 
	ByteReferenceArray/*(distribution.restriction(D.region)())*/ restriction(dist D) {
	 return restriction(D.region);
	}
	
	/** Take as parameter a distribution D of the same rank as *
	 * this, and defined over a disjoint region. Take as argument an *
	 * array other over D. Return an array whose distribution is the
	 * union of this and D and which takes on the value
	 * this.atValue(p) for p in this.region and other.atValue(p) for p
	 * in other.region.
	 */
	abstract public /*(distribution(:region.disjoint(this.region) && rank=this.rank) D)*/
	ByteReferenceArray/*(distribution.union(other.distribution))*/ union( byteArray other);
	
	/** Return the array obtained by overlaying this array on top of
	 other. The method takes as parameter a distribution D over the
	 same rank. It returns an array over the distribution
	 dist.asymmetricUnion(D).
	 */
	abstract public /*(distribution(:rank=this.rank) D)*/
	ByteReferenceArray/*(distribution.asymmetricUnion(D))*/ overlay( byteArray/*(D)*/ other);
	
	/** Update this array in place by overlaying the array other on top of this. The distribution
	 * of the input array must be a subdistribution of D.
	 * TODO: update the description of the parametric type.
	 */
    abstract public void update( byteArray/*(D)*/ other);
    
	/** Assume given a ByteArray a over the given distribution.
	 * Assume given a function f: byte -> byte -> byte.
	 * Return a ByteArray with distribution dist 
	 * containing fun(this.atValue(p),a.atValue(p)) for each p in
	 * dist.region.
	 */
	abstract public 
	ByteReferenceArray/*(distribution)*/ lift(binaryOp fun, byteArray/*(distribution)*/ a);
	abstract public 
	ByteReferenceArray/*(distribution)*/ lift(unaryOp fun);
	
	/**
	 * Return an immutable copy of this array. Note: The implementation actually returns a copy
	 * at the representation of the X10 type x10.lang.byteValueArray, which is byteArray.
	 * @return an immutable version of this array.
	 */
	abstract public byteArray toValueArray();
	
	public Iterator iterator() {
	 	return region.iterator();
	 }
	public dist toDistribution() {
		return distribution;
	}
}