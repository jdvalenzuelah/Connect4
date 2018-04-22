/***************************************************************
Universidad del Valle de Guatemala
Authors: Josue David Valenzuela 171001
		 Marcos Gutierrez	    17909
Two player connect 4 game developed as part of CC3055 course
File contains the game main method for execution
***************************************************************/

/* Data used on the game */
.data
.align 2
@Message strings
welcome: .asciz "--- Bienvenidos a Cuatro en línea modificado. ---\n"
player1: .asciz "- Jugador 1 es representado por 1.\n"
player2: .asciz "- Jugador 2 representado por 2.\n"
esVacio: .asciz "- Espacio vacio representado por 0.\n"
mensajeGanador: .asciz "Ganador: ¡¡Jugador %d!!\n"
empate: .asciz "¡Empate!"



/* Game main function */
.text
.align 2
.global main
.type main,%function
main:
	stmfd sp!,{lr}

	/* utility variables */
	winner .req r5
	cont .req r6
	mov cont, #0
	mov winner, #0


	/* Display welcome message */
	ldr r0, =welcome
	bl printf
	mov r0, #0

	/* Display game instructions */
	ldr r0, =player1
	bl printf
	mov r0, #0
	ldr r0, =player2
	bl printf
	ldr r0, =esVacio
	bl printf


/* --- PLayer 1 input --- */
player1Input:
	mov r0, #0
	mov r1, #0
	mov r0, #1
	bl input
	@save input
	mov r1, r0
	mov r0, #1	
	bl insertInput
	@show matrix
	bl printMatrix
	@Check for a winner
	bl getWinner
	mov winner, r0
	cmp winner, #0
	bne printWinner

/* --- PLayer 2 input --- */
player2Input:
	mov r0, #0
	mov r1, #0
	mov r0, #2
	bl input
	@save input
	mov r1, r0
	mov r0, #2	
	bl insertInput
	@show matrix
	bl printMatrix
	@Check for a winner
	bl getWinner
	mov winner, r0
	cmp winner, #0
	bne printWinner
/* -- Verify if there is a tie -- */
tieChecker:
	add cont, #1
	cmp cont, #8
	bne player1Input
	beq printTie

/* Print tie message */
printTie:
	ldr r0, =empate
	bl printf
	b exit

/* print the winner */
printWinner:
	ldr r0, =mensajeGanador
	mov r1, winner
	bl printf 

/* exit code */
exit:
	@UN LINK variables
	.unreq winner
	.unreq cont
	@OS exit
	mov r0,#0
	mov r3,#0
	ldmfd sp!,{lr}
	bx lr
