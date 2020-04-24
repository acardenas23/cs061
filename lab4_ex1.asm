;=================================================
; Name: Ana Cardenas Beltran
; Email: acard079@ucr.edu
; 
; Lab: lab 3, ex 1
; Lab section: 21
; TA: David Feng
; 
;=================================================
.ORIG x3000
;------------
;INSTRUCTIONS
;------------
			;LOADING VALUES
	LD	R4, ARRAY_1			;LOADS X4000 IN R2
	LD	R5, COUNTER1		;LOADS 7 IN R5
	AND R3, R3, x0			;0 IN R3
			;LOOP TO 1-7
	DO_WHILE_LOOP
		LDR R3, R4, #0		;R3 VALUE IN R4
		ADD R4, R4, #1		;INCREMENT LOCATION
		ADD R3, R3, #1		;ADD 1 TO NUMBER BEING STORED
		STR R3, R4, #0		;STORES NUMBER IN R4
		ADD R5, R5, #-1		;DECREASE COUNTER
	BRp DO_WHILE_LOOP
	END_DO_WHILE_LOOP
			;STORE 7TH VALUE IN R2
	AND R2, R2, x0			;ZEROS R2
	ADD R2, R3, #0			;PUTS R3(7TH VALUE) IN R2
			;CONTINUE LOOP WITH 7-10
	LD R6, COUNTER2			;STORES SECONT COUNTER IN R6
	DO_WHILE_LOOP1
		LDR R3, R4, #0		;LOAD R4 IN R3
		ADD R4, R4, #1		;INCREMENT LOCATION OF ARRAY
		ADD R3, R3, #1		;ADD 1 TO NUMBER BEING STORED
		STR R3, R4, #0		;STORE THE NUMBER IN R3
		ADD R6, R6, #-1		;DECREASE COUNTER
	BRp DO_WHILE_LOOP1		;DO WHILE LOOP IF POSITIVE
	END_DO_WHILE_LOOP1
	;NOTE: I did 2 while loops to store the 7th value in the array in r2
	;instead of simply storing #6(which I already knew would be the 
	;7th value) because I didn't want "hard code".
	

HALT
;------------
;LOCAL DATA
;------------
	ARRAY_1  .FILL	x4000
	COUNTER1 .FILL	#7
	COUNTER2 .FILL	#3
;------------
;REMOTE DATA
;------------
.ORIG x4000
	ARRAY	.BLKW	#10				;TO MAKE AN ARRAY WITH 10 CHARACTERS






