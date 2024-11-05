# Problem

1. Convert the following program from machine language into ARM assembly language

0x00008008 0xE3A02000
0x0000800C 0xE1A03001
0x00008010 0xE1510000
0x00008014 0x8A000002
0x00008018 0xE2822001
0x0000801C 0xE0811003
0x00008020 0xEAFFFFFA
0x00008024 0xE1A00002

# Problem Solving

When PC starts from the first instruction, the instruction address is `0x00008008` and real instruction, `0xE3A02000`. When converting to **32** bits, it will look like this:

1110 00 1 1101 0 0000 0010 000000000000
|--| || | |--| | |--| |--| |----------|
  1  2  3  4   5  6    7        8

Here: 
- First `4` bits are `condition` code which refers to `always execute`.
- Second `2` bits are `op type` which refers to data processing
- Third `1` bit is `I` that refers to immediate value
- Fourth place is `op code` that refers to `MOV`
- Fifth place is constant for updating flag, in this case `0` 
- Sixth place is not used because we don't have `R_n` first operand register, so `0`
- Seventh place refers to `R_d`, `R2` destination register
- Eigth place refers to immediate value of `0`

First instruction is `MOV R2, #0`


In second insctruction : `0xE1A03001`

1110 00 0 1101 0 0000 0011 000000000001
|--| || | |--| | |--| |--| |----------|
  1   2 3   4  5   6    7       8

- First `4` bits are `condition` code which refers to always execute.
- Second `2` bits are `op type` which refers to data processing
- Third `1` bit is `I` `0`, that refers to register value
- Fourth `4` bits are `op code` which refers to `MOV`
- Fifth place is constant for updating flag, in this case `0`
- Sixth place is not used because we don't have `R_n` first operand register, so `0`
- Seventh place refers to `R_d` `R3` destination register
- Eigth place is `R1` source register because, in `I` being `0`. 

Second instruction is `MOV R3, R1`


In third instruction: 0xE1510000

1110 00 0 1010 1 0001 0000 000000000000
|--| || | |--| | |--| |--| |----------|
  1   2 3   4  5  6     7        8

- First `4` bits are `condition` code which refers to always execute.
- Second `2` bits are `op type` which refers to data processing
- Third `1` bit is `I` `0`, that refers to register value
- Fourth `4` bits are `op code` which refers to `CMP`
- Fifth place is constant for updating flag, in this case `1` (update the flag)
- Sixth place is `R_n`, in this case `R1`
- Seventh place is not used
- Eigth place is `R0` register

Third instruction is `CMP R1, R0`


In fourth instruction: 0x8A000002

10001010000000000000000000000010

(Since I couldn't find exact place meaning in this 32 bit code, I say resulting)
This branches to `0xe1a00002` instruction if `Higher than` condition meets 

Fourth instruction is `BHI 0x1c` 


In fifth instruction : 0xE2822001

1110 00 1 0100 0 0010 0010 000000000001
|--| || | |--| | |--| |--| |----------|
  1  2  3   4  5  6     7        8

- First `4` bits are `condition` code which refers to always execute.
- Second `2` bits are `op type` which refers to data processing
- Third `1` bit is `I` that refers to immediate value
- Fourth `4` bits are `op code` which refers to `ADD`
- Fifth place is constant for updating flag, in this case `0`
- Sixth place is operand1 `R_n`, in this case  `R2`
- Seventh place is `R_d`, `R2`
- Eigth place is immediate value `1`

Fifth instruction is `ADD R2, R2, #1`


In sixth instruction : 0xE0811003

1110 00 0 0100 0 0001 0001 000000000011
|--| || | |--| | |--| |--| |----------|
  1  2  3   4  5   6    7       8

- First `4` bits are `condition` code which refers to always execute.
- Second `2` bits are `op type` which refers to data processing
- Third `1` bit is `I` that refers to register value
- Fourth `4` bits are `op code` which refers to `ADD`
- Fifth place is constant for updating flag, in this case `0`
- Sixth place is `R_n`, in this case `R1`
- Seventh place is `R_d`, `R1`
- Eigth place is register value `R3`

Sixth instruction is `ADD R1, R1, R3`


In seventh instruction : 0xEAFFFFFA

11101010111111111111111111111010

(Since I couldn't find exact place meaning in this 32 bit code, I say resulting)
All in all, this is unconditional branch that goes to `0xe1510000` place

Seventh instruction is `B 0x8`


In Eigth instruction : 0xE1A00002

1110 00 0 1101 0 0000 0000 000000000010
|--| || | |--| | |--| |--| |----------|
  1   2 3   4  5   6    7        8

- First `4` bits are `condition` code which refers to always execute.
- Second `2` bits are `op type` which refers to data processing
- Third `1` bit is `I` `0`, that refers to register value
- Fourth `4` bits are `op code` which refers to `MOV`
- Fifth place is constant for updating flag, in this case `0`
- Sixth place is not used because we don't have `R_n` first operand register, so `0`
- Seventh place refers to `R_d` `R0` destination register
- Eigth place is `R2` source register because, in `I` being `0`. 

Eigth instruction is `MOV R0, R2`

# Summary

- It initializes R2 to zero, which could be a counter
- It compares R1 with R0 and, if R1 > R0, jumps forward, bypassing the increment of R2 and the addition to R1.
- If R1 <= R0, it: Increments R2 by 1.
- Adds the initial value in R1 (stored in R3) to R1.
- It then loops back to the comparison, creating an iterative structure that repeats until a condition causes the loop to exit.
- Finally, it moves the final value in R2 to R0, to output the result of the count.

# Note

In order to reverse engineer on this code, I used the documentation and a bit of linux arm object dumper to verify.
[Source Link for documentation](https://eng.libretexts.org/Bookshelves/Computer_Science/Programming_Languages/Introduction_to_Assembly_Language_Programming%3A_From_Soup_to_Nuts%3A_ARM_Edition_(Kann)/06%3A_New_Page/6.02%3A_New_Page)

In order to create `.bin` file, I used `main.py` code. Basically, it iterates over instructions and save it as little endian byte format. Then, I used linux arm dumper in such a way:

- arm-none-eabi-objdump -D -b binary -m arm test.bin 


This is the output:

test.bin:     file format binary 


Disassembly of section .data: 

00000000 <.data>: 

   0:	e3a02000 	mov	r2, #0 

   4:	e1a03001 	mov	r3, r1 

   8:	e1510000 	cmp	r1, r0 

   c:	8a000002 	bhi	0x1c 

  10:	e2822001 	add	r2, r2, #1 

  14:	e0811003 	add	r1, r1, r3 

  18:	eafffffa 	b	0x8 

  1c:	e1a00002 	mov	r0, r2 


# Disassembly of High-Level Programming C

Here, first `initial_R1 = 5` translates to `MOV R3, #5` and stores that at stack frame with offset such as `STR [FP, #16]`
This is the same as `R0 = 20` .

Then, branch call is executed. 

In function call, the stack frame is pushed and values with offsets considering stack frame are loaded to registers.

After that, stack variables are assigned, in this case , it is assigned to registers.

Branch operation is called. Then `R2` value is incremented by 1 and `R1` value is incremented by `R3`.

After that, `CMP R2, R3` is applied and check for `BLE`. If true, than branch that address or use `BX` to go to instruction in main stack.


In order to verify, I used the linux disassembler. Here are the codes:
- `arm-linux-gnueabi-gcc -o c_assembly c_assembly.c`
- `arm-linux-gnueabi-objdump -d c_assembly > c_assembly.s` 

The `c_assembly.s` file resides in the same directory.