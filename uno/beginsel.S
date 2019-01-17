	.file	"clock.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__RAMPZ__ = 0x3b
__tmp_reg__ = 0
__zero_reg__ = 1
DDRB  = 0x04
PORTB = 0x05
TCCR0A = 0x24
TCCR0B = 0x25
TIMSK0 = 0x6E
	.text

/*	Timer0 overflow vector	*/
.global __vector_16
	.type __vector_16, @function
__vector_16:
/*	swap nibbles in PORTB	*/
	in	r0,	PORTB
	swap r0
	out	PORTB,	r0
	reti
	.size	__vector_16, .-__vector_16

/*	main	*/
.global	main
	.type	main, @function
main:
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__

/*	load and store values in PORTB and DDRB	*/
	ldi	r16, 	0b01111111
	ldi	r17, 	0x0F
	out	DDRB,	r16
	out PORTB,	r17
	
	ldi	r16,	0x00
	sts	0x0100,	r16
	nop
	
	ldi	r16,	0b00000000
	ldi	r17,	0b00000101
	ldi r18,	0b00000001
	out	TCCR0A,	r16
	out TCCR0B, r17
	ldi	r30,	lo8(TIMSK0)
	ldi r31,	0
	st	Z,		r18
	sei

.end:
	rjmp .end
	ret
	.size	main, .-main


	.ident	"GCC: (GNU) 8.2.0"
