# CodeFest 3 – CMAN: DRAM Traffic Analysis

## 1. Naive Triple Loop (ijk order)

For one output element:

C[i][j] = sum over k=0 to N-1 of A[i][k] * B[k][j]

Each computation:
- Reads N elements from A
- Reads N elements from B

Across the full (N × N) output:
- A accesses = N^3
- B accesses = N^3

Total element accesses:
2N^3

Assuming FP32 (4 bytes per element):

Total DRAM traffic = 2N^3 * 4 = 8N^3 bytes

---

## 2. Tiled Matrix Multiply (T = 8)

The matrix is divided into 8 × 8 tiles.

Each element of A and B is loaded once from DRAM and reused.

- A loads = N^2
- B loads = N^2

Total element loads:
2N^2

Total DRAM traffic:
2N^2 * 4 = 8N^2 bytes

---

## 3. Traffic Ratio

Naive / Tiled = (8N^3) / (8N^2) = N

Explanation:
The tiled version reuses data in shared memory, so each element is loaded once instead of N times.

---

## 4. Execution Time and Bottleneck

Given:
- DRAM bandwidth = 320 GB/s
- Compute = 10 TFLOPS

Total FLOPs:
2N^3

### Naive

Memory time:
t_mem = (8N^3) / (320 × 10^9)

Compute time:
t_compute = (2N^3) / (10 × 10^12)

Result:
Naive is memory-bound

---

### Tiled

Memory time:
t_mem = (8N^2) / (320 × 10^9)

Compute time:
t_compute = (2N^3) / (10 × 10^12)

Result:
Tiled is compute-bound

---

## Summary

| Method | DRAM Traffic | Bottleneck |
|--------|-------------|------------|
| Naive  | 8N^3 bytes  | Memory     |
| Tiled  | 8N^2 bytes  | Compute    |
