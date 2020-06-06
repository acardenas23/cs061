;=================================================
; Name: Ana Cardenas Beltran
; Email: acard079@ucr.edu 
; 
; Lab: lab 9, ex 1 & 2
; Lab section: 21
; TA: David Feng
; 
;=================================================

; test harness
					.orig x3000
				 
			LD R3, SUB_STACK_PUSH_3200
			JSRR R3
	
			ADD R6, R6, #0
			LD R3, SUB_STACK_POP_3400
			JSRR R3	 
				 
					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
SUB_STACK_PUSH_3200			.FILL x3200
SUB_STACK_POP_3400			.FILL x3400


;===============================================================================================


; subroutines:

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1). 
;		    If the stack was already full (TOS = MAX), the subroutine has printed an
;		    overflow error message and terminated.
; Return Value: R6 ← updated TOS
;------------------------------------------------------------------------------------------
					.orig x3200
					
		ST R1, BACKUP_R1_3200
		ST R3, BACKUP_R3_3200
		ST R4, BACKUP_R4_3200
		ST R5, BACKUP_R5_3200
		ST R7, BACKUP_R7_3200
		
		LD R4, BASE
		LD R5, MAX
		LD R6, TOS
		AND R1, R1, x0
		ADD R4, R4, #1
		LEA R0, PROMPT
		PUTS
		
POPULATE_STACK_IN	
		GETC
		OUT
		LD R3, NEWLINE
		NOT R3, R3
		ADD R3, R3, #1
		ADD R3, R3, R0
		BRnp POPULATE_STACK
		BRz CHECK_STACK
	POPULATE_STACK
		STR R0, R4, #0
		ADD R4, R4, #1
		ADD R1, R1, #1
		BRnzp POPULATE_STACK_IN

	CHECK_STACK
		ADD R6, R6, R1
		NOT R6, R6
		ADD R6, R6, #1
		ADD R5, R5, R6			;IF TOS IS LESS THAN MAX, RESULT WILL BE POSITIVE
		BRp PUSH_STACK
		BRnz ERROR_MESSAGE
		
	PUSH_STACK
		LEA R0, PUSH_PROMPT
		PUTS	
		GETC
		OUT
		LD R6, TOS
		ADD R6, R6, R1
		STR R0, R6, #0			;STORE R0 TO TOP OF STACK
		
		BRnzp THE_END_3200
		
	ERROR_MESSAGE
		LEA R0, ERROR_3200
		PUTS
		
				 
	THE_END_3200			 
		LD R1, BACKUP_R1_3200
		LD R3, BACKUP_R3_3200
		LD R4, BACKUP_R4_3200
		LD R5, BACKUP_R5_3200
		LD R7, BACKUP_R7_3200		 				 
				 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_PUSH local data
BASE				.FILL xA000
MAX					.FILL xA005
TOS					.FILL xA000

COUNTER 			.FILL #4
NEWLINE				.FILL '\n'
PROMPT				.STRINGZ "\nENTER MAX 4 CHARACTERS TO FILL THE STACK AND PRESS ENTER\n"
PUSH_PROMPT			.STRINGZ "PUSH A VALUE ONTO A STACK\n"
ERROR_3200			.STRINGZ "\nERROR: OVERFLOW\n"
BACKUP_R1_3200		.BLKW #1
BACKUP_R3_3200		.BLKW #1
BACKUP_R4_3200		.BLKW #1
BACKUP_R5_3200		.BLKW #1
BACKUP_R7_3200		.BLKW #1

;===============================================================================================


;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available                      
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack.
;		    If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Value: R0 ← value popped off the stack
;		   R6 ← updated TOS
;------------------------------------------------------------------------------------------
					.orig x3400
		ST R3, BACKUP_R3_3400
		ST R4, BACKUP_R4_3400
		ST R5, BACKUP_R5_3400
		ST R7, BACKUP_R7_3400
		
	
		LD R5, MAX_400	
		LD R4, BASE_400
		LD R3, ZERO_VAL
			
	IF
		NOT R6, R6
		ADD R6, R6, #1
		ADD R5, R6, R5		;IF TOS+MAX IS POS, TOS IS GREATER THAN MAX
		BRp POP_STACK
		BRnz ERROR_3400_B
POP_STACK
		LDR R0, R6, #0		;COPY VALUE OF R6 TO R0
		STR R3, R6, #0		;CLEAR IT
		ADD R6, R6, #-1	
		BRnzp THE_END_3400	
ERROR_3400_B
		LEA R0, ERROR_3400
		PUTS
								
THE_END_3400	
		LD R3, BACKUP_R3_3400
		LD R4, BACKUP_R4_3400
		LD R5, BACKUP_R5_3400
		LD R7, BACKUP_R7_3400		 
				 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_POP local data
BASE_400			.FILL xA000
MAX_400				.FILL xA005
ZERO_VAL			.FILL #0
BACKUP_R3_3400		.BLKW #1
BACKUP_R4_3400		.BLKW #1
BACKUP_R5_3400		.BLKW #1
BACKUP_R7_3400		.BLKW #1
ERROR_3400			.STRINGZ "\nERROR: OVERFLOW\n"


;===============================================================================================

