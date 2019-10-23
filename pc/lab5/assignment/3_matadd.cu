#include<stdio.h>
#define N 16
#define BLOCK_DIM 16

__global__ void matrixAdd (int *a, int *b, int *c);

int main() {
    int a[N][N], b[N][N], c[N][N];
    for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            a[i][j] = i+j;
            b[i][j] = 0;
            c[i][j] = 0;
        }
        b[i][i] = 2;
    }
    int *dev_a, *dev_b, *dev_c;
    int size = N * N * sizeof(int);

    // initialize a and b with real values (NOT SHOWN)
    cudaMalloc((void**) &dev_a, size);
    cudaMalloc((void**) &dev_b, size);
    cudaMalloc((void**) &dev_c, size);

    cudaMemcpy (dev_a, a, size, cudaMemcpyHostToDevice) ;
    cudaMemcpy (dev_b, b, size, cudaMemcpyHostToDevice) ;
    dim3 dimBlock(BLOCK_DIM, BLOCK_DIM) ;

    dim3 dimGrid( (int) ceil (N/dimBlock.x) , (int) ceil (N/dimBlock.y));
    matrixAdd<<<dimGrid, dimBlock>>> (dev_a,dev_b,dev_c);
    cudaMemcpy(c, dev_c, size, cudaMemcpyDeviceToHost) ;
    cudaFree(dev_a); cudaFree(dev_b); cudaFree (dev_c) ;

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
}

__global__ void matrixAdd (int *a, int *b, int *e) {
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int index = col + row * N;
    if (col < N && row < N) {
        e[index] = a[index] + b[index] ;
        //printf("a[i][j] = %d, b[i][j] = %d, i,j = %d,%d\n", a[i][j], b[i][j], i, j);
    }
}

void printArray(int a[N], int b[N], int c[N]) {

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

}
