// Program in serial Excecution

#include <omp.h>
#include <stdio.h>
#include <time.h>

int main() {
    int i;
    int n=5000;
    int a[5000];
    for (int j = 0; j < 5000; j++) {
        a[j] = j+1;
    }
    int c[5000];
    for (int j = 0; j < 5000; j++) {
        c[j] = j+1;
    }
    double b[5000],d[5000];
    clock_t begin_time = clock();

    // For time calculation
    printf("-----> Start <-----\n");
    // Loop 1
    for(i=0; i<n-1;i++)
    {
        b[i]=(a[i]+a[i+1])/2.0;
    }

    printf("-----> Loop 1 Complete <-----\n");
    // Loop 2
    for(i=0;i<n;i++)
    {
        d[i]=1.0/c[i];
    }
    printf("-----> Loop 2 Complete <-----\n");

    clock_t end_time = clock();
    printf("TIME: %f\n", (double)(end_time-begin_time)/CLOCKS_PER_SEC);
}
