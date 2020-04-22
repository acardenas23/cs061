;=================================================
; Name: Ana Cardenas
; Email: acard079@ucr.edu
; 
; Lab: lab 3, ex 3
; Lab section: 
; TA: David Feng
; 
;=================================================
.orig x3000
;--------------
;Instructions
;--------------
	LEA R1, ARRAY_1				;loads R1 with array_1
	LD R2, COUNTER				;loads r2 with counter
	LEA R0, MSG
	PUTS
DO_WHILE_LOOP
	GETC
	OUT
	STR R0, R1, #0
	ADD R1, R1, #1
	LEA R0, NEWLINE
	PUTS
	ADD R2, R2, -#1				;Decreases the counter 
Brnp DO_WHILE_LOOP
END_DO_WHILE_LOOP	




	HALT
;-----------
;Data
;------------
	ARRAY_1		.BLKW	#10		;creates 10 spaces for array 1
	COUNTER 	.FILL	#10		; makes counter 10
	MSG		.STRINGZ	"Enter 10 characters \n" 
	NEWLINE	.STRINGZ	"\n"
	
.END	
