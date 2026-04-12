# Interface Selection

## Chosen Interface
PCIe (Peripheral Component Interconnect Express)

## Reason for Selection
I chose PCIe because it provides high bandwidth good for transferring large amounts of data between the CPU and the accelerator.

## Required Bandwidth

From previous analysis:

- Arithmetic intensity ≈ 1.06 FLOP/byte
- Target compute ≈ 800 GFLOP/s

Bandwidth required:

Bandwidth = Compute / AI  
= 800 / 1.06  
≈ 755 GB/s

## Interface Capability

Typical PCIe bandwidth:
- PCIe Gen4 x16 ≈ 32 GB/s
- PCIe Gen5 x16 ≈ 64 GB/s

## Comparison

Required bandwidth: ~755 GB/s  
Available bandwidth: ~32–64 GB/s  

## Conclusion

The interface is a major bottleneck. PCIe can't supply enough data to fully utilize the compute capability of the accelerator.

To reduce this bottleneck:
- Use on-chip memory
- Apply tiling and data reuse
- Minimize data transfers between host and accelerator

## Host Platform

- Host: CPU (Intel i7-12800HX)
- Accelerator: hypothetical hardware accelerator connected via PCIe
