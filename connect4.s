/**********************************************************************
Universidad del Valle de Guatemala
Authors: Josue David Valenzuela 171001
		 Marcos Gutierrez	    17909
Two player connect 4 game developed as part of CC3055 course
File contains subroutines and stores the data for the connect 4 game.
**********************************************************************/

.data
.align 2
@Message strings
inputMessage: .asciz "Judador %d: Ingrese el numero de columna (1, 2, 3, 4): \n"
inputErrorM: .asciz "** Valor invalido. **\n"
vectorFull: .asciz "** Columna llena! ***\n"
@Input formats
inputColumn: .asciz "%d"
matrix: .asciz "|%d|"
enter: .asciz "\n"
@Saved data
currentColumn: .word 0
column1: .word 0,0,0,0
column2: .word 0,0,0,0
column3: .word 0,0,0,0
column4: .word 0,0,0,0

.text
.align 2

/**
 * Player input, subroutine verifys that the value is between 1 and 4 and returns the value
 * Param r0: player number (1 or 2)
 * Return: column number on r0
 */
 .global input
 input:
 	player .req r5 @player variable
 	column .req r6 @column variable
 	push {lr} @Save the link register
 	mov player, r0 @mov the param to variable player
 inputBody:
 	ldr r0, =inputMessage @Load input message
 	mov r1, player @Load the player
	bl printf @Display message
	ldr r0, =inputColumn @load input format
	ldr r1, =currentColumn @Load addres to store input
	bl scanf @Store the input
	ldr r0, =currentColumn @Load input adress
	ldr column, [r0] @Load input value
	cmp column, #1 @if(column < 1)
	blt inputError @True, go to input error
	cmp column, #4 @else if(column > 4)
	bgt inputError @True, go to input error
	ble inputFinish @else go to input finish
inputError:
	ldr r0, =inputErrorM @Load error message
	bl printf @Display error message
	b inputBody @Go back to input inputBody
inputFinish:
	mov r0, column @mov the column value to r0
	.unreq player @Unlink the player variable from r5
	.unreq column @Unlink the cplumn variable from r6
	pop {lr} @Retrieve link register
	mov pc, lr @Return r0

/**
 * Insert the players input
 * Param: r0: player number (1 or 2)
 *        r1: column number
 * Return: r0: vector with the players input
*/
.global insertInput
insertInput:
	column .req r5 @Variable column
	box	   .req r6 @variable box
	player .req r7 @variable player
	count  .req r8 @variable count
	columnInput .req r9 @variable columnInput
	push {lr} @store the link register
	mov player, r0 @store he player
	mov column, r1 @store the column
	cmp column, #1 @if(column == 1)
	ldreq column, =column1 @true: load column1
	cmp column, #2 @else if(column == 2)
	ldreq column, =column2 @true: load column2
	cmp column, #3 @else if(column == 3)
	ldreq column, =column3 @true: load column3
	cmp column, #4 @else if(column == 4)
	ldreq column, =column4 @load column4
	mov columnInput, column @store column input
recorridoVector:
	ldr box, [column] @load the current column element
	cmp box, #0 @if element is empty
	streq player, [column] @store the player in such element
	beq insertInputFinish @Go to insertInputFinish
	add column, #4 @Go to next element
	add count, #1 @count++
	cmp count, #4 @if count != 4
	bne recorridoVector @true go to recorridoVector
	ldr r0, =vectorFull @ else, load vectorFull message
	bl printf @display vectorFull message
insertInputFinish:
	mov r0, columnInput @r0 = address of the vector
	@Unlink variables from registers
	.unreq column
	.unreq box
	.unreq player
	.unreq count
	pop {lr} @Retrieve the link register
	mov pc, lr @return r0

