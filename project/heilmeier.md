# Heilmeier Questions

## 1. What are you trying to do?
I want to accelerate the convolution operation in a neural network used for image classification. The goal is to identify the bottleneck using profiling and improve its performance using a hardware accelerator.

## 2. How is it done today, and what are the limits?
Currently, the algorithm runs entirely in software on a CPU. Profiling shows that the convolution forward pass dominates runtime. The system is limited by memory bandwidth, as shown by the low arithmetic intensity compared to the ridge point.

## 3. What is new in your approach and why do you think it will be successful?
My approach is to focus on the dominant kernel identified through profiling and analyze it using the roofline model. By designing hardware specifically for this kernel and improving data reuse, the system can reduce memory bottlenecks and achieve higher performance.
