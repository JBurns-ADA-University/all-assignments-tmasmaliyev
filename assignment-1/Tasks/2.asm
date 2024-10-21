// Data section for storing arrays
.section .data                                   

day_1: .word 11, 2, 3, 4, 5, 7, 8, 0              // Array for day_1 as unsigned integers
day_2: .word 2, 13, 4, 0                          // Array for day_2 as unsigned integers
day_3: .word 14, 5, 6, 2, 0                       // Array for day_3 as unsigned integers
day_4: .word 3, 5, 1, 12, 5, 8, 0                 // Array for day_4 as unsigned integers
day_5: .word 4, 24, 6, 7, 1, 0                    // Array for day_5 as unsigned integers

average_val: .word 0                              // Average value stored in RAM

.section .text                                    // Code section after this line, // so ARM Assembly can detect from where the code starts

.global _start                                    // Start position of program

_start:
	//Store the address of average value in register R6, R7
	LDR R6, =average_val
	LDR R7, =average_val

    
	LDR R0, =day_1            // Load the address of day_1 into register
    BL calc_avg               // Branch Link to calc_avg for finding average value, then return back
	
	LDR R0, =day_2            // Load the address of day_2 into register
    BL calc_avg               // Branch Link to calc_avg for finding average value, then return back
	
	LDR R0, =day_3            // Load the address of day_3 into register
    BL calc_avg               // Branch Link to calc_avg for finding average value, then return back
	
	LDR R0, =day_4            // Load the address of day_4 into register
    BL calc_avg               // Branch Link to calc_avg for finding average value, then return back

	LDR R0, =day_5            // Load the address of day_5 into register
    BL calc_avg               // Branch Link to calc_avg for finding average value, then return back
	 
	LDR R1, [R7], #4       // Day 1 Average Sales
	LDR R2, [R7], #4 	   // Day 2 Average Sales
	LDR R3, [R7], #4 	   // Day 3 Average Sales
	LDR R4, [R7], #4       // Day 4 Average Sales
	LDR R5, [R7], #4       // Day 5 Average Sales
	
	SWI 0                  // End of the program
	
calc_avg:
	PUSH {R1-R4, LR}    // Store previous R1 to R4 values and Link Register in stack to not override to them
	MOV R1, #0          // Running sum (Nominator)
	MOV R2, #0          // Running counter (Denominator)
	
	MOV R4, #0          // Value of unsigned division result
	
loop:
	LDR R3, [R0], #4    // Load day_n sales single value to R3 and apply post-index to R0 as R0 = R0 + #4
	CMP R3, #0          // Compare R3 with #0 to see if it reached null terminator
	
	BEQ divide          // If True, then go to calculation of divide : sum / counter
	
	ADD R1, R1, R3      // If False, then sum up single stock value of day_n 
	ADD R2, R2, #1      // Increment counter by 1
	
	B loop              // Loop over until null terminator meets
	
// Division simulation	
// R1 / R2 = q 
// R1 / R2 = R1 - R2 - R2 - R2 ..... until R1 < R2
divide:
	CMP R1, R2          // Compare R1 with R2, R1 never becomes less than R2 when divide branch first initialized
	
	BHS division_rule   // Unsigned integer condition. If Higher or same, then branch to division rule
						// Otherwise, it means, it has continued
	
	STR R4, [R6], #4    // Store the average value of day_n sales to R6 memory address with offset value 4
	
	POP {R1-R4, LR}     // Load previous register values back to registers with Link Register
					    // It means, we are done evaluating.
	BX LR               // Branch back to original global function (_start)


division_rule:
	ADD R4, R4, #1      // R4 will increment by 1 (quotient part)
	SUB R1, R1, R2		// Subtract value R2 from R1
	
	B divide            // Continue by branching back `divide`