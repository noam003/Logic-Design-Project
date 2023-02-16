
# Logic Design Project

#### A digital clock that has a stop watch, timer, and uses a computer monitor to display your clock. We will provide the code for connecting the FPGA to the monitor via the VGA port. The user has the flexibility on how they want to display the digital clock on the monitor. ####
**Contents:**\
[Design Specifications](#design-specifications "Goto design-specifications")\
[24 Hour Clock Specifications](#24-hour-clock-specifications "24-hour-clock-specifications")\
[Stopwatch and Timer](#stopwatch-and-timer "Goto stopwatch-and-timer")\
[Authors](#Authors "Goto authors")

## Design Specifications
- internal clock → faster since we’re incrementing/decrementing the milliseconds bit
- reset → active high for all modes
- to select between these modes, we use two buttons to act as each bit of the select line (since 4:1 mux needs a 2 bit select line)
- use the high/low combination of each to represent each mode
- switch → high = start, low = stop
- finally, output: 27 bits, stores 4 internal registers (hr, min, sec, ms)
- each is of the correct bit size to account for the respective max value



## 24 Hour Clock Specifications

Our clock works through a series of increments. First here you can see the design choice we will be implementing through our FPGA 7 segment LED display, where we use 2 colons and one period to show the time. This clock increments as the khz clock increments. Everything starts at zero. The ms increments by 1 for every posedge khz. For every ms = 999, the ss increments. Once ss reaches 59, mm follows that pattern. When all our values reach their max, the clock resets. The only difference between the 12 hr and 24 hr is the hr total.  

## Stopwatch and Timer

Stopwatch:
- at the posedge of the clk (kHz)
- increment ms
- then, before ms reg hits max (1000), increment seconds and reset ms / all less significant bits
- reset

Timer:
The timer has a similar functionality as does the stopwatch. 
The few differences, is that it starts at a set time and counts down to 0 when it stops. 
Similar to the stopwatch it decrements the ms at every posedge of the clock. 
After each decrement we check if the ms reached zero, then we decrement the second and reset the ms to 1000. 
Same thing with the second and minutes, and minutes and hours. 

## Authors

- [@noam003](https://www.github.com/noam003) [noam@bu.edu]
- [@suhanimitra](https://github.com/suhanimitra) [suhanim@bu.edu]
- [@lraiff](https://github.com/lraiff) [lraiff@bu.edu]
- [@ktscott](https://github.com/ktscott) [ktscott@bu.edu]
