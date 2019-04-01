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
	.file	"myLib.c"
	.text
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
	@ link register save eliminated.
	mov	r1, #83886080
	ldr	r3, .L3
	ldr	r2, .L3+4
	ldr	r3, [r3]
	str	r0, [r3, #36]
	str	r1, [r3, #40]
	str	r2, [r3, #44]
	bx	lr
.L4:
	.align	2
.L3:
	.word	.LANCHOR0
	.word	-2147483392
	.size	loadPalette, .-loadPalette
	.align	2
	.global	DMANow
	.syntax unified
	.arm
	.fpu softvfp
	.type	DMANow, %function
DMANow:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	ip, .L7
	str	lr, [sp, #-4]!
	add	r0, r0, r0, lsl #1
	ldr	lr, [ip]
	lsl	r0, r0, #2
	add	ip, lr, r0
	orr	r3, r3, #-2147483648
	str	r1, [lr, r0]
	str	r2, [ip, #4]
	ldr	lr, [sp], #4
	str	r3, [ip, #8]
	bx	lr
.L8:
	.align	2
.L7:
	.word	.LANCHOR0
	.size	DMANow, .-DMANow
	.align	2
	.global	waitForVblank
	.syntax unified
	.arm
	.fpu softvfp
	.type	waitForVblank, %function
waitForVblank:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r2, #67108864
.L10:
	ldrh	r3, [r2, #6]
	cmp	r3, #160
	bhi	.L10
	mov	r2, #67108864
.L11:
	ldrh	r3, [r2, #6]
	cmp	r3, #159
	bls	.L11
	bx	lr
	.size	waitForVblank, .-waitForVblank
	.align	2
	.global	flipPage
	.syntax unified
	.arm
	.fpu softvfp
	.type	flipPage, %function
flipPage:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r2, #67108864
	ldrh	r3, [r2]
	ldr	r1, .L18
	tst	r3, #16
	ldrne	r0, [r1, #8]
	ldreq	r0, [r1, #12]
	bicne	r3, r3, #16
	orreq	r3, r3, #16
	strh	r3, [r2]	@ movhi
	str	r0, [r1, #4]
	bx	lr
.L19:
	.align	2
.L18:
	.word	.LANCHOR0
	.size	flipPage, .-flipPage
	.align	2
	.global	fillScreen
	.syntax unified
	.arm
	.fpu softvfp
	.type	fillScreen, %function
fillScreen:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #8
	ldr	r1, .L22
	add	r2, sp, #8
	strh	r0, [r2, #-2]!	@ movhi
	ldr	r3, [r1]
	ldr	r0, [r1, #4]
	ldr	r1, .L22+4
	str	r2, [r3, #36]
	str	r0, [r3, #40]
	str	r1, [r3, #44]
	add	sp, sp, #8
	@ sp needed
	bx	lr
.L23:
	.align	2
.L22:
	.word	.LANCHOR0
	.word	-2130668032
	.size	fillScreen, .-fillScreen
	.align	2
	.global	setPixel
	.syntax unified
	.arm
	.fpu softvfp
	.type	setPixel, %function
setPixel:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L25
	rsb	r0, r0, r0, lsl #4
	add	r1, r1, r0, lsl #4
	ldr	r3, [r3, #4]
	lsl	r1, r1, #1
	strh	r2, [r3, r1]	@ movhi
	bx	lr
.L26:
	.align	2
.L25:
	.word	.LANCHOR0
	.size	setPixel, .-setPixel
	.align	2
	.global	drawBackgroundImage3
	.syntax unified
	.arm
	.fpu softvfp
	.type	drawBackgroundImage3, %function
drawBackgroundImage3:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r2, .L28
	ldr	r1, .L28+4
	ldr	r3, [r2]
	ldr	r2, [r2, #4]
	str	r0, [r3, #36]
	str	r2, [r3, #40]
	str	r1, [r3, #44]
	bx	lr
.L29:
	.align	2
.L28:
	.word	.LANCHOR0
	.word	-2147445248
	.size	drawBackgroundImage3, .-drawBackgroundImage3
	.global	dma
	.global	backBuffer
	.global	frontBuffer
	.global	videoBuffer
	.data
	.align	2
	.set	.LANCHOR0,. + 0
	.type	dma, %object
	.size	dma, 4
dma:
	.word	67109040
	.type	videoBuffer, %object
	.size	videoBuffer, 4
videoBuffer:
	.word	100663296
	.type	backBuffer, %object
	.size	backBuffer, 4
backBuffer:
	.word	100704256
	.type	frontBuffer, %object
	.size	frontBuffer, 4
frontBuffer:
	.word	100663296
	.ident	"GCC: (devkitARM release 47) 7.1.0"
