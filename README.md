# MIPS-16-Pipeline
This repository features a pipelined 16-bit MIPS processor in VHDL, supporting arithmetic, logical, memory, and control instructions. Designed for educational use, it demonstrates MIPS architecture with enhanced performance through pipelining. Includes test benches for hands-on experimentation.

## Description

This repository contains a sophisticated implementation of a pipelined 16-bit MIPS processor using VHDL. The processor supports a comprehensive range of MIPS instructions, including arithmetic, logical, memory access, and control operations, making it a versatile tool for various computational tasks. Designed primarily for educational purposes, this project serves as an exemplary model for understanding and experimenting with MIPS architecture and pipelining techniques. By incorporating pipelining, the processor significantly enhances instruction throughput, providing a more efficient execution model. The repository includes extensive test benches and example programs, enabling users to test and modify the processor according to their needs.

The instructions are encoded as follows:
```
1. ADD 000_SSS_TTT_DDD_0_000
2. SUB 000_SSS_TTT_DDD_0_001
3. SHL 000_SSS_TTT_DDD_1_010
4. SHR 000_SSS_TTT_DDD_1_011
5. AND 000_SSS_TTT_DDD_0_100
6. OR 000_SSS_TTT_DDD_0_101
7. XOR 000_SSS_TTT_DDD_0_110
8. NOT 000_SSS_TTT_DDD_0_111

9. ADDI 001_SSS_TTT_IIIIIII
10. SUBI 010_SSS_TTT_IIIIIII
11. LW 011_SSS_TTT_IIIIIII
12. SW 100_SSS_TTT_IIIIIII
13. BEQ 101_SSS_TTT_IIIIIII
14. BNE 110_SSS_TTT_IIIIIII

15. JMP 111_IIIIIIIIIIII
```
Where: 
* SSS represents the bit encoding of the Source Register
* TTT represents the bit encoding of the Target Register
* DDD represents the bit encoding of the Destination Register
* III represents the immediate value

The processor architecture does not incorporate hazard detection mechanisms; therefore, users are required to manually insert No-Operation (NoOp) instructions where necessary to ensure proper execution and avoid pipeline conflicts.

## Getting Started

### Dependencies

* Vivado Design Suite

### Executing program

* Open MIPS.xpr file.
* Make sure that TEST_ENVIRONMENT is set as the top simulation module.
* Modify the instructions in the ROM.vhd file according to your needs whilst following the ISA described above.
* Run behavioural simulation.
