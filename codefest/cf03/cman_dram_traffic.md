# CodeFest 3 – CMAN DRAM Traffic

## 1. Naive (ijk loop)

For one output element:

C[i][j] = sum of A[i][k] * B[k][j]

Each time we compute one output:
- we read N values from A
- we read N values from B

So for the full N x N matrix:
- A is accessed N^3 times
- B is accessed N^3 times

Total accesses = 2N^3

Each value is 4 bytes (FP32), so:

Total DRAM traffic = 2N^3 * 4 = 8N^3 bytes

---

## 2. Tiled (T = 8)

We split the matrix into 8 x 8 tiles.

With tiling:
- each value from A is loaded once
- each value from B is loaded once

So:
- A accesses = N^2
- B accesses = N^2

Total accesses = 2N^2

Total DRAM traffic = 2N^2 * 4 = 8N^2 bytes

---

## 3. Ratio

Naive / Tiled = (8N^3) / (8N^2) = N

Explanation:
In tiling we reuse data, so we don’t load the same values again and again.

---

## 4. Execution time

Given:
- DRAM bandwidth = 320 GB/s
- Compute = 10 TFLOPS

Total work = 2N^3 FLOPs

### Naive

Memory time = (8N^3) / (320e9)  
Compute time = (2N^3) / (10e12)  

Memory time is bigger → memory is the bottleneck

Naive = memory-bound

---

### Tiled

Memory time = (8N^2) / (320e9)  
Compute time = (2N^3) / (10e12)  

Now memory is much smaller, so compute dominates

Tiled = compute-bound
