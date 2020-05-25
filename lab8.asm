;=================================================
; Name: Ana Cardenas Beltran
; Email: acard079@ucr.edu
; 
; Lab: lab 8, ex 1 & 2
; Lab section: 21
; TA: David Feng
; 
;=================================================

; test harness
					.orig x3000
					
	LD R1, INSTRUCTIONS_MAIN_PTR
	LD R6, SUB_PRINT_OPCODE_TABLE
	JSRR R6
	
	LD R6, SUB_FIND_OPCODE_MAIN
	JSRR R6
				 
				 
					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
SUB_PRINT_OPCODE_TABLE		.FILL x3200
INSTRUCTIONS_MAIN_PTR		.FILL x4100
SUB_FIND_OPCODE_MAIN		.FILL x3600


;===============================================================================================


; subroutines:
;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE_TABLE
; Parameters: None
; Postcondition: The subroutine has printed out a list of every LC3 instruction
;				 and corresponding opcode in the following format:
;					ADD = 0001
;					AND = 0101
;					BR = 0000
;					…
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3200
					
		ST R0, BACKUP_R0_3200
		ST R1, BACKUP_R1_3200
		ST R3, BACKUP_R3_3200
		ST R7, BACKUP_R7_3200
		
		LD R1, instructions_po_ptr
		LD R2, opcodes_po_ptr
		
	PRE_PRINT_3200
		LD R0, NEWLINE_3200
		OUT
PRINT_3200
		LDR R0, R1, #0					;LOAD THE VALUE OF R1 IN R0
		OUT
		ADD R1, R1, #1					;INCREASE LOCATION OF R1
		LDR R0, R1, #0	
		BRnp PRINT_3200					;DO LOOP IF NEXT VAL IS NOT ZERO
END_PRINT_3200
		LD R0, SPACE_3200
		OUT
		LD R0, EQUAL_ASCII				;OUTPUT EQUALS
		OUT		
	
		LD R6, SUB_PRINT_OPCODE			;CALL SUBROUTINE THAT PRINTS BINARY
		JSRR R6 
		
		ADD R2, R2, #1
	
CHECK_IF_END
		ADD R1, R1, #1					;SHIFT
		LDR R0, R1, #0
		LD R3, ONE_3200
		ADD R0, R0, R3					;CHECK IF -1
		BRnp PRE_PRINT_3200				;IF NEXT VAL ISNT 0, GO BACK TO PRINT NEXT VAL
		BRz THE_END_3200
		
	THE_END_3200		 
		LD R0, BACKUP_R0_3200	
		LD R1, BACKUP_R1_3200
		LD R7, BACKUP_R7_3200
		LD R3, BACKUP_R3_3200	
	
					ret
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE_TABLE local data
BACKUP_R0_3200		.BLKW #1
BACKUP_R1_3200		.BLKW #1
BACKUP_R3_3200		.BLKW #1
BACKUP_R7_3200		.BLKW #1
opcodes_po_ptr		.fill x4000				; local pointer to remote table of opcodes
instructions_po_ptr	.fill x4100				; local pointer to remote table of instructions
EQUAL_ASCII			.FILL x3D
COUNTER_3200		.FILL #4
NEWLINE_3200		.FILL '\n'
ZERO_3200			.FILL #48
SPACE_3200			.FILL x20
ONE_3200			.FILL #1
SUB_PRINT_OPCODE	.FILL x3400


;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE
; Parameters: R2 containing a 4-bit op-code in the 4 LSBs of the register
; Postcondition: The subroutine has printed out just the 4 bits as 4 ascii 1s and 0s
;				 The output is NOT newline terminated.
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3400
					
		ST R3, BACKUP_R3_3400
		ST R4, BACKUP_R4_3400
		ST R5, BACKUP_R5_3400
		ST R7, BACKUP_R7_3400
		
		LDR R4, R2, #0						;VALUE TO BE DISPLAYED AS BINARY IN R4
		LD R3, COUNTER_3400
		
	CHECK_OUT_BIN
		ADD R3, R3, #-1						;SKIP THE FIRST 12 ITERATIONS
		ADD R4, R4, R4						;SHIFT
		ADD R3, R3, #0						;WHEN COUNTER REACHES 0 GO TO OUT_BIN
		BRz PRE_OUT_BIN
		BRp CHECK_OUT_BIN
		
	PRE_OUT_BIN
		LD R5, COUNTER4_3400
OUT_BIN
		ADD R4, R4, #0
		BRzp IS_ZERO
		BRn IS_ONE
	IS_ZERO
		LD R3, ZERO_3400
		ADD R0, R3, #0
		OUT
		BRnzp SHIFT_3400
	IS_ONE
		LD R3, ONE_3400
		ADD R0, R3, #0
		OUT
		BRnzp SHIFT_3400
	SHIFT_3400
		ADD R4, R4, R4
		ADD R5, R5, #-1
		BRp OUT_BIN
		BRnz THE_END_3400
				 
