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
	ldr	r3, .L10+16
	ldr	r2, .L10+20
	strh	r6, [r3]	@ movhi
	strh	fp, [r2]	@ movhi
	pop	{r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx	lr
.L11:
	.align	2
.L10:
	.word	SCREEN_MAP
	.word	WORLD_MAP_TILE_WIDTH
	.word	WORLD_MAP
	.word	DMANow
	.word	TILE_COL
	.word	TILE_ROW
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
	ldr	r2, .L16
	ldr	r3, .L16+4
	str	lr, [sp, #-4]!
	ldrh	lr, [r2]
	ldr	r2, .L16+8
	lsl	r0, r0, #1
	add	ip, r3, #1280
	add	ip, ip, r0
	add	r3, r0, r3
	lsl	lr, lr, #1
	add	r0, r0, r2
.L13:
	ldrh	r1, [r0, #-4]
	ldrh	r2, [r0, #-2]
	strh	r1, [r3, #-4]	@ movhi
	strh	r2, [r3, #-2]	@ movhi
	add	r3, r3, #64
	cmp	r3, ip
	add	r0, r0, lr
	bne	.L13
	ldr	lr, [sp], #4
	bx	lr
.L17:
	.align	2
.L16:
	.word	WORLD_MAP_TILE_WIDTH
	.word	SCREEN_MAP
	.word	WORLD_MAP
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
	push	{r4, r5, r6, lr}
	ldr	r4, .L22
	ldr	r1, .L22+4
	ldr	r3, .L22+8
	ldrh	r5, [r4]
	ldrh	ip, [r1]
	ldr	r2, .L22+12
	lsl	r1, r5, #1
	add	lr, r3, #1280
	add	r2, r1, r2
	add	r3, r1, r3
	add	lr, lr, r1
	lsl	ip, ip, #1
.L19:
	ldrh	r0, [r2, #60]
	ldrh	r1, [r2, #62]
	strh	r0, [r3, #-4]	@ movhi
	strh	r1, [r3, #-2]	@ movhi
	add	r3, r3, #64
	cmp	r3, lr
	add	r2, r2, ip
	bne	.L19
	ldr	r3, .L22+16
	ldrh	r3, [r3]
	add	r5, r5, #2
	strh	r5, [r4]	@ movhi
	lsr	r3, r3, #1
	ldr	r4, .L22+20
	ldr	r2, .L22+24
	ldr	r1, .L22+8
	mov	r0, #3
	mov	lr, pc
	bx	r4
	pop	{r4, r5, r6, lr}
	bx	lr
.L23:
	.align	2
.L22:
	.word	TILE_COL
	.word	WORLD_MAP_TILE_WIDTH
	.word	SCREEN_MAP
	.word	WORLD_MAP
	.word	WORLD_MAP_LENGTH
	.word	DMANow
	.word	100716544
	.size	moveMapRight, .-moveMapRight
	.comm	TILE_ROW,2,2
	.comm	TILE_COL,2,2
	.comm	WORLD_MAP_TILE_HEIGHT,2,2
	.comm	WORLD_MAP_TILE_WIDTH,2,2
	.comm	WORLD_MAP_LENGTH,2,2
	.comm	WORLD_TILE_LENGTH,2,2
	.comm	WORLD_MAP,5000,4
	.comm	WORLD_TILES,16000,4
	.comm	SCREEN_MAP,2048,4
	.ident	"GCC: (devkitARM release 47) 7.1.0"
