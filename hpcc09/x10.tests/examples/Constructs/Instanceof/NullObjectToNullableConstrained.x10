/*
 *
 * (C) Copyright IBM Corporation 2006
 *
 *  This file is part of X10 Test.
 *
 */
import harness.x10Test;

/**
 * Purpose: 
 * Issue: 
 * @author vcave
 **/
public class NullObjectToNullableConstrained extends x10Test {
	 
	public def run(): boolean = {
		var array: Rail[X10DepTypeClassOne] = new Array[X10DepTypeClassOne](1);
		var var: X10DepTypeClassOne = array(0);
		var nullableVarNull: Box[X10DepTypeClassOne] = null;
		
		// array[0] is null hence it is not an instance of targeted non nullable type
		var res1: boolean = !(array(0) instanceof  Box[X10DepTypeClassOne{p==1})]);
		
		// var is null hence it is not an instance of targeted non nullable type
		var res2: boolean = !(var instanceof  Box[X10DepTypeClassOne{p==1})]);
		
		// nullableVarNull is null hence it is not an instance of targeted non nullable type
		var res3: boolean = !(nullableVarNull instanceof  Box[X10DepTypeClassOne{p==1})]);
		
		// nullableVarNull is null hence it is an instance of the nullable type
		var res4: boolean = !(getNullNullable() instanceof Box[X10DepTypeClassOne{p==1})]);

		return res1 && res2 && res3 && res4;
	}
	
	public def getNullNullable(): Box[X10DepTypeClassOne] = {
		return null;
	}
	
	public static def main(var args: Rail[String]): void = {
		new NullObjectToNullableConstrained().execute();
	}
}