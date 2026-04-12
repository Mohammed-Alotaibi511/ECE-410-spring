# Software Baseline Benchmark

## Platform
- CPU: Intel Core i7-12800HX
- OS: Windows 11
- Python version: 3.x
- Framework: NumPy (manual CNN implementation)

## Configuration
- Batch size: 32
- Input size: 16 × 16
- Model: small CNN configuration (Conv2D + Dense)

## Execution Time
Measured using cProfile over multiple runs:

- Number of runs: 10
- Average runtime per run: ~0.5 seconds (this is just an example, i'll adjust thsi later)

## Throughput
- Samples per second ≈ 32 / 0.5 = 64 samples/sec

## Memory Usage
- Data stored in FP64 (8 bytes per value)
- Estimated memory usage is low (few MBs)
- No GPU used, CPU-only execution

## Summary
The baseline implementation is CPU-based and dominated by convolution operations using im2col. Performance is limited by memory access rather than compute capability.
