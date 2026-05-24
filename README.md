# Asynchronous FIFO (Dual-Clock · Gray-Code Pointers)

| | |
|---|---|
| **Type** | RTL IP block · Clock Domain Crossing |
| **Language** | Verilog |
| **Tools** | Vivado · ModelSim/XSim · GTKWave |
| **Related** | [CDC_TECHNIQUES](https://github.com/RAJ-07-RAJ/CDC_TECHNIQUES) · [FIFO_S](https://github.com/RAJ-07-RAJ/FIFO_S) |

---

## Overview

Parameterized **asynchronous FIFO** for safe data transfer between independent write and read clock domains.

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

## Directory structure

```
FIFO_ASYNC/
├── NEW_SYNCHRONOUS_FIFO.srcs/
│   ├── sources_1/new/          # RTL
│   │   ├── fifo_top.v          # Top-level async FIFO
│   │   ├── fifo_mem.v          # Dual-port memory
│   │   ├── wptr_handler.v      # Write pointer + Gray + full
│   │   ├── rptr_handler.v      # Read pointer + Gray + empty
│   │   └── synchronizer.v      # 2-FF CDC synchronizer
│   └── sim_1/new/
│       └── fif0_tb.v           # Dual-clock testbench
└── README.md
```

## Simulation (Vivado / XSim)

1. Open `NEW_SYNCHRONOUS_FIFO.xpr` in Vivado, or
2. Add all `sources_1/new/*.v` + `sim_1/new/fif0_tb.v` to your simulator file list
3. Run behavioral simulation and probe `wclk` / `rclk` pointer sync and full/empty flags

## Recruiter checklist

| Item | Covered |
|------|---------|
| Gray-code pointer CDC | Yes |
| Dual-clock TB | Yes |
| Full / empty boundary tests | Yes |
| Modular RTL decomposition | Yes |

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
