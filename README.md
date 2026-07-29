<div align="center">
     
# Neural Network MAC Unit



## Softwares Used


| Software | Purpose |
| :--- | :--- |
| **`Icarus Verilog`** | Code simulation and testing |
| **`Yosys`** | Hardware logic synthesis (Gate mapping) |
| **`NextPNR`** | FPGA layout, placement, and routing |
| **`Icetime`** | Hardware timing analysis |
| **`OSS CAD Suite`**| A bundled toolkit containing Yosys, NextPNR, and Icetime |

---
</div>

This project builds the core math unit of a neural network neuron in hardware. A neuron simply multiplies inputs by weights, adds them up, and passes the result through an activation function (ReLU):

`neuron_output = ReLU( (x1*w1) + (x2*w2) + ... )`

This project implements that math using actual digital logic gates, built entirely from scratch without using any built-in `+` or `*` operators.


<img width="500" height="780" alt="WhatsApp Image 2026-07-17 at 5 28 20 PM" src="https://github.com/user-attachments/assets/3715b1dc-e438-40db-be5b-ebc75e16be8b" />


<img width="500" height="780" alt="diagram (1)" src="https://github.com/user-attachments/assets/7cca7eab-1777-4ecd-a59a-aab898e11e2f" />



## How to Simulate the Code
To test the code and simulate the hardware behavior in your terminal, run the following commands (you must have Icarus Verilog installed):

```bash
iverilog -o mac_sim mac_tb.v mac_unit.v multiplier.v ripple_adder_16.v accumulator.v half_adder.v full_adder.v
vvp mac_sim
```

## How to Synthesize for Hardware (Windows)
You can compile this code into real hardware logic using Yosys and the OSS CAD Suite. 

<img width="580" height="752" alt="Design Hierarchy" src="https://github.com/user-attachments/assets/f4870a35-ac27-41e8-b5df-6b654be60c43" />

I have provided a Windows Batch script that automatically sets up the environment and runs the entire pipeline (Synthesis, Placement, Routing, and Timing Analysis) for an iCE40 FPGA.

To run it, simply run this command in your terminal:

```cmd
run_synthesis.bat
```
