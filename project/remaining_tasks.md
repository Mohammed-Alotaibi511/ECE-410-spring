# Remaining Tasks Before M4

1. Replace the projected accelerator benchmark with measured hardware results from FPGA or cycle-accurate simulation.

2. Add on-chip buffering for convolution weights and input tiles to increase arithmetic intensity and reduce off-chip memory traffic.

3. Increase compute parallelism from one MAC per cycle to multiple MACs per cycle to improve throughput beyond 0.2 GFLOP/s.

4. Perform a complete power analysis using representative workloads and compute energy efficiency metrics.

5. Verify end-to-end operation using larger CNN workloads and compare outputs against the software baseline.
