/*
**  PROGRAM: to compute the nth Fibonacci number and perform a comparitive study when running it using OpenMP parallelization using various clauses
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
**  USAGE:   cd "/path/to/file" && gcc-<your_version> <filename>.c -fopenmp -o <filename> && ./<filename>;
**
**  HISTORY: Written by Aditya J Karia, Aug 2019
*/

#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#define lld long long int

lld serial_fib(lld n)
{
    // If n is less than or equal to 1, return 1
    if (n < 2)
        return n;
    else
        return serial_fib(n - 1) + serial_fib(n - 2);
}

lld parallel_fib(lld n)
{
    lld i, j;

    // If n is less than 2, return n
    if (n < 2)
        return n;
    else
    {
        #pragma omp task
        i = parallel_fib(n - 1);

        #pragma omp task
        j = parallel_fib(n - 2);

        return i + j;
    }
}

lld parallel_fib_taskwait(lld n)
{
    // Return values of fib(n-1) and fib(n-2)
    lld i, j;

    if (n < 2)
        return n;

        #pragma omp task shared(i)
    i = parallel_fib_taskwait(n - 1);

        #pragma omp task shared(j)
    j = parallel_fib_taskwait(n - 2);

    #pragma omp taskwait
    return i + j;
}

void check_correctness(lld result, lld n)
{
    lld error = result - serial_fib(n);
    if (error)
        printf("\t==> ERROR OBTAINED\n");
    else
        printf("\tCorrectness checked\n");
}

int main()
{
    lld n, result;
    double start_time, time_taken;

    printf("Enter n:  ");
    scanf("%lld", &n);
    if (n < 1)
    {
        printf("ERROR: n must be greater than 1\n");
        exit(1);
    }

    // Computing Fibonacci in Serial
    printf("\nFibonacci in Serial:\n");
    start_time = omp_get_wtime();
    result = serial_fib(n);
    time_taken = omp_get_wtime() - start_time;
    printf("\tResult:\t%lld\n", result);
    printf("\tTime taken:\t%lf s\n", time_taken);

    // Check for errros
    check_correctness(result, n);

    // Computing Fibonacci in Parallel
    printf("\nFibonacci in Parallel:\n");
    start_time = omp_get_wtime();
    #pragma omp parallel
    {
        #pragma omp single
        result = parallel_fib(n);
    }
    time_taken = omp_get_wtime() - start_time;
    printf("\tResult:\t%lld\n", result);
    printf("\tTime taken:\t%lf s\n", time_taken);
    check_correctness(result, n);

    // Computing Fibonacci in Parallel with tast-wait
    printf("\nFibonacci in Parallel with tast-wait:\n");
    start_time = omp_get_wtime();
    #pragma omp parallel
    {
        #pragma omp single
        result = parallel_fib_taskwait(n);
    }
    time_taken = omp_get_wtime() - start_time;
    printf("\tResult:\t%lld\n", result);
    printf("\tTime taken:\t%lf s\n", time_taken);
    check_correctness(result, n);

    return 0;
}
