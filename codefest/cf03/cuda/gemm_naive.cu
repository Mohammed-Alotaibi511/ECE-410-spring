#include <iostream>
#include <cuda_runtime.h>

#define N 1024

__global__ void gemm_naive(float* A, float* B, float* C) {
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;

    if (row < N && col < N) {
        float sum = 0.0f;
        for (int k = 0; k < N; k++) {
            sum += A[row * N + k] * B[k * N + col];
        }
        C[row * N + col] = sum;
    }
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

    dim3 threads(16, 16);
    dim3 blocks(N / 16, N / 16);

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start);

    gemm_naive<<<blocks, threads>>>(A, B, C);

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
