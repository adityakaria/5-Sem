/*
**  PROGRAM: Calculation of Pi
**
**  PURPOSE: This is a simple program to calculate the value of Pi implemented as plain simple and OpenMP parallelised versions
**           
**			 Pi can be calculated using the integral
**                  (4.0/1+x^2)dx
**           over the range 0 to 1. We take very small portion widths
**           of the integral (1/10000000) and sum the results to obtain
**           Pi. The number of steps is thus assumed as 10000000.
**
**  USAGE:   Simply run the program. An output file 'output.txt' is 
**           created, with each entry being the number of threads and 
**           the speedup ratio.
**
**  HISTORY: Written by Aditya J Karia, Sep 2019
*/
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

static long num_steps = 10000000;
double step;

int main()
{

    int i, id, nthrds, nthreads = 0;
    double x, pi, sum, aux, start_time_s, time_taken_s, start_time_p, time_taken_p, speedup;
    FILE *fp;
    fp = fopen("output2.txt", "w");

    // Initialisation of intermediate variables
    sum = 0.0;
    step = 1.0 / (double)num_steps;

    // Serial Calculation of Pi
    start_time_s = omp_get_wtime();

    for (i = 0; i < num_steps; i = i + 1)
    {

        x = (i + 0.5) * step;
        aux = 4.0 / (1.0 + x * x);

        sum = sum + aux;
    }
    pi = step * sum;

    time_taken_s = omp_get_wtime() - start_time_s;

    printf("Value of pi: %lf. Time taken for serial calculation: %lf s\n", pi, time_taken_s);

    for (int itr = 1; itr <= 2; ++itr)
    {

        omp_set_num_threads(itr);

        // Initialisation of intermediate variables
        num_steps = 10000000 * itr;
        pi = 0.0;
        step = 1.0 / (double)num_steps;

        // Parallel Calculation of Pi with 'itr' no. of threads
        start_time_p = omp_get_wtime();

#pragma omp parallel
        {
            int i, id, nthrds;
            double x, sum;
            id = omp_get_thread_num();
            nthrds = omp_get_num_threads();

            if (id == 0)
                nthreads = nthrds;

            for (i = id, sum = 0.0; i < num_steps; i += nthrds)
            {
                x = (i + 0.5) * step;
                sum += 4.0 / (1.0 + x * x);
            }
            sum *= step;

#pragma atomic
            pi += sum;
        }

        time_taken_p = omp_get_wtime() - start_time_p;
        speedup = time_taken_s / time_taken_p;

        printf("Value of pi: %lf. Time taken for parallel calculation using %d threads: %lf s. Speedup ratio: %lf\n", pi, itr, time_taken_p, speedup);

        fprintf(fp, "%d %lf\n", itr, speedup);
    }

    fclose(fp);
    return 0;
}