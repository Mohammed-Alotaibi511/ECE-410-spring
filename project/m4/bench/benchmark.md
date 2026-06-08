# Benchmark Results

## Assumptions

The hardware accelerator has not yet been benchmarked on FPGA hardware. Therefore, projected hardware performance is used based on synthesis results and simulation.

Clock frequency:

100 MHz

Useful operations per cycle:

1 MAC/cycle

1 MAC = 2 FLOPs

Projected accelerator throughput:

100 MHz × 2 FLOPs

= 200 MFLOP/s

= 0.2 GFLOP/s

---

| Metric | M1 Software Baseline | Hardware Accelerator (Projected) |
|----------|----------|----------|
| Execution Time | 1.0 ms | 0.346 ms |
| Throughput | 69.2 MFLOP/s | 200 MFLOP/s |
| Memory Usage | 49,981 bytes | 49,981 bytes |
| Source | Measured/Estimated SW | Projected from synthesis |

---

## Speedup

Speedup = HW Throughput / SW Throughput

Speedup = 200 / 69.2

Speedup = 2.89×

---

## Energy Efficiency

Power report exists, but accurate workload energy was not measured.

Energy efficiency improvement is therefore not reported and would require FPGA or silicon measurements.
