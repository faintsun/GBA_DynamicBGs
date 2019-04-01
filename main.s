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
	mov	r1, #0
	ldr	r3, .L4+32
	mov	r0, r1
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
	ldr	r2, .L32
	ldr	r1, .L32+4
	ldr	r0, [r2]
	push	{r4, r5, r6, lr}
	str	r0, [r1]
	ldr	r1, [r3, #304]
	str	r1, [r2]
	ldr	r3, [r3, #304]
	tst	r3, #16
	bne	.L7
	ldr	r3, .L32+8
	ldr	r1, .L32+12
	ldrh	r3, [r3]
	ldrh	r2, [r1]
	sub	r3, r3, #30
	cmp	r2, r3
	blt	.L29
.L7:
	mov	r3, #67108864
	ldr	r3, [r3, #304]
	tst	r3, #32
	bne	.L8
	ldr	r4, .L32+12
	ldrh	r0, [r4]
	cmp	r0, #0
	bne	.L30
.L8:
	mov	r3, #67108864
	ldr	r3, [r3, #304]
	tst	r3, #128
	bne	.L10
	mov	ip, #1
	mov	r0, #2
	ldr	r2, .L32+16
	ldrh	r1, [r2]
	add	r1, r1, ip
	lsl	r1, r1, #16
	lsr	r1, r1, #16
	ldr	r3, .L32+20
	cmp	r1, #6
	strh	r1, [r2]	@ movhi
	str	ip, [r3]
	str	r0, [r3, #4]
	bhi	.L31
.L10:
	mov	r3, #67108864
	ldr	r3, [r3, #304]
	tst	r3, #64
	bne	.L6
	ldr	r2, .L32+16
	ldrh	r3, [r2]
	cmp	r3, #0
	beq	.L6
	mov	ip, #1
	mov	r0, #3
	ldr	r1, .L32+20
	sub	r3, r3, #1
	strh	r3, [r2]	@ movhi
	str	ip, [r1]
	str	r0, [r1, #4]
.L6:
	pop	{r4, r5, r6, lr}
	bx	lr
.L29:
	mov	r0, #1
	ldr	r3, .L32+20
	add	r2, r2, #2
	strh	r2, [r1]	@ movhi
	str	r0, [r3]
	str	r0, [r3, #4]
	str	r0, [r3, #8]
	b	.L7
.L31:
	add	r1, r1, #20
	ldr	r5, .L32+24
	lsl	r1, r1, #6
	ldr	r3, .L32+28
	sub	r2, r1, #1664
	add	r2, r5, r2
	add	r1, r3, r1
	mov	r0, #3
	mov	r3, #32
	ldr	r4, .L32+32
	mov	lr, pc
	bx	r4
	mov	r1, r5
	mov	r3, #2112
	ldr	r2, .L32+36
	mov	r0, #3
	mov	lr, pc
	bx	r4
	b	.L10
.L30:
	mov	ip, #1
	mov	r1, #0
	ldr	r3, .L32+20
	ldr	r2, .L32+40
	str	ip, [r3]
	str	r1, [r3, #4]
	mov	lr, pc
	bx	r2
	ldrh	ip, [r4]
	sub	ip, ip, #2
	strh	ip, [r4]	@ movhi
	mov	r3, #1024
	ldr	r2, .L32+36
	ldr	r1, .L32+24
	mov	r0, #3
	ldr	r4, .L32+32
	mov	lr, pc
	bx	r4
	b	.L8
.L33:
	.align	2
.L32:
	.word	buttons
	.word	oldButtons
	.word	WORLD_MAP_TILE_WIDTH
	.word	TILE_COL
	.word	TILE_ROW
	.word	.LANCHOR0
	.word	SCREEN_MAP
	.word	littlerootMap
	.word	DMANow
	.word	100716544
	.word	moveMapLeft
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
	ldr	r1, .L43
	ldr	r2, .L43+4
	ldr	r3, [r1]
	ldr	r0, [r2, #4]
	sub	r3, r3, #1
	cmp	r0, #0
	str	r3, [r1]
	bne	.L35
	ldr	r0, [r2, #12]
	cmp	r3, #0
	sub	r0, r0, #1
	str	r0, [r2, #12]
	bxgt	lr
.L42:
	mov	ip, #16
	mov	r0, #2
	mov	r3, #0
	str	ip, [r1]
	str	r0, [r2, #8]
	str	r3, [r2]
	bx	lr
.L35:
	cmp	r0, #1
	beq	.L40
	cmp	r0, #2
	beq	.L41
	cmp	r0, #3
	ldreq	r0, [r2, #16]
	subeq	r0, r0, #1
	streq	r0, [r2, #16]
	cmp	r3, #0
	bxgt	lr
	b	.L42
.L40:
	ldr	r0, [r2, #12]
	cmp	r3, #0
	add	r0, r0, #1
	str	r0, [r2, #12]
	bxgt	lr
	b	.L42
.L41:
	ldr	r0, [r2, #16]
	cmp	r3, #0
	add	r0, r0, #1
	str	r0, [r2, #16]
	bxgt	lr
	b	.L42
.L44:
	.align	2
.L43:
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
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}
	ldr	r3, .L56
	ldr	fp, .L56+4
	mov	lr, pc
	bx	r3
	mov	r10, #0
	ldr	r4, .L56+8
	ldr	r7, .L56+12
	ldr	r6, .L56+16
	ldr	r9, .L56+20
	ldr	r8, .L56+24
	ldr	r5, .L56+28
	b	.L51
.L55:
	mov	lr, pc
	bx	r7
	ldr	r3, [r4, #8]
	cmp	r3, #2
	beq	.L54
.L48:
	mov	r3, #67108864
	ldrh	r1, [r4, #12]
	ldrh	r2, [r4, #16]
	strh	r1, [r3, #24]	@ movhi
	strh	r2, [r3, #26]	@ movhi
	mov	lr, pc
	bx	r5
	mov	lr, pc
	bx	r5
	mov	lr, pc
	bx	r5
.L51:
	ldr	r3, [r4]
	cmp	r3, #0
	beq	.L55
	mov	lr, pc
	bx	r6
	ldr	r3, [r4, #8]
	cmp	r3, #2
	bne	.L48
.L54:
	ldrh	ip, [r9]
	cmp	ip, #1
	bls	.L49
	ldr	r3, .L56+32
	ldrh	lr, [r3]
	ldr	r3, .L56+36
	lsl	ip, ip, #1
	add	r2, r3, ip
	ldr	r1, .L56+40
	ldr	r3, .L56+4
	lsl	lr, lr, #1
	add	r3, r3, ip
	add	ip, r1, ip
.L50:
	ldrh	r0, [r2, #60]
	ldrh	r1, [r2, #62]
	strh	r0, [r3, #-4]	@ movhi
	strh	r1, [r3, #-2]	@ movhi
	add	r3, r3, #64
	cmp	r3, ip
	add	r2, r2, lr
	bne	.L50
.L49:
	mov	r3, #1024
	ldr	r2, .L56+44
	mov	r1, fp
	mov	r0, #3
	str	r10, [r4, #8]
	mov	lr, pc
	bx	r8
	b	.L48
.L57:
	.align	2
.L56:
	.word	initMode0
	.word	SCREEN_MAP
	.word	.LANCHOR0
	.word	buttonHandler
	.word	cameraHandler
	.word	TILE_COL
	.word	DMANow
	.word	waitForVblank
	.word	WORLD_MAP_TILE_WIDTH
	.word	littlerootMap
	.word	SCREEN_MAP+1280
	.word	100716544
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
	ldr	r2, .L59
	ldrh	r1, [r2, #12]
	ldrh	r2, [r2, #16]
	strh	r1, [r3, #24]	@ movhi
	strh	r2, [r3, #26]	@ movhi
	bx	lr
.L60:
	.align	2
.L59:
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
	.type	delayRightMove, %object
	.size	delayRightMove, 4
delayRightMove:
	.space	4
	.type	hOff, %object
	.size	hOff, 4
hOff:
	.space	4
	.type	vOff, %object
	.size	vOff, 4
vOff:
	.space	4
	.ident	"GCC: (devkitARM release 47) 7.1.0"
