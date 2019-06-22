	.cpu arm7tdmi
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.align	2
	.syntax unified
	.arm
	.fpu softvfp
	.type	cameraHandler.part.0, %function
cameraHandler.part.0:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L20
	ldrh	r3, [r0, #14]
	cmp	r3, #0
	str	lr, [sp, #-4]!
	beq	.L2
	ands	r1, r3, #7
	beq	.L15
.L3:
	sub	r3, r3, #1
	strh	r3, [r0, #14]	@ movhi
.L2:
	ldr	ip, .L20+4
	ldr	r2, .L20+8
	ldr	r3, [ip]
	ldr	r2, [r2]
	ldr	r1, .L20+12
	sub	r3, r3, #1
	cmp	r2, r1
	str	r3, [ip]
	beq	.L16
	ldr	r1, .L20+16
	cmp	r2, r1
	beq	.L17
	ldr	r1, .L20+20
	cmp	r2, r1
	beq	.L18
	ldr	r1, .L20+24
	cmp	r2, r1
	beq	.L19
.L6:
	cmp	r3, #0
	movle	r1, #16
	movle	r2, #0
	ldrle	r3, .L20+28
	strle	r1, [ip]
	strle	r2, [r3, #8]
	ldr	lr, [sp], #4
	bx	lr
.L15:
	ldrh	r2, [r0, #12]
	cmp	r2, #2
	addls	r2, r2, #1
	strhls	r2, [r0, #12]	@ movhi
	strhhi	r1, [r0, #12]	@ movhi
	b	.L3
.L17:
	ldr	lr, .L20+28
	ldrh	r2, [r0]
	ldr	r1, [lr]
	add	r2, r2, #1
	add	r1, r1, #1
	str	r1, [lr]
	strh	r2, [r0]	@ movhi
	b	.L6
.L16:
	ldr	lr, .L20+28
	ldrh	r2, [r0]
	ldr	r1, [lr]
	sub	r2, r2, #1
	sub	r1, r1, #1
	str	r1, [lr]
	strh	r2, [r0]	@ movhi
	b	.L6
.L18:
	ldr	lr, .L20+28
	ldrh	r2, [r0, #2]
	ldr	r1, [lr, #4]
	add	r2, r2, #1
	add	r1, r1, #1
	str	r1, [lr, #4]
	strh	r2, [r0, #2]	@ movhi
	b	.L6
.L19:
	ldr	lr, .L20+28
	ldrh	r2, [r0, #2]
	ldr	r1, [lr, #4]
	sub	r2, r2, #1
	sub	r1, r1, #1
	str	r1, [lr, #4]
	strh	r2, [r0, #2]	@ movhi
	b	.L6
.L21:
	.align	2
.L20:
	.word	player
	.word	dirTimer
	.word	nextMove
	.word	moveMapLeft
	.word	moveMapRight
	.word	moveMapDown
	.word	moveMapUp
	.word	.LANCHOR0
	.size	cameraHandler.part.0, .-cameraHandler.part.0
	.align	2
	.global	init
	.syntax unified
	.arm
	.fpu softvfp
	.type	init, %function
init:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r1, #5184
	mov	r2, #7296
	mov	r3, #67108864
	push	{r4, lr}
	strh	r1, [r3]	@ movhi
	strh	r2, [r3, #12]	@ movhi
	ldr	r3, .L24
	mov	lr, pc
	bx	r3
	ldr	r3, .L24+4
	mov	lr, pc
	bx	r3
	ldr	r3, .L24+8
	ldr	r3, [r3]
	ldr	r4, .L24+12
	mov	r0, r3
	ldr	r2, .L24+16
	str	r3, [r4]
	mov	lr, pc
	bx	r2
	mov	r2, #8
	ldr	r0, [r4]
	mov	r1, r2
	ldr	r3, .L24+20
	mov	lr, pc
	bx	r3
	ldr	r0, .L24+24
	ldr	r3, .L24+28
	mov	lr, pc
	bx	r3
	mov	r0, #32
	mov	r2, #16
	ldr	r1, .L24+32
	ldr	r3, .L24+36
	strh	r0, [r1, #14]	@ movhi
	str	r2, [r3]
	pop	{r4, lr}
	bx	lr
.L25:
	.align	2
.L24:
	.word	initialize_mapHandler
	.word	initialize_mapList
	.word	MAP_ARRAY
	.word	currMap
	.word	loadPalette
	.word	loadMap
	.word	s_MayPal
	.word	setSpritePal
	.word	player
	.word	dirTimer
	.size	init, .-init
	.align	2
	.global	hideSprites
	.syntax unified
	.arm
	.fpu softvfp
	.type	hideSprites, %function
hideSprites:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r1, #512
	ldr	r3, .L30
	add	r2, r3, #1024
.L27:
	strh	r1, [r3], #8	@ movhi
	cmp	r3, r2
	bne	.L27
	bx	lr
.L31:
	.align	2
.L30:
	.word	shadowOAM
	.size	hideSprites, .-hideSprites
	.align	2
	.global	buttonHandler
	.syntax unified
	.arm
	.fpu softvfp
	.type	buttonHandler, %function
buttonHandler:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r3, #67108864
	ldr	r2, .L49
	ldr	ip, .L49+4
	ldr	r1, [r2]
	push	{r4, r5, lr}
	str	r1, [ip]
	ldr	r3, [r3, #304]
	tst	r1, #16
	sub	sp, sp, #20
	mov	r4, r0
	str	r3, [r2]
	beq	.L33
	ands	r3, r3, #16
	beq	.L46
.L33:
	ldr	r1, .L49+8
	ldr	r3, [r1, #8]
	cmp	r3, #0
	bne	.L32
	mov	r3, #67108864
	ldr	r2, [r3, #304]
	tst	r2, #16
	bne	.L35
	add	r4, r4, #24576
	add	r3, r4, #476
	ldrh	r3, [r3, #2]
	ldr	r2, [r4, #492]
	sub	r3, r3, #30
	cmp	r2, r3
	bge	.L32
	mov	ip, #2
	ldr	r2, .L49+12
	ldr	r0, .L49+16
	ldr	r3, .L49+20
	strb	ip, [r2, #16]
	str	r3, [r0]
.L36:
	mov	ip, #1
	mov	r0, #32
	str	ip, [r1, #8]
	strh	r0, [r2, #14]	@ movhi
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, lr}
	bx	r3	@ indirect register sibling call
.L35:
	ldr	r2, [r3, #304]
	tst	r2, #32
	beq	.L47
	ldr	r2, [r3, #304]
	tst	r2, #128
	bne	.L38
	add	r4, r4, #24576
	add	r3, r4, #480
	ldrh	r3, [r3]
	ldr	r2, [r4, #488]
	sub	r3, r3, #22
	cmp	r2, r3
	blt	.L48
.L32:
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, lr}
	bx	lr
.L46:
	mov	r2, #2
	mov	r1, #3
	str	r2, [sp, #8]
	stm	sp, {r1, r2}
	ldr	r0, .L49+24
	mov	r2, r3
	mov	r1, r3
	ldr	r5, .L49+28
	mov	lr, pc
	bx	r5
	b	.L33
.L47:
	add	r4, r4, #24576
	ldr	r3, [r4, #492]
	cmp	r3, #0
	ble	.L32
	mov	ip, #1
	ldr	r2, .L49+12
	ldr	r0, .L49+16
	ldr	r3, .L49+32
	strb	ip, [r2, #16]
	str	r3, [r0]
	b	.L36
.L38:
	ldr	r3, [r3, #304]
	tst	r3, #64
	bne	.L32
	add	r4, r4, #24576
	ldr	r3, [r4, #488]
	cmp	r3, #0
	ble	.L32
	mov	ip, #3
	ldr	r0, .L49+36
	ldr	lr, .L49+16
	ldr	r2, .L49+12
	mov	r3, r0
	str	r0, [lr]
	strb	ip, [r2, #16]
	b	.L36
.L48:
	mov	ip, #4
	ldr	r2, .L49+12
	ldr	r0, .L49+16
	ldr	r3, .L49+40
	strb	ip, [r2, #16]
	str	r3, [r0]
	b	.L36
.L50:
	.align	2
.L49:
	.word	buttons
	.word	oldButtons
	.word	.LANCHOR0
	.word	player
	.word	nextMove
	.word	moveMapRight
	.word	testSpriteTiles
	.word	dmaSpriteSheet
	.word	moveMapLeft
	.word	moveMapUp
	.word	moveMapDown
	.size	buttonHandler, .-buttonHandler
	.align	2
	.global	movePlayerLeft
	.syntax unified
	.arm
	.fpu softvfp
	.type	movePlayerLeft, %function
movePlayerLeft:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	bx	lr
	.size	movePlayerLeft, .-movePlayerLeft
	.align	2
	.global	cameraHandler
	.syntax unified
	.arm
	.fpu softvfp
	.type	cameraHandler, %function
cameraHandler:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L54
	ldr	r3, [r3, #8]
	cmp	r3, #0
	bxeq	lr
	b	cameraHandler.part.0
.L55:
	.align	2
.L54:
	.word	.LANCHOR0
	.size	cameraHandler, .-cameraHandler
	.align	2
	.global	updateScreenLocations
	.syntax unified
	.arm
	.fpu softvfp
	.type	updateScreenLocations, %function
updateScreenLocations:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r0, #67108864
	ldr	r3, .L58
	ldr	r2, .L58+4
	str	lr, [sp, #-4]!
	ldrh	ip, [r2, #4]
	ldrh	lr, [r2]
	ldrh	r1, [r3, #2]
	ldrh	r2, [r3]
	sub	r1, r1, ip
	sub	r2, r2, lr
	strh	r1, [r3, #6]	@ movhi
	strh	r2, [r3, #4]	@ movhi
	strh	lr, [r0, #24]	@ movhi
	strh	ip, [r0, #26]	@ movhi
	ldr	lr, [sp], #4
	bx	lr
.L59:
	.align	2
.L58:
	.word	player
	.word	.LANCHOR0
	.size	updateScreenLocations, .-updateScreenLocations
	.align	2
	.global	drawPlayer
	.syntax unified
	.arm
	.fpu softvfp
	.type	drawPlayer, %function
drawPlayer:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	ldr	r2, .L95
	ldrb	r4, [r2, #16]	@ zero_extendqisi2
	cmp	r4, #0
	sub	sp, sp, #16
	ldrh	r5, [r2, #12]
	ldrsh	r3, [r2, #6]
	beq	.L61
	cmp	r5, #0
	bne	.L61
.L62:
	sub	r3, r3, #1
	mvn	r3, r3, lsl #17
	mvn	r3, r3, lsr #17
	ldr	r1, .L95+4
	cmp	r4, #2
	strh	r3, [r1]	@ movhi
	ldrsh	r3, [r2, #4]
	beq	.L89
.L65:
	mvn	r3, r3, lsl #17
	mov	r6, #0
	mvn	r3, r3, lsr #17
	cmp	r4, r6
	strh	r3, [r1, #2]	@ movhi
	strh	r6, [r1, #4]	@ movhi
	beq	.L70
	cmp	r4, #4
	bne	.L69
	bic	r3, r5, #2
	cmp	r3, #0
	beq	.L70
	cmp	r5, #1
	beq	.L90
	cmp	r5, #3
	bne	.L60
	mov	r5, #2
	mov	r7, #1
	mov	r3, r6
	mov	r2, r4
	mov	r1, r6
	ldr	r8, .L95+8
	stmib	sp, {r5, r7}
	str	r5, [sp]
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r8
	mov	r1, r7
	mov	r3, r6
	mov	r2, r4
	stm	sp, {r4, r5, r7}
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r8
	mov	r0, #6
	stmib	sp, {r5, r7}
	str	r0, [sp]
	mov	r1, r5
	mov	r3, r6
	mov	r2, r4
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r8
	b	.L60
.L61:
	cmp	r5, #2
	beq	.L62
	mvn	r3, r3, lsl #17
	mvn	r3, r3, lsr #17
	ldr	r1, .L95+4
	cmp	r4, #2
	strh	r3, [r1]	@ movhi
	ldrsh	r3, [r2, #4]
	bne	.L65
.L89:
	mov	r0, #0
	orr	r3, r3, #36864
	strh	r3, [r1, #2]	@ movhi
	strh	r0, [r1, #4]	@ movhi
.L66:
	ldrh	r5, [r2, #12]
	bic	r3, r5, #2
	subs	r4, r3, #0
	beq	.L91
	cmp	r5, #1
	beq	.L92
	cmp	r5, #3
	bne	.L60
	mov	r4, #2
	mov	r6, #4
	mov	r7, #1
	mov	r2, r6
	ldr	r5, .L95+8
	stmib	sp, {r4, r7}
	str	r4, [sp]
	mov	r3, #0
	mov	r1, #6
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r5
	mov	r2, r6
	stmib	sp, {r4, r7}
	str	r6, [sp]
	mov	r3, #0
	mov	r1, #7
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r5
	mov	r3, #6
	stmib	sp, {r4, r7}
	str	r3, [sp]
	mov	r2, r6
	mov	r3, #0
	mov	r1, #8
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r5
	b	.L60
.L70:
	mov	r4, #2
	mov	r5, #1
	mov	r3, #0
	ldr	r0, .L95+12
	mov	r2, r3
	mov	r1, r3
	ldr	r6, .L95+8
	stmib	sp, {r4, r5}
	str	r4, [sp]
	mov	lr, pc
	bx	r6
	mov	r3, #0
	mov	r2, #4
	mov	r1, r5
	str	r2, [sp]
	ldr	r0, .L95+12
	mov	r2, r3
	stmib	sp, {r4, r5}
	mov	lr, pc
	bx	r6
	mov	r2, #6
	mov	r3, #0
	str	r2, [sp]
	stmib	sp, {r4, r5}
	mov	r1, r4
	mov	r2, r3
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r6
.L60:
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, r7, r8, lr}
	bx	lr
.L69:
	cmp	r4, #3
	bne	.L73
	bic	r3, r5, #2
	subs	r7, r3, #0
	beq	.L93
	cmp	r5, #1
	beq	.L94
	cmp	r5, #3
	bne	.L60
	mov	r4, #4
	mov	r7, #2
	mov	r8, #1
	mov	r1, r5
	mov	r3, r6
	mov	r2, r4
	ldr	r5, .L95+8
	stmib	sp, {r7, r8}
	str	r7, [sp]
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r5
	mov	r2, r4
	mov	r1, r4
	mov	r3, r6
	stm	sp, {r4, r7, r8}
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r5
	mov	r1, #6
	stmib	sp, {r7, r8}
	str	r1, [sp]
	mov	r2, r4
	mov	r3, r6
	mov	r1, #5
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r5
	b	.L60
.L91:
	mov	r5, #2
	mov	r7, #1
	mov	r2, r4
	ldr	r6, .L95+8
	stmib	sp, {r5, r7}
	str	r5, [sp]
	mov	r1, #6
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r6
	mov	r3, #4
	mov	r2, r4
	stm	sp, {r3, r5, r7}
	mov	r1, #7
	mov	r3, r4
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r6
	mov	r3, #6
	mov	r2, r4
	stm	sp, {r3, r5, r7}
	mov	r1, #8
	mov	r3, r4
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r6
	b	.L60
.L93:
	mov	r5, #2
	mov	r6, #1
	mov	r1, r4
	mov	r2, r7
	ldr	r4, .L95+8
	stmib	sp, {r5, r6}
	str	r5, [sp]
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r4
	mov	r1, #4
	mov	r3, r7
	stm	sp, {r1, r5, r6}
	mov	r2, r7
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r4
	mov	r3, #6
	mov	r2, r7
	stm	sp, {r3, r5, r6}
	mov	r1, #5
	mov	r3, r7
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r4
	b	.L60
.L90:
	mov	r7, #2
	mov	r3, r6
	mov	r2, r7
	mov	r1, r6
	ldr	r8, .L95+8
	str	r5, [sp, #8]
	str	r7, [sp, #4]
	str	r7, [sp]
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r8
	mov	r2, r7
	mov	r3, r6
	mov	r1, r5
	str	r7, [sp, #4]
	str	r5, [sp, #8]
	str	r4, [sp]
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r8
	mov	r0, #6
	str	r7, [sp, #4]
	str	r0, [sp]
	str	r5, [sp, #8]
	mov	r3, r6
	mov	r2, r7
	mov	r1, r7
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r8
	b	.L60
.L94:
	mov	r7, #2
	mov	r1, r4
	mov	r2, r7
	mov	r3, r6
	ldr	r4, .L95+8
	str	r5, [sp, #8]
	str	r7, [sp, #4]
	str	r7, [sp]
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r4
	mov	r1, #4
	mov	r2, r7
	str	r1, [sp]
	mov	r3, r6
	str	r7, [sp, #4]
	str	r5, [sp, #8]
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r4
	mov	r1, #6
	str	r7, [sp, #4]
	str	r1, [sp]
	mov	r2, r7
	str	r5, [sp, #8]
	mov	r3, r6
	mov	r1, #5
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r4
	b	.L60
.L92:
	mov	r4, #2
	ldr	r6, .L95+8
	mov	r2, r4
	stmib	sp, {r4, r5}
	str	r4, [sp]
	mov	r3, #0
	mov	r1, #6
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r6
	mov	r3, #4
	mov	r2, r4
	str	r3, [sp]
	stmib	sp, {r4, r5}
	mov	r3, #0
	mov	r1, #7
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r6
	mov	r3, #6
	str	r4, [sp, #4]
	str	r3, [sp]
	mov	r2, r4
	str	r5, [sp, #8]
	mov	r3, #0
	mov	r1, #8
	ldr	r0, .L95+12
	mov	lr, pc
	bx	r6
	b	.L60
.L73:
	sub	r4, r4, #1
	cmp	r4, #1
	bhi	.L60
	b	.L66
.L96:
	.align	2
.L95:
	.word	player
	.word	shadowOAM
	.word	dmaSpriteSheet
	.word	s_MayTiles
	.size	drawPlayer, .-drawPlayer
	.align	2
	.global	draw
	.syntax unified
	.arm
	.fpu softvfp
	.type	draw, %function
draw:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r1, #512
	push	{r4, lr}
	ldr	r3, .L101
	add	r2, r3, #1024
.L98:
	strh	r1, [r3], #8	@ movhi
	cmp	r3, r2
	bne	.L98
	bl	drawPlayer
	ldr	r4, .L101+4
	mov	r3, #512
	mov	r2, #117440512
	ldr	r1, .L101
	mov	r0, #3
	mov	lr, pc
	bx	r4
	pop	{r4, lr}
	bx	lr
.L102:
	.align	2
.L101:
	.word	shadowOAM
	.word	DMANow
	.size	draw, .-draw
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
	@ Volatile: function does not return.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r7, fp, lr}
	ldr	r3, .L110
	mov	lr, pc
	bx	r3
	mov	r2, #112
	mov	r3, #64
	ldr	r4, .L110+4
	mov	r6, #67108864
	ldr	r10, .L110+8
	strh	r2, [r4]	@ movhi
	strh	r3, [r4, #2]	@ movhi
	ldr	r9, .L110+12
	ldr	r5, .L110+16
	ldr	fp, .L110+20
	ldr	r8, .L110+24
	ldr	r7, .L110+28
	b	.L105
.L104:
	ldrh	r1, [r5, #4]
	ldrh	r0, [r5]
	ldrh	r2, [r4, #2]
	ldrh	r3, [r4]
	sub	r2, r2, r1
	strh	r0, [r6, #24]	@ movhi
	sub	r3, r3, r0
	strh	r1, [r6, #26]	@ movhi
	strh	r2, [r4, #6]	@ movhi
	strh	r3, [r4, #4]	@ movhi
	mov	lr, pc
	bx	r8
	mov	lr, pc
	bx	r7
.L105:
	ldr	r0, [r10]
	mov	lr, pc
	bx	r9
	ldr	r3, [r5, #8]
	cmp	r3, #0
	beq	.L104
	mov	lr, pc
	bx	fp
	b	.L104
.L111:
	.align	2
.L110:
	.word	init
	.word	player
	.word	CURRENT_AREA_P
	.word	buttonHandler
	.word	.LANCHOR0
	.word	cameraHandler.part.0
	.word	draw
	.word	waitForVblank
	.size	main, .-main
	.text
	.align	2
	.global	animatePlayer
	.syntax unified
	.arm
	.fpu softvfp
	.type	animatePlayer, %function
animatePlayer:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldrh	r3, [r0, #14]
	cmp	r3, #0
	bxeq	lr
	ands	r1, r3, #7
	bne	.L114
	ldrh	r2, [r0, #12]
	cmp	r2, #2
	addls	r2, r2, #1
	strhls	r2, [r0, #12]	@ movhi
	strhhi	r1, [r0, #12]	@ movhi
.L114:
	sub	r3, r3, #1
	strh	r3, [r0, #14]	@ movhi
	bx	lr
	.size	animatePlayer, .-animatePlayer
	.align	2
	.global	startPlayerAniCounter
	.syntax unified
	.arm
	.fpu softvfp
	.type	startPlayerAniCounter, %function
startPlayerAniCounter:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r2, #32
	ldr	r3, .L120
	strh	r2, [r3, #14]	@ movhi
	bx	lr
.L121:
	.align	2
.L120:
	.word	player
	.size	startPlayerAniCounter, .-startPlayerAniCounter
	.comm	player,18,4
	.comm	nextMove,4,4
	.comm	currMap,4,4
	.comm	dirTimer,4,4
	.global	moving
	.global	dir
	.comm	shadowOAM,1024,4
	.global	vOff
	.global	hOff
	.comm	oldButtons,4,4
	.comm	buttons,4,4
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	hOff, %object
	.size	hOff, 4
hOff:
	.space	4
	.type	vOff, %object
	.size	vOff, 4
vOff:
	.space	4
	.type	moving, %object
	.size	moving, 4
moving:
	.space	4
	.type	dir, %object
	.size	dir, 4
dir:
	.space	4
	.ident	"GCC: (devkitARM release 47) 7.1.0"
