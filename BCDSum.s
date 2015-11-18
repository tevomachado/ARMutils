/*
 *	Desafio02i
 *	Autor:
 *	Estevam Souza Machado	RA 140596 Turma F
 */
.data
.align 2
ImpressaoVetor: .asciz "Vi(i=%x): %x\n"
vetor: .byte 5, 0x42,0x94,0x96,0x72,0x95 @ declaracao do vetor na memoria. A principio sao alocadas 4 words, mas o vetor pode ser representados por ate 256 (contando o primeiro valor, que representa o numero de elementos, que pode assumir valor ate 255) espacos na memoria
vetor2: .byte 2, 0x18,0x76
vetor3: .space 6
.text
.align 2
.global main

main:
	push {lr}
	bl somavetorbcd
	bl imprimirvetor
	pop {pc}
somavetorbcd:
	push {lr}
	ldr r0, =vetor
	ldr r1, =vetor2
	ldr r2, =vetor3
	push {r0}
	push {r1}
	push {r2}
	ldrb r5, [r0]
	ldrb r6, [r1]
	cmp r5, r6
	movhs r11, r0
	movhs r12, r5
	movlo r11, r1
	movlo r12, r6
	push {r11}
	push {r12}
	movlo r11, r0
	movlo r12, r5
	movhs r11, r1
	movhs r12, r6
	push {r12}
	strb r12, [r2], #1
	add r0, r0, r5
	add r1, r1, r6
	mov r10, #0
	

	for1:
		ldrb r3, [r0]
		and r3, r3, #0xf
		ldrb r4, [r1]
		and r4, r4, #0xf
	
		add r7, r3, r4
		add r7, r7, r10
		mov r10, #0
		cmp r7, #10
		blo normal1
		overflowdec1:
		mov r10, #1
		sub r7, r7, #10

		normal1:
		ldrb r3, [r0]
		lsr r3, r3, #4
		ldrb r4, [r1]
		lsr r4, r4, #4

		add r8, r3, r4
		add r8, r8, r10
		mov r10, #0
		cmp r8, #10
		blo normal2
		overflowdec2:
		mov r10, #1
		sub r8, r8, #10

		normal2:
		lsl r8, r8, #4
		add r7, r7, r8
		strb r7, [r2], #1

		sub r0, #1
		sub r1, #1
		sub r12, #1
		cmp r12, #0
		bne for1
	pop {r5}
	pop {r6}
	pop {r11}
	add r5, r5, #1
	strb r6, [r2,-r5]
	sub r5, r5, #1
	sub r6, r6, r5
	cmp r6, #0
	beq final
	add r11, r11, r6
	for2:
		ldrb r0, [r11]
		add r0, r0, r10
		mov r10, #0
		strb r0, [r2], #1
		sub r6, #1
		sub r11, #1
		cmp r6, #0
		bne for2
	final:
	cmp r10, #1
	streqb r10, [r2]
	pop {r2}
	ldreqb r0, [r2]
	addeq r0, r0, #1
	streqb r0, [r2]
	push {r2}
	
	desinverter:
	ldrb r3, [r2]
	mov r0, r2
	add r0, r0, #1
	mov r1, r2
	add r1, r1, r3
	for3:
		ldrb r4, [r0]
		ldrb r5, [r1]
		strb r5, [r0]
		strb r4, [r1]
		sub r1, r1, #1
		add r0, r0, #1
		cmp r0, r1
		blo for3
	pop {r2}
	pop {r1}
	pop {r0}
	pop {pc}

imprimirvetor: @ rotina para imprimir todos os elementos do vetor, percorrendo-o ate o final e imprimindo elemento por elemento
	push {r0-r2,r5-r8,lr}
	ldr r5, =vetor3
	ldrb r8, [r5]
	mov r7, #0
	add r5, r5, #1
	for:
		add r7, r7, #1
		mov r1, r7
		ldrb r2, [r5], #1
		ldr r0, =ImpressaoVetor
		bl printf
		cmp r8, r7
		bne for
	pop {r0-r2,r5-r8,pc}