# Codefest 8 CMAN: AER Bandwidth Analysis

## 1. Mean Aggregate Spike Rate

R = N × f

R = 1024 × 50

R = 51,200 spikes/second

 the mean aggregate spike rate is:

R = 51,200 spikes/s

---

## 2. Mean Required AER Bandwidth

Formula:

B = R × 20

B = 51,200 × 20

B = 1,024,000 bits/second

Convert to Mbit/s:

B = 1.024 Mbit/s

the mean required AER bandwidth is:

B = 1.024 Mbit/s

---

## 3. Interface Comparison

Mean required bandwidth:

1.024 Mbit/s

| Interface | Bandwidth | Can Sustain Mean Rate? |
|----------|-----------|-------------------------|
| SPI | ≤ 50 Mbit/s | Yes |
| I²C | ≤ 3.4 Mbit/s | Yes |
| AXI4-Lite | 100 Mbit/s | Yes |

All three interfaces can sustain the mean rate.

The lowest complexity interface that is sufficient is:

I²C

Because:

I²C bandwidth = 3.4 Mbit/s

3.4 Mbit/s > 1.024 Mbit/s

So I²C can support the mean AER bandwidth.

---

## 4. Burst Analysis

25% of the 1024 neurons fire in a 1 ms window.

Number of neurons firing:

0.25 × 1024 = 256 neurons

Each spike packet is 20 bits.

Total burst bits:

256 × 20 = 5120 bits

Burst time window:

1 ms = 0.001 s

Peak instantaneous bandwidth:

B_peak = 5120 bits / 0.001 s

B_peak = 5,120,000 bits/s

B_peak = 5.12 Mbit/s

the burst peak bandwidth is:

5.12 Mbit/s

---

## Burst-to-Mean Ratio

Mean bandwidth:

B_mean = 1.024 Mbit/s

Burst bandwidth:

B_peak = 5.12 Mbit/s

Ratio:

B_peak / B_mean = 5.12 / 1.024

B_peak / B_mean = 5

the burst bandwidth is 5× larger than the mean bandwidth.

---

## Buffering Decision

The chosen lowest complexity interface from task 3 was I²C.

I²C bandwidth:

3.4 Mbit/s

Burst bandwidth:

5.12 Mbit/s

Because:

5.12 Mbit/s > 3.4 Mbit/s

I²C can't absorb the burst directly, buffering is needed to happen.

Excess bandwidth:

5.12 Mbit/s - 3.4 Mbit/s = 1.72 Mbit/s

Extra data during 1 ms:

1.72 × 10^6 bits/s × 0.001 s = 1720 bits

Convert to bytes:

1720 / 8 = 215 bytes

the buffer should be at least about:

215 bytes

I²C is good for the mean rate, but isn't for the burst rate. A buffer of around 215 bytes is needed to absorb the burst.

---

## 5. Frame-Based Comparison

A conventional frame based readout samples all 1024 neurons every 1 ms.

Each neuron sends 1 bit per sample.

Bits per frame:

1024 bits

Sampling rate:

1 frame every 1 ms = 1000 frames/s

Frame-based bandwidth:

B_frame = 1024 × 1000

B_frame = 1,024,000 bits/s

B_frame = 1.024 Mbit/s

So the frame-based bandwidth is:

1.024 Mbit/s

---

## AER-to-Frame Bandwidth Ratio at f = 50 Hz

AER bandwidth:

B_AER = 1.024 Mbit/s

Frame bandwidth:

B_frame = 1.024 Mbit/s

Ratio:

B_AER / B_frame = 1.024 / 1.024

Ratio = 1

So at f = 50 Hz, AER and the frame based readout use the same bandwidth.

---

## Crossover Firing Rate

Set AER bandwidth equal to the frame based bandwidth:

20 × N × f = 1024 × 1000

N = 1024

20 × 1024 × f = 1,024,000

Divide both sides by 1024:

20f = 1000

f = 50 Hz

So that means the crossover firing rate is:

f_crossover = 50 Hz

---

## Implication

AER is the better choice when firing activity is little or below the crossover firing rate, because it only sends packets when spikes happen instead of constantly sending every neuron state.
