
## 1. Scale factor

Using symmetric per-tensor quantization:

S = max(|W|) / 127

max(|W|) = 2.31

S = 2.31 / 127 = 0.01819

## 2. Quantized INT8 matrix

W_q = round(W / S), clamped to [-128, 127]

W_q =
[ [  47,  -66,   19,  115 ],
  [  -4,   50, -103,    7 ],
  [  85,    2,  -24, -127 ],
  [ -10,   57,   42,   30 ] ]

## 3. Dequantized FP32 matrix

W_deq = W_q × S

W_deq =
[ [  0.8549, -1.2005,  0.3456,  2.0917 ],
  [ -0.0728,  0.9094, -1.8735,  0.1273 ],
  [  1.5461,  0.0364, -0.4365, -2.3100 ],
  [ -0.1819,  1.0368,  0.7639,  0.5457 ] ]

## 4. Error analysis

Absolute error = |W - W_deq|

Largest error:

Original value = 2.10  
Dequantized value = 2.0917  
Error = |2.10 - 2.0917| = 0.0083

Largest-error element is row 1, column 4.

MAE = mean absolute error over all 16 elements

MAE ≈ 0.00433

## 5. Bad scale experiment

Use:
S_bad = 0.01

W_q_bad = round(W / S_bad), clamped to [-127, 127]

W_q_bad = [[85, -120, 34, 127], [-7, 91, -127, 12], [127, 3, -44, -127], [-18, 103, 77, 55]]

W_deq_bad = W_q_bad × S_bad

W_deq_bad = [[0.85, -1.20, 0.34, 1.27], [-0.07, 0.91, -1.27, 0.12], [1.27, 0.03, -0.44, -1.27], [-0.18, 1.03, 0.77, 0.55]]

MAE_bad ≈ 0.17125

When S is too small, values exceed the INT8 range and are clamped to [-127,127], and this causes saturation error.