/**
 * Print matrix
 * No arguments and no return value
*/
.global printMatrix
printMatrix:
	push {lr} @store the link register
	co1 .req r5 @co1 variable
	co2 .req r6 @co2 variable
	co3 .req r7 @co3 variable
	co4 .req r8 @co4 variable
	@load all the columns from the matrix
	ldr co1, =column1
	ldr co2, =column2
	ldr co3, =column3
	ldr co4, =column4
	@Start from the last element
		@Access to the second row
	add co1, #12
	add co2, #12
	add co3, #12
	add co4, #12
	@print first row of the matrix (first row of every column)
	ldr r0, =matrix
	ldr r1, [co1]
	bl printf
	ldr r0, =matrix
	ldr r1, [co2]
	bl printf
	ldr r0, =matrix
	ldr r1, [co3]
	bl printf
	ldr r0, =matrix
	ldr r1, [co4]
	bl printf
	ldr r0, =enter
	bl printf
	@Access to the second row
	add co1, #-4
	add co2, #-4
	add co3, #-4
	add co4, #-4
	@print second row of the matrix (second row of every column)
	ldr r0, =matrix
	ldr r1, [co1]
	bl printf
	ldr r0, =matrix
	ldr r1, [co2]
	bl printf
	ldr r0, =matrix
	ldr r1, [co3]
	bl printf
	ldr r0, =matrix
	ldr r1, [co4]
	bl printf
	ldr r0, =enter
	bl printf
	@Access to the third row
	add co1, #-4
	add co2, #-4
	add co3, #-4
	add co4, #-4
	@print third row of the matrix (third row of every column)
	ldr r0, =matrix
	ldr r1, [co1]
	bl printf
	ldr r0, =matrix
	ldr r1, [co2]
	bl printf
	ldr r0, =matrix
	ldr r1, [co3]
	bl printf
	ldr r0, =matrix
	ldr r1, [co4]
	bl printf
	ldr r0, =enter
	bl printf
	@Access to the fourth row
	add co1, #-4
	add co2, #-4
	add co3, #-4
	add co4, #-4
	@print fourth row of the matrix (fourth row of every column)
	ldr r0, =matrix
	ldr r1, [co1]
	bl printf
	ldr r0, =matrix
	ldr r1, [co2]
	bl printf
	ldr r0, =matrix
	ldr r1, [co3]
	bl printf
	ldr r0, =matrix
	ldr r1, [co4]
	bl printf
	ldr r0, =enter
	bl printf
	.unreq co1
	.unreq co2
	.unreq co3
	.unreq co4
	pop {lr}
	mov pc, lr

/**
 * Verify winner
 * Return: winner on r0,  0 for no winner yet, 1 for player 1, 2 for player 2
*/
.global getWinner
getWinner:
	push {lr}
	co1 .req r2 @co1 variable
	co2 .req r3 @co2 variable
	co3 .req r4 @co3 variable
	co4 .req r5 @co4 variable
	@variable for each value
	value1 .req r6
	value2 .req r7
	value3 .req r8
	value4 .req r9 
	@variable for winner
	winner .req r10
	cont .req r11
	@Load columns from the Matrix
	ldr co1, =column1
	ldr co2, =column2
	ldr co3, =column3
	ldr co4, =column4
	mov cont, #0
/*verifyHorizontal:
	@Load each value
	ldr value1, [co1]
	ldr value2, [co2]
	ldr value3, [co3]
	ldr value4, [co4]
	@Compare each value
	cmp value1, value2 @if(value1 == value2)
	moveq winner, value1 @winner = value1
	cmp value3, value4 @if(value3 == value4)
	cmpeq winner, value4 @if(winner == value4)
	beq verifyFinish @go to verifyfinish
	movne winner, #0 @If non of values is equal winner = 0
	@acces the next element
	add co1, #4
	add co2, #4
	add co3, #4
	add co4, #4
	add cont, #1 @cont++
	cmp cont, #4 @while cont < 4
	bne verifyHorizontal @go to verifyHorizontal*/
