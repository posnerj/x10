/*
 *
 * (C) Copyright IBM Corporation 2006
 *
 *  This file is part of X10 Test.
 *
 */
import harness.x10Test;

/**
 * Check that a float literal can be cast as float.
 */
public class FloatLitDepType_MustFailCompile extends x10Test {
	public def run(): boolean = {
		var f: float{self==0.001F} = 0.003F;
		return true;
	}

	public static def main(var args: Rail[String]): void = {
		new FloatLitDepType_MustFailCompile().execute();
	}


}