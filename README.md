# ARM PROCESSOR DESIGN
Describing simplified version of 32-bit arm processor

This project describes simplified version of 32-bit ARM processor. It can do data processing, memory processing, branch, and multiplication instructions.

Processor unites following modules:

- Instruction memory
- Register file
- Data memory
- Src2shift
- ALU
- Flags
- Controller
- Src1mux
- X\_mux
- Y\_mux
- +4 increment

All these instructions are instanciated in PROCEESSOR.sv file and connections among them are as shown in the picture below.

![](https://github.com/shbutkhuzi/arm_processor_design/blob/main/Screenshots/first_program.png?raw=true)

Processor supports following data processing instructions from ARM instruction set:

AND, EOR, SUB, RSB, ADD, ADC, SBC, RSC, TST, TEQ, CMP, CMN, ORR, MOV, LSL, LSR, ASR, ROR, BIC, MVN

Memory instructions: STR, LDR

Branch instructions: B, BL

Multiply instructions: MUL

Now let's demonstrate it by simulating project in questa sim and executing following instructions:

ADDS R1, R0, #53

RSBS R2, R1, R1\<\<26

STR R2, [R4, 3]

BNE by -3 instructions from here

The first instruction adds immediate value 53 to register R0 and writes result in register R1

![](https://github.com/shbutkhuzi/arm_processor_design/blob/main/Screenshots/first_program.png?raw=true)

The very first instruction in instruction memory is branch instruction which jumps to first program stored in instruction memory. In this case it is second instruction, therefore addition is performed when PC\_out is 4. Initially content of R1 was just randomly distributed bits, but after this instruction it became 824658336, since 824658283 + 53 = 824658336. The following instruction made R1 subtract from R1\<\<26 and wrote result in R2. So, let's check this. R1 in binary is 0011 0001 0010 0111 0100 1001 1010 0000 and R1\<\<26 is

1000 0000 0000 0000 0000 0000 0000 0000, which in decimal is 2,147,483,648 and processor basically calculated following: 2,147,483,648 – 824658336 = 1,322,825,312 and carry flag was set (borrow in this case, current\_flags in the picture are NZCV flags correspondingly).

The next instruction stored content of R2 in the memory location calculated as R4 + 3. Since R4 is 0, R2 is stored in memory address 3. R2 in binary is 01001110 11011000 10110110 01100000, which matches to the content of memory file beginning from address 3.

The very last instruction jumps back by 3 instructions, which means that program counter decrements by 3\*4 = 12, and therefore becomes 4 and the whole program repeats. We can see this from picture that after executing instruction at address 16, next instruction is executed from address 4.

But there is more this processor can do!

Instruction memory contains second program in it. The second program toggles content of register as if it blinks led periodically. Let's demonstrate it.

The following instructions are executed in this program:

MOV R5, #0

LDR R6, [R4, 12]

MOV R12, #0

CMP R5, R6

BNE by +4 instructions from here

MVN R12, R12

MOV R5, #0

B by -4 instructions from here

ADD R5, R5, #1

B by -6 instructions from here

This program is run when bootloader (first instruction in instruction memory) is configured to jump to the location of this program, which is 20.

![](https://github.com/shbutkhuzi/arm_processor_design/blob/main/Screenshots/second_program_shot1.png?raw=true)

First three instructions initialize contents of R5, R6 and R12. R5 contains counter, R6 contains maximum value, which is loaded from data memory (in this case 5), and R12 contains the bits that are toggled. The main part of the program checks if content of R5 and R6 are equal. If they are equal, R12 is toggled and R5 is initialized to 0, if not R5 is incremented. And this is repeated infinitely.

![](https://github.com/shbutkhuzi/arm_processor_design/blob/main/Screenshots/second_program_shot2.png?raw=true)

From the picture we can see that R12 is toggled when counter reaches 5, and then it returns to 0.
