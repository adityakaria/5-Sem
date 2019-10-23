#define N 2048
#include <stdio.h>

__global__ void matrixMult (int *a, int *b, int *c, int width);

int main() {
	int a[N][N], b[N][N], c[N][N];
	int *dev_a, *dev_b, *dev_c;

	// initialize matrices a and b with appropriate values
	for (int i = 0; i < N; i++) {
		for (int j = 0; j < N; j++) {
			a[i][j] = i+j;
			b[i][j] = i-j;
			c[i][j] = 0;
		}
	}

	int size = N * N * sizeof(int);
	for(int BLOCK_DIM=2;BLOCK_DIM<=64;BLOCK_DIM+=2){
				clock_t t_exec = clock();

	cudaMalloc((void **) &dev_a, size);
	cudaMalloc((void **) &dev_b, size);
	cudaMalloc((void **) &dev_c, size);

	cudaMemcpy(dev_a, a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(dev_b, b, size, cudaMemcpyHostToDevice);

	dim3 dimBlock(BLOCK_DIM, BLOCK_DIM);
	dim3 dimGrid((int)ceil(N/dimBlock.x),(int)ceil(N/dimBlock.y));

	matrixMult<<<dimGrid, dimBlock>>>(dev_a, dev_b, dev_c, N);

	cudaMemcpy(c, dev_c, size, cudaMemcpyDeviceToHost);


	cudaFree(dev_a);
	cudaFree(dev_b);
	cudaFree(dev_c);
	printf("%d %f\n", BLOCK_DIM, double(clock() - t_exec) / CLOCKS_PER_SEC);

}
	exit(0);
}

__global__ void matrixMult (int *a, int *b, int *c, int width) {
	int k, sum = 0;
	int col = threadIdx.x + blockDim.x * blockIdx.x;
	int row = threadIdx.y + blockDim.y * blockIdx.y;

	if(col < width && row < width) {
		for (k = 0; k < width; k++) {
			sum += a[row * width + k] * b[k * width + col];
		}
		c[row * width + col] = sum;
	}
}
