#include <iostream>
#include <cuda_runtime.h>

#define N 1024
#define TILE 8

__global__ void gemm_tiled(float* A, float* B, float* C) {
    __shared__ float As[TILE][TILE];
    __shared__ float Bs[TILE][TILE];

    int row = blockIdx.y * TILE + threadIdx.y;
    int col = blockIdx.x * TILE + threadIdx.x;

    float sum = 0.0f;

    for (int t = 0; t < N / TILE; t++) {
        As[threadIdx.y][threadIdx.x] = A[row * N + t * TILE + threadIdx.x];
        Bs[threadIdx.y][threadIdx.x] = B[(t * TILE + threadIdx.y) * N + col];

        __syncthreads();

        for (int k = 0; k < TILE; k++) {
            sum += As[threadIdx.y][k] * Bs[k][threadIdx.x];
        }

        __syncthreads();
    }

    C[row * N + col] = sum;
}

int main() {
    size_t size = N * N * sizeof(float);

    float *A, *B, *C;
    cudaMallocManaged(&A, size);
    cudaMallocManaged(&B, size);
    cudaMallocManaged(&C, size);

    for (int i = 0; i < N * N; i++) {
        A[i] = 1.0f;
        B[i] = 1.0f;
    }

    dim3 threads(TILE, TILE);
    dim3 blocks(N / TILE, N / TILE);

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start);

    gemm_tiled<<<blocks, threads>>>(A, B, C);

    cudaDeviceSynchronize();

    cudaEventRecord(stop);
    cudaEventSynchronize(stop);

    float ms;
    cudaEventElapsedTime(&ms, start, stop);

    double flops = 2.0 * N * N * N;
    double gflops = flops / (ms / 1000.0) / 1e9;

    std::cout << "Time (ms): " << ms << std::endl;
    std::cout << "GFLOPS: " << gflops << std::endl;

    cudaFree(A); cudaFree(B); cudaFree(C);
}
