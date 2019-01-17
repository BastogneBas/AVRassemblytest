# 1 "beginsel.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "beginsel.S"
 .file "clock.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__RAMPZ__ = 0x3b
__tmp_reg__ = 0
__zero_reg__ = 1
DDRB = 0x04
PORTB = 0x05
TCCR0A = 0x24
TCCR0B = 0x25
TIMSK0 = 0x6E
 .text
.global main
 .type main, @function
main:
 push r28
 push r29
 in r28,__SP_L__
 in r29,__SP_H__

 ldi r16, 0b01111111
 ldi r17, 0x0F
 out DDRB, r16
 out PORTB, r17
 nop

 ldi r16, 0b00000000
 ldi r17, 0b00000101
 ldi r18, 0b00000001
 out TCCR0A, r16
 out TCCR0B, r17
 ldi r30, lo8(TIMSK0)
 ldi r31, 0
 st Z, r18
 sei
 .size main, .-main

end:sleep
 ret


.global __vector_23
 .type __vector_23, @function
__vector_23:
 in r16, PORTB
 swap r16
 out PORTB, r16
 reti
 .size __vector_23, .-__vector_23
 .ident "GCC: (GNU) 8.2.0"
