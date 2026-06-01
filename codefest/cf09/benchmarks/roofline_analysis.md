# Roofline Analysis

The accelerator point is based on projected throughput from synthesis results because a complete hardware benchmark is not yet available. The arithmetic intensity values from CF09 range from approximately 0.818 FLOP/byte with no reuse to 1.384 FLOP/byte with perfect weight reuse.

The projected throughput is 0.2 GFLOP/s based on a 100 MHz clock and one MAC per cycle. This places the accelerator near the roofline compute ceiling. The lower arithmetic-intensity bound remains memory-bound because it falls below the ridge point. The upper arithmetic-intensity bound crosses the ridge point and becomes compute-bound.

The dominant uncertainty in this projection is the assumption that the accelerator sustains one MAC every clock cycle with no stalls from memory transfers or interface overhead. To convert this projection into a true measurement, a complete end-to-end benchmark running on FPGA or post-layout simulation would be required. That benchmark would measure actual execution time, bandwidth utilization, and achievable throughput under realistic workloads.
