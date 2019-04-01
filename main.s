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
	.type	buttonHandler.part.0, %function
buttonHandler.part.0:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r3, #67108864
	ldr	r3, [r3, #304]
	tst	r3, #16
	bne	.L2
	ldr	r3, .L16
	ldr	r2, .L16+4
	ldrh	r3, [r3]
	ldr	r2, [r2]
	sub	r3, r3, #30
	cmp	r3, r2
	ldrgt	r3, .L16+8
	ldrgt	r2, .L16+12
	strgt	r2, [r3]
.L2:
	mov	r3, #67108864
	ldr	r3, [r3, #304]
	tst	r3, #32
	bne	.L11
	ldr	r3, .L16+4
	ldr	r3, [r3]
	cmp	r3, #0
	bgt	.L15
.L11:
	mov	r3, #67108864
	ldr	r2, [r3, #304]
	ldr	r3, [r3, #304]
	bx	lr
.L15:
	ldr	r2, .L16+8
	ldr	r3, .L16+16
	push	{r4, lr}
	str	r3, [r2]
	mov	lr, pc
	bx	r3
	mov	r3, #67108864
	pop	{r4, lr}
	ldr	r2, [r3, #304]
	ldr	r3, [r3, #304]
	bx	lr
.L17:
	.align	2
.L16:
	.word	WORLD_MAP_TILE_WIDTH
	.word	TILE_COL
	.word	nextMove
	.word	moveMapRight
	.word	moveMapLeft
	.size	buttonHandler.part.0, .-buttonHandler.part.0
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
	mov	r3, #67108864
	mov	r1, #1024
	mov	r2, #6784
	push	{r4, lr}
	ldr	r0, .L20
	sub	sp, sp, #8
	strh	r1, [r3]	@ movhi
	strh	r2, [r3, #12]	@ movhi
	ldr	r3, .L20+4
	mov	lr, pc
	bx	r3
	mov	r2, #48
	mov	r3, #44
	mov	r1, #13184
	stm	sp, {r2, r3}
	ldr	r0, .L20+8
	mov	r3, #4224
	ldr	r2, .L20+12
	ldr	r4, .L20+16
	mov	lr, pc
	bx	r4
	ldr	r3, .L20+20
	ldrh	r3, [r3]
	mov	r2, #100663296
	ldr	r4, .L20+24
	lsr	r3, r3, #1
	ldr	r1, .L20+28
	mov	r0, #3
	mov	lr, pc
	bx	r4
	mov	r1, #4
	mov	r0, #0
	ldr	r3, .L20+32
	mov	lr, pc
	bx	r3
	ldr	r3, .L20+36
	ldrh	r3, [r3]
	ldr	r2, .L20+40
	lsr	r3, r3, #1
	ldr	r1, .L20+44
	mov	r0, #3
	mov	lr, pc
	bx	r4
	add	sp, sp, #8
	@ sp needed
	pop	{r4, lr}
	bx	lr
.L21:
	.align	2
.L20:
	.word	littlerootPal
	.word	loadPalette
	.word	littlerootTiles
	.word	littlerootMap
	.word	loadMap
	.word	WORLD_TILE_LENGTH
	.word	DMANow
	.word	WORLD_TILES
	.word	initMap
	.word	WORLD_MAP_LENGTH
	.word	100716544
	.word	SCREEN_MAP
	.size	init, .-init
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
	@ link register save eliminated.
	mov	r2, #67108864
	ldr	r3, .L24
	ldr	r0, .L24+4
	ldr	ip, [r3]
	ldr	r1, .L24+8
	str	ip, [r0]
	ldr	r1, [r1]
	ldr	r2, [r2, #304]
	cmp	r1, #0
	str	r2, [r3]
	bxne	lr
	b	buttonHandler.part.0
.L25:
	.align	2
.L24:
	.word	buttons
	.word	oldButtons
	.word	nextMove
	.size	buttonHandler, .-buttonHandler
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
	push	{r4, lr}
	ldr	r4, .L44
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L26
	ldr	r1, .L44+4
	ldr	r0, .L44+8
	ldr	r2, [r1]
	cmp	r3, r0
	sub	r2, r2, #1
	str	r2, [r1]
	beq	.L40
	ldr	r0, .L44+12
	cmp	r3, r0
	beq	.L41
	ldr	r0, .L44+16
	cmp	r3, r0
	beq	.L42
	ldr	r0, .L44+20
	cmp	r3, r0
	beq	.L43
	cmp	r2, #0
	bgt	.L26
	mov	r3, #16
	str	r3, [r1]
.L36:
	mov	r3, #0
	str	r3, [r4]
.L26:
	pop	{r4, lr}
	bx	lr
.L40:
	ldr	ip, .L44+24
	ldr	r0, [ip]
	sub	r0, r0, #1
	str	r0, [ip]
.L30:
	cmp	r2, #0
	bgt	.L26
	mov	r2, #16
	ldr	r0, .L44+12
	cmp	r3, r0
	str	r2, [r1]
	bne	.L36
	b	.L38
.L41:
	ldr	ip, .L44+24
	ldr	r3, [ip]
	cmp	r2, #0
	add	r3, r3, #1
	str	r3, [ip]
	bgt	.L26
	mov	r3, #16
	str	r3, [r1]
.L38:
	mov	lr, pc
	bx	r0
	b	.L36
.L43:
	ldr	ip, .L44+24
	ldr	r0, [ip, #4]
	sub	r0, r0, #1
	str	r0, [ip, #4]
	b	.L30
.L42:
	ldr	ip, .L44+24
	ldr	r0, [ip, #4]
	add	r0, r0, #1
	str	r0, [ip, #4]
	b	.L30
.L45:
	.align	2
.L44:
	.word	nextMove
	.word	.LANCHOR0
	.word	moveMapLeft
	.word	moveMapRight
	.word	moveMapDown
	.word	moveMapUp
	.word	.LANCHOR1
	.size	cameraHandler, .-cameraHandler
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
	ldr	r3, .L50
	mov	lr, pc
	bx	r3
	mov	r5, #67108864
	ldr	r10, .L50+4
	ldr	r7, .L50+8
	ldr	r9, .L50+12
	ldr	fp, .L50+16
	ldr	r8, .L50+20
	ldr	r6, .L50+24
	ldr	r4, .L50+28
	b	.L48
.L47:
	mov	lr, pc
	bx	r8
	ldrh	r2, [r6]
	ldrh	r3, [r6, #4]
	strh	r2, [r5, #24]	@ movhi
	strh	r3, [r5, #26]	@ movhi
	mov	lr, pc
	bx	r4
	mov	lr, pc
	bx	r4
	mov	lr, pc
	bx	r4
.L48:
	ldr	r3, [r7]
	str	r3, [r10]
	ldr	r2, [r9]
	ldr	r3, [r5, #304]
	cmp	r2, #0
	str	r3, [r7]
	bne	.L47
	mov	lr, pc
	bx	fp
	b	.L47
.L51:
	.align	2
.L50:
	.word	init
	.word	oldButtons
	.word	buttons
	.word	nextMove
	.word	buttonHandler.part.0
	.word	cameraHandler
	.word	.LANCHOR1
	.word	waitForVblank
	.size	main, .-main
	.text
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
	@ link register save eliminated.
	mov	r3, #67108864
	ldr	r2, .L53
	ldrh	r1, [r2]
	ldrh	r2, [r2, #4]
	strh	r1, [r3, #24]	@ movhi
	strh	r2, [r3, #26]	@ movhi
	bx	lr
.L54:
	.align	2
.L53:
	.word	.LANCHOR1
	.size	updateScreenLocations, .-updateScreenLocations
	.comm	nextMove,4,4
	.global	dirTimer
	.global	dir
	.global	vOff
	.global	hOff
	.comm	oldButtons,4,4
	.comm	buttons,4,4
	.data
	.align	2
	.set	.LANCHOR0,. + 0
	.type	dirTimer, %object
	.size	dirTimer, 4
dirTimer:
	.word	16
	.bss
	.align	2
	.set	.LANCHOR1,. + 0
	.type	hOff, %object
	.size	hOff, 4
hOff:
	.space	4
	.type	vOff, %object
	.size	vOff, 4
vOff:
	.space	4
	.type	dir, %object
	.size	dir, 4
dir:
	.space	4
	.ident	"GCC: (devkitARM release 47) 7.1.0"
