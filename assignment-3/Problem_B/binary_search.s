.global binary_search
.type binary_search, %function

binary_search:
	PUSH {R4-R7, R8-R11, LR}       @ Push general purpose register and callee-event register to stack 	

	MOV R4, R0                     @ R4 = base pointer

	MOV R5, R1                     @ R5 = length of array
	MOV R6, R2                     @ R6 = K (Searched element in array)

	MOV R7, #0                     @ left bound for variable  l (Basically, l = 0)
	SUB R8, R5, #1                 @ right bound for variable r (Basically, r = n - 1)
	
inner_loop:
	CMP R7, R8                     @ If (l <= r), then continue the process until it breaks
	BGT finalize_search_empty      @ If no element found, it will branch into `finalize_search_empty` and will return -1
	
	ADD R9, R7, R8                 @ R9 = (l + r)	
	LSR R9, R9, #1                 @ Mid value index : R9 = R9 / 2 (in int division)
	
	MOV R10, R4                    @ R10 = base pointer (for offset reasons)
	ADD R10, R10, R9, LSL #2       @ R10 = base pointer + 4 * mid_value_index (basically accessing array[mid])	

	LDR R11, [R10]                 @ R11 = &R10 (accessing value using pointer)
	
	CMP R11, R6                    @ If arr[mid] == K
	
	BEQ finalize_search            @ If true, then finalize the search and return mid_index (R9 register value)
	BLT is_in_right_side           @ arr[mid] < K, then it is sure that, the K is in right side (Basically, l = mid + 1)
	BGT is_in_left_side            @ arr[mid] > K, then it is sure that, the K is in left side  (Basically, r = mid - 1)

is_in_right_side:
	ADD R9, R9, #1                 @ mid = mid + 1
	MOV R7, R9                     @ l = mid (after adding 1 to mid)
	
	B inner_loop                   @ Continue the loop

is_in_left_side:
	SUB R9, R9, #1                 @ mid = mid - 1
	MOV R8, R9                     @ r = mid (after subtracting 1 from mid)

	B inner_loop                   @ Continue the loop

finalize_search:
	MOV R0, R9                     @ In armv7 assembly, the return value is stored in R0 register, so the return value is set to mid_index
	
	B end_of_binary_search         @ Branch to end_of_binary_search

finalize_search_empty:
	MVN R0, #0                     @ Since negative values cannot be assigned, only way to return it, is to negate the 0 to get -1
	
	B end_of_binary_search         @ Branch to end_of_binary_search 

end_of_binary_search:
	POP {R4-R7, R8-R11, PC}	       @ Restore register values and exit the process (PC = LR)
