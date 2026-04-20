## GEMM Analysis (Naive vs. Tiled)

The naive GEMM kernel is memory bound because each thread loads the data from global memory for every multiplication. This makes in a large number of redundant DRAM accesses, causing memory bandwidth to become the primary bottleneck. because of this, the naive kernel achieves only about 30 GFLOPS, that is far below the compute capability of the GPU.

The tiled kernel improves performance by using shared memory to reduce global memory traffic. Instead of repeatedly loading the same elements from DRAM, blocks of data are loaded once into shared memory and reused multiple times. This significantly increases data reuse and reduces memory bandwidth pressure.

With tiling, the kernel achieves about 327 GFLOPS, which is more than 10× faster than the naive implementation. This demonstrates that reducing memory traffic and improving locality can move the kernel closer to the compute-bound region.

Although the tiled version is much faster, it may still not fully reach peak performance due to factors such as limited occupancy, synchronization overhead, and shared memory size constraints. Further optimizations such as loop unrolling or larger tile sizes could improve performance further.

