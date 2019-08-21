#include <omp.h>
#include <stdio.h>
int main(){
    long int i;
	long int a[100000];
    long int n=100000;
   for(i=0;i<100000;i++)
a[i]=i;    double b[100000],d[10];
    double start_time = omp_get_wtime();
    for(i=0; i<n-1;i++)
    {
        b[i]=(a[i]+a[i+1])/2.0;
    }
 
    
    printf("time = %lfsec",omp_get_wtime()-start_time);
}
