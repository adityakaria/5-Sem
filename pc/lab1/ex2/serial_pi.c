#include <stdio.h>
#include "omp.h"
#include <time.h>

static long num_steps = 100000;
double step;

int main(){
    clock_t begin_time = clock();
    int i; 
    double x, pi, sum = 0.0;
    step = 1.0/(double) num_steps;
    for (i=0;i< num_steps; i++) {
        x = (i+0.5)*step;
        sum = sum + 4.0/(1.0+x*x);
    }
    pi = step * sum;
    clock_t end_time = clock();
    printf("PI: %f\nTIME: %f\n", pi, (double)(end_time-begin_time)/CLOCKS_PER_SEC);
    return 0;
}

// gcc -fopenmp serial_pi.c -o serial_pi
// 
// PI: 3.141593
// TIME: 0.004518