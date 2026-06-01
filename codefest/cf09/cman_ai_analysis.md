# Codefest 9 CMAN: Arithmetic Intensity Analysis

## 1. Dominant Kernel

The dominant kernel in my accelerator is CNN convolution.

Kernel dimensions:

- Input feature map: 64 × 64
- Kernel/filter size: 3 × 3
- Input channels: 1
- Output channels: 1
- Stride: 1
- Padding: none
- Output feature map: 62 × 62

Data types:

- Input activations: INT8, 1 byte each
- Weights: INT8, 1 byte each
- Output accumulations: INT32, 4 bytes each

the reuse pattern:
This is a convolution weight reuse pattern. The same 3 × 3 filter weights are reused on all output pixels.

## 2. FLOPs Count

Formula:

FLOPs = 2 × H_out × W_out × K_h × K_w × C_in × C_out

Substitute:

FLOPs = 2 × 62 × 62 × 3 × 3 × 1 × 1

FLOPs = 2 × 62 × 62 × 9

FLOPs = 69,192 FLOPs

MACs:

MACs = 62 × 62 × 9

MACs = 34,596 MACs

Since each MAC is 2 FLOPs:

2 × 34,596 = 69,192 FLOPs

## 3. Bytes Transferred: No Data Reuse

Assume no data reuse. For every MAC, the accelerator reads:

- 1 input activation = 1 byte
- 1 weight = 1 byte

Each output is written once as INT32:

- 1 output = 4 bytes

Input and weight bytes:

Bytes input weight = MACs × 2 bytes

Bytes input weight = 34,596 × 2

Bytes input weight = 69,192 bytes

Output bytes:

Bytes output = 62 × 62 × 4

Bytes output = 15,376 bytes

Total no reuse bytes:

Bytes no reuse = 69,192 + 15,376

Bytes no reuse = 84,568 bytes

## 4. Arithmetic Intensity: No Data Reuse

Formula:

AI = FLOPs / bytes

AI no reuse = 69,192 / 84,568

AI no reuse = 0.818 FLOP/byte

So that means the lower bound arithmetic intensity is:

AI no reuse = 0.818 FLOP/byte

## 5. Bytes Transferred: Perfect Weight Reuse

Assume perfect on chip weight reuse. The 3 × 3 filter weights are loaded once and reused for all output pixels.

Input bytes:

Bytes input = MACs × 1 byte

Bytes input = 34,596 bytes

Weight bytes:

Bytes weight = 3 × 3 × 1 byte

Bytes weight = 9 bytes

Output bytes:

Bytes output = 62 × 62 × 4

Bytes output = 15,376 bytes

Total bytes with perfect weight reuse:

Bytes weight reuse = 34,596 + 9 + 15,376

Bytes weight reuse = 49,981 bytes

## 6. Arithmetic Intensity: Perfect Weight Reuse

Formula:

AI = FLOPs / bytes

AI weight reuse = 69,192 / 49,981

AI weight reuse = 1.384 FLOP/byte

So that means the upper bound arithmetic intensity is:

AI_weight_reuse = 1.384 FLOP/byte


## 7. Roofline Numbers

Target synthesis platform:

- OpenLane 2 / sky130 ASIC flow
- Clock period used: 10 ns
- Clock frequency: 100 MHz

Assume the current hardware core can perform one MAC per cycle.

Peak compute:

1 MAC/cycle × 2 FLOPs/MAC × 100 MHz

Peak compute = 200 MFLOP/s

Peak compute = 0.2 GFLOP/s

Assume the interface can provide two INT8 operands per cycle:

2 bytes/cycle × 100 MHz = 200 MB/s

Bandwidth ceiling:

BW = 0.2 GB/s

Ridge point:

Ridge point = peak compute / bandwidth

Ridge point = 0.2 GFLOP/s / 0.2 GB/s

Ridge point = 1 FLOP/byte

## 8. Attainable Performance Range

No reuse case:

AI = 0.818 FLOP/byte

Performance = AI × BW

Performance = 0.818 × 0.2

Performance = 0.164 GFLOP/s

Perfect weight-reuse case:

AI = 1.384 FLOP/byte

Performance = AI × BW

Performance = 1.384 × 0.2

Performance = 0.277 GFLOP/s

But performance cannot exceed the compute ceiling:

Attainable performance = 0.2 GFLOP/s

So the attainable performance range is:

0.164 GFLOP/s to 0.2 GFLOP/s

## 9. Bottleneck Identification

The no reuse case has AI = 0.818 FLOP/byte, that's is below the ridge point of 1 FLOP/byte. That means the design is memory bound when data reuse is poor.

The perfect weight reuse case has AI = 1.384 FLOP/byte, whichs above the ridge point. That means the design can be compute bound after weight reuse improves.

Current bottleneck:

The design is limited by memory/interface bandwidth when input and weight data are repeatedly loaded from off chip memory.

## 10. Highest-Leverage Improvement

The highest leverage improvement is to add on chip buffering for convolution weights and input tiles.

That would make the accelerator to reuse the 3 × 3 filter weights and nearby input pixels instead of repeatedly loading them from the off chip memory. That increases arithmetic intensity, and reduces memory traffic, and moves the design closer to the compute bound region of the roofline plot.
