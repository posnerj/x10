/**************************************************************************
*                                                                         *
*             Java Grande Forum Benchmark Suite - MPJ Version 1.0         *
*                                                                         *
*                            produced by                                  *
*                                                                         *
*                  Java Grande Benchmarking Project                       *
*                                                                         *
*                                at                                       *
*                                                                         *
*                Edinburgh Parallel Computing Centre                      *
*                                                                         *
*                email: epcc-javagrande@epcc.ed.ac.uk                     *
*                                                                         *
*                  Original version of this code by                       *
*                 Gabriel Zachmann (zach@igd.fhg.de)                      *
*                                                                         *
*      This version copyright (c) The University of Edinburgh, 2001.      *
*                         All rights reserved.                            *
*                                                                         *
**************************************************************************/
package series;

import jgfutil.*;

/**
 * Class SeriesTest
 *
 * Performs the transcendental/trigonometric portion of the
 * benchmark. This test calculates the first n fourier
 * coefficients of the function (x+1)^x defined on the interval
 * 0,2 (where n is an arbitrary number that is set to make the
 * test last long enough to be accurately measured by the system
 * clock). Results are reported in number of coefficients calculated
 * per sec.
 *
 * The first four pairs of coefficients calculated shoud be:
 * (2.83777, 0), (1.04578, -1.8791), (0.2741, -1.15884), and
 * (0.0824148, -0.805759).
 */
public class SeriesTest {

	// Declare class data.

	int array_rows;
	double [.] testArray;  // Array of arrays.

	/**
	 * buildTestData.
	 * Instantiate array(s) to hold fourier coefficients.
	 */

	void buildTestData()
	{
		// Allocate appropriate length for the double array of doubles.
		final region R = [0:1,0:array_rows-1];
		testArray = new double [dist.factory.block(R)];
	}

	/**
	 * Do.
	 *
	 * This consists of calculating the
	 * first n pairs of fourier coefficients of the function (x+1)^x on
	 * the interval 0,2. n is given by array_rows, the array size.
	 * NOTE: The # of integration steps is fixed at 1000.
	 */
	void Do()
	{
		// Start the stopwatch.
		JGFInstrumentor.startTimer("Section2:Series:Kernel");

		// Calculate the fourier series. Begin by calculating A[0].

		testArray[0,0] = TrapezoidIntegrate((double)0.0, // Lower bound.
				(double)2.0,            // Upper bound.
				1000,                    // # of steps.
				(double)0.0,            // No omega*n needed.
				0) / (double)2.0;       // 0 = term A[0].

		// Calculate the fundamental frequency.
		// (2 * pi) / period...and since the period
		// is 2, omega is simply pi.

		final double omega = (double) 3.1415926535897932;
		final dist U = dist.factory.unique();
		finish {
			ateach (final point p: U) {
				int ilow;

				if (U[p].isFirst()) {
					ilow = 1;
				} else {
					ilow = 0;
				}
				for (point p[n,i] : testArray.distribution| here) {
					if (i >= ilow) {

						// Calculate A[i] terms. Note, once again, that we
						// can ignore the 2/period term outside the integral
						// since the period is 2 and the term cancels itself
						// out.
						if (n == 0) {
							testArray[0,i] = TrapezoidIntegrate((double)0.0,
									(double)2.0,
									1000,
									omega * (double)i,
									1);                       // 1 = cosine term.
						} else {
							// Calculate the B[i] terms.

							testArray[n,i] = TrapezoidIntegrate((double)0.0,
									(double)2.0,
									1000,
									omega * (double)i,
									2);                       // 2 = sine term.
						}
					}
				}
			}
		}

		JGFInstrumentor.stopTimer("Section2:Series:Kernel");
	}

	/**
	 * TrapezoidIntegrate.
	 *
	 * Perform a simple trapezoid integration on the function (x+1)**x.
	 * x0,x1 set the lower and upper bounds of the integration.
	 * nsteps indicates # of trapezoidal sections.
	 * omegan is the fundamental frequency times the series member #.
	 * select = 0 for the A[0] term, 1 for cosine terms, and 2 for
	 * sine terms. Returns the value.
	 */
	private double TrapezoidIntegrate (double x0,     // Lower bound.
									   double x1,     // Upper bound.
									   int nsteps,    // # of steps.
									   double omegan, // omega * n.
									   int select)    // Term type.
	{
		double x;               // Independent variable.
		double dx;              // Step size.
		double rvalue;          // Return value.

		// Initialize independent variable.

		x = x0;

		// Calculate stepsize.

		dx = (x1 - x0) / (double)nsteps;

		// Initialize the return value.

		rvalue = thefunction(x0, omegan, select) / (double)2.0;

		// Compute the other terms of the integral.

		if (nsteps != 1)
		{
			--nsteps;               // Already done 1 step.
			while (--nsteps > 0)
			{
				x += dx;
				rvalue += thefunction(x, omegan, select);
			}
		}

		// Finish computation.

		rvalue = (rvalue + thefunction(x1, omegan, select) / (double)2.0) * dx;
		return (rvalue);
	}

	/**
	 * thefunction.
	 *
	 * This routine selects the function to be used in the Trapezoid
	 * integration. x is the independent variable, omegan is omega * n,
	 * and select chooses which of the sine/cosine functions
	 * are used. Note the special case for select = 0.
	 */
	private double thefunction(double x,      // Independent variable.
							   double omegan, // Omega * term.
							   int select)    // Choose type.
	{
		// Use select to pick which function we call.

		switch (select)
		{
			case 0: return (Math.pow(x+(double)1.0, x));
			case 1: return (Math.pow(x+(double)1.0, x) * Math.cos(omegan*x));
			case 2: return (Math.pow(x+(double)1.0, x) * Math.sin(omegan*x));
		}

		// We should never reach this point, but the following
		// keeps compilers from issuing a warning message.

		return (0.0);
	}

	/**
	 * freeTestData
	 *
	 * Nulls array that is created with every run and forces garbage
	 * collection to free up memory.
	 */
	void freeTestData()
	{
		//testArray = null;    // Destroy the array.
		System.gc();         // Force garbage collection.
	}
}

