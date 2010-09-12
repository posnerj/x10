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

package x10.lang;

import x10.compiler.Native;
import x10.compiler.NativeRep;
import x10.util.Ordered;

/**
 * UShort is a 16-bit unsigned integral data type, with
 * values ranging from 0 to 65535, inclusive.  All of the normal
 * arithmetic and bitwise operations are defined on UShort, and UShort
 * is closed under those operations.  There are also static methods
 * that define conversions from other data types, including String,
 * as well as some UShort constants.
 */
// @NativeRep("java", "short", null, "x10.rtt.Types.USHORT")
@NativeRep("c++", "x10_ushort", "x10_ushort", null)
public final struct UShort /*TODO implements Arithmetic[UShort], Bitwise[UShort], Ordered[UShort]*/ {

    /** The actual number with Short representation */
    public val shortVal:Short;
    public def this(value:Short) {
        this.shortVal = value;
    }

    /**
     * A less-than operator.
     * Compares the given UShort with another UShort and returns true if the given UShort is
     * strictly less than the other UShort.
     * @param x the given UShort
     * @param y the other UShort
     * @return true if the given UShort is strictly less than the other UShort.
     */
    // @Native("java", "x10.core.Unsigned.lt(#1, #2)")
    @Native("c++",  "((#1) < (#2))")
    public static safe operator (x:UShort) < (y:UShort): Boolean {
         return (x.shortVal + Short.MIN_VALUE) < (y.shortVal + Short.MIN_VALUE);
     }

    /**
     * A greater-than operator.
     * Compares the given UShort with another UShort and returns true if the given UShort is
     * strictly greater than the other UShort.
     * @param x the given UShort
     * @param y the other UShort
     * @return true if the given UShort is strictly greater than the other UShort.
     */
    // @Native("java", "x10.core.Unsigned.gt(#1, #2)")
    @Native("c++",  "((#1) > (#2))")
    public static safe operator (x:UShort) > (y:UShort): Boolean {
        return (x.shortVal + Short.MIN_VALUE) > (y.shortVal + Short.MIN_VALUE);
    }

    /**
     * A less-than-or-equal-to operator.
     * Compares the given UShort with another UShort and returns true if the given UShort is
     * less than or equal to the other UShort.
     * @param x the given UShort
     * @param y the other UShort
     * @return true if the given UShort is less than or equal to the other UShort.
     */
    // @Native("java", "x10.core.Unsigned.le(#1, #2)")
    @Native("c++",  "((#1) <= (#2))")
    public static safe operator (x:UShort) <= (y:UShort): Boolean {
         return (x.shortVal + Short.MIN_VALUE) <= (y.shortVal + Short.MIN_VALUE);
     }

    /**
     * A greater-than-or-equal-to operator.
     * Compares the given UShort with another UShort and returns true if the given UShort is
     * greater than or equal to the other UShort.
     * @param x the given UShort
     * @param y the other UShort
     * @return true if the given UShort is greater than or equal to the other UShort.
     */
    // @Native("java", "x10.core.Unsigned.ge(#1, #2)")
    @Native("c++",  "((#1) >= (#2))")
    public static safe operator (x:UShort) >= (y:UShort): Boolean {
        return (x.shortVal + Short.MIN_VALUE) >= (y.shortVal + Short.MIN_VALUE);
    }


    /**
     * A binary plus operator.
     * Computes the result of the addition of the two operands.
     * Overflows result in truncating the high bits.
     * @param x the given UShort
     * @param y the other UShort
     * @return the sum of the given UShort and the other UShort.
     */
    // @Native("java", "((short) ((#1) + (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) + (#2)))")
    public static safe operator (x:UShort) + (y:UShort): UShort = UShort(x.shortVal + y.shortVal);
    /**
     * A binary plus operator (unsigned disambiguation).
     * @see #operator(UShort)+(UShort)
     */
    // @Native("java", "((short) ((#1) + (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) + (#2)))")
    public static safe operator (x:UShort) + (y:Short): UShort = UShort(x.shortVal + y);
    /**
     * A binary plus operator (unsigned disambiguation).
     * @see #operator(UShort)+(UShort)
     */
    // @Native("java", "((short) ((#1) + (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) + (#2)))")
    public static safe operator (x:Short) + (y:UShort): UShort = UShort(x + y.shortVal);

