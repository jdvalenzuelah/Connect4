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

	/* Display welcome message */
	ldr r0, =welcome
	bl printf
	mov r0, #0

	/* Display player instructions */
	ldr r0, =player1
	bl printf
	mov r0, #0
	ldr r0, =player2
	bl printf

/* --- PLayer 1 input --- */
player1Input:
	mov r0, #1
	bl input
	@save input
	mov r1, r0
	mov r0, #1	
	bl insertInput
	@show matrix
	bl printMatrix

/* --- PLayer 2 input --- */
player2Input:
	mov r0, #2
	bl input
	@save input
	mov r1, r0
	mov r0, #2	
	bl insertInput
	@show matrix
	bl printMatrix

	@OS exit
	mov r0,#0
	mov r3,#0
	ldmfd sp!,{lr}
	bx lr
