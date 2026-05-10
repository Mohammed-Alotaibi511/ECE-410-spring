# Codefest 6 CMAN: Sneak Paths in a Resistive Crossbar

## Given

R[0][0] = 1 kΩ  
R[0][1] = 2 kΩ  
R[1][0] = 2 kΩ  
R[1][1] = 1 kΩ  

V_row0 = 1 V  
col 0 = 0 V  


## 1. Ideal Read

In the ideal case, row 1 and col 1 are grounded.

Current through R[0][0]:

I_col0 = V / R

I_col0 = 1 V / 1 kΩ

I_col0 = 1 mA

So the ideal output current is:

**I_col0 = 1 mA**

---

## 2. Sneak Path Read

Now row 1 and col 1 are floating.

Let:

V_row1 = x  
V_col1 = y  

Using KCL:

At row 1:

x / 2k + (x - y) / 1k = 0

At col 1:

(y - 1) / 2k + (y - x) / 1k = 0

Solve:

V_row1 = 0.4 V

V_col1 = 0.6 V


## Actual Current Into Column 0

Direct intended current:

I_direct = 1 V / 1 kΩ = 1 mA

Sneak path current through R[1][0]:

I_sneak = 0.4 V / 2 kΩ = 0.2 mA

Total actual current:

I_col0 = I_direct + I_sneak

I_col0 = 1 mA + 0.2 mA

I_col0 = 1.2 mA

So the actual output current is:

**I_col0 = 1.2 mA**

---

## 3. Explanation

The sneak path adds extra current into column 0 that wasn't a part of the matrix vector multiplication result. That makes the sensed current larger than the actual real ideal value, so the output is corrupted. In large crossbar arrays sneak paths become more serious because a lot of unintended paths can contribute current.
