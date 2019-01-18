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
/*	load value from ram, add 1 to it and store it again	*/
	lds	r16,	0x0100
	ldi	r17,	0x01
	add	r16,	r17
	sts	0x0100,	r16

/*	Check if equal to 10, if not, go to v16end	*/
	cpi	r16,	10
	brne v16end

/*	Store 0 to the value in the SRAM	*/
	ldi	r17,	0x00
	sts	0x0100,	r17
	
/*	swap nibbles in PORTB	*/
	in	r17,	PORTB
	swap r17
	out	PORTB,	r17
v16end:
	reti
	.size	__vector_16, .-__vector_16

/*	main	*/
.global	main
	.type	main, @function
main:
/*	Some Stackpointerthings	*/
/*	TODO: check if this can be removed	*/
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__

/*	load and store values in PORTB and DDRB	*/
	ldi	r16, 	0b01111111			/*	Load 0b01111111 to r16		*/
	ldi	r17, 	0x0F				/*	Load 0b00001111 to r17		*/
	out	DDRB,	r16					/*	Put r16 in DDRB				*/
	out PORTB,	r17					/*	Put r17 in PORTB			*/

/*	Set the variable at 0x0100 to 0	*/
	ldi	r16,	0x00				/*	Load 0b00000000 to r16		*/
	sts	0x0100,	r16					/*	Store it in 0x0100 (SRAM)	*/
	nop
	
/*	Setup timer0 to:
 *	No Compare Match Outputs
 *	And Mode of Operation to normal */
	ldi	r16,	0b00000000			/*	Load timersettings 			*/
	ldi	r17,	0b00000101
	ldi r18,	0b00000001
	out	TCCR0A,	r16					/*	Put those in their destination 	*/
	out TCCR0B, r17
	ldi	r30,	lo8(TIMSK0)			/*	TIMSK0 is in the extended IO part */
	ldi r31,	0					/*	So its address should be loaded in register Z */
	st	Z,		r18					/*	And then it can be stored with st */
/*	And of course, enable the interrupts	*/
	sei

.end:
	rjmp .end
	ret
	.size	main, .-main


	.ident	"GCC: (GNU) 8.2.0"
