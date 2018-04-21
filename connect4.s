/*
Universidad del Valle de Guatemala
Authors: Josue David Valenzuela 171001
		 Marcos Gutierrez	    17699
Two player connect 4 game developed as part of CC3055 course 
*/

/* Data used on the game */
.data
.align 2
welcome: .asciz "Bienvenidos a Cuatro en línea modificado. \nJugador 1 es representado por X \n Jugador 2 representado por O"

/* Game main function */
.text
.align 2
.global main
.type main,%function
main:
	@Display welcome message
	ldr r0, =welcome
	bl printf
