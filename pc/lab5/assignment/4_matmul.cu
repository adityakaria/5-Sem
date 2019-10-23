#include<stdio.h>
#define N 16
#define BLOCK_DIM 16

__global__ void matrixmul (int *a, int *b, int *c,int width);

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
    dim3 dimGrid(1,1);
    dim3 dimBlock(BLOCK_DIM, BLOCK_DIM) ;

    matrixmul<<<dimGrid, dimBlock>>> (dev_a,dev_b,dev_c,N);
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

__global__ void matrixmul (int *a, int *b, int *e,int width) {
    int k,sum=0;
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    int row = blockIdx.y * blockDim.y + threadIdx.y;

    if (col < width && row < width) {
        for(int k=0;k<width;k++)
            sum+=a[row*width+k]*b[k*width+col];
        e[row*width+col] = sum;
    }
}