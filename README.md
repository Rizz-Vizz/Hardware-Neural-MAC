<div align="center">
# Neural Network MAC Unit — Hardware Accelerator

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

## What is this?
This project builds the core math unit of a neural network neuron in hardware. A neuron simply multiplies inputs by weights, adds them up, and passes the result through an activation function (ReLU):

`neuron_output = ReLU( (x1*w1) + (x2*w2) + ... )`

![Handwritten Note](notes.jpg)

This project implements that math using actual digital logic gates, built entirely from scratch without using any built-in `+` or `*` operators.


```
half_adder.v
     └── used by full_adder.v
              └── used by ripple_adder_16.v (16 copies, chained)
                       ├── used by multiplier.v (8 copies, shift-and-add)
                       └── used directly inside mac_unit.v / mac_unit_pipelined.v (accumulate step)

multiplier.v ──┐
               ├──> mac_unit.v            (single-cycle MAC)
accumulator.v ─┘

multiplier.v ──┐
               ├──> mac_unit_pipelined.v  (two-cycle pipelined MAC)
accumulator.v ─┘

mac_unit_pipelined.v ──┐
                        ├──> neuron_layer.v  (x4, running in parallel)
relu.v ─────────────────┘
```

## How to Simulate the Code
To test the code and simulate the hardware behavior in your terminal, run the following commands (you must have Icarus Verilog installed):

```bash
iverilog -o mac_sim mac_tb.v mac_unit.v multiplier.v ripple_adder_16.v accumulator.v half_adder.v full_adder.v
vvp mac_sim
```

## How to Synthesize for Hardware (Windows)
You can compile this code into real hardware logic using Yosys and the OSS CAD Suite. 

![Yosys Terminal Output](terminal.jpg)

I have provided a Windows Batch script that automatically sets up the environment and runs the entire pipeline (Synthesis, Placement, Routing, and Timing Analysis) for an iCE40 FPGA.

To run it, simply run this command in your terminal:

```cmd
run_synthesis.bat
```