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
@Input formats
inputColumn: .asciz "%d"
@Saved data
currentColumn: .word 0

.text
.align 2

/**
 * Player input
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
	bl scanf @Store the inpur
	ldr r0, =currentColumn @Load input adress
	ldr column, [r0] @Load input value
	cmp column, #1 @if(column < 1)
	blt inputError @True, go to input error
	cmp column, #4 @else if(column > 4)
	bgt inputError @True, go to input error
	ble inputFinish @else go to input finish
	bne inputError @case a string was entered
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


