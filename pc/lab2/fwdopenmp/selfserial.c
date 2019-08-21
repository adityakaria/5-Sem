#include <omp.h>
 #define N 100000
 #include <stdio.h>

 int main(int argc, char *argv[]) {

 int i;
 float a[N], b[N], c[N], d[N];

 /* Some initializations */
 for (i=0; i < N; i++) {
   a[i] = i * 1.5;
   b[i] = i;
   }
    double start_time = omp_get_wtime();
   

  

     for (i=0; i < N; i++)
       c[i] = a[i] + b[i];

     for (i=0; i < N; i++)
       d[i] = a[i] * b[i];

  

    printf("time = %lfsec",omp_get_wtime()-start_time);

 }