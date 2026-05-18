# Codefest 7 CMAN: Sparsity Breakeven Analysis

## Given

N = 512  
Dense storage = 4 bytes per FP32 weight  
Sparsity s = fraction of zeros  
Nonzero fraction = 1 - s  

N² = 512² = 262,144

---

## 1. Expressions

### (a) Dense MVM compute

Dense MVM performs N² MACs.

Each MAC = 2 FLOPs.

Dense FLOPs:

2N²

For N = 512:

2(512²) = 524,288 FLOPs

---

### (b) Dense memory bytes

Dense memory stores all N² FP32 weights.

Dense bytes:

4N²

For N = 512:

4(512²) = 1,048,576 bytes

---

### (c) Sparse compute

Sparse computation only uses nonzero weights.

Nonzeros:

(1 - s)N²

Sparse FLOPs:

2(1 - s)N²

---

### (d) Sparse memory bytes

CSR uses:
- values array: 4 bytes per nonzero
- column index array: 4 bytes per nonzero
- row pointer array: 4(N + 1) bytes

Sparse bytes:

4(1 - s)N² + 4(1 - s)N² + 4(N + 1)

Sparse bytes:

8(1 - s)N² + 4(N + 1)

---

## 2. FLOPs Speedup

Speedup = dense FLOPs / sparse FLOPs

Speedup = 2N² / [2(1 - s)N²]

Speedup = 1 / (1 - s)

For 2x speedup:

2 = 1 / (1 - s)

1 - s = 0.5

s = 0.5

So the FLOPs speedup is 2x when:

s = 50%

---

## 3. Memory Breakeven

Set sparse memory bytes = to dense memory bytes:

8(1 - s)N² + 4(N + 1) = 4N²

For N = 512:

8(1 - s)(512²) + 4(513) = 4(512²)

8(1 - s)(262,144) + 2,052 = 1,048,576

8(1 - s)(262,144) = 1,046,524

1 - s = 1,046,524 / 2,097,152

1 - s = 0.4990

s = 0.5010

So the memory breakeven sparsity is about:

s = 50.1%

Above about 50.1% sparsity, CSR sparse format uses less memory than dense storage.

---

## 4. End-to-End Speedup at s = 0.9

For a memory bound system execution time is mostly on memory bytes.

Dense bytes:

4N² = 1,048,576 bytes

Sparse bytes:

8(1 - s)N² + 4(N + 1)

At s = 0.9:

Sparse bytes = 8(0.1)(512²) + 4(513)

Sparse bytes = 209,715.2 + 2,052

Sparse bytes = 211,767.2 bytes

End to end speedup:

Speedup = dense bytes / sparse bytes

Speedup = 1,048,576 / 211,767.2

Speedup = 4.95x

So at s = 0.9, the memory bound end to end speedup is around:

4.95x
