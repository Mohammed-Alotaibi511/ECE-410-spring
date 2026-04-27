# MAC Code Review

## Models used
- LLM A: ChatGPT
- LLM B: Gemini

## Specification
Module name: mac  
Inputs: clk, rst, signed 8-bit a, signed 8-bit b  
Output: signed 32-bit accumulator out  
Behavior: On each rising clock edge, if rst is high, set out to 0; otherwise add a*b to out.  
Constraint: Synthesizable SystemVerilog only, use always_ff.

---

## Issue 1: Reset polarity error in mac_llm_B.v

Offending line:
```systemverilog
if (!rst)
```
This is wrong becasue the specification needs an active high reset. but this line makes the reset active low, so the accumulator resets when rst = 0 instead of rst = 1.

Corrected version:
```systemverilog
if (rst)
    out <= 32'sd0;
else
    out <= out + product;
```
## Issue 2: Missing explicit sign extension

Offending line:
```systemverilog
out <= out + a * b;
```
It's wrong because the multiplication output is 16 bit signed, but the accumulator is 32 bit.

Corrected version:
```systemverilog
logic signed [15:0] product;
assign product = a * b;
out <= out + {{16{product[15]}}, product};
```
