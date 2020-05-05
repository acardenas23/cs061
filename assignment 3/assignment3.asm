						;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Ana Cardenas Beltran
; Email: acard079@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 21
; TA: David Feng
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
LD R5, COUNTER_16			;THIS WILL COUNT 16 ITERATIONS IN MY LOOP
LD R4, COUNTER_4			;COUNT 4 ITERATIONS FOR THE SPACES

DO_WHILE_LOOP1
	STR R1, R6, #0
	
	;DO IF STATEMENT THAT WILL OUTPUT LEFTMOST DIGIT
		IF_STATEMENT1
		ADD R1, R1, #0	;IF LEFTMOST DIGIT IS 1, NUMBER IS NEGATIVE
		BRzp TRUE_CONDITION1 ;IF EVALUATES TO POSITIVE, LEFTMOST DIGIT IS 0
		FALSE_CONDITION1	;IF NEGATIVE, LEFTMOST DIGIT IS 1
		LD R0, NUM1
		OUT					;OUTPUT 1
		ADD R1, R1, #0
		BRn TEST_SPACE
		TRUE_CONDITION1		;OUTPUT 0 IF POSITIVE
		LD R0, NUM0
		OUT
	TEST_SPACE
	ADD R1, R1, R1		;DOUBLE R1 TO DO LEFTMOST SHIFT
	ADD R5, R5, #-1		;DECREASE COUNTER
	ADD R4, R4, #-1		;DECREASE SPACE COUNTER
	
		IF_STATEMENT2
		ADD R5, R5, #0	;IF 4 ITERATIONS HAVE HAPPENED, OUTPUT A SPACE
		BRz	NO_SPACE
		ADD R4, R4, #0
		BRz ADD_SPACE
		BRp NO_SPACE
		
		ADD_SPACE
		LD R0, SPACE
		OUT
		LD R4, COUNTER_4
		END_IF1
		
		NO_SPACE		;DONT DO ANYTHING
		END_IF2
		
	ADD R5, R5, #0		;WILL STOP LOOP WHEN 16 ITERATIONS ARE DONE
BRp DO_WHILE_LOOP1
END_DO_WHILE_LOOP1

	LD R0, NEWLINE	;OUTPUT NEWLINE
	OUT


HALT
;---------------	
;Data
;---------------
Value_ptr	.FILL xB270	; The address where value to be displayed is stored
COUNTER_16	.FILL #16
COUNTER_4	.FILL #4
NUM1		.FILL #49
NUM0		.FILL #48
NEWLINE		.FILL '\n'
SPACE		.FILL ' '


.ORIG xB270					; Remote data
Value .FILL x0000			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
