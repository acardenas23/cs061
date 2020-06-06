;=================================================
; Name: Ana Cardenas Beltran
; Email: acard079@ucr.edu
; 
; Lab: lab 9, ex 3
; Lab section: 21
; TA: David Feng
; 
;=================================================

; test harness
					.orig x3000
		LD R4, BASE
		LD R5, MAX
		LD R6, TOS
		AND R1, R1, x0
		ADD R4, R4, #1
		LD R3, COUNTER
		
POPULATE_STACK_IN	
		LEA R0, PROMPT1
		PUTS
		GETC
		OUT
		ADD R3, R3, #-1
		BRp POPULATE_STACK
		BRnz CHECK_STACK
	POPULATE_STACK
		STR R0, R4, #0
		ADD R4, R4, #1
		ADD R1, R1, #1
		ADD R3, R3, #0
		LD R6, SUB_STACK_PUSH_3200
		JSRR R6
		BRnzp POPULATE_STACK_IN

	CHECK_STACK
		ADD R6, R6, R1
		NOT R6, R6
		ADD R6, R6, #1
		ADD R5, R5, R6			;IF TOS IS LESS THAN MAX, RESULT WILL BE POSITIVE
		BRp PUSH_STACK_SUB
		BRnz ERROR_MESSAGE	
		
	ERROR_MESSAGE
		LEA R0, ERROR_MSG
		PUTS
		BRnzp THE_END_MAIN
		
	PUSH_STACK_SUB	
		ADD R1, R1, #1
		LD R6, SUB_STACK_PUSH_3200
		JSRR R6
	MULTIPLY_SUB
		LEA R0, MULT_MSG
		PUTS
		GETC
		OUT 
		LD R2, STAR_CHAR
		ADD R2, R0, R2
		BRz CONTINUE_MULT
		BRnp ERROR_MSG
	CONTINUE_MULT
		LD R6, SUB_RPN_MULTIPLY
		JSRR R6
		
				 
	THE_END_MAIN			 
					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
PROMPT1				.STRINGZ "\nENTER A SINGLE DIGIT NUMERIC CHARACTER\n"
BASE				.FILL xA000
MAX					.FILL xA005
TOS					.FILL xA000
SUB_STACK_PUSH_3200 .FILL x3200
COUNTER				.FILL #2
ERROR_MSG			.STRINGZ "\nINVALID INPUT \n"
MULT_MSG			.STRINGZ "\nENTER *\n"
STAR_CHAR			.FILL #-42
SUB_RPN_MULTIPLY	.FILL x3600

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
					

		ST R7, BACKUP_R7_3200
		
		
	PUSH_STACK
		LD R6, TOS_3200
		ADD R6, R6, R1
		STR R0, R6, #0			;STORE R0 TO TOP OF STACK
		
		BRnzp THE_END_3200
		
		
				 
	THE_END_3200			 

		LD R7, BACKUP_R7_3200		 				 			 
				 
					ret				 

;-----------------------------------------------------------------------------------------------
; SUB_STACK_PUSH local data
TOS_3200			.FILL xA000
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
		ST R6, BACKUP_R6_3400
		ST R7, BACKUP_R7_3400
		
	
		LD R5, MAX_400	
		LD R4, BASE_400
		LD R3, ZERO_VAL
		LD R6, TOS_400
		ADD R6, R6, R1
			
	IF
		NOT R5, R5
		ADD R5, R5, #1
		ADD R5, R6, R5		;IF TOS+MAX IS POS, TOS IS GREATER THAN MAX
		BRn POP_STACK
		BRzp ERROR_3400_B
POP_STACK
		LDR R0, R6, #0		;COPY VALUE OF R6 TO R0
		STR R3, R6, #0
		
		ADD R6, R6, #-1	
		BRnzp THE_END_3400	
ERROR_3400_B
		LEA R0, ERROR_3400
		PUTS
								
THE_END_3400	
		LD R3, BACKUP_R3_3400
		LD R4, BACKUP_R4_3400
		LD R5, BACKUP_R5_3400
		LD R6, BACKUP_R6_3400
		LD R7, BACKUP_R7_3400						
	 
					ret				 
	
;-----------------------------------------------------------------------------------------------
; SUB_STACK_POP local data
BASE_400			.FILL xA000
MAX_400				.FILL xA005
TOS_400				.FILL xA000
ZERO_VAL			.FILL #0
BACKUP_R3_3400		.BLKW #1
BACKUP_R4_3400		.BLKW #1
BACKUP_R5_3400		.BLKW #1
BACKUP_R6_3400		.BLKW #1
BACKUP_R7_3400		.BLKW #1
ERROR_3400			.STRINGZ "\nERROR: OVERFLOW\n"


