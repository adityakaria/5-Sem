#define N 8
#define BLOCK_DIM 8
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

	cudaMalloc((void **) &dev_a, size);
	cudaMalloc((void **) &dev_b, size);
	cudaMalloc((void **) &dev_c, size);

	cudaMemcpy(dev_a, a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(dev_b, b, size, cudaMemcpyHostToDevice);

	dim3 dimBlock(BLOCK_DIM, BLOCK_DIM);
	dim3 dimGrid((int)ceil(N/dimBlock.x),(int)ceil(N/dimBlock.y));

	matrixMult<<<dimGrid, dimBlock>>>(dev_a, dev_b, dev_c, N);

	cudaMemcpy(c, dev_c, size, cudaMemcpyDeviceToHost);

	for (int j = 0; j < N; j++) {
			printf("____");
		}
		printf("__\n");
	for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            printf("|%-3d", a[i][j]);
        }
		printf(" |\n");
		for (int j = 0; j < N; j++) {
			printf("|___");
		}
		printf("_|\n");
    }
	printf("\n");
	for (int j = 0; j < N; j++) {
			printf("____");
		}
		printf("__\n");
    for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            printf("|%2d ", b[i][j]);
        }
		printf(" |\n");
		for (int j = 0; j < N; j++) {
			printf("|___");
		}
		printf("_|\n");
    }
	printf("\n");
	for (int j = 0; j < N; j++) {
			printf("_______");
		}
		printf("__\n");
    for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            printf("|%5d ", c[i][j]);
        }
		printf(" |\n");
		for (int j = 0; j < N; j++) {
			printf("|______");
		}
		printf("_|\n");
    }

	cudaFree(dev_a);
	cudaFree(dev_b);
	cudaFree(dev_c);

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
