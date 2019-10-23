#define N 2048
#include <stdio.h>

__global__ void vecAdd (int *a, int *b, int *c);
void printArray(int a[], int b[], int c[]);

int main() {
	int a[N], b[N], c[N];
	int *dev_a, *dev_b, *dev_c;

	// initialize a and b with real values (NOT SHOWN)
	int size = N * sizeof(int);
	for (int i = 0; i < N; i++) {
		a[i] = i;
		b[i] = i/2;
	}
	for(int T=128;T<=1024;T+=128){
		clock_t t_exec = clock();
		cudaMalloc((void**)&dev_a, size);
		cudaMalloc((void**)&dev_b, size);
		cudaMalloc((void**)&dev_c, size);

		cudaMemcpy(dev_a, a, size,cudaMemcpyHostToDevice);
		cudaMemcpy(dev_b, b, size,cudaMemcpyHostToDevice);

		vecAdd<<<(int)ceil(N/T),T>>>(dev_a,dev_b,dev_c);

		cudaMemcpy(c, dev_c, size,cudaMemcpyDeviceToHost);

		cudaFree(dev_a);
		cudaFree(dev_b);
	    cudaFree(dev_c);
	    t_exec=clock()-t_exec;
	    printArray(a,b,c);
	    printf("%d %f\n",T, (double)t_exec/CLOCKS_PER_SEC);
	}

	exit (0);
}

__global__ void vecAdd (int *a, int *b, int *c) {
	int i = blockIdx.x * blockDim.x + threadIdx.x;
	if (i < N) {
		c[i] = a[i] + b[i];
	}
}

void printArray(int a[], int b[], int c[]) {

	// printf("a + b = c:\n");
	for(int i = 0; i < N; i++){
		//printf("%d + %d = %d\n", a[i],b[i],c[i]);
    }
	//printf("\n");
}
