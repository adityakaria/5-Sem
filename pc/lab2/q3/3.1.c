// Program for serial cumulative addition from an array (no openMP)

#include <omp.h>
#include <stdio.h>

int main() {
    long int i;
    long int n=100000;
    long int a[n];

    for(i=0;i<n;i++)
        a[i]=i;
    
    double b[n],d[10];
    double start_time = omp_get_wtime();

    for(i=0; i<n-1;i++) {
        b[i]=(a[i]+a[i+1])/2.0;
    }
    
    printf("Total time = %lf seconds\n", omp_get_wtime()-start_time);
    return 0;
}
