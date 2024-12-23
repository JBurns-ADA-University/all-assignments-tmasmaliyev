.global selection_sort
.type selection_sort, %function

selection_sort:
	@ When the caller calls callee, the arguments are stored from R0 - R3, since there is only two arguments,
	@ It is safer to pick only R0 and R1

	PUSH {R4-R7, R8-R12, LR}   @ Save general purpose callee-saved registers and Link register into stack
	MOV R4, R0                 @ R4 = array pointer
	MOV R5, R1		   @ R5 = array length

	MOV R6, #0                 @ i = 0 (Index assignment)

outer_loop:
	CMP R6, R5                 @ Compare i with array length
	BGE end_selection_sort     @ If i >= array length, then end the sort process else continue
	
	MOV R7, R6                 @ min_ind = i
	MOV R8, R4                 @ R8 = Base address of array

	ADD R8, R8, R7, LSL #2     @ ptr_min_i = array[min_ind] (Basically, BasePointer + 4 * min_ind)
	
	MOV R9, R6                 @ j = i
	MOV R10, R8                @ ptr_j = ptr_i

inner_loop:
	ADD R9, R9, #1             @ j = j + 1

	CMP R9, R5                 @ Compare j with array length
	BGE update_array_value     @ If j >= array length, then go to o branch, else continue with inner_loop
	
	LDR R11, [R8]              @ R11 = &ptr_min_i
	LDR R12, [R10, #4]!        @ Apply pre-increment by value of 4 (int size), then R12 = &ptr_j
	
	CMP R12, R11               @ If &ptr_j < &ptr_min_i, 
                                   @ then update min_ind, else continue
	BLT update_min

	B inner_loop               @ Back to second loop statement, if no update_min happens
		
update_min:
	MOV R7, R9                 @ min_ind = j
	
	MOV R8, R4                 @ R8 = Base address of array 
	ADD R8, R8, R7, LSL #2     @ ptr_min_i = array[min_ind] (Basically, BasePointer + 4 * min_ind)
	
	B inner_loop               @ Back to second loop statement

update_array_value:
	MOV R9, R4                 @ After inner loop, j variable (R9 register) will be useless, so it is free to use
	ADD R9, R9, R6, LSL #2     @ R9 = Base pointer of array and ptr_i = array[i]

	LDR R12, [R9]              @ R12 = &ptr_i
	LDR R11, [R8]              @ R11 = &ptr_min_ind
	
	STR R12, [R8]              @ *ptr_min_i = array[i]  	
	STR R11, [R9]              @ *ptr_i = array[min_ind]

	ADD R6, R6, #1             @ Increment i by 1
	B outer_loop               @ Back to first loop statement

end_selection_sort:
	POP {R4-R7, R8-R12, PC}    @ Restore registers and return