    /**
     * A binary minus operator.
     * Computes the result of the subtraction of the two operands.
     * Overflows result in truncating the high bits.
     * @param x the given UShort
     * @param y the other UShort
     * @return the difference of the given UShort and the other UShort.
     */
    // @Native("java", "((short) ((#1) - (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) - (#2)))")
    public static safe operator (x:UShort) - (y:UShort): UShort = UShort(x.shortVal - y.shortVal);
    /**
     * A binary minus operator (unsigned disambiguation).
     * @see #operator(UShort)-(UShort)
     */
    // @Native("java", "((short) ((#1) - (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) - (#2)))")
    public static safe operator (x:Short) - (y:UShort): UShort = UShort(x - y.shortVal);
    /**
     * A binary minus operator (unsigned disambiguation).
     * @see #operator(UShort)-(UShort)
     */
    // @Native("java", "((short) ((#1) - (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) - (#2)))")
    public static safe operator (x:UShort) - (y:Short): UShort = UShort(x.shortVal - y);

    /**
     * A binary multiply operator.
     * Computes the result of the multiplication of the two operands.
     * Overflows result in truncating the high bits.
     * @param x the given UShort
     * @param y the other UShort
     * @return the product of the given UShort and the other UShort.
     */
    // @Native("java", "((short) ((#1) * (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) * (#2)))")
    public static safe operator (x:UShort) * (y:UShort): UShort = UShort(x.shortVal * y.shortVal);
    /**
     * A binary multiply operator (unsigned disambiguation).
     * @see #operator(UShort)*(UShort)
     */
    // @Native("java", "((short) ((#1) * (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) * (#2)))")
    public static safe operator (x:Short) * (y:UShort): UShort = UShort(x * y.shortVal);
    /**
     * A binary multiply operator (unsigned disambiguation).
     * @see #operator(UShort)*(UShort)
     */
    // @Native("java", "((short) ((#1) * (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) * (#2)))")
    public static safe operator (x:UShort) * (y:Short): UShort = UShort(x.shortVal * y);

    /**
     * A binary divide operator.
     * Computes the result of the division of the two operands.
     * @param x the given UShort
     * @param y the other UShort
     * @return the quotient of the given UShort and the other UShort.
     */
    // @Native("java", "((short) x10.core.Unsigned.div(#1, #2))")
    @Native("c++",  "((x10_ushort) ((#1) / (#2)))")
    public static safe operator (x:UShort) / (y:UShort): UShort {
        return UShort(((x.shortVal as Long) / (y.shortVal as Long)) as Short);
    }
    /**
     * A binary divide operator (unsigned disambiguation).
     * @see #operator(UShort)/(UShort)
     */
    // @Native("java", "((short) x10.core.Unsigned.div(#1, #2))")
    @Native("c++",  "((x10_ushort) ((#1) / (#2)))")
    public static safe operator (x:Short) / (y:UShort): UShort {
        return UShort(((x as Long) / (y.shortVal as Long)) as Short);
    }
    /**
     * A binary divide operator (unsigned disambiguation).
     * @see #operator(UShort)/(UShort)
     */
    // @Native("java", "((short) x10.core.Unsigned.div(#1, #2))")
    @Native("c++",  "((x10_ushort) ((#1) / (#2)))")
    public static safe operator (x:UShort) / (y:Short): UShort {
        return UShort(((x.shortVal as Long) / (y as Long)) as Short);
    }

    /**
     * A binary remainder operator.
     * Computes a remainder from the division of the two operands.
     * @param x the given UShort
     * @param y the other UShort
     * @return the remainder from dividing the given UShort by the other UShort.
     */
    // @Native("java", "((short) x10.core.Unsigned.rem(#1, #2))")
    @Native("c++",  "((x10_ushort) ((#1) % (#2)))")
    public static safe operator (x:UShort) % (y:UShort): UShort {
        return UShort(((x.shortVal as Long) % (y.shortVal as Long)) as Short);
    }
    /**
     * A binary remainder operator (unsigned disambiguation).
     * @see #operator(UShort)%(UShort)
     */
    // @Native("java", "((short) x10.core.Unsigned.rem(#1, #2))")
    @Native("c++",  "((x10_ushort) ((#1) % (#2)))")
    public static safe operator (x:Short) % (y:UShort): UShort {
        return UShort(((x as Long) % (y.shortVal as Long)) as Short);
    }
    /**
     * A binary remainder operator (unsigned disambiguation).
     * @see #operator(UShort)%(UShort)
     */
    // @Native("java", "((short) x10.core.Unsigned.rem(#1, #2))")
    @Native("c++",  "((x10_ushort) ((#1) % (#2)))")
    public static safe operator (x:UShort) % (y:Short): UShort {
        return UShort(((x.shortVal as Long) % (y as Long)) as Short);
    }

    /**
     * A unary plus operator.
     * A no-op.
     * @param x the given UShort
     * @return the value of the given UShort.
     */
    // @Native("java", "((short) +(#1))")
    @Native("c++",  "((x10_ushort) +(#1))")
    public static safe operator + (x:UShort): UShort = x;

    /**
     * A unary minus operator.
     * Computes the two's complement of the operand.
     * Overflows result in truncating the high bits.
     * @param x the given UShort
     * @return the two's complement of the given UShort.
     */
    // @Native("java", "((short) -(#1))")
    @Native("c++",  "((x10_ushort) -(#1))")
    public static safe operator - (x:UShort): UShort = UShort(-(x.shortVal));


    /**
     * A bitwise and operator.
     * Computes a bitwise AND of the two operands.
     * @param x the given UShort
     * @param y the other UShort
     * @return the bitwise AND of the given UShort and the other UShort.
     */
    // @Native("java", "((short) ((#1) & (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) & (#2)))")
    public static safe operator (x:UShort) & (y:UShort): UShort = UShort(x.shortVal & y.shortVal);
    /**
     * A bitwise and operator (unsigned disambiguation).
     * @see #operator(UShort)&(UShort)
     */
    // @Native("java", "((short) ((#1) & (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) & (#2)))")
    public static safe operator (x:Short) & (y:UShort): UShort = UShort(x & y.shortVal);
    /**
     * A bitwise and operator (unsigned disambiguation).
     * @see #operator(UShort)&(UShort)
     */
    // @Native("java", "((short) ((#1) & (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) & (#2)))")
    public static safe operator (x:UShort) & (y:Short): UShort = UShort(x.shortVal & y);

    /**
     * A bitwise or operator.
     * Computes a bitwise OR of the two operands.
     * @param x the given UShort
     * @param y the other UShort
     * @return the bitwise OR of the given UShort and the other UShort.
     */
    // @Native("java", "((short) ((#1) | (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) | (#2)))")
    public static safe operator (x:UShort) | (y:UShort): UShort = UShort(x.shortVal | y.shortVal);
    /**
     * A bitwise or operator (unsigned disambiguation).
     * @see #operator(UShort)|(UShort)
     */
    // @Native("java", "((short) ((#1) | (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) | (#2)))")
    public static safe operator (x:Short) | (y:UShort): UShort = UShort(x | y.shortVal);
    /**
     * A bitwise or operator (unsigned disambiguation).
     * @see #operator(UShort)|(UShort)
     */
    // @Native("java", "((short) ((#1) | (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) | (#2)))")
    public static safe operator (x:UShort) | (y:Short): UShort = UShort(x.shortVal | y);

