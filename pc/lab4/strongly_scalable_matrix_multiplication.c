/*
**  PROGRAM: Matrix Multiplicatin
**
**  PURPOSE: This is a simple program to multiply two matrices of dimensions MxN and 
**  NxM implemented as plain simple and OpenMP parallelised versions
**           
**			 The matrices are initialised such that the first matrix A contains
**           the row index as its elements, and the second matrix B uses the
**           the column index
**           Example of the first matrix with size 4:
**
**                0,1,2,4
**                1,2,3,5
**                2,3,4,5
**                3,4,5,6
**
**           The resultant matrix element R(i,j)
**           is the sum of products of kth element in ith
**           row of matrix A, and jth column of matrix B. 
**
**  USAGE:   Run the program and enter an integer in the command line when 
**           prompted, where the integer is the size of the array. An output
**           file 'output.txt' is created, with each entry being the number
**           of threads and the speedup ratio.
**
**  HISTORY: Written by Aditya Karia, Sep 2019
*/
#include <omp.h>
#include <stdio.h>
#define N 500

int main()
{
    int m = N, n = N, p = N, q = N, i, j, k;
    int A[N][N], B[N][N], R[N][N];
    double start_time_s, time_taken_s, start_time_p, time_taken_p, speedup;
    FILE *fp;
    fp = fopen("output1.txt", "w");

    // Initialising the matrix
    for (i = 0; i < N; ++i)
    {
        for (j = 0; j < N; j++)
        {
            A[i][j] = i;
            B[i][j] = j;
        }
    }

    // Serial Matrix Multiplication
    start_time_s = omp_get_wtime();

    for (i = 0; i < m; ++i)
    {
        for (j = 0; j < n; ++j)
        {
            R[i][j] = 0;
            for (k = 0; k < p; ++k)
                R[i][j] += A[i][k] * B[k][j];
        }
    }
    time_taken_s = omp_get_wtime() - start_time_s;

    printf("Time taken for serial matrix multiplication = %lf s\n", time_taken_s);

    for (int itr = 1; itr <= 2; ++itr)
    {

        omp_set_num_threads(itr);

        // Parallel Matrix Multiplication with 'itr' no. of threads
        start_time_p = omp_get_wtime();

#pragma omp parallel shared(A, B, R) private(i, j, k)
        {
#pragma omp for schedule(static)
            for (i = 0; i < m; ++i)
            {
                for (j = 0; j < n; ++j)
                {
                    R[i][j] = 0;
                    for (k = 0; k < p; ++k)
                        R[i][j] += A[i][k] * B[k][j];
                }
            }
        }

        time_taken_p = omp_get_wtime() - start_time_p;
        speedup = time_taken_s / time_taken_p;

        printf("Time taken for parallel matrix multiplication with %d threads: %lf s. Speedup ratio: %lf\n", itr, time_taken_p, speedup);

        fprintf(fp, "%d %lf\n", itr, speedup);
    }

    fclose(fp);
    return 0;
}