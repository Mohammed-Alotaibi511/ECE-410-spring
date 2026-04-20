# CodeFest 3 – CMAN: DRAM Traffic Analysis

## 1. Naive Triple Loop (ijk order)

For one output element:

\[
C[i][j] = \sum_{k=0}^{N-1} A[i][k] \cdot B[k][j]
\]

Each computation:
- Reads **N elements from A**
- Reads **N elements from B**

Across the full \(N \times N\) output:
- A accesses = \(N^3\)
- B accesses = \(N^3\)

Total element accesses:
\[
2N^3
\]

Assuming FP32 (4 bytes per element):

\[
\text{Total DRAM traffic} = 2N^3 \cdot 4 = 8N^3 \text{ bytes}
\]

---

## 2. Tiled Matrix Multiply (T = 8)

The matrix is divided into \(8 \times 8\) tiles.

Each element of A and B is loaded **once** from DRAM and reused from shared memory.

- A loads = \(N^2\)
- B loads = \(N^2\)

Total element loads:
\[
2N^2
\]

Total DRAM traffic:
\[
2N^2 \cdot 4 = 8N^2 \text{ bytes}
\]

---

## 3. Traffic Ratio

\[
\frac{\text{Naive traffic}}{\text{Tiled traffic}} = \frac{8N^3}{8N^2} = N
\]

**Explanation (one sentence):**  
The tiled version reduces DRAM traffic by reusing data in shared memory, so each element is loaded once instead of being reloaded \(N\) times.

---

## 4. Execution Time and Bottleneck

Given:
- DRAM bandwidth = 320 GB/s = \(320 \times 10^9\) bytes/s  
- Compute = 10 TFLOPS = \(10 \times 10^{12}\) FLOP/s  

Total FLOPs:
\[
2N^3
\]

---

### Naive Case

Memory time:
\[
t_{\text{mem}} = \frac{8N^3}{320 \times 10^9}
\]

Compute time:
\[
t_{\text{compute}} = \frac{2N^3}{10 \times 10^{12}}
\]

Since memory time is much larger than compute time:

\[
\textbf{Naive is memory-bound}
\]

---

### Tiled Case

Memory time:
\[
t_{\text{mem}} = \frac{8N^2}{320 \times 10^9}
\]

Compute time:
\[
t_{\text{compute}} = \frac{2N^3}{10 \times 10^{12}}
\]

Since DRAM traffic is greatly reduced, compute dominates:

\[
\textbf{Tiled is compute-bound}
\]

---

## Final Summary

| Method | DRAM Traffic | Bottleneck |
|-------|-------------|-----------|
| Naive | \(8N^3\) bytes | Memory-bound |
| Tiled | \(8N^2\) bytes | Compute-bound |