    /**
     * A bitwise xor operator.
     * Computes a bitwise XOR of the two operands.
     * @param x the given UShort
     * @param y the other UShort
     * @return the bitwise XOR of the given UShort and the other UShort.
     */
    // @Native("java", "((short) ((#1) ^ (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) ^ (#2)))")
    public static safe operator (x:UShort) ^ (y:UShort): UShort = UShort(x.shortVal ^ y.shortVal);
    /**
     * A bitwise xor operator (unsigned disambiguation).
     * @see #operator(UShort)^(UShort)
     */
    // @Native("java", "((short) ((#1) ^ (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) ^ (#2)))")
    public static safe operator (x:Short) ^ (y:UShort): UShort = UShort(x ^ y.shortVal);
    /**
     * A bitwise xor operator (unsigned disambiguation).
     * @see #operator(UShort)^(UShort)
     */
    // @Native("java", "((short) ((#1) ^ (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) ^ (#2)))")
    public static safe operator (x:UShort) ^ (y:Short): UShort = UShort(x.shortVal ^ y);

    /**
     * A bitwise left shift operator.
     * Computes the value of the left-hand operand shifted left by the value of the right-hand operand.
     * If the right-hand operand is negative, the results are undefined.
     * @param x the given UShort
     * @param count the shift count
     * @return the given UShort shifted left by count.
     */
    // @Native("java", "((short) ((#1) << (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) << (#2)))")
    public static safe operator (x:UShort) << (count:Int): UShort = UShort(x.shortVal << count);

    /**
     * A bitwise right shift operator.
     * Computes the value of the left-hand operand shifted right by the value of the right-hand operand,
     * filling the high bits with zeros.
     * If the right-hand operand is negative, the results are undefined.
     * @param x the given UShort
     * @param count the shift count
     * @return the given UShort shifted right by count.
     */
    // @Native("java", "((short) ((#1) >>> (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) >> (#2)))")
    public static safe operator (x:UShort) >> (count:Int): UShort = UShort(x.shortVal >>> count);

    /**
     * A bitwise logical right shift operator (zero-fill).
     * Computes the value of the left-hand operand shifted right by the value of the right-hand operand,
     * filling the high bits with zeros.
     * If the right-hand operand is negative, the results are undefined.
     * @deprecated use the right-shift operator.
     * @param x the given UShort
     * @param count the shift count
     * @return the given UShort shifted right by count with high bits zero-filled.
     */
    // @Native("java", "((short) ((#1) >>> (#2)))")
    @Native("c++",  "((x10_ushort) ((#1) >> (#2)))")
    public static safe operator (x:UShort) >>> (count:Int): UShort = UShort(x.shortVal >>> count);

    /**
     * A bitwise complement operator.
     * Computes a bitwise complement (NOT) of the operand.
     * @param x the given UShort
     * @return the bitwise complement of the given UShort.
     */
    // @Native("java", "((short) ~(#1))")
    @Native("c++",  "((x10_ushort) ~(#1))")
    public static safe operator ~ (x:UShort): UShort = UShort(~(x.shortVal));


    /**
     * Coerce a given UByte to a UShort.
     * @param x the given UByte
     * @return the given UByte converted to a UShort.
     */
    // @Native("java", "((short) ((#1) & 0xff))")
    @Native("c++",  "((x10_ushort) (#1))")
    public static safe operator (x:UByte): UShort = UShort(x.byteVal & 0xff as Short);

    /**
     * Convert a given UInt to a UShort.
     * @param x the given UInt
     * @return the given UInt converted to a UShort.
     */
    // @Native("java", "((short) (#1))")
    @Native("c++",  "((x10_ushort) (#1))")
    public static safe operator (x:UInt) as UShort = UShort(x.intVal as Short);

    /**
     * Convert a given ULong to a UShort.
     * @param x the given ULong
     * @return the given ULong converted to a UShort.
     */
    // @Native("java", "((short)(long)(#1))")
    @Native("c++",  "((x10_ushort) (#1))")
    public static safe operator (x:ULong) as UShort = UShort(x.longVal as Short);


    /**
     * Coerce a given Byte to a UShort.
     * @param x the given Byte
     * @return the given Byte converted to a UShort.
     */
    // @Native("java", "((short)(byte)(#1))")
    @Native("c++",  "((x10_ushort) (#1))")
    public static safe operator (x:Byte): UShort = UShort(x);

    /**
     * Convert a given Int to a UShort.
     * @param x the given Int
     * @return the given Int converted to a UShort.
     */
    // @Native("java", "((short)(int)(#1))")
    @Native("c++",  "((x10_ushort) (#1))")
    public static safe operator (x:Int) as UShort = UShort(x as Short);

