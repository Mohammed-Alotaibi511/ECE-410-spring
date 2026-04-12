## Dominant Kernel

The dominant kernel is the convolution operation implemented using the im2col method.

From profiling results:
- cnn.py:305 (forward) takes the largest cumulative time (~1.0 sec)
- cnn.py:91 (_im2col) also contributes significantly

This indicates that the convolution forward pass (im2col + matrix multiplication) dominates execution time.
