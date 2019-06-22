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
	.file	"mapList.c"
	.text
	.align	2
	.global	initialize_mapList
	.syntax unified
	.arm
	.fpu softvfp
	.type	initialize_mapList, %function
initialize_mapList:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r1, #15488
	push	{r4, lr}
	mov	r0, #4800
	mov	lr, #9280
	ldr	r2, .L4
	ldr	r3, .L4+4
	ldr	ip, .L4+8
	strh	r1, [r2, #4]	@ movhi
	str	r3, [r2]
	ldr	r1, .L4+12
	ldr	r3, .L4+16
	str	ip, [r2, #8]
	strh	r1, [r2, #12]	@ movhi
	ldr	ip, .L4+20
	ldr	r1, .L4+24
	str	r3, [r2, #16]
	ldr	r3, .L4+28
	str	ip, [r2, #20]
	ldr	r4, .L4+32
	str	r2, [r1]
	ldr	ip, .L4+36
	str	r3, [r1, #4]
	ldr	r2, .L4+40
	ldr	r1, .L4+44
	str	r4, [r3]
	strh	lr, [r3, #4]	@ movhi
	str	ip, [r3, #8]
	strh	r0, [r3, #12]	@ movhi
	str	r1, [r3, #16]
	str	r2, [r3, #20]
	pop	{r4, lr}
	bx	lr
.L5:
	.align	2
.L4:
	.word	LittlerootTown
	.word	littlerootTiles
	.word	littlerootMap
	.word	6800
	.word	littlerootPal
	.word	3276868
	.word	MAP_ARRAY
	.word	DewfordTown
	.word	dewfordTiles
	.word	dewfordMap
	.word	3145778
	.word	dewfordPal
	.size	initialize_mapList, .-initialize_mapList
	.comm	MAP_ARRAY,8,4
	.comm	DewfordTown,24,4
	.comm	LittlerootTown,24,4
	.comm	area,25104,4
	.ident	"GCC: (devkitARM release 47) 7.1.0"
