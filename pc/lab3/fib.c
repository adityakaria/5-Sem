/*
**  PROGRAM: nth Fibonacci number
**
**  PURPOSE: This is a simple program to calculate the nth Fibonacci number. 
**           Each number in the Fibonacci series is the sum of the two previous numbers before it.
**			 The first two numbers in the series are 0 and 1.
**           Example of the first 10 numbers in the Fibonacci series:
**
**                0,1,1,2,3,5,8,13,21,34
**
**           We use a recursive function to find the previous two elements, taking n as input. 
**           If n goes below 2, then we return n.
**           Else, we return the sum of the values returned by the functions taking n-1 and n-2 as input.
**
**  USAGE:   Run the program and enter an integer in the command line when prompted.
**
**  HISTORY: Written by Bharath Adikar, Aug 2019
*/
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

#define lld long long int

lld fib_serial(lld n)
{
	// Return values of fib(n-1) and fib(n-2)
	lld i, j;

	// If n is less than 2, return itself (first two elements of Fibonacci series)
	if (n < 2)
		return n;
	else
	{
		i = fib_serial(n - 1);
		j = fib_serial(n - 2);
		return i + j;
	}
}

lld fib_parallel(lld n)
{
	// Return values of fib(n-1) and fib(n-2)
	lld i, j;

	// If n is less than 2, return itself (first two elements of Fibonacci series)
	if (n < 2)
		return n;
	else
	{
		i = fib_parallel(n - 1);
		j = fib_parallel(n - 2);
		return i + j;
	}
}

lld fib_parallel_taskwait(lld n)
{
	/*To get good performance you need to use a cutoff value for "n". 
	Otherwise, too many small tasks will be generated. 
	Once the value of "n" gets below this threshold it is best to simply execute the serial version without tasking.*/

	// Return values of fib(n-1) and fib(n-2)
	lld i, j;

	// If n is less than 20, fallback to serialised generation of nth Fibonacci number.
	if (n < 20)
		return fib_serial(n);
	else
	{
#pragma omp task
		i = fib_parallel_taskwait(n - 1);

#pragma omp task
		j = fib_parallel_taskwait(n - 2);

#pragma omp taskwait
		return i + j;
	}
}

lld check_correctness(lld num, lld n)
{
	if (n < 2)
		return num - n;

	lld i, x1, x2, x3;
	x1 = 0;
	x2 = 1;
	for (i = 2; i <= n; ++i)
	{
		x3 = x1 + x2;
		x1 = x2;
		x2 = x3;
	}
	return num - x3;
}

int main()
{
	lld n, answer, error;
	double start_time, time_taken;

	printf("Enter the nth fibonacci number to print\n");
	scanf("%lld", &n);

	start_time = omp_get_wtime();
	answer = fib_serial(n);
	time_taken = omp_get_wtime() - start_time;
	error = check_correctness(answer, n);
	printf("nth fibonacci number is %lld\n", answer);
	printf("Time taken for serial approach is %lf s\n", time_taken);
	if (error)
		printf("Error obtained: %lld\n", error);
	else
		printf("The output obtained is correct and has no errors.\n");
	printf("\n");

	start_time = omp_get_wtime();
#pragma omp parallel
	{
#pragma omp single
		answer = fib_parallel(n);
	}
	time_taken = omp_get_wtime() - start_time;
	error = check_correctness(answer, n);
	printf("The nth fibonacci number is %lld\n", answer);
	printf("Time taken for parallel approach is %lf s\n", time_taken);
	if (error)
		printf("Error obtained: %lld\n", error);
	else
		printf("The output obtained is correct and has no errors.\n");
	printf("\n");

	start_time = omp_get_wtime();
#pragma omp parallel
	{
#pragma omp single
		answer = fib_parallel_taskwait(n);
	}
	time_taken = omp_get_wtime() - start_time;
	error = check_correctness(answer, n);
	printf("The nth fibonacci number is %lld\n", answer);
	printf("Time taken for parallel approach with taskwait is %lf s\n", time_taken);
	if (error)
		printf("Error obtained: %lld\n", error);
	else
		printf("The output obtained is correct and has no errors.\n");
	printf("\n");

	return 0;
}