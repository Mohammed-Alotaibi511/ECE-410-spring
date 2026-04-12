# AI Calculation

## Dominant kernel
The dominant kernel is the convolution forward pass implemented with the `im2col` method.

From the profiler output:
- `cnn.py:305(forward)` has the largest cumulative runtime
- `cnn.py:91(_im2col)` is also a significant hotspot

This shows that the convolution forward path, especially `im2col`, dominates execution time.

## FLOPs
For one forward pass through a Conv2D layer:

FLOPs = 2 × N × C_in × k^2 × H_out × W_out × C_out

Using the small config from the run:
- N = 32
- C_in = 1
- k = 3
- H_out = 16
- W_out = 16
- C_out = 8

FLOPs = 2 × 32 × 1 × 3^2 × 16 × 16 × 8  
FLOPs = 2 × 32 × 1 × 9 × 256 × 8  
FLOPs = 1,179,648

## Bytes transferred
Assuming no reuse and all operands come from DRAM, using FP64 as stated in the course appendix for this sample code:

Input bytes = N × C_in × k^2 × H_out × W_out × 8  
= 32 × 1 × 9 × 16 × 16 × 8  
= 589,824 bytes

Weight bytes = C_out × C_in × k^2 × 8  
= 8 × 1 × 9 × 8  
= 576 bytes

Output bytes = N × C_out × H_out × W_out × 8  
= 32 × 8 × 16 × 16 × 8  
= 524,288 bytes

Total bytes = 589,824 + 576 + 524,288  
Total bytes = 1,114,688 bytes

## Arithmetic intensity
AI = FLOPs / Bytes

AI = 1,179,648 / 1,114,688  
AI ≈ 1.058 FLOP/byte

## Conclusion
The dominant kernel is the convolution forward pass using `im2col`. Its arithmetic intensity is about 1.06 FLOP/byte, which is relatively low compared with typical compute-bound kernels, so memory traffic is an important performance factor.