THE_END_3400	 
		LD R3, BACKUP_R3_3400
		LD R4, BACKUP_R4_3400
		LD R5, BACKUP_R5_3400
		LD R7, BACKUP_R7_3400
				 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE local data
OPCODES_PTR_3400	.FILL x4000
COUNTER_3400		.FILL #12
COUNTER4_3400		.FILL #4
ZERO_3400			.FILL #48
ONE_3400			.FILL #49
BACKUP_R3_3400		.BLKW #1
BACKUP_R4_3400		.BLKW #1
BACKUP_R5_3400		.BLKW #1
BACKUP_R7_3400		.BLKW #1
OPCODE_PRINT_TABLE	.FILL x4000


;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_FIND_OPCODE
; Parameters: None
; Postcondition: The subroutine has invoked the SUB_GET_STRING subroutine and stored a string
; 				as local data; it has searched the AL instruction list for that string, and reported
;				either the instruction/opcode pair, OR "Invalid instruction"
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3600
	ST R1, BACKUP_R1_3600
	ST R2, BACKUP_R2_3600				
	ST R3, BACKUP_R3_3600
	ST R4, BACKUP_R4_3600
	ST R5, BACKUP_R5_3600
	ST R6, BACKUP_R6_3600
	ST R7, BACKUP_R7_3600
	
		LD R1, instructions_fo_ptr
		
		LD R6, SUB_GET_STRING		;CALL GETSTRING SUBROUTINE TO PROMPT USER TO ENTER STRING
		JSRR R6
	
		LD R2, INPUT_STRING
		LDR R4, R2, #0				;GET VALUE OF R2 IN R4
		LDR R3, R1, #0				;VALUE OF R1 IN R3
		AND R5, R5, x0
		
CHECK_IF_EQUAL_LOOP
		LDR R4, R2, #0
		NOT R4, R4
		ADD R4, R4, #1
		ADD R4, R4, R3
		BRz NEXT_INPUT_SPOT_LOOP
		BRnp NOT_RIGHT_OPCODE
	NOT_RIGHT_OPCODE
		LD R2, INPUT_STRING
		LDR R4, R2, #0				;RELOAD STRING
		ADD R1, R1, #1				;INCREASE ARRAY UNTIL ZERO IS REACHED
		LDR R3, R1, #0
		ADD R3, R3, #0
		BRnp NOT_RIGHT_OPCODE
		BRz GO_TO_NEXT
	GO_TO_NEXT
		ADD R5, R5, #1				;ADD 1 TO POINTER IF 0
		ADD R1, R1, #1				;GET NEXT VAL
		LDR R3, R1, #0				;LOAD IN R3
		ADD R3, R3, #0				
		BRz WAS_INVALID				;IF NEXT IS ZERO AGAIN, REACHED END
		BRnp CHECK_IF_EQUAL_LOOP
	NEXT_INPUT_SPOT_LOOP
		ADD R2, R2, #1
		LDR R4, R2, #0				;GET NEXT VAL
		ADD R4, R4, #0
		ADD R1, R1, #1
		LDR R3, R1, #0				;NEXT VAL
		ADD R3, R3, #0				;END WHEN R3 IS 0, MEANS STRING ENDED
		BRz WAS_EQUAL
		BRnp CHECK_IF_EQUAL_LOOP
		
		
		
WAS_EQUAL
;PRINT STRING AND EQUAL SIGN
;HAVE POINTER FOR HOW MANY TIMES ZERO IS REACHED TO INCREASE BINARY ARRAY THAT MANY TIMES
		LD R1, INPUT_STRING
	PRINT_INPUT_STRING_3600
		LDR R3, R1, #0
		ADD R0, R3, #0
		OUT
		ADD R1, R1, #1
		ADD R1, R1, #0
		BRz PRINT_OPCODE_3600
		BRnp PRINT_INPUT_STRING_3600
	PRINT_OPCODE_3600
		LEA R0, EQUAL_3600
		PUTS
		LD R2, opcodes_fo_ptr	;HAS TO BE IN R2 TO USE SUBROUTINE
		ADD R2, R2, R5			;INCREASE R1 R5 NUM TIMES	
		LD R6, SUB_PRINT_OPCODE_6
		JSRR R6
		BRnzp THE_END_3600
	
WAS_INVALID
		LEA R0, INVALID_INSTRUCTION
		PUTS
		BRnzp THE_END_3600
	
	THE_END_3600		 
	
	LD R1, BACKUP_R1_3600			 
	LD R2, BACKUP_R2_3600			 
	LD R3, BACKUP_R3_3600	
	LD R4, BACKUP_R4_3600
	LD R5, BACKUP_R5_3600
	LD R6, BACKUP_R6_3600		 
	LD R7, BACKUP_R7_3600			 
				 ret
