# Codefest 5 CMAN: 2x2 Weight-Stationary Systolic Array

## PE Diagram

Weights are preloaded and stay fixed in the PEs.

|        | Column 0 | Column 1 |
|--------|----------|----------|
| Row 0  | PE[0][0] = B[0][0] = 5 | PE[0][1] = B[0][1] = 6 |
| Row 1  | PE[1][0] = B[1][0] = 7 | PE[1][1] = B[1][1] = 8 |

Inputs from A come from the left. Partial sums move downward.


## Cycle-by-Cycle Trace

A = [[1, 2], [3, 4]]

B = [[5, 6], [7, 8]]

Expected:

C = [[19, 22], [43, 50]]

| Cycle | Input Row 0 | Input Row 1 | PE[0][0] psum | PE[0][1] psum | PE[1][0] psum | PE[1][1] psum | Output C |
|------:|-------------|-------------|---------------|---------------|---------------|---------------|----------|
| 1 | 1 | - | 1×5 = 5 | 1×6 = 6 | - | - | - |
| 2 | - | 2 | - | - | 5 + 2×7 = 19 | 6 + 2×8 = 22 | C[0] = [19, 22] |
| 3 | 3 | - | 3×5 = 15 | 3×6 = 18 | - | - | - |
| 4 | - | 4 | - | - | 15 + 4×7 = 43 | 18 + 4×8 = 50 | C[1] = [43, 50] |

Final result:

C = [[19, 22], [43, 50]]


## Counts

### Total MAC operations

Matrix multiply size is 2×2×2.

Total MACs = 2 × 2 × 2 = 8 MACs


### Input reuse

Each input value from A is reused in 2 columns.

So each A value is reused 2 times.


### Off-chip memory accesses

A inputs: 4 reads

B weights: 4 reads

C outputs: 4 writes

Total off-chip accesses = 4 + 4 + 4 = 12 accesses


## Output-Stationary Answer

In output stationary dataflow the output partial sums C[i][j] stay fixed in the PEs while A and B values stream through.
