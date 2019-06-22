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
	.file	"spriteHandler.c"
	.text
	.align	2
	.global	dmaSpriteSheet
	.syntax unified
	.arm
	.fpu softvfp
	.type	dmaSpriteSheet, %function
dmaSpriteSheet:
	@ Function supports interworking.
	@ args = 12, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, lr}
	ldr	r6, [sp, #32]
	cmp	r6, #0
	ble	.L1
	ldr	ip, [sp, #24]
	add	r5, ip, r3, lsl #5
	lsl	r5, r5, #5
	add	r6, r1, r6
	ldr	r3, [sp, #28]
	add	r6, r2, r6, lsl #5
	add	r5, r5, #100663296
	add	r2, r2, r1, lsl #5
	ldr	r8, .L7
	add	r5, r5, #65536
	add	r6, r0, r6, lsl #5
	add	r4, r0, r2, lsl #5
	lsl	r7, r3, #4
.L3:
	mov	r2, r5
	mov	r1, r4
	mov	r3, r7
	mov	r0, #3
	add	r4, r4, #1024
	mov	lr, pc
	bx	r8
	cmp	r4, r6
	add	r5, r5, #1024
	bne	.L3
.L1:
	pop	{r4, r5, r6, r7, r8, lr}
	bx	lr
.L8:
	.align	2
.L7:
	.word	DMANow
	.size	dmaSpriteSheet, .-dmaSpriteSheet
	.align	2
	.global	setSpriteTiles
	.syntax unified
	.arm
	.fpu softvfp
	.type	setSpriteTiles, %function
setSpriteTiles:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r1, r0
	ldr	r4, .L11
	mov	r3, #16384
	ldr	r2, .L11+4
	mov	r0, #3
	mov	lr, pc
	bx	r4
	pop	{r4, lr}
	bx	lr
.L12:
	.align	2
.L11:
	.word	DMANow
	.word	100728832
	.size	setSpriteTiles, .-setSpriteTiles
	.align	2
	.global	setSpritePal
	.syntax unified
	.arm
	.fpu softvfp
	.type	setSpritePal, %function
setSpritePal:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r1, r0
	ldr	r4, .L15
	mov	r3, #256
	ldr	r2, .L15+4
	mov	r0, #3
	mov	lr, pc
	bx	r4
	pop	{r4, lr}
	bx	lr
.L16:
	.align	2
.L15:
	.word	DMANow
	.word	83886592
	.size	setSpritePal, .-setSpritePal
	.ident	"GCC: (devkitARM release 47) 7.1.0"
