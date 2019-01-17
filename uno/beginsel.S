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

.global __vector_16
	.type __vector_16, @function
__vector_16:
	in	r0,	PORTB
	swap r0
	out	PORTB,	r0
	reti
	.size	__vector_16, .-__vector_16


.global	main
	.type	main, @function
main:
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__

	ldi	r0, 	0b01111111
	ldi	r1, 	0x0F
	out	DDRB,	r0
	out PORTB,	r1
	nop
	
	ldi	r0,	0b00000000
	ldi	r1,	0b00000101
	ldi r2,	0b00000001
	out	TCCR0A,	r0
	out TCCR0B, r1
	ldi	r30,	lo8(TIMSK0)
	ldi r31,	0
	st	Z,		r2
	sei

.end:
	rjmp .end
	ret
	.size	main, .-main


	.ident	"GCC: (GNU) 8.2.0"
