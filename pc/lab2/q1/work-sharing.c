// Program in for work sharing constructs in parallel WITHOUT no-wait clause

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
    // For time calculation
    clock_t begin_time = clock();
    // Start Work sharing loop
    #pragma omp parallel shared(n,a,b,c,d) private(i)
    {   
        printf("Pragma parallel section excecution start\n");
        // Start Loop 1
        #pragma omp for
        for(i=0; i<n-1;i++)
        {
            
            b[i]=(a[i]+a[i+1])/2.0;
        }
        
        // Start Loop 2
        #pragma omp for
        for(i=0;i<n;i++)
        {
            d[i]=1.0/c[i];
        }
    }
    // Time End
    clock_t end_time = clock();
    printf("TIME: %f\n", (double)(end_time-begin_time)/CLOCKS_PER_SEC);
}