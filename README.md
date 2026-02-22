# Moore 101 Sequence Detector with SystemVerilog Assertions

In this project I have implemented an overlapping Moore FSM to detect the sequence "101" using SystemVerilog.

## Commands to run this file 
```bash
qverilog fsm_assertions.sv fsm.sv fsm_tb.sv 
```
## Design Overview
- Moore state machine (output depends only on state)
- Overlapping sequence detection 
- Four states: S0, S1, S2, S3

## The Verification Approach I followed
- Separate module for assertion "bind" in testbench. 
- State transition verification 
- Output correctness checking
- Sequence validated using SVA properties
- Reset-safe properties using `disable iff`

## Tools Used
- _QuestaSim_
- _Vscode_

## What I learned
- Understanding SVA sampling regions
- Handling `$past` correctly 
- How to Bind the assertion module properly

---
Thank you for your precious time and patience.
Author: Siddharth