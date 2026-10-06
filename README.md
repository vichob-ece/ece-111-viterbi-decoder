In the Winter 2025 academic term, the ECE 111 Term Project was to design a Viterbi Decoder in SystemVerilog, using designs from previous lab assignments and some starter-code. The design would be verified through a test bench provided by the professor.

Part 1 of the assignment was to simply design the Viterbi Decoder and verify the design with clean bits encoded by a standard convolutional coder. I proved synthesis with Quartus Prime's RTL viewer diagram and a utilization report. With zero injected corrupt bits, the ModelSim transcript would show that out of 256 trials, all inputs were correctly decoded.

In Part 2, I tested the robustness of our designs. By injecting bit inversions (errors) between the encoder and decoder, I documented the dimensions of corruption, including frequency of corruption, type of corruption, duration of corruption, and frequency of corruption.