;===============================================================================================

;------------------------------------------------------------------------------------------
; Subroutine: SUB_RPN_MULTIPLY
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped off the top two values of the stack,
;		    multiplied them together, and pushed the resulting value back
;		    onto the stack.
; Return Value: R6 ← updated TOS address
;------------------------------------------------------------------------------------------
					.orig x3600
		ST R3, BACKUP_R3_3600
		ST R4, BACKUP_R4_3600
		ST R7, BACKUP_R7_3600
		
		LD R0, NEWL_3600
		OUT
				 
		LD R6, SUB_STACK_POP_3400
		JSRR R6	
		ADD R0, R0, #0
		OUT
		LD R4, ZERO_ASCII_3600	 
		ADD R4, R0, R4
		ADD R1, R1, #-1
		LEA R0, MULT_SIGN
		PUTS
		LD R6, SUB_STACK_POP_3400
		JSRR R6
		ADD R0, R0, #0
		OUT
		LD R5, ZERO_ASCII_3600
		ADD R5, R0, R5
		
		LEA R0, EQUALS_SIGN
		PUTS
		
		AND R3, R3, x0
	MULT_LOOP
		ADD R3, R3, R4
		ADD R5, R5, #-1				;MULTIPLY NUMS
		BRp MULT_LOOP
		BRnz PRINT_DEC_NUM
		
	PRINT_DEC_NUM
		LD R6, TOS_3600
		ADD R1, R1, #1
		ADD R6, R1, R6
		STR R3, R6, #0
		
		LD R6, SUB_PRINT_DECIMAL
		JSRR R6
				 
		LD R3, BACKUP_R3_3600
		LD R4, BACKUP_R4_3600		 
		LD R7, BACKUP_R7_3600		 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_RPN_MULTIPLY local data
SUB_STACK_POP_3400		.FILL x3400
TOS_3600				.FILL xA000
BACKUP_R3_3600			.BLKW #1
BACKUP_R4_3600			.BLKW #1
BACKUP_R7_3600			.BLKW #1
ZERO_ASCII_3600			.FILL #-48
MULT_SIGN				.STRINGZ " * "
EQUALS_SIGN				.STRINGZ " = "
NEWL_3600				.FILL '\n'
SUB_PRINT_DECIMAL		.FILL x3800
;===============================================================================================



; SUB_MULTIPLY		

; SUB_GET_NUM		
;===============================================================================
; SUB_PRINT_DECIMAL		Only needs to be able to print 1 or 2 digit numbers. 
;						You can use your lab 7 s/r.
;===============================================================================
.ORIG x3800
ST R1, BACKUP_R1_3800
ST R4, BACKUP_R4_3800
ST R7, BACKUP_R7_3800


	AND R0, R0, x0
	LD R4, ASCII_10
	ADD R1, R4, R3
	BRzp IS_10
	BRn IS_1	
	
	IS_10	
		AND R0, R0, x0
		LD R4, ASCII_10
		ADD R3, R3, R4
		BRn NO_MORE_10
		BRzp CONTINUE_10
	CONTINUE_10
		ADD R0, R0, #1
		BRzp CHECK_NEXT_10
	CHECK_NEXT_10
		ADD R3, R3, R4
		BRn NO_MORE_10
		BRzp CONTINUE_10
	NO_MORE_10
		NOT R4, R4
		ADD R4, R4, #1
		ADD R3, R4, R3
		LD R4, ASCII_ZER
		ADD R0, R0, R4
		OUT
		BRnzp PRE_IS_1
	
	PRE_IS_1
		AND R0, R0, x0
		BRz IS_1
		
	IS_1
		LD R4, ASCII_1
		ADD R3, R3, R4
		BRn NO_MORE_1
		BRzp CONTINUE_1
	CONTINUE_1
		ADD R0, R0, #1
		BRzp CHECK_NEXT_1
	CHECK_NEXT_1
		ADD R3, R3, R4
		BRn NO_MORE_1
		BRzp CONTINUE_1
	NO_MORE_1
		NOT R4, R4
		ADD R4, R4, #1
		ADD R3, R3, R4
		LD R4, ASCII_ZER
		ADD R0, R0, R4
		OUT
		BRnzp THE_END_3800
	
THE_END_3800
LD R1, BACKUP_R1_3800
LD R4, BACKUP_R4_3800
LD R7, BACKUP_R7_3800
	RET
;DATA
ASCII_10			.FILL #-10
ASCII_1				.FILL #-1
ASCII_ZER			.FILL #48
BACKUP_R1_3800		.BLKW #1
BACKUP_R4_3800		.BLKW #1
BACKUP_R7_3800		.BLKW #1

