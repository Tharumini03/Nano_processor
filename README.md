<h1 align="center">🧠 4-Bit Nano Processor (VHDL)

<small>Semester 2 — Computer Organization & Digital Design</small></h1>

<p align="center"> <img src="https://img.shields.io/badge/Language-VHDL-blue?style=for-the-badge"> <img src="https://img.shields.io/badge/Platform-Basys3%20FPGA-orange?style=for-the-badge"> <img src="https://img.shields.io/badge/Status-Completed-success?style=for-the-badge"> <img src="https://img.shields.io/badge/Team%20Project-Yes-purple?style=for-the-badge"> </p>

<h2>📌 Overview</h2>

This repository contains the complete implementation of a custom-designed 4-bit Nano Processor, developed as a team project for the CS1050 — Computer Organization & Digital Design module.

The processor was built using a modular VHDL design, simulated via Xilinx Vivado, and tested on a BASYS-3 FPGA board.

<h2>🧩 Instruction Set Architecture</h2>

The processor supports a compact 12-bit instruction format, enabling arithmetic, logic, data movement, and branching.
| Instruction    | Purpose        | Format                  | Description      |
| -------------- | -------------- | ----------------------- | ---------------- |
| **MOVI R, d**  | Load immediate | `10 RRR 000 dddd`       | R ← d            |
| **ADD Ra, Rb** | Add registers  | `00 RaRaRa RbRbRb 0000` | Ra ← Ra + Rb     |
| **NEG R**      | 2’s complement | `01 RRR 0000000`        | R ← –R           |
| **JZR R, d**   | Jump if zero   | `11 RRR 0000 ddd`       | If R==0 → PC ← d |

<h2>🔧 Major Components</h2>

* Program Counter (PC) — 3-bit, jump-enabled

* Program ROM — stores binary instructions

* Instruction Decoder — converts opcode → control signals

* Register Bank (8 × 4-bit)

* ALU (Add / Sub / NEG)

* Multiplexers (8×4-bit, 2×4-bit, 2×3-bit)

* Slow Clock Divider

* Top-Level Processor Integration

</details>

<h2>⚙️ Features</h2>
<ul style="font-size: 16px;"> <li>🟦 <strong>Modular VHDL Design</strong> — clean separation of components</li> <li>⚡ <strong>Carry Lookahead ALU</strong> for faster operations</li> <li>🔁 <strong>Full instruction cycle</strong> (Fetch → Decode → Execute → Writeback)</li> <li>🧪 <strong>All modules testbench-verified</strong> with waveforms</li> <li>💡 <strong>BASYS-3 FPGA implementation</strong> with LED & 7-segment output</li> </ul>

<h2>🧪 Simulation & Testing</h2>

✔ Individual testbenches for PC, ROM, Register Bank, ALU, MUXes

✔ Elaborated schematics + timing diagrams

✔ Full CPU simulation testbench

✔ Real FPGA testing on BASYS-3 development board

<h2>🚀 How to Run</h2>
🔧 1. Open in Vivado

   * Create a new Vivado project

   * Add all .vhd files from src/

   * Set NanoProcessor as the top module

▶️ 2. Run Simulation

   * Add testbenches from sim/

   * Run behavioral simulation

💡 3. FPGA Deployment

   * Use the .xdc constraint file

   * Generate bitstream

   * Program FPGA
