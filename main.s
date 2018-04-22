/***************************************************************
Universidad del Valle de Guatemala
Authors: Josue David Valenzuela 171001
		 Marcos Gutierrez	    17699
Two player connect 4 game developed as part of CC3055 course
File contains the game main method for execution
***************************************************************/

/* Data used on the game */
.data
.align 2
@Message strings
welcome: .asciz "--- Bienvenidos a Cuatro en línea modificado. ---\n"
player1: .asciz "Jugador 1 es representado por 1.\n"
player2: .asciz "Jugador 2 representado por 2.\n"
test: .asciz "input test: %d \n"



/* Game main function */
.text
.align 2
.global main
.type main,%function
main:
	stmfd sp!,{lr}

	@Display welcome message
	ldr r0, =welcome
	bl printf
	mov r0, #0

	@Display player instructions
	ldr r0, =player1
	bl printf
	mov r0, #0
	ldr r0, =player2
	bl printf

	@Player 1 input
	mov r0, #1
	bl input
	bl insertInput

	mov r1, r0
	ldr r1, [r1]
	ldr r0, =test
	bl printf

	@OS exit
	mov r0,#0
	mov r3,#0
	ldmfd sp!,{lr}
	bx lr
