;=================================================
; Name: Henry Tu
; Email: htu002@ucr.edu
; 
; Lab: lab 7
; Lab section: 23
; TA: Jason Goulding
; 
;=================================================

.orig x3000

	LEA	R0,req_input
	PUTS
	GETC
	OUT
	ADD	R1,R0,#0
	LD	R0,NEWLINE
	OUT
	LD	R6,count_1s_addr
	JSRR	R6
	
	LEA	R0,num_of_ones
	PUTS
	ADD	R0,R2,#0
	LD	R3,toASCII
	ADD	R0,R0,R3
	OUT
	LD	R0,NEWLINE
	OUT
	
	HALT
;DATA
	req_input	.STRINGZ	"Please enter a character: "
	NEWLINE		.FILL		#10
	count_1s_addr	.FILL		x4000
	num_of_ones	.STRINGZ	"The number of 1's in the char is: "
	toASCII		.FILL		#48
.orig x4000

	ST	R7,R7_save
	AND	R2,R2,#0
	LD	R3,bits_16
LOOP
	ADD	R1,R1,#0
	BRn	NEGATIVE
POST_CHECK
	ADD	R1,R1,R1
	ADD	R3,R3,#-1
	BRz	DONE_COUNT
	BRnp	LOOP
NEGATIVE
	ADD	R2,R2,#1
	BRnzp	POST_CHECK

DONE_COUNT
	
	LD	R7,R7_save
	RET

;DATA
	R7_save		.FILL x0
	bits_16		.FILL #16
.end
