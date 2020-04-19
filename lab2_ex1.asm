;=================================================
; Name: Ana Cardenas Beltran
; Email: acard079@ucr.edu
; 
; Lab: lab 2. ex 1
; Lab section: 
; TA: 
; 
;=================================================
.ORIG x3000
;Instructions
	LD R3, DEC_65 ; loads dec_65 into r3
	LD R4, HEX_41 ; loads hex_41 into r4
	HALT
; Data
	DEC_65	.FILL #65 ;puts #65 into mem loc dec_65
	HEX_41	.FILL x41
.end
