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
It was wrong because the specification requires a high reset. This line makes reset low, so the accumulator resets when rst = 0 instead of rst = 1.