    /**
     * Convert a given Long to a UShort.
     * @param x the given Long
     * @return the given Long converted to a UShort.
     */
    // @Native("java", "((short)(long)(#1))")
    @Native("c++",  "((x10_ushort) (#1))")
    public static safe operator (x:Long) as UShort = UShort(x as Short);

    /**
     * Convert a given Float to a UShort.
     * @param x the given Float
     * @return the given Float converted to a UShort.
     */
    // @Native("java", "x10.core.Floats.toUShort(#1)")
    @Native("c++",  "((x10_ushort) (#1))")
    public static safe operator (x:Float) as UShort {
        val temp : Int = x as Int;
        if (temp > 0xffff) return UShort(0xffff as Byte);
        else if (temp < 0) return UShort(0);
        else return UShort(temp as Short);
    }

    /**
     * Convert a given Double to a UShort.
     * @param x the given Double
     * @return the given Double converted to a UShort.
     */
    // @Native("java", "x10.core.Floats.toUShort(#1)")
    @Native("c++",  "((x10_ushort) (#1))")
    public static safe operator (x:Double) as UShort {
        val temp : Int = x as Int;
        if (temp > 0xffff) return UShort(0xffff as Byte);
        else if (temp < 0) return UShort(0);
        else return UShort(temp as Short);        
    }

    /**
     * Coerce a given Short to a UShort.
     * @param x the given Short
     * @return the given Short converted to a UShort.
     */
    // @Native("java", "((short)(short)(#1))")
    @Native("c++",  "((x10_ushort) (#1))")
    public static safe operator (x:Short): UShort = UShort(x);


    /**
     * A constant holding the minimum value a UShort can have, 0.
     */
    // @Native("java", "((short)0)")
    @Native("c++", "((x10_ushort)0U)")
    public static MIN_VALUE = 0 as UShort;

    /**
     * A constant holding the maximum value a UShort can have, 2<sup>16</sup>-1.
     */
    // @Native("java", "((short)0xffff)")
    @Native("c++", "((x10_ushort)0xffffU)")
    public static MAX_VALUE = 0xffff as UShort;


    /**
     * Returns a String representation of this UShort in the specified radix.
     * @param radix the radix to use in the String representation
     * @return a String representation of this UShort in the specified radix.
     */
    // @Native("java", "java.lang.Integer.toString((#0) & 0xffff, #1)")
    @Native("c++", "x10aux::int_utils::toString((#0) & 0xffff, #1)")
    public safe def toString(radix:Int): String = ((this.shortVal & 0xFFFF) as Int).toString(radix);

    /**
     * Returns a String representation of this UShort as a hexadecimal number.
     * @return a String representation of this UShort as a hexadecimal number.
     */
    // @Native("java", "java.lang.Integer.toHexString((#0) & 0xffff)")
    @Native("c++", "x10aux::int_utils::toHexString((#0) & 0xffff)")
    public safe def toHexString(): String = this.shortVal.toHexString();

    /**
     * Returns a String representation of this UShort as an octal number.
     * @return a String representation of this UShort as an octal number.
     */
    // @Native("java", "java.lang.Integer.toOctalString((#0) & 0xffff)")
    @Native("c++", "x10aux::int_utils::toOctalString((#0) & 0xffff)")
    public safe def toOctalString(): String = this.shortVal.toOctalString();

    /**
     * Returns a String representation of this UShort as a binary number.
     * @return a String representation of this UShort as a binary number.
     */
    // @Native("java", "java.lang.Integer.toBinaryString((#0) & 0xffff)")
    @Native("c++", "x10aux::int_utils::toBinaryString((#0) & 0xffff)")
    public safe def toBinaryString(): String = this.shortVal.toBinaryString();

    /**
     * Returns a String representation of this UShort as a decimal number.
     * @return a String representation of this UShort as a decimal number.
     */
    // @Native("java", "java.lang.Integer.toString((#0) & 0xffff)")
    @Native("c++", "x10aux::to_string(#0)")
    public safe def toString(): String = ((this.shortVal & 0xFFFF) as Int).toString();

