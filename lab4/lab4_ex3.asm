;=================================================
; Name: Ana Sofia Cardenas Beltran
; Email: acard079@ucr.edu
; 
; Lab: lab 3, ex 3
; Lab section: 21
; TA: David Feng
; 
;=================================================
.ORIG x3000
;------------
;INSTRUCTIONS
;------------
	LD R3, ARRAY_1				;LOADS LOCATION X4000 WHICH HAS ARRAY
	LD R1, DEC_1				;GETS #1 IN R1 (FIRST VALUE) 2^0
	LD R2, COUNTER				;WILL COUNT 10 ITERATIONS
	
	
	DO_WHILE_LOOP
		STR R1, R3, #0
		ADD R3, R3, #1			;GOES TO NEXT MEM. LOCATION
		ADD R1, R1, R1			;DOUBLES VALUE IN R1 (2^1=2=1+1 , 2^2=4=2+2...)
		ADD R2, R2, #-1			;DECREASES COUNTER
	BRp DO_WHILE_LOOP			;DO LOOP UNTIL COUNTER=0
	END_DO_WHILE_LOOP

HALT
;------------
;LOCAL DATA
;------------
	ARRAY_1 .FILL	x4000
	DEC_1	.FILL	x1
	COUNTER .FILL	#10
;------------
;REMOTE DATA
;------------
.ORIG x4000
	ARRAY	.BLKW	#10				;TO MAKE AN ARRAY WITH 10 CHARACTERS
