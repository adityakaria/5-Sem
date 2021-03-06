#define N 5000
#define T 1024 // max threads per block

#include <stdio.h>

__global__ void vecAdd (int *a, int *b, int *c);

int main() {
	int a[N], b[N], c[N];
	int *dev_a, *dev_b, *dev_c;

	// initialize a and b with real values (NOT SHOWN)
	int size = N * sizeof(int);
	for (int i = 0; i < 200; i++) {
		a[i] = i;
		b[i] = i/2;
	}

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
    
    for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            printf("%d ", a[i][j]);
        }
        printf("\n");
    }
    printf("\n");
    for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            printf("%d ", b[i][j]);
        }
        printf("\n");
    }
    printf("\n");
    for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            printf("%d ", c[i][j]);
        }
        printf("\n");
    }

	exit (0);
}

__global__ void vecAdd (int *a, int *b, int *c) {
	int i = blockIdx.x * blockDim.x + threadIdx.x;
	if (i < N) {
		c[i] = a[i] + b[i];
	}
}
