#!/bin/bash
NAME=beginsel.S
PROJNAME=AVRbeginsel
BUILDFOLDER=build-uno
mkdir -p build-uno
avr-gcc -MMD -c -D__PROG_TYPES_COMPAT__ -save-temps=obj -mmcu=atmega328p -DF_CPU=8000000L -DARDUINO=188 -DARDUINO_ARCH_AVR -Wall -std=gnu11 -fdiagnostics-color=always $NAME -o $BUILDFOLDER/$NAME.o
avr-gcc -mmcu=atmega328p -Wl,--gc-sections -Os -fuse-linker-plugin -o $BUILDFOLDER/$PROJNAME.elf $BUILDFOLDER/$NAME.o -lc -lm 
avr-objcopy -j .eeprom --set-section-flags=.eeprom='alloc,load' --no-change-warnings --change-section-lma .eeprom=0 -O ihex $BUILDFOLDER/$PROJNAME.elf $BUILDFOLDER/$PROJNAME.eep
avr-objcopy -O binary $BUILDFOLDER/$PROJNAME.elf $BUILDFOLDER/$PROJNAME.bin
avr-objcopy -O ihex -R .eeprom $BUILDFOLDER/$PROJNAME.elf $BUILDFOLDER/$PROJNAME.hex
avr-size --mcu=atmega328p -C --format=avr $BUILDFOLDER/$PROJNAME.elf

/home/bas/arduino/hardware/tools/avr/bin/avrdude -v -p atmega328p -c arduino -C /home/bas/arduino/hardware/tools/avr/etc/avrdude.conf -D -b 57600 -P /dev/ttyACM0 -U flash:w:$BUILDFOLDER/$PROJNAME.hex:i
