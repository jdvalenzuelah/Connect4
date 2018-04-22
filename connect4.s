/***************************************************************
Universidad del Valle de Guatemala
Authors: Josue David Valenzuela 171001
		 Marcos Gutierrez	    17699
Two player connect 4 game developed as part of CC3055 course
File contains subroutines for the connect 4 game.
***************************************************************/

.data
.align 2
@Message strings
inputMessage: .asciz "Judador %d: Ingrese el numero de columna (1, 2, 3, 4): \n"
inputErrorM: .asciz "** Valor invalido. **\n"
vectorFull: .asciz "** Columna llena! ***"
@Input formats
inputColumn: .asciz "%d"
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
	cmpne column, #2 @else if(column == 2)
	ldreq column, =column2 @true: load column2
	cmpne column, #3 @else if(column == 3)
	ldreq column, =column3 @true: load column3
	cmpne column, #4 @else if(column == 4)
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




