/*
 *	Lab06-1
 *	Autores:
 *	Lucas de Souza e Silva	RA 140765 Turma E
 *	Estevam Souza Machado	RA 140596 Turma F
 */
.data
.align 2
ImpressaoResultado: .asciz "%d"
string1: .asciz "abc"
string2: .asciz "abcd"
.text
.align 2
.global main

main:
	push {lr}
	ldr r1, =string1
	ldr r2, =string2
	bl cmpstring
	ldr r0, =ImpressaoResultado
	bl printf
	pop {pc}
cmpstring:
	push {r0,r2-r12,lr}
	while1:
		ldrb r7, [r1], #1
		ldrb r8, [r2], #1
		cmp r7, r8
		cmpeq r7, #0
		moveq r10, #0
		beq fim
		cmp r7, r8
		movlo r10, #-1
		movhi r10, #1
		bne fim
		b while1
	fim:
	mov r1, r10
	pop {r0,r2-r12,pc}