#include <omp.h>
#include <stdio.h>
int main(){
    int i;
    int n=5;
    int a[]={1,2,3,5,4};
    int c[]={1,2,3,5,4};
    double b[10],d[10];
    double start_time = omp_get_wtime();
    #pragma omp parallel shared(n,a,b,c,d) private(i)
    {
        #pragma omp for nowait
        for(i=0; i<n-1;i++)
        {
            b[i]=(a[i]+a[i+1])/2.0;
        }
        

        #pragma omp for nowait
        for(i=0;i<n;i++)
        {
            printf("yes %d",i);
            d[i]=1.0/c[i];
        }
    }
    printf("time = %lfsec",omp_get_wtime()-start_time);
}