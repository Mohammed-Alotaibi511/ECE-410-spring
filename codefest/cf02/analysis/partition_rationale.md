# HW/SW Partition Rationale

The kernel selected for hardware acceleration is the convolution forward operation implemented using the im2col method. Profiling results show that this part dominates execution time, making it the most important target for optimization.

The software baseline will continue to handle training control flow, data loading, loss computation, and parameter updates. These tasks are less computationally intensive and benefit from flexibility in software.

The arithmetic intensity of the kernel is approximately 1.06 FLOP/byte, while the ridge point of the system is around 20 FLOP/byte. Since the kernel lies far below the ridge point, it is memory-bound. This means performance is limited by memory bandwidth rather than compute capability.

To avoid becoming interface-bound, the accelerator must support sufficient memory bandwidth to feed data to the compute units. Techniques such as buffering, tiling, and data reuse can reduce memory traffic and improve effective bandwidth.

A custom hardware accelerator can improve performance by reducing unnecessary data movement and increasing locality. By keeping data on-chip and reusing it efficiently, the design can move closer to the ridge point and achieve higher performance.
