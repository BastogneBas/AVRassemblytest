#!/bin/bash
NAME=beginsel.S
PROJNAME=AVRbeginsel
mkdir -p build-mega-atmega2560
avr-gcc -MMD -c -D__PROG_TYPES_COMPAT__ -save-temps=obj -mmcu=atmega2560 -DF_CPU=16000000L -DARDUINO=187 -DARDUINO_ARCH_AVR -Wall -std=gnu11 -fdiagnostics-color=always $NAME -o build-mega-atmega2560/$NAME.o
avr-gcc -mmcu=atmega2560 -Wl,--gc-sections -Os -fuse-linker-plugin -o build-mega-atmega2560/$PROJNAME.elf build-mega-atmega2560/$NAME.o -lc -lm 
avr-objcopy -j .eeprom --set-section-flags=.eeprom='alloc,load' --no-change-warnings --change-section-lma .eeprom=0 -O ihex build-mega-atmega2560/$PROJNAME.elf build-mega-atmega2560/$PROJNAME.eep
avr-objcopy -O binary build-mega-atmega2560/$PROJNAME.elf build-mega-atmega2560/$PROJNAME.bin
avr-objcopy -O ihex -R .eeprom build-mega-atmega2560/$PROJNAME.elf build-mega-atmega2560/$PROJNAME.hex
avr-size --mcu=atmega2560 -C --format=avr build-mega-atmega2560/$PROJNAME.elf
