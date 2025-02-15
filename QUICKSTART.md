CircuitPython Environment Setup
=====
[It is highly recommended to read this document by Adafruit all the way through](https://learn.adafruit.com/debugging-the-samd21-with-gdb?view=all), along with this QUICKSTART guide.

This has been verified on OSX (latest), and Metro M0 Express.

Other guides that may help: [CircuitPython: Creating and Editing Code](https://learn.adafruit.com/welcome-to-circuitpython/creating-and-editing-code)

### Build firmware

Take care of dependencies first. [See here](https://learn.adafruit.com/building-circuitpython?view=all)

This takes a while the first time but `Makefile` should be good for minor (single file) changes afterwards.

Building the firmware is tested with gcc version 9.3.1 20200408 (release).

```
git clone https://github.com/adafruit/circuitpython.git
cd circuitpython
git submodule sync
git submodule update --init --recursive
cd ports/atmel-samd
make BOARD=metro_m0_express DEBUG=1

```

### Debug

Now get the JLink debugger, and the adapter, connect to Metro M0 Express, also connect power (via Jack or via USB). [See this Adafruit doc as a reference](https://learn.adafruit.com/debugging-the-samd21-with-gdb?view=all)

Use this to start the debugger over JLink.

```
JLinkGDBServer -if SWD -device ATSAMD21G18
``` 

Open up a new shell tab (zsh) within the same directory and start GDB:

```
arm-none-eabi-gdb-py build-metro_m0_express/firmware.elf
```

In the GDB prompt set stuff up

```
(gdb) file build-metro_m0_express/firmware.elf
...
(gdb) target extended-remote :2331
...
(gdb) load
...
(gdb) break main
...
(gdb) c
Breakpoint 1, main () at ../../main.c:392
392	    safe_mode_t safe_mode = port_init();
(gdb)
```

You may want to reset the target twice if you get a SIGTRAP at this point (see below)

```
Program received signal SIGTRAP, Trace/breakpoint trap.
0x0000205c in exception_table ()
(gdb) monitor reset
Resetting target
(gdb) monitor reset
Resetting target
(gdb) c
Continuing.

Breakpoint 1, main () at ../../main.c:392
392	    safe_mode_t safe_mode = port_init();
(gdb) c
```

Now you have to load a python file on the device for anything to actually happen, otherwise it busy waits until new python file is detected. Try this code below (name it code.py on CIRCUITPY drive), which will blink the LED. To see that code is changing / updating, just change the 0.5s to 0.1s.

```
# Simple blink app
import board
import digitalio
import time
 
led = digitalio.DigitalInOut(board.D13)
led.direction = digitalio.Direction.OUTPUT
 
while True:
    led.value = True
    time.sleep(0.5) # Change these to see updates
    led.value = False
    time.sleep(0.5) # Change these to see updates
```
You can Ctrl+C things and step through execution, if things get out of wack, or you are seeing a SIGTRAP, just reset the board via gdb by typing `monitor reset` and if things are real crazy, `load` the firmware again.

### Workflow 

To reload a program, dont restart everything, you should be able to keep JLink and GDB going all-day. I think the best way is to get things setup, and when you make changes to the firmware with `make BOARD=metro_m0_express DEBUG=1` then just reload and reset the target:

```
(gdb) load
(gdb) monitor reset
...set breakboints here...
(gdb) continue
```

You wont have to set breakpoints if you set them based on symbols / function names.