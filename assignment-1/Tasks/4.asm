// Data section for storing arrays
.section .data                                   

day_1: .word 11, 2, 3, 4, 5, 7, 8, 0              // Array for day_1 as unsigned integers
day_2: .word 2, 13, 4, 0                          // Array for day_2 as unsigned integers
day_3: .word 14, 5, 6, 2, 0                       // Array for day_3 as unsigned integers
day_4: .word 3, 5, 1, 12, 5, 8, 0                 // Array for day_4 as unsigned integers
day_5: .word 4, 24, 6, 7, 1, 0                    // Array for day_5 as unsigned integers

min_sale: .word 0xFFFFFFFF                        // Min value stored in RAM

.section .text

.global _start                                    // Start position of program

_start:

	LDR R0, =day_1                                // Load the address of day_1 into register
	LDR R1, =min_sale                             // Load the address of min_sale into register	
	 
	BL calc_min_sale                              // Branch Link to calc_min_sale for finding min value at day_1
	
	LDR R0, =day_2                                // Load the address of day_2 into register
	BL calc_min_sale                              // Branch Link to calc_min_sale for finding min value at day_2
	
	LDR R0, =day_3                                // Load the address of day_3 into register
	BL calc_min_sale                              // Branch Link to calc_min_sale for finding min value at day_3

	LDR R0, =day_4                                // Load the address of day_4 into register
	BL calc_min_sale                              // Branch Link to calc_min_sale for finding min value at day_4
	
	LDR R0, =day_5                                // Load the address of day_5 into register
	BL calc_min_sale                              // Branch Link to calc_min_sale for finding min value at day_5
	
	LDR R2, [R1]                                  // Load resulting value from R1 memory address and store it in R2
	
	SWI 0                                         // Terminate program
	
calc_min_sale:
	PUSH {R2-R4, LR}        // Store previous R2 to R4 values and Link Register in stack to not override to them
	
	LDR R2, [R1]            // Load global min value
	
_min:
	LDR R3, [R0], #4        // Load day_n sales single value to R3 and apply post-index to R0 as R0 = R0 + #4
	CMP R3, #0              // Compare R3 with #0 to see if it reached null terminator
	
	BEQ _stop               // If True, then go to _stop branch
							// If False, then take single stock value of day_n and compare with minimum 
	
	CMP R3, R2              // Compare new stock value with current minimum
	BLS _substitute         // If it is less than or same, then branch to _substitute_1
	
	B _min                  // If not, then loop over until null terminator meet

_substitute:
	MOV R2, R3              // Substitute which focuses on assigning R3 to R2 and branch to _min
	
	B _min                  // Branch back to _min

_stop:
	STR R2, [R1]            // Store value (R2) in the memory address of R1

	POP {R2-R4, LR}         // Load previous register values back to registers with Link Register
					        // It means, we are done evaluating.
	
	BX LR                   // Branch back to original global function (_start)