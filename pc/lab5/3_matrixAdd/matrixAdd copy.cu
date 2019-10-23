#define N 2048

#include <stdio.h>
__global__ void matrixAdd (int *a, int *b, int *c);

int main() {
	int a[N][N], b[N][N], c[N][N];
	int *dev_a, *dev_b, *dev_c;
	int size = N * N * sizeof(int);

	// initialize a and b with real values (NOT SHOWN)
	for (int i = 0; i < N; i++) {
		for (int j = 0; j < N; j++) {
			a[i][j] = i+j;
			b[i][j] = i/2 + j/2;
			c[i][j] = 0;
		}
	}
	for (int k = 2; k <= 40; k+=1) {
		clock_t t_exec = clock();

		cudaMalloc((void**)&dev_a, size);
		cudaMalloc((void**)&dev_b, size);
		cudaMalloc((void**)&dev_c, size);

		cudaMemcpy(dev_a, a, size, cudaMemcpyHostToDevice);
		cudaMemcpy(dev_b, b, size, cudaMemcpyHostToDevice);

		dim3 dimBlock(k, k);
		dim3 dimGrid((int)ceil(N/dimBlock.x),(int)ceil(N/dimBlock.y));

		matrixAdd<<<dimGrid,dimBlock>>>(dev_a,dev_b,dev_c);

		cudaMemcpy(c, dev_c, size, cudaMemcpyDeviceToHost);

		for (int i = 0; i < N; i++) {
			for (int j = 0; j < N; j++) {
				// printf("%d + %d = %d\n", a[i][j], b[i][j], c[i][j]);
			}
		}

		cudaFree(dev_a);
		cudaFree(dev_b);
		cudaFree(dev_c);
		printf("%d %f\n", k, double(clock() - t_exec) / CLOCKS_PER_SEC);
	}
}

__global__ void matrixAdd (int *a, int *b, int *c) {
	int col = blockIdx.x * blockDim.x + threadIdx.x;
	int row = blockIdx.y * blockDim.y + threadIdx.y;
	int index = col + row * N;
	if (col < N && row < N) {
		c[index] = a[index] + b[index];
		// printf("%d", c[index]);
	}
}