;-----------------------------------------------------------------------------------------------
; SUB_FIND_OPCODE local data
opcodes_fo_ptr			.fill x4000
instructions_fo_ptr		.fill x4100
BACKUP_R6_3600			.BLKW #1
BACKUP_R1_3600			.BLKW #1
BACKUP_R2_3600			.BLKW #1
BACKUP_R3_3600			.BLKW #1
BACKUP_R4_3600			.BLKW #1
BACKUP_R5_3600			.BLKW #1
BACKUP_R7_3600			.BLKW #1
NEWLINE_3600			.FILL '\n'
EQUAL_3600				.STRINGZ " = "
SUB_GET_STRING			.FILL x3800
SUB_PRINT_OPCODE_6		.FILL x3400
INPUT_STRING			.FILL x4200
INVALID_INSTRUCTION		.STRINGZ "\nInvalid Instruction\n"

;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameters: R2 - the address to which the null-terminated string will be stored.
; Postcondition: The subroutine has prompted the user to enter a short string, terminated 
; 				by [ENTER]. That string has been stored as a null-terminated character array 
; 				at the address in R2
; Return Value: None (the address in R2 does not need to be preserved)
;-----------------------------------------------------------------------------------------------
					.orig x3800
		ST R3, BACKUP_R3_3800
		ST R4, BACKUP_R4_3800
		ST R5, BACKUP_R5_3800
		ST R7, BACKUP_R7_3800
		
		LD R2, STRING_ADDR			;LOAD ADDRESS AT WHICH STRING WILL BE STORED
						
		LEA R0, PROMPT_GET
		PUTS						;GET PROMPT AND OUTPUT
INPUT_LOOP
		GETC
		OUT
		LD R4, ENTER
		NOT R4, R4
		ADD R4, R4, #1				;GET 2'S COMPLEMENT OF NEWLINE
		ADD R5, R4, R0				;CHECK IF NEWLINE WAS ENTERED
		BRnp STORE_STRING			;IF NOT NEWLINE, STORE
		BRz NEXT_3800
	STORE_STRING
		STR R0, R2, #0				;STORE R0 IN R2
		ADD R2, R2, #1				;INCREASE LOCATION OF R2
		BRnzp INPUT_LOOP			;AFTER STORING, GO BACK TO DOING LOOP
	NEXT_3800
				 
				 
		LD R3, BACKUP_R3_3800
		LD R4, BACKUP_R4_3800
		LD R5, BACKUP_R5_3800
		LD R7, BACKUP_R7_3800
				 
				 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_GET_STRING local data
PROMPT_GET				.STRINGZ "\nENTER A STRING TERMINATED BY ENTER \n"
ENTER					.FILL '\n'
STRING_ADDR				.FILL x4200
BACKUP_R3_3800			.BLKW #1
BACKUP_R4_3800			.BLKW #1
BACKUP_R5_3800			.BLKW #1
BACKUP_R7_3800			.BLKW #1

;===============================================================================================


;-----------------------------------------------------------------------------------------------
; REMOTE DATA
					.ORIG x4000			; list opcodes as numbers from #0 through #15, e.g. .fill #12 or .fill xC
; opcodes
.FILL	x1	;ADD
.FILL	x5	;AND
.FILL	x0	;BR
.FILL	xC	;JMP
.FILL	x4	;JSR
.FILL	x4	;JSRR
.FILL	x2	;LD
.FILL	xA	;LDI
.FILL	x6	;LDR
.FILL	xE	;LEA
.FILL	x9	;NOT
.FILL	xC	;RET
.FILL	x8	;RTI
.FILL	x3	;ST
.FILL	xB	;STI
.FILL	x7	;STR
.FILL	xF	;TRAP
.FILL	xD	;RESERVED	

					.ORIG x4100			; list AL instructions as null-terminated character strings, e.g. .stringz "JMP"
								 		; - be sure to follow same order in opcode & instruction arrays!
; instructions
.STRINGZ	"ADD"
.STRINGZ	"AND"
.STRINGZ	"BR"
.STRINGZ	"JMP"
.STRINGZ	"JSR"
.STRINGZ	"JSRR"
.STRINGZ	"LD"
.STRINGZ	"LDI"
.STRINGZ	"LDR"
.STRINGZ	"LEA"
.STRINGZ	"NOT"
.STRINGZ	"RET"
.STRINGZ	"RTI"
.STRINGZ	"ST"
.STRINGZ	"STI"
.STRINGZ	"STR"
.STRINGZ	"TRAP"
.STRINGZ	"reserved"
.FILL		#-1
	

;===============================================================================================
