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
	.global	initialize_mapHandler
	.syntax unified
	.arm
	.fpu softvfp
	.type	initialize_mapHandler, %function
initialize_mapHandler:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L3
	ldr	r2, .L3+4
	str	r2, [r3]
	bx	lr
.L4:
	.align	2
.L3:
	.word	CURRENT_AREA_P
	.word	area
	.size	initialize_mapHandler, .-initialize_mapHandler
	.align	2
	.global	loadMap
	.syntax unified
	.arm
	.fpu softvfp
	.type	loadMap, %function
loadMap:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r4, r0
	ldr	fp, .L9
	sub	sp, sp, #12
	ldrh	r5, [r0, #12]
	mov	r10, r1
	str	r1, [sp, #4]
	ldrh	r1, [r0, #4]
	ldrh	r0, [r0, #20]
	ldrh	lr, [r4, #22]
	add	r6, fp, #476
	add	ip, fp, #480
	lsr	r3, r1, #1
	ldr	r7, .L9+4
	str	r1, [fp, #472]
	mov	r8, r2
	ldr	r1, [r4]
	sub	r2, fp, #22528
	strh	r0, [r6, #2]	@ movhi
	mov	r0, #3
	strh	lr, [ip]	@ movhi
	strh	r5, [r6]	@ movhi
	mov	lr, pc
	bx	r7
	ldrh	r3, [r6]
	ldr	r1, [r4, #8]
	lsr	r3, r3, #1
	sub	r2, fp, #6528
	mov	r0, #3
	mov	lr, pc
	bx	r7
	ldr	r3, [fp, #472]
	add	r3, r3, r3, lsr #31
	sub	r9, fp, #24576
	asr	r3, r3, #1
	sub	r1, fp, #22528
	mov	r2, #100663296
	mov	r0, #3
	mov	lr, pc
	bx	r7
	mov	r4, r9
	mov	r5, r10
	add	r10, r9, #2048
.L6:
	ldrh	r3, [r6, #2]
	mla	r1, r5, r3, r8
	add	r1, r1, #9024
	mov	r2, r4
	add	r1, r9, r1, lsl #1
	mov	r3, #32
	mov	r0, #3
	add	r4, r4, #64
	mov	lr, pc
	bx	r7
	cmp	r10, r4
	add	r5, r5, #1
	bne	.L6
	mov	r0, #0
	ldr	r2, [sp, #4]
	str	r0, [fp, #504]
	str	r2, [fp, #488]
	str	r2, [fp, #496]
	str	r0, [fp, #508]
	str	r0, [fp, #512]
	str	r0, [fp, #516]
	str	r0, [fp, #520]
	str	r0, [fp, #524]
	mov	r3, #1024
	ldr	r2, .L9+8
	ldr	r1, .L9+12
	mov	r0, #3
	str	r8, [fp, #492]
	str	r8, [fp, #500]
	mov	lr, pc
	bx	r7
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx	lr
.L10:
	.align	2
.L9:
	.word	area+24576
	.word	DMANow
	.word	100720640
	.word	area
	.size	loadMap, .-loadMap
	.align	2
	.global	loadPalette
	.syntax unified
	.arm
	.fpu softvfp
	.type	loadPalette, %function
loadPalette:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	r1, [r0, #16]
	ldr	r4, .L13
	mov	r3, #256
	mov	r2, #83886080
	mov	r0, #3
	mov	lr, pc
	bx	r4
	pop	{r4, lr}
	bx	lr
.L14:
	.align	2
.L13:
	.word	DMANow
	.size	loadPalette, .-loadPalette
	.align	2
	.global	drawMap
	.syntax unified
	.arm
	.fpu softvfp
	.type	drawMap, %function
drawMap:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	mov	r3, #1024
	ldr	r4, .L17
	ldr	r2, .L17+4
	ldr	r1, .L17+8
	mov	r0, #3
	mov	lr, pc
	bx	r4
	pop	{r4, lr}
	bx	lr
.L18:
	.align	2
.L17:
	.word	DMANow
	.word	100720640
	.word	area
	.size	drawMap, .-drawMap
	.align	2
	.global	worldToScreen
	.syntax unified
	.arm
	.fpu softvfp
	.type	worldToScreen, %function
worldToScreen:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, lr}
	ldr	lr, .L21
	add	ip, lr, #24832
	add	ip, ip, #220
	ldrh	ip, [ip, #2]
	mla	r4, r2, ip, r3
	add	r3, r4, #9024
	lsl	r3, r3, #1
	ldrh	r3, [lr, r3]
	add	r1, r1, r0, lsl #5
	lsl	r1, r1, #1
	strh	r3, [lr, r1]	@ movhi
	pop	{r4, lr}
	bx	lr
.L22:
	.align	2
.L21:
	.word	area
	.size	worldToScreen, .-worldToScreen
	.align	2
	.global	cursorReset
	.syntax unified
	.arm
	.fpu softvfp
	.type	cursorReset, %function
cursorReset:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L33
	ldr	r2, [r3, #508]
	cmp	r2, #0
	blt	.L31
	cmp	r2, #32
	ble	.L26
	ldr	r1, [r3, #520]
	cmp	r1, #31
	subgt	r1, r1, #32
	sub	r2, r2, #32
	strgt	r1, [r3, #520]
	str	r2, [r3, #508]
.L26:
	ldr	r2, [r3, #504]
	cmp	r2, #0
	blt	.L32
.L28:
	cmp	r2, #32
	bxle	lr
	ldr	r1, [r3, #512]
	cmp	r1, #31
	subgt	r1, r1, #32
	sub	r2, r2, #32
	strgt	r1, [r3, #512]
	str	r2, [r3, #504]
	bx	lr
.L31:
	ldr	r1, [r3, #524]
	cmp	r1, #31
	subgt	r1, r1, #32
	add	r2, r2, #32
	strgt	r1, [r3, #524]
	str	r2, [r3, #508]
	ldr	r1, [r3, #520]
	ldr	r2, [r3, #504]
	add	r1, r1, #32
	cmp	r2, #0
	str	r1, [r3, #520]
	bge	.L28
.L32:
	ldr	r1, [r3, #512]
	add	r2, r2, #32
	add	r1, r1, #32
	str	r2, [r3, #504]
	str	r1, [r3, #512]
	bx	lr
.L34:
	.align	2
.L33:
	.word	area+24576
	.size	cursorReset, .-cursorReset
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
	push	{r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r8, #2
	ldr	r6, .L43
	ldr	r10, [r6, #492]
	ldr	r9, [r6, #508]
	sub	r7, r6, #24576
.L39:
	sub	r10, r10, #1
	sub	r9, r9, #1
	str	r10, [r6, #492]
	str	r9, [r6, #508]
	bl	cursorReset
	ldr	r2, .L43+4
	ldr	r5, [r6, #496]
	ldr	r4, [r6, #516]
	ldrh	r0, [r2, #2]
	ldr	r2, [r6, #512]
	add	r4, r5, r4
	mul	r1, r0, r4
	sub	r5, r5, r2
	lsl	r0, r0, #1
	mul	fp, r0, r5
	mov	r3, #0
	mov	r5, fp
	ldr	r10, [r6, #492]
	ldr	r9, [r6, #508]
	add	r2, r10, #9024
	add	r2, r2, r1
	rsb	r4, r1, r1, lsl #31
	ldr	ip, [r6, #504]
	add	r2, r7, r2, lsl #1
	lsl	r4, r4, #1
	add	lr, r7, r9, lsl #1
.L38:
	cmp	ip, r3
	lsl	r1, r3, #6
	addle	r1, r2, r5
	ldrhgt	fp, [r2]
	ldrhle	fp, [r1, r4]
	lslle	r1, r3, #6
	add	r3, r3, #1
	cmp	r3, #32
	strh	fp, [lr, r1]	@ movhi
	add	r2, r2, r0
	bne	.L38
	cmp	r8, #1
	bne	.L40
	mov	r3, #1024
	ldr	r4, .L43+8
	ldr	r2, .L43+12
	ldr	r1, .L43+16
	mov	r0, #3
	mov	lr, pc
	bx	r4
	pop	{r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx	lr
.L40:
	mov	r8, #1
	b	.L39
.L44:
	.align	2
.L43:
	.word	area+24576
	.word	area+25052
	.word	DMANow
	.word	100720640
	.word	area
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
	push	{r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r9, #2
	ldr	r7, .L56
	ldr	fp, [r7, #492]
	ldr	r10, [r7, #508]
	sub	r8, r7, #24576
	add	r6, r7, #476
.L51:
	add	fp, fp, #1
	add	r10, r10, #1
	str	fp, [r7, #492]
	str	r10, [r7, #508]
	bl	cursorReset
	ldr	r10, [r7, #508]
	add	r3, r10, #30
	cmp	r3, #32
	movle	r1, r3
	subgt	r1, r10, #2
	tst	r3, #31
	ldreq	r3, [r7, #524]
	addeq	r3, r3, #32
	streq	r3, [r7, #524]
	mov	r3, #0
	ldr	r5, [r7, #496]
	ldr	r4, [r7, #516]
	ldrh	r0, [r6, #2]
	ldr	r2, [r7, #512]
	add	r4, r5, r4
	mul	ip, r0, r4
	sub	r5, r5, r2
	lsl	r0, r0, #1
	mul	r2, r0, r5
	ldr	fp, [r7, #492]
	mov	r5, r2
	add	r2, fp, #9024
	add	r2, r2, #29
	add	r2, r2, ip
	rsb	r4, ip, ip, lsl #31
	ldr	ip, [r7, #504]
	add	r1, r8, r1, lsl #1
	add	r2, r8, r2, lsl #1
	lsl	r4, r4, #1
.L50:
	cmp	ip, r3
	movle	lr, r5
	addle	lr, r2, lr
	ldrhgt	lr, [r2]
	ldrhle	lr, [lr, r4]
	add	r3, r3, #1
	cmp	r3, #32
	strh	lr, [r1, #-2]	@ movhi
	add	r2, r2, r0
	add	r1, r1, #64
	bne	.L50
	cmp	r9, #1
	bne	.L53
	mov	r3, #1024
	ldr	r4, .L56+4
	ldr	r2, .L56+8
	ldr	r1, .L56+12
	mov	r0, #3
	mov	lr, pc
	bx	r4
	pop	{r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}
	bx	lr
.L53:
	mov	r9, #1
	b	.L51
.L57:
	.align	2
.L56:
	.word	area+24576
	.word	DMANow
	.word	100720640
	.word	area
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
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	mov	r8, #2
	ldr	r6, .L67
	ldr	r10, [r6, #488]
	ldr	r9, [r6, #504]
	sub	r7, r6, #24576
	add	r5, r6, #476
.L63:
	sub	r10, r10, #1
	sub	r9, r9, #1
	str	r10, [r6, #488]
	str	r9, [r6, #504]
	bl	cursorReset
	ldr	r9, [r6, #504]
	add	r3, r9, #20
	tst	r3, #31
	ldreq	r3, [r6, #516]
	subeq	r3, r3, #32
	streq	r3, [r6, #516]
	mov	r3, #0
	ldr	lr, [r6, #524]
	ldr	r2, [r6, #500]
	ldrh	r1, [r5, #2]
	add	r2, lr, r2
	ldr	r10, [r6, #488]
	add	r0, r2, #9024
	mla	r2, r10, r1, r0
	ldr	r4, [r6, #520]
	rsb	lr, lr, lr, lsl #31
	rsb	r4, r4, r4, lsl #31
	ldr	r0, [r6, #508]
	lsl	lr, lr, #1
	add	r2, r7, r2, lsl #1
	lsl	r4, r4, #1
	add	r1, r7, r9, lsl #6
.L62:
	cmp	r0, r3
	addle	ip, lr, r2
	ldrhgt	ip, [r2]
	ldrhle	ip, [ip, r4]
	add	r3, r3, #1
	cmp	r3, #32
	strh	ip, [r1]	@ movhi
	add	r2, r2, #2
	add	r1, r1, #2
	bne	.L62
	cmp	r8, #1
	bne	.L64
	ldr	r4, .L67+4
	mov	r3, #1024
	ldr	r2, .L67+8
	ldr	r1, .L67+12
	mov	r0, #3
	mov	lr, pc
	bx	r4
	pop	{r4, r5, r6, r7, r8, r9, r10, lr}
	bx	lr
.L64:
	mov	r8, #1
	b	.L63
.L68:
	.align	2
.L67:
	.word	area+24576
	.word	DMANow
	.word	100720640
	.word	area
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
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	mov	r8, #2
	ldr	r6, .L80
	ldr	r10, [r6, #488]
	ldr	r9, [r6, #504]
	sub	r7, r6, #24576
	add	r5, r6, #476
.L75:
	add	r10, r10, #1
	add	r9, r9, #1
	str	r10, [r6, #488]
	str	r9, [r6, #504]
	bl	cursorReset
	ldr	r9, [r6, #504]
	add	r3, r9, #20
	cmp	r3, #32
	movle	r1, r3
	subgt	r1, r9, #12
	tst	r3, #31
	ldreq	r3, [r6, #516]
	addeq	r3, r3, #32
	streq	r3, [r6, #516]
	mov	r3, #0
	ldr	lr, [r6, #524]
	ldr	r2, [r6, #500]
	ldr	r10, [r6, #488]
	add	r2, lr, r2
	ldrh	ip, [r5, #2]
	add	r4, r2, #9024
	add	r0, r10, #19
	mla	r2, ip, r0, r4
	ldr	r4, [r6, #520]
	sub	r1, r1, #1
	rsb	lr, lr, lr, lsl #31
	rsb	r4, r4, r4, lsl #31
	ldr	r0, [r6, #508]
	add	r1, r7, r1, lsl #6
	lsl	lr, lr, #1
	add	r2, r7, r2, lsl #1
	lsl	r4, r4, #1
.L74:
	cmp	r0, r3
	addle	ip, lr, r2
	ldrhgt	ip, [r2]
	ldrhle	ip, [ip, r4]
	add	r3, r3, #1
	cmp	r3, #32
	strh	ip, [r1]	@ movhi
	add	r2, r2, #2
	add	r1, r1, #2
	bne	.L74
	cmp	r8, #1
	bne	.L77
	ldr	r4, .L80+4
	mov	r3, #1024
	ldr	r2, .L80+8
	ldr	r1, .L80+12
	mov	r0, #3
	mov	lr, pc
	bx	r4
	pop	{r4, r5, r6, r7, r8, r9, r10, lr}
	bx	lr
.L77:
	mov	r8, #1
	b	.L75
.L81:
	.align	2
.L80:
	.word	area+24576
	.word	DMANow
	.word	100720640
	.word	area
	.size	moveMapDown, .-moveMapDown
	.comm	palette,4,4
	.comm	CURRENT_AREA_P,4,4
	.comm	area,25104,4
	.ident	"GCC: (devkitARM release 47) 7.1.0"
