/*
 *	Lab06-4
 *	Autores:
 *	Lucas de Souza e Silva	RA 140765 Turma E
 *	Estevam Souza Machado	RA 140596 Turma F
 */
.data
.align 2
ImpressaoValor: .asciz "Resultado: 0x%x\n"
vetor: .byte 10, 0x42,0x94,0x96,0x72,0x95
.text
.align 2
.global main

main:
	push {lr}
	bl converterpckdbcdbinario
	pop {pc}
converterpckdbcdbinario:
	push {lr}
	ldr r0, =vetor
	ldrb r1, [r0], #1
	lsr r2, r1, #1
	lsl r2, r2, #1
	cmp r1, r2
	addne r2, r2, #2
	lsr r2, r2, #1
	mov r3, #0
	mov r10, #0
	for1:
		cmp r3, r2
		bhs fimfor1
		ldrb r5, [r0], #1
		mov r6, r5
		and r5, r5, #0xf0
		lsr r5, r5, #4
		and r6, r6, #0xf

		add r10, r10, r10
		add r10, r10, r10, lsl #2
		add r10, r10, r5
		add r10, r10, r10
		add r10, r10, r10, lsl #2
		add r10, r10, r6

		add r3, r3, #1
		b for1
	fimfor1:
	ldr r0, =ImpressaoValor
	mov r1, r10
	bl printf
	pop {pc}