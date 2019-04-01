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
	.file	"mapHandler.c"
	.text
	.align	2
	.global	loadMap
	.syntax unified
	.arm
	.fpu softvfp
	.type	loadMap, %function
loadMap:
	@ Function supports interworking.
	@ args = 8, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	ip, r1
	push	{r4, r5, r6, r7, r8, lr}
	mov	r5, r3
	mov	r6, r2
	ldr	r3, .L4
	ldrh	r4, [sp, #24]
	ldr	r2, .L4+4
	ldrh	lr, [sp, #28]
	strh	ip, [r3]	@ movhi
	ldr	r7, .L4+8
	lsr	r3, ip, #1
	ldr	ip, .L4+12
	mov	r1, r0
	strh	r4, [r2]	@ movhi
	mov	r0, #3
	ldr	r4, .L4+16
	ldr	r2, .L4+20
	strh	lr, [ip]	@ movhi
	strh	r5, [r7]	@ movhi
	mov	lr, pc
	bx	r4
	lsr	r3, r5, #1
	mov	r1, r6
	ldr	r2, .L4+24
	mov	r0, #3
	mov	lr, pc
	bx	r4
	mov	r2, #0
	ldr	r3, .L4+28
	strb	r2, [r3]
	pop	{r4, r5, r6, r7, r8, lr}
	bx	lr
.L5:
	.align	2
.L4:
	.word	WORLD_TILE_LENGTH
	.word	WORLD_MAP_TILE_WIDTH
	.word	WORLD_MAP_LENGTH
	.word	WORLD_MAP_TILE_HEIGHT
	.word	DMANow
	.word	WORLD_TILES
	.word	WORLD_MAP
	.word	moving
	.size	loadMap, .-loadMap
	.align	2
	.global	initMap
	.syntax unified
	.arm
	.fpu softvfp
	.type	initMap, %function
initMap:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	fp, r0
	mov	r6, r1
	mov	r5, r0
	ldr	r4, .L10
	ldr	r10, .L10+4
	ldr	r9, .L10+8
	ldr	r8, .L10+12
	add	r7, r4, #1280
.L7:
	ldrh	r3, [r10]
	mla	r1, r5, r3, r6
	mov	r2, r4
	mov	r3, #32
	add	r1, r9, r1, lsl #1
	mov	r0, #3
	add	r4, r4, #64
	mov	lr, pc
	bx	r8
	cmp	r7, r4
	add	r5, r5, #1
	bne	.L7
	mov	r3, #0
	ldr	r2, .L10+16
	ldr	r0, .L10+20
	str	r3, [r2]
	ldr	r1, .L10+24
	ldr	r2, .L10+28
	str	r3, [r0]
	str	fp, [r1]
	str	r6, [r2]
	pop	{r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx	lr
.L11:
	.align	2
.L10:
	.word	SCREEN_MAP
	.word	WORLD_MAP_TILE_WIDTH
	.word	WORLD_MAP
	.word	DMANow
	.word	TILE_ROW_OFFSET
	.word	TILE_COL_OFFSET
	.word	TILE_ROW
	.word	TILE_COL
	.size	initMap, .-initMap
	.align	2
	.global	moveMapLeft
	.syntax unified
	.arm
	.fpu softvfp
	.type	moveMapLeft, %function
moveMapLeft:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L20
	ldr	r2, .L20+4
	ldr	r3, [r0]
	ldr	r1, [r2]
	sub	ip, r3, #2
	push	{r4, lr}
	ldr	lr, .L20+8
	str	ip, [r0]
	sub	r0, r1, #2
	str	r0, [r2]
	ldr	r0, .L20+12
	cmp	ip, #0
	ldr	r2, .L20+16
	ldrh	ip, [lr]
	lsl	r3, r3, #1
	add	lr, r0, #1280
	add	lr, lr, r3
	lsl	ip, ip, #1
	add	r3, r3, r0
	add	r2, r2, r1, lsl #1
	blt	.L14
.L16:
	ldrh	r0, [r2, #-4]
	ldrh	r1, [r2, #-2]
	strh	r0, [r3, #-4]	@ movhi
	strh	r1, [r3, #-2]	@ movhi
	add	r3, r3, #64
	cmp	r3, lr
	add	r2, r2, ip
	bne	.L16
.L15:
	ldr	r3, .L20+20
	ldrh	r3, [r3]
	ldr	r4, .L20+24
	ldr	r2, .L20+28
	lsr	r3, r3, #1
	ldr	r1, .L20+12
	mov	r0, #3
	mov	lr, pc
	bx	r4
	pop	{r4, lr}
	bx	lr
.L14:
	ldrh	r0, [r2, #-4]
	ldrh	r1, [r2, #-2]
	strh	r0, [r3, #60]	@ movhi
	strh	r1, [r3, #62]	@ movhi
	add	r3, r3, #64
	cmp	lr, r3
	add	r2, r2, ip
	bne	.L14
	b	.L15
.L21:
	.align	2
.L20:
	.word	TILE_COL_OFFSET
	.word	TILE_COL
	.word	WORLD_MAP_TILE_WIDTH
	.word	SCREEN_MAP
	.word	WORLD_MAP
	.word	WORLD_MAP_LENGTH
	.word	DMANow
	.word	100716544
	.size	moveMapLeft, .-moveMapLeft
	.align	2
	.global	moveMapRight
	.syntax unified
	.arm
	.fpu softvfp
	.type	moveMapRight, %function
moveMapRight:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r0, .L30
	ldr	r2, .L30+4
	ldr	r3, [r0]
	ldr	r1, [r2]
	add	ip, r3, #2
	push	{r4, lr}
	ldr	lr, .L30+8
	str	ip, [r0]
	add	r0, r1, #2
	str	r0, [r2]
	ldr	r0, .L30+12
	cmp	ip, #0
	ldr	r2, .L30+16
	ldrh	ip, [lr]
	lsl	r3, r3, #1
	add	lr, r0, #1280
	add	lr, lr, r3
	lsl	ip, ip, #1
	add	r3, r3, r0
	add	r2, r2, r1, lsl #1
	ble	.L24
.L26:
	ldrh	r0, [r2, #64]
	ldrh	r1, [r2, #66]
	strh	r0, [r3]	@ movhi
	strh	r1, [r3, #2]	@ movhi
	add	r3, r3, #64
	cmp	r3, lr
	add	r2, r2, ip
	bne	.L26
.L25:
	ldr	r3, .L30+20
	ldrh	r3, [r3]
	ldr	r4, .L30+24
	ldr	r2, .L30+28
	lsr	r3, r3, #1
	ldr	r1, .L30+12
	mov	r0, #3
	mov	lr, pc
	bx	r4
	pop	{r4, lr}
	bx	lr
.L24:
	ldrh	r0, [r2, #64]
	ldrh	r1, [r2, #66]
	strh	r0, [r3, #64]	@ movhi
	strh	r1, [r3, #66]	@ movhi
	add	r3, r3, #64
	cmp	lr, r3
	add	r2, r2, ip
	bne	.L24
	b	.L25
.L31:
	.align	2
.L30:
	.word	TILE_COL_OFFSET
	.word	TILE_COL
	.word	WORLD_MAP_TILE_WIDTH
	.word	SCREEN_MAP
	.word	WORLD_MAP
	.word	WORLD_MAP_LENGTH
	.word	DMANow
	.word	100716544
	.size	moveMapRight, .-moveMapRight
	.align	2
	.global	moveMapUp
	.syntax unified
	.arm
	.fpu softvfp
	.type	moveMapUp, %function
moveMapUp:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	bx	lr
	.size	moveMapUp, .-moveMapUp
	.align	2
	.global	moveMapDown
	.syntax unified
	.arm
	.fpu softvfp
	.type	moveMapDown, %function
moveMapDown:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	bx	lr
	.size	moveMapDown, .-moveMapDown
	.comm	moving,1,1
	.comm	TILE_ROW_OFFSET,4,4
	.comm	TILE_COL_OFFSET,4,4
	.comm	TILE_ROW,4,4
	.comm	TILE_COL,4,4
	.comm	WORLD_MAP_TILE_HEIGHT,2,2
	.comm	WORLD_MAP_TILE_WIDTH,2,2
	.comm	WORLD_MAP_LENGTH,2,2
	.comm	WORLD_TILE_LENGTH,2,2
	.comm	WORLD_MAP,5000,4
	.comm	WORLD_TILES,16000,4
	.comm	SCREEN_MAP,2048,4
	.ident	"GCC: (devkitARM release 47) 7.1.0"
