;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Ana Cardenas Beltran
; Email: acard079@ucr.edu
; 
; Assignment name: Assignment 2
; Lab section: 021
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

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------
			;GETTING NUM1
	AND R1, R1, x0			;ZEROS OUT REGISTER 1
	GETC
	OUT
	ADD R1, R0, #0 			;
	LD R0, newline			;loads newline in r0
	OUT					;PRINTS CONTENTS OF R0
			;GETTING NUM2

	AND R2, R2, x0			;ZEROS OUT R2
	GETC
	OUT
	ADD R2, R0, #0			;
	LD R0, newline			;LOADS NEWLINE IN R0
	OUT					;PRINTS  (NOT PUTS BECAUSE NOT A STRING)
	
	
			;PRINT OPERATION
	ADD R0, R1, #0
	OUT						;PRINTS R0 WHICH HAS FIRST NUMBER
	LEA R0, minus
	PUTS					;PRINTS OUT -
	ADD R0, R2, #0
	OUT						;PRINTS OUT R2 WHICH HAS 2ND NUMBER	
	LEA R0, EQUALS
	PUTS					;PRINTS EQUAL SIGN (PUTS BECAUSE STRING)
			;MAKING SECOND NUMBER NEGATIVE
	AND R3, R3, x0			;ZEROS OUT R3
	ADD R3, R2, #0
	NOT R3, R3				;INVERSE OF R3
	ADD R3, R3, #1			;ADDS 1 FOR 2'S COMPLEMENT
			;DO OPERATION
	ADD R4, R1, R3			;R4<-R1-R2
	
	IF_STATEMENT
		BRzp TRUE_CONDITION	;IF RESULT IS POSITIVE or zero
	FALSE_CONDITION ;IF RESULT IS NEGATIVE
		NOT R4, R4
		ADD R4, R4, #1		;GET 2'S COMPLEMENT OF R4(MAKE NUM POSITIVE)
		ADD R4, R4, #15
		ADD R4, R4, #15			
		ADD R4, R4, #15			
		ADD R4, R4, #3		;ADDS 48 TO CONVERT
	;PRINTING NEGATIVE RESULT
		LD R0, NEGATIVE
		OUT					;PRINTS -
		ADD R0, R4, #0	
		OUT					;PRINTS 'SUBTRACTION'
		LD R0, newline
		OUT					;PRINTS NEWLINE	
		BR END_IF
	TRUE_CONDITION
	;1. GET #48 IN R4/CONVERT CHARACTERS
		ADD R4, R4, #15			
		ADD R4, R4, #15			
		ADD R4, R4, #15			
		ADD R4, R4, #3		;ADDS 48 TO CONVERT		
	;2. PRINT THE RESULT
		ADD R0, R4, #0
		OUT						;PRINTS 'SUBTRACTION'
		LD R0, newline
		OUT						;PRINTS NEWLINE
	END_IF
	



HALT				; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL '\n'	; newline character - use with LD followed by OUT
minus .STRINGZ " - "	
EQUALS	.STRINGZ " = "
NEGATIVE .FILL #45	;HAS -





;---------------	
;END of PROGRAM
;---------------	
.END

