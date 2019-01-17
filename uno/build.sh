#!/bin/bash
NAME=beginsel.S
PROJNAME=AVRbeginsel
mkdir -p build-uno
avr-gcc -MMD -c -D__PROG_TYPES_COMPAT__ -save-temps=obj -mmcu=atmega328p -DF_CPU=8000000L -DARDUINO=188 -DARDUINO_ARCH_AVR -Wall -std=gnu11 -fdiagnostics-color=always $NAME -o build-uno/$NAME.o
avr-gcc -mmcu=atmega328p -Wl,--gc-sections -Os -fuse-linker-plugin -o build-uno/$PROJNAME.elf build-uno/$NAME.o -lc -lm 
avr-objcopy -j .eeprom --set-section-flags=.eeprom='alloc,load' --no-change-warnings --change-section-lma .eeprom=0 -O ihex build-uno/$PROJNAME.elf build-uno/$PROJNAME.eep
avr-objcopy -O binary build-uno/$PROJNAME.elf build-uno/$PROJNAME.bin
avr-objcopy -O ihex -R .eeprom build-uno/$PROJNAME.elf build-uno/$PROJNAME.hex
avr-size --mcu=atmega328p -C --format=avr build-uno/$PROJNAME.elf
