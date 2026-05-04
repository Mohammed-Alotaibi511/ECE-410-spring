# M2

## Overview

This milestone implements a simple hardware accelerator for a convolution-like operation using a MAC-based compute core. The design is written in synthesizable SystemVerilog and verified using testbenches.

---

## Simulator

Icarus Verilog (iverilog)
Tested in VM environment

---

## How to run

### Compute Core

```
iverilog -g2012 -o compute_core_sim tb/tb_compute_core.sv rtl/compute_core.sv
vvp compute_core_sim
```

To save log:

```
vvp compute_core_sim > sim/compute_core_run.log
```

---

### Interface Module

```
iverilog -g2012 -o interface_sim tb/tb_interface.sv rtl/interface.sv rtl/compute_core.sv
vvp interface_sim
```

To save log:

```
vvp interface_sim > sim/interface_run.log
```

---

## Output

* Logs are saved in `sim/`
* Waveform is generated as `sim/wave.vcd`
* Screenshot saved as `sim/waveform.png`

---

## Notes

* Testbenches compare expected values and print PASS/FAIL
* Design uses INT8 inputs and INT32 accumulation
* Simple valid signal interface is used

---

## Deviations from M1

No major deviations. The design implements a simplified MAC-based compute core instead of a full convolution engine, focusing on correctness and basic dataflow.

---