verifyvertical:
	@load value from each value from the current column
	ldr value1, [co1]
	add co1, #4
	ldr value2, [co1]
	add co1, #4
	ldr value3, [co1]
	add co1, #4
	ldr value4, [co1]
	rsb value1, value1, value2 @value1 = value1 - value2
	rsb value3, value3, value4 @value3 = value3 - value4
	add value1, value1, value3 @value1 = value1 + value3
	cmp value1, #0 @If valuue1 == 0,then it means all the values are equal
	moveq winner, value2 @store the winner if all are equal
	beq verifyFinish @Go to verifyFinish
	@load value from each value from the current column
	ldr value1, [co2]
	add co1, #4
	ldr value2, [co2]
	add co1, #4
	ldr value3, [co2]
	add co1, #4
	ldr value4, [co2]
	rsb value1, value1, value2 @value1 = value1 - value2
	rsb value3, value3, value4 @value3 = value3 - value4
	add value1, value1, value3 @value1 = value1 + value3
	cmp value1, #0 @If valuue1 == 0,then it means all the values are equal
	moveq winner, value2 @store the winner if all are equal
	beq verifyFinish @Go to verifyFinish
	@load value from each value from the current column
	ldr value1, [co3]
	add co1, #4
	ldr value2, [co3]
	add co1, #4
	ldr value3, [co3]
	add co1, #4
	ldr value4, [co3]
	rsb value1, value1, value2 @value1 = value1 - value2
	rsb value3, value3, value4 @value3 = value3 - value4
	add value1, value1, value3 @value1 = value1 + value3
	cmp value1, #0 @If valuue1 == 0,then it means all the values are equal
	moveq winner, value2 @store the winner if all are equal
	beq verifyFinish @Go to verifyFinish
	@load value from each value from the current column
	ldr value1, [co4]
	add co1, #4
	ldr value2, [co4]
	add co1, #4
	ldr value3, [co4]
	add co1, #4
	ldr value4, [co4]
	rsb value1, value1, value2 @value1 = value1 - value2
	rsb value3, value3, value4 @value3 = value3 - value4
	add value1, value1, value3 @value1 = value1 + value3
	cmp value1, #0 @If valuue1 == 0,then it means all the values are equal
	moveq winner, value2 @store the winner if all are equal
	beq verifyFinish @Go to verifyFinish
	@Reload all the values
	ldr co1, =column1
	ldr co2, =column2
	ldr co3, =column3
	ldr co4, =column4
verifyDiagonals:
	@reload values
	ldr co1, =column1
	ldr co2, =column2
	ldr co3, =column3
	ldr co4, =column4
	firstDiagonal:
		@load first diagonal values
		ldr value1, [co1]
		add co2, #4
		ldr value2, [co2]
		add co3, #8
		ldr value3, [co3]
		add co4, #12
		ldr value4, [co4]
		@Compare each value
		cmp value1, value2 @if(value1 == value2)
		moveq winner, value1 @winner = value1
		cmp value3, value4 @if(value3 == value4)
		cmpeq winner, value4 @if(winner == value4)
		beq verifyFinish @go to verifyfinish
		movne winner, #0 @If non of values is equal winner = 0
	secondDiagonal:
		@Load second diagonal values
		add co1, #12
		ldr value1, [co1]
		add co2, #4
		ldr value2, [co2]
		add co3, #-4
		ldr value3, [co3]
		add co4, #-12
		ldr value4, [co4]
		@Compare each value
		cmp value1, value2 @if(value1 == value2)
		moveq winner, value1 @winner = value1
		cmp value3, value4 @if(value3 == value4)
		cmpeq winner, value4 @if(winner == value4)
		beq verifyFinish @go to verifyfinish
		movne winner, #0 @If non of values is equal winner = 0
verifyFinish:
	mov r0, winner @move the winner to r0
	@Unlink all variables from registers
	.unreq co1
	.unreq co2
	.unreq co3
	.unreq co4
	.unreq value1
	.unreq value2
	.unreq value3
	.unreq value4
	.unreq winner
	.unreq cont
	pop {lr}
	mov pc, lr @return r0
