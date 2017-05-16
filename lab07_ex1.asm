;=================================================
; Name: Henry Tu
; Email: htu002@ucr.edu
; 
; Lab: lab 7
; Lab section: 23
; TA: Jason Goulding
;=================================================

.orig x3000

	LD	R7,sub_addr
	JSRR	R7

	ADD	R5,R5,#1
	LD	R7,print_addr
	JSRR	R7
	
	HALT


	sub_addr	.FILL	x4000
	print_addr	.FILL	x5000


.orig x4000
	ST	R7,R7_register		;store the return addr for main
	LD	R6,MAX_ENTRY		;counter for storing values
	ADD	R6,R6,#-1	;we only have 5 chars for lab.
	AND	R3,R3,#0	;initialize sum register to 0

LOOP	
	GETC				
	OUT
	;check if inputted char > 57
	ADD	R1,R0,#0	
	LD	R5,NINE_ASCII
	ADD	R1,R1,R5
	BRp	GREATER_57
	;check if inputted char < 48
	ADD     R1,R0,#0        
        LD      R5,ZERO_ASCII
        ADD     R1,R1,R5
        BRn     LESS_48
	;if inputted char < 48 AND > 57, multiply current sum by 10 
	ADD	R7,R3,R3	;x + x = 2x -> R7
	ADD	R3,R7,R7	;2x + 2x = 4x -> R3
	ADD	R3,R3,R3	;4x + 4x = 8x -> R3
	ADD	R3,R3,R7	;2x + 8x = 10x -> R3
	;and then add the inputted char to that sum
	LD	R5,ZERO_ASCII
	ADD	R0,R0,R5
	ADD	R3,R3,R0	
	
	ADD	R6,R6,#-1	;decrement amount of chars left can input
	BRnp	LOOP	

NEWLINE_ENTERED
	ADD	R1,R6,#0
	ADD	R1,R1,#-5
	BRz	GREATER_57
	BRnp	END
LESS_48
	ADD	R1,R0,#0
	LD	R5,NEWLINE
	ADD	R1,R1,R5
	BRz	NEWLINE_ENTERED

GREATER_57
	LEA	R0,ERROR_MSG
	PUTS	
	LEA	R0,ENTER_VALID	
	PUTS
	BRnzp	LOOP
	;determination of character validity SKIP for now- do in assn
	;is the character less than 48?
	;ADD	R1,R0,#0		;load inputted char into R1
	;LD	R5,ZERO_ASCII		;load -48 into R5
	;ADD	R1,R0,R5		;subtract 48 from inputted char
	;BRn	LESS_48			;if negative, check moar
	;is the character greater than 57?	;if nonneg, check if too big
	;ADD	R1,R0,#0		;load inputted char into R1
	;LD	R5,NINE_ASCII		;load -57 into R5
	;ADD	R1,R0,R5		;subtract 57 from inputted char
	;BRp	INVALID_INPUT		;if positive we have invalid input.
;LESS_48
	;ADD	R4,R6,#0		;check if this is the first character
	;ADD	R4,R4,-16		;
	
;INVALID_INPUT
	;LEA	R0,ERROR_MSG	
	;PUTS
	;BRnzp	END
END
	LD	R0,NEWLINE_CHAR
	OUT
	ADD	R5,R3,#0		;move the end value to R5
	AND	R3,R3,#0		;clear used registers 
	AND	R0,R0,#0
	AND	R1,R1,#0
	AND	R6,R6,#0
	LD	R7,R7_register		;reload ret addr for main to return
	RET

;SUB DATA
	R7_register	.FILL	x0	;stores the return reg
	PLUS_ASCII	.FILL	#-43	;check for +
	MINUS_ASCII	.FILL	#-45	;check for -
	NINE_ASCII	.FILL	#-57	;upper number bd
	ZERO_ASCII	.FILL	#-48
	MAX_ENTRY	.FILL	#6	;max chars can enter
	ERROR_MSG	.STRINGZ	"ERROR INVALID INPUT\n"
	ENTER_VALID	.STRINGZ	"continue entering a valid char\n"
	NEWLINE		.FILL	#-10
	NEWLINE_CHAR	.FILL	#10

.orig x5000
	ST	R7,return_address
	AND	R2,R2,#0
	ADD	R6,R5,#0

LOOP1
	LD	R1,TEN_THOUSAND
	ADD	R5,R1,R5
	BRzp	INCREMENT1
	LD	R0,add_48
	ADD	R0,R2,R0
	OUT
	ADD	R5,R6,#0
	AND	R2,R2,#0
	BRnzp	LOOP2

INCREMENT1
	ADD	R6,R5,#0
	ADD	R2,R2,#1
	BRnzp	LOOP1

LOOP2
	LD	R1,THOUSAND
	ADD	R5,R1,R5
	BRzp	INCREMENT2
	LD	R0,add_48
	ADD	R0,R2,R0
	OUT
	ADD	R5,R6,#0
	AND	R2,R2,#0
	BRnzp	LOOP3

INCREMENT2
	ADD	R6,R5,#0
	ADD	R2,R2,#1
	BRnzp	LOOP2

LOOP3	
	LD	R1,HUNDRED
	ADD	R5,R1,R5
	BRzp	INCREMENT3
	LD	R0,add_48
	ADD	R0,R2,R0
	OUT
	ADD	R5,R6,#0
	AND	R2,R2,#0
	BRnzp	LOOP4

INCREMENT3
	ADD	R6,R5,#0
	ADD	R2,R2,#1
	BRnzp	LOOP3

LOOP4
	LD	R1,TEN
	ADD	R5,R1,R5
	BRzp	INCREMENT4
	LD	R0,add_48
	ADD	R0,R2,R0
	OUT
	ADD	R5,R6,#0
	AND	R2,R2,#0
	BRnzp	LOOP5

INCREMENT4
	ADD	R6,R5,#0
	ADD	R2,R2,#1
	BRnzp	LOOP4

LOOP5
	LD	R1,ONE
	ADD	R5,R1,R5
	BRzp	INCREMENT5
	LD	R0,add_48
	ADD	R0,R2,R0
	OUT
	ADD	R5,R6,#0
	AND	R2,R2,#0
	BRnzp	ENDING

INCREMENT5
	ADD	R6,R5,#0
	ADD	R2,R2,#1
	BRnzp	LOOP5

ENDING
	LD	R0,NEWLINE2
	OUT
	LD	R7,return_address
	RET
;data
	add_48		.FILL	#48
	return_address	.FILL	x0
	TEN_THOUSAND	.FILL	#-10000
	THOUSAND	.FILL	#-1000
	HUNDRED		.FILL	#-100
	TEN		.FILL	#-10
	ONE		.FILL	#-1
	NEWLINE2	.FILL	#10
.end
