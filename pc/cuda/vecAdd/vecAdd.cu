#define N 256
#include <stdio.h>

__global void vecAdd (int *a, int *b, int *c);

int main() {
	int a[N], b[N], c[N];
	int *dev_A, *dev_b, *dev_c;

	for (int i = 0; i < 240; i++) {
		a[i] = i;
		b[i] = i**2;
	}
	size = N * sizeof(int);

	cudaMalloc((void**)&dev_a, size);
	cudaMalloc((void**)&dev_b, size);
	cudaMalloc((void**)&dev_c, size);

	cudeMemcpy (dev_a, a, size, cudaMemcpyHostToDevice);
	cudeMemcpy (dev_b, b, size, cudaMemcpyHostToDevice);

	vectAdd<<<1,N>>>(dev_a,dev_b,dev_c);

	cudaMemcpy (c, dev_c, size,cudaMemcpyDeviceToHost);

	cudeFree(dev_a);
	cudeFree(dev_b);
	cudaFree(dev_c);

	exit(0);
}

__global void vecAdd (int *a, int *b, int *c) {
	int i = threadIdx.x;
	c[i] = a[i] + b[i];
}
