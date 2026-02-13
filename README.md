# Asynchronous FIFO (Dual Clock FIFO - Verilog)

## Overview

This project implements a parameterized Asynchronous FIFO in Verilog, designed to safely transfer data between two independent clock domains.

The design uses Gray code pointer synchronization to avoid metastability and ensure reliable full/empty detection.

---

## Design Features

- Independent write and read clocks
- Gray code pointer conversion
- Two-flop synchronizers for CDC
- Full and Empty flag generation
- Parameterized data width and depth
- Registered read output
- Self-checking behavioral testbench

---

## Architecture

The FIFO consists of the following blocks:

1. Write Pointer Handler  
   - Binary to Gray conversion  
   - Full flag logic  

2. Read Pointer Handler  
   - Gray to Binary synchronization  
   - Empty flag logic  

3. Dual Port Memory  

4. Two-stage Synchronizers  
   - Write pointer synced into read clock domain  
   - Read pointer synced into write clock domain  

---

## Full and Empty Detection Logic

Full condition:
When next write pointer equals read pointer with MSBs inverted (Gray code comparison).

Empty condition:
When synchronized write pointer equals read pointer.

---

## Simulation Details

- Verified using behavioral testbench
- Independent read and write clocks
- Multiple write/read bursts
- Verified boundary conditions:
  - Reset behavior
  - Full condition
  - Empty condition
  - Pointer wrap-around

---

## Directory Structure


```
NEW_SYNCHRONOUS_FIFO.srcs/
│
├── sources_1(rtl)/
│   ├── fifo_top.v         // Top-level FIFO module
│   ├── fifo_mem.v         // Dual-port memory
│   ├── wptr_handler.v     // Write pointer + full logic
│   ├── rptr_handler.v     // Read pointer + empty logic
│   ├── synchronizer.v     // 2-flop CDC synchronizer
│
├── sim_1(tb)/
│   └── fifo_tb.v          // Behavioral testbench
│
└── README.md
```

---

## Key Concepts Demonstrated

- Clock Domain Crossing (CDC)
- Gray code pointer synchronization
- Metastability mitigation
- Dual clock FIFO design methodology

---

## Future Improvements

- Add SystemVerilog assertions
- Add UVM-based verification
- Add formal verification
- Add synthesis and timing reports

---
