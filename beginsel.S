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
.global	main
	.type	main, @function
main:
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
	ldi	r16, 	0b01111111
	ldi	r17, 	0x0F
	out	DDRB,	r16
	out PORTB,	r17
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
/*.L__stack_usage = 2
	ldi r24,lo8(42)
	ldi r25,0
	movw r30,r24
	st Z,__zero_reg__
	ldi r24,0
	ldi r25,0 */
/* epilogue start */
/*	pop r29
	pop r28 */
end:sleep
	ret
TIM0_OVF:
	in	r16,	PORTB
	swap r16
	out	PORTB,	r16
	reti
	.size	main, .-main
	.ident	"GCC: (GNU) 8.2.0"