    /**
     * @deprecated use {@link #parse(String,Int)} instead
     */
    // @Native("java", "((short) (java.lang.Integer.parseInt(#1, #2) & 0xffff))")
    @Native("c++", "((x10_ushort) x10aux::int_utils::parseInt(#1, #2))")
    public static def parseUShort(s:String, radix:Int): UShort throws NumberFormatException {
        return UShort(Short.parse(s, radix));
    }

    /**
     * @deprecated use {@link #parse(String)} instead
     */
    // @Native("java", "java.lang.Integer.parseInt(#1)")
    @Native("c++", "x10aux::int_utils::parseInt(#1)")
    public static def parseUShort(s:String): UShort throws NumberFormatException {
        return UShort(Short.parse(s));
    }

    /**
     * Parses the String argument as a UShort in the radix specified by the second argument.
     * @param s the String containing the UShort representation to be parsed
     * @param radix the radix to be used while parsing s
     * @return the UShort represented by the String argument in the specified radix.
     * @throws NumberFormatException if the String does not contain a parsable UShort.
     */
    // @Native("java", "((short) (java.lang.Integer.parseInt(#1, #2) & 0xffff))")
    @Native("c++", "((x10_ushort) x10aux::int_utils::parseInt(#1, #2))")
    public static def parse(s:String, radix:Int): UShort throws NumberFormatException {
         return UShort(Short.parse(s, radix));
     }

    /**
     * Parses the String argument as a decimal UShort.
     * @param s the String containing the UShort representation to be parsed
     * @return the UShort represented by the String argument.
     * @throws NumberFormatException if the String does not contain a parsable UShort.
     */
    // @Native("java", "((short) (java.lang.Integer.parseInt(#1) & 0xffff)")
    @Native("c++", "((x10_ushort) x10aux::int_utils::parseInt(#1))")
    public static def parse(s:String): UShort throws NumberFormatException {
        return UShort(Short.parse(s));
    }


    /**
     * Returns the value obtained by reversing the order of the bits in the
     * binary representation of this UShort.
     * @return the value obtained by reversing order of the bits in this UShort.
     */
    // @Native("java", "((short)(java.lang.Integer.reverse(#0)>>>16))")
    @Native("c++", "((x10_ushort)(x10aux::int_utils::reverse(#0)>>16))")
    public def reverse(): UShort = UShort(this.shortVal.reverse());

    /**
     * Returns the signum function of this UShort.  The return value is 0 if
     * this UShort is zero and 1 if this UShort is non-zero.
     * @return the signum function of this UShort.
     */
    // @Native("java", "(((#0)==0) ? 0 : 1)")
    @Native("c++",  "(((#0)==0U) ? 0 : 1)")
    public def signum(): Int = (this.shortVal == 0) ? 0 : 1;

    /**
     * Returns the value obtained by reversing the order of the bytes in the
     * representation of this UShort.
     * @return the value obtained by reversing (or, equivalently, swapping) the bytes in this UShort.
     */
    // @Native("java", "java.lang.Short.reverseBytes(#0)")
    @Native("c++", "((x10_ushort) x10aux::short_utils::reverseBytes((x10_short) #0))")
    public def reverseBytes(): UShort = UShort(this.shortVal.reverseBytes());


    /**
     * Return true if the given entity is a UShort, and this UShort is equal
     * to the given entity.
     * @param x the given entity
     * @return true if this UShort is equal to the given entity.
     */
    // @Native("java", "x10.rtt.Equality.equalsequals(#0, #1)")
    @Native("c++", "x10aux::equals(#0,#1)")
    public safe def equals(x:Any):Boolean = this.shortVal.equals(x);

    /**
     * Returns true if this UShort is equal to the given UShort.
     * @param x the given UShort
     * @return true if this UShort is equal to the given UShort.
     */
    // @Native("java", "x10.rtt.Equality.equalsequals(#0, #1)")
    @Native("c++", "x10aux::equals(#0,#1)")
    public safe def equals(x:UShort):Boolean = this.shortVal == x.shortVal;
}
