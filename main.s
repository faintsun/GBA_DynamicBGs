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
	.global	initMode0
	.syntax unified
	.arm
	.fpu softvfp
	.type	initMode0, %function
initMode0:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r3, #67108864
	mov	r1, #1024
	mov	r2, #6784
	push	{r4, lr}
	ldr	r0, .L4
	sub	sp, sp, #8
	strh	r1, [r3]	@ movhi
	strh	r2, [r3, #12]	@ movhi
	ldr	r3, .L4+4
	mov	lr, pc
	bx	r3
	mov	r2, #48
	mov	r3, #44
	mov	r1, #13184
	stm	sp, {r2, r3}
	ldr	r0, .L4+8
	mov	r3, #4224
	ldr	r2, .L4+12
	ldr	r4, .L4+16
	mov	lr, pc
	bx	r4
	ldr	r3, .L4+20
	ldrh	r3, [r3]
	mov	r2, #100663296
	ldr	r4, .L4+24
	lsr	r3, r3, #1
	ldr	r1, .L4+28
	mov	r0, #3
	mov	lr, pc
	bx	r4
	mov	r1, #2
	mov	r0, #0
	ldr	r3, .L4+32
	mov	lr, pc
	bx	r3
	ldr	r3, .L4+36
	ldrh	r3, [r3]
	ldr	r2, .L4+40
	lsr	r3, r3, #1
	ldr	r1, .L4+44
	mov	r0, #3
	mov	lr, pc
	bx	r4
	add	sp, sp, #8
	@ sp needed
	pop	{r4, lr}
	bx	lr
.L5:
	.align	2
.L4:
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
	.size	initMode0, .-initMode0
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
	ldr	r2, .L26
	ldr	r1, .L26+4
	ldr	r0, [r2]
	push	{r4, r5, r6, lr}
	str	r0, [r1]
	ldr	r1, [r3, #304]
	str	r1, [r2]
	ldr	r3, [r3, #304]
	tst	r3, #16
	bne	.L7
	ldr	r3, .L26+8
	ldr	r2, .L26+12
	ldrh	r3, [r3]
	ldr	r2, [r2]
	sub	r3, r3, #30
	cmp	r3, r2
	bgt	.L23
.L7:
	mov	r3, #67108864
	ldr	r3, [r3, #304]
	tst	r3, #32
	bne	.L8
	ldr	r3, .L26+12
	ldr	r3, [r3]
	cmp	r3, #0
	bgt	.L24
.L8:
	mov	r3, #67108864
	ldr	r3, [r3, #304]
	tst	r3, #128
	bne	.L10
	mov	lr, #1
	mov	ip, #2
	ldr	r2, .L26+16
	ldr	r1, [r2]
	ldr	r3, .L26+20
	add	r0, r1, lr
	cmp	r0, #6
	str	r0, [r2]
	str	lr, [r3]
	str	ip, [r3, #4]
	bgt	.L25
.L10:
	mov	r3, #67108864
	ldr	r3, [r3, #304]
	tst	r3, #64
	bne	.L6
	ldr	r2, .L26+16
	ldr	r3, [r2]
	cmp	r3, #0
	ble	.L6
	mov	ip, #1
	mov	r0, #3
	ldr	r1, .L26+20
	sub	r3, r3, #1
	str	r3, [r2]
	str	ip, [r1]
	str	r0, [r1, #4]
.L6:
	pop	{r4, r5, r6, lr}
	bx	lr
.L24:
	mov	r0, #1
	mov	r1, #0
	ldr	r3, .L26+20
	ldr	r2, .L26+24
	stm	r3, {r0, r1}
	mov	lr, pc
	bx	r2
	b	.L8
.L25:
	add	r1, r1, #21
	ldr	r5, .L26+28
	lsl	r1, r1, #6
	ldr	r3, .L26+32
	sub	r2, r1, #1664
	add	r2, r5, r2
	add	r1, r3, r1
	mov	r0, #3
	mov	r3, #32
	ldr	r4, .L26+36
	mov	lr, pc
	bx	r4
	ldr	r3, .L26+40
	ldrh	r3, [r3]
	mov	r1, r5
	lsr	r3, r3, #1
	ldr	r2, .L26+44
	mov	r0, #3
	mov	lr, pc
	bx	r4
	b	.L10
.L23:
	mov	r2, #1
	ldr	r3, .L26+20
	ldr	r1, .L26+48
	str	r2, [r3]
	str	r2, [r3, #4]
	mov	lr, pc
	bx	r1
	b	.L7
.L27:
	.align	2
.L26:
	.word	buttons
	.word	oldButtons
	.word	WORLD_MAP_TILE_WIDTH
	.word	TILE_COL
	.word	TILE_ROW
	.word	.LANCHOR0
	.word	moveMapLeft
	.word	SCREEN_MAP
	.word	WORLD_MAP
	.word	DMANow
	.word	WORLD_MAP_LENGTH
	.word	100716544
	.word	moveMapRight
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
	@ link register save eliminated.
	ldr	r1, .L37
	ldr	r2, .L37+4
	ldr	r3, [r1]
	ldr	r0, [r2, #4]
	sub	r3, r3, #1
	cmp	r0, #0
	str	r3, [r1]
	bne	.L29
	ldr	r0, [r2, #8]
	cmp	r3, #0
	sub	r0, r0, #1
	str	r0, [r2, #8]
	bxgt	lr
.L36:
	mov	ip, #16
	mov	r0, #2
	mov	r3, #0
	str	ip, [r1]
	str	r0, [r2, #16]
	str	r3, [r2]
	bx	lr
.L29:
	cmp	r0, #1
	beq	.L34
	cmp	r0, #2
	beq	.L35
	cmp	r0, #3
	ldreq	r0, [r2, #12]
	subeq	r0, r0, #1
	streq	r0, [r2, #12]
	cmp	r3, #0
	bxgt	lr
	b	.L36
.L34:
	ldr	r0, [r2, #8]
	cmp	r3, #0
	add	r0, r0, #1
	str	r0, [r2, #8]
	bxgt	lr
	b	.L36
.L35:
	ldr	r0, [r2, #12]
	cmp	r3, #0
	add	r0, r0, #1
	str	r0, [r2, #12]
	bxgt	lr
	b	.L36
.L38:
	.align	2
.L37:
	.word	.LANCHOR1
	.word	.LANCHOR0
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
	push	{r7, lr}
	ldr	r3, .L45
	mov	lr, pc
	bx	r3
	mov	r6, #67108864
	ldr	r5, .L45+4
	ldr	r8, .L45+8
	ldr	r7, .L45+12
	ldr	r4, .L45+16
	b	.L42
.L44:
	mov	lr, pc
	bx	r8
.L41:
	ldrh	r2, [r5, #8]
	ldrh	r3, [r5, #12]
	strh	r2, [r6, #24]	@ movhi
	strh	r3, [r6, #26]	@ movhi
	mov	lr, pc
	bx	r4
	mov	lr, pc
	bx	r4
	mov	lr, pc
	bx	r4
.L42:
	ldr	r3, [r5]
	cmp	r3, #0
	beq	.L44
	mov	lr, pc
	bx	r7
	b	.L41
.L46:
	.align	2
.L45:
	.word	initMode0
	.word	.LANCHOR0
	.word	buttonHandler
	.word	cameraHandler
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
	ldr	r2, .L48
	ldrh	r1, [r2, #8]
	ldrh	r2, [r2, #12]
	strh	r1, [r3, #24]	@ movhi
	strh	r2, [r3, #26]	@ movhi
	bx	lr
.L49:
	.align	2
.L48:
	.word	.LANCHOR0
	.size	updateScreenLocations, .-updateScreenLocations
	.global	delayRightMove
	.global	dirTimer
	.global	dir
	.global	moving
	.global	vOff
	.global	hOff
	.comm	oldButtons,4,4
	.comm	buttons,4,4
	.data
	.align	2
	.set	.LANCHOR1,. + 0
	.type	dirTimer, %object
	.size	dirTimer, 4
dirTimer:
	.word	16
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	moving, %object
	.size	moving, 4
moving:
	.space	4
	.type	dir, %object
	.size	dir, 4
dir:
	.space	4
	.type	hOff, %object
	.size	hOff, 4
hOff:
	.space	4
	.type	vOff, %object
	.size	vOff, 4
vOff:
	.space	4
	.type	delayRightMove, %object
	.size	delayRightMove, 4
delayRightMove:
	.space	4
	.ident	"GCC: (devkitARM release 47) 7.1.0"
