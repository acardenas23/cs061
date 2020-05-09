;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Ana Cardenas Beltran
; Email: acard079@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 21
; TA: David Feng
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R1
;=================================================================================

					.ORIG x3000		
;-------------
;Instructions
;-------------
START_OVER
; output intro prompt
	LD R0, introPromptPtr
	PUTS 					
; Set up flags, counters, accumulators as needed
	LD R3, COUNTER
	AND R1, R1, x0
	GETC
	OUT					;GET FIRST CHAR AND ECHO IT TO SCREEN

			LD R4, PLUS_ASCII	;CHECK IF NUM ENTERED WAS A + SIGN
			ADD R5, R4, R0
			BRz DO_HAS_PLUS_LOOP
			BRnp NEWLINE_FLAG
	NEWLINE_FLAG
			LD R4, NEWL_ASCII
			ADD R5, R4, R0
			BRz THE_END
			BRnp NEGATIVE_FLAG
	NEGATIVE_FLAG
			LD R4, NEG_ASCII
			ADD R5, R4, R0		;TEST IF CHAR INPUTTED WAS "-"
			BRz DO_NEG_LOOP
			BRnp NOT_NUM_FLAG1
	NOT_NUM_FLAG1			;CHECK IF SOMETHING BETWEEN #48 AND #57 WAS ENTERED
			LD R4, ZERO_ASCII
			ADD R5, R4, R0
			BRn PRINT_ERROR
			BRzp NOT_NUM_FLAG2
	NOT_NUM_FLAG2
			LD R4, NINE_ASCII
			ADD R5, R4, R0
			BRp PRINT_ERROR
		BRnz POS_STEP
	
;DO LOOP FOR POSITIVE NUMBER WITH A + IN FRONT		
DO_HAS_PLUS_LOOP
			GETC
			OUT
			LD R4, NEWL_ASCII
			ADD R5, R4, R0
			BRz THE_END
			BRnp CHECK_PLUS_NUM
	CHECK_PLUS_NUM
			LD R4, ZERO_ASCII
			ADD R5, R4, R0				;IF CHAR ENTERED WAS LESS THAN 48, OUT ERROR
			BRn PRINT_ERROR
			BRzp TEST_NEXT
	TEST_NEXT
			LD R4, NINE_ASCII
			ADD R5, R4, R0
			BRp PRINT_ERROR
			BRnp STORE_PLUS_NUM
	STORE_PLUS_NUM	
			LD R4, ZERO_ASCII
			ADD R0, R0, R4
			ADD R1, R1, R1
			ADD R5, R1, R1
			ADD R5, R5, R5
			ADD R1, R1, R5
			ADD R1, R0, R1
			ADD R3, R3, #-1
			BRzp DO_HAS_PLUS_LOOP
			BRn ALMOST_THE_END

DO_NEG_LOOP
			GETC
			OUT
			LD R4, NEWL_ASCII
			ADD R5, R4, R0					;CHECK NEWLINE WASNT ENTERED
			BRz MAKE_NEG
			BRnp CHECK_NEG_NUM
		CHECK_NEG_NUM
			LD R4, ZERO_ASCII
			ADD R5, R4, R0
			BRn PRINT_ERROR
			BRzp CHECK_NEG_NUM2
		CHECK_NEG_NUM2
			LD R4, NINE_ASCII
			ADD R5, R4, R0
			BRp PRINT_ERROR
			BRnz STORE_NEG_NUM
		STORE_NEG_NUM
			LD R4, ZERO_ASCII
			ADD R0, R0, R4
			ADD R1, R1, R1
			ADD R5, R1, R1
			ADD R5, R5, R5
			ADD R1, R1, R5
			ADD R1, R0, R1	
			ADD R3, R3, #-1
			BRzp DO_NEG_LOOP
			BRn MAKE_NEG1
		MAKE_NEG1
		LD R0, NEWLINE
		OUT
		BRnzp MAKE_NEG	
	MAKE_NEG
			NOT R1, R1
			ADD R1, R1, #1
			BRnzp THE_END

POS_STEP
			LD R4, ZERO_ASCII
			ADD R0, R0, R4
			ADD R1, R1, R1
			ADD R5, R1, R1
			ADD R5, R5, R5
			ADD R1, R1, R5
			ADD R1, R0, R1
			BRnzp DO_POS_LOOP
DO_POS_LOOP
			GETC
			OUT
			LD R4, NEWL_ASCII
			ADD R5, R4, R0
			BRz THE_END
			BRnp CHECK_POS_NUM
		CHECK_POS_NUM
			LD R4, ZERO_ASCII
			ADD R5, R4, R0				;IF CHAR ENTERED WAS LESS THAN 48, OUT ERROR
			BRn PRINT_ERROR
			BRzp NEXT_TEST
		NEXT_TEST
			LD R4, NINE_ASCII
			ADD R5, R4, R0
			BRp PRINT_ERROR
			BRnp STORE_POS_NUM
		STORE_POS_NUM	
			LD R4, ZERO_ASCII
			ADD R0, R0, R4
			ADD R1, R1, R1
			ADD R5, R1, R1
			ADD R5, R5, R5
			ADD R1, R1, R5
			ADD R1, R0, R1

			ADD R3, R3, #-1
			BRp DO_POS_LOOP
			BRzp THE_END

PRINT_ERROR
		LD R0, NEWLINE
		OUT
		LD R0, errorMessagePtr
		PUTS
		ADD R5, R5, #0
		BRnzp START_OVER
	

; Get first character, test for '\n', '+', '-', digit/non-digit: 	
					
					; is very first character = '\n'? if so, just quit (no message)!

					; is it = '+'? if so, ignore it, go get digits

					; is it = '-'? if so, set neg flag, go get digits
					
					; is it < '0'? if so, it is not a digit	- o/p error message, start over

					; is it > '9'? if so, it is not a digit	- o/p error message, start over
				
					; if none of the above, first character is first numeric digit - convert it to number & store in target register!
					
; Now get remaining digits (max 5) from user, testing each to see if it is a digit, and build up number in accumulator

					; remember to end with a newline!
					
					ALMOST_THE_END
					LD R0, NEWLINE
					OUT
					BRnzp THE_END
					THE_END		

					HALT

;---------------	
; Program Data
;---------------
NEG_ASCII			.FILL #-45
NEWL_ASCII			.FILL #-10
NEWLINE				.FILL #10
PLUS_ASCII			.FILL #-43
COUNTER				.FILL #4		;IF FIRST DIG WAS A NUM, ENTER 4 MORE CHARS
ZERO_ASCII			.FILL #-48
NINE_ASCII			.FILL #-57
introPromptPtr		.FILL xA800
errorMessagePtr		.FILL xA900


;------------
; Remote data
;------------
					.ORIG xA800			; intro prompt
		.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
					
					
					.ORIG xA900			; error message
		.STRINGZ	"ERROR! invalid input\n"

;---------------
; END of PROGRAM
;---------------
					.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
