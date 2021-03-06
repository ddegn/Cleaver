CON
{{
  Modified by Duane Degn

  The software is a modified version of Jon McPalen's "jm_mcp3208_ez.spin" object.
  The modifications are intended to make it easier to use part of the "Eddie"
  robot's firmware.

  The Eddie control board uses a MCP3008 analog to digital converter chip. This is an
  8 channel 10-bit device. The values returned have been scaled to 12-bits. The least
  significant 2-bits do not contain useful data. 

  These modifications were made as part of Parallax's Open Propeller Project #8.
  For more information about this project see the following thread on the Parallax forums:

  http://forums.parallax.com/showthread.php/158030

  Some of the changes I made include changing the name of the "start" method to "init"
  to comply with the convention of only using "start" with methods which start a new
  cog. 

  I changed most instances of comments with "MCP3208" to "MCP3008".

  Methods which were not called by the Eddie firmware have been deleted. These include
  the methods "stop", "readx", "scale" and "map".

  The formatting was changed to more closely agree with the Parallax Gold Standard
  formatting conventions.

  
  Header to the original object below.
}}
'' ==========================================================================================
''
''   File....... jm_mcp3208_ez.spin
''   Purpose.... 3-wire Spin interface for MCP3208, 8 channel, 12-bit ADC
''   Author..... Jon "JonnyMac" McPhalen
''               Copyright (c) 2010-13 Jon McPhalen
''               -- see below for terms of use
''   E-mail..... jon@jonmcphalen.com
''   Started.... 03 JUL 2010
''   Updated.... 16 DEC 2013
''
'' ==========================================================================================

{{ 
                               3v3-5v0
                   MCP3208        
             ┌─────────────────┐  │
    ch0 ────┤1  CH0     VDD 16├──┫                
    ch1 ────┤2  CH1    VREF 15├──┘           
    ch2 ────┤3  CH2    AGND 14├──┐ 
    ch3 ────┤4  CH3     CLK 13├──│──────── clk
    ch4 ────┤5  CH4    DOUT 12├──│──┐ 3k3 
    ch5 ────┤6  CH5     DIN 11├──│────┻── dio
    ch6 ────┤7  CH6     /CS 10├──│──────── cs               
    ch7 ────┤8  CH7    DGND  9├──┫
             └─────────────────┘  │
                                  
}} 
VAR

  long  cs                                              ' chip select
  long  clk                                             ' clock input
  long  dio                                             ' data io

PUB Init(cspin, clkpin, diopin)

'' Get pin assignments and set /CS and CLK pins to outputs
'' -- /CS initialized high to disable MCP3008

  cs := cspin
  outa[cs] := 1                                         ' output high
  dira[cs] := 1

  clk := clkpin
  outa[clk] := 0                                        ' output low
  dira[clk] := 1

  dio := diopin

PUB Read(ch) 

'' Read MCP3008 channel
'' -- ch is channel, 0 to 7
'' -- only single-ended reads are supported

  ch := %1_1000 | (ch & %111)                           ' create mux bits
  result := readx(ch) 
 
PRI Readx(mux) | level

'' Read MCP3008 channel
'' -- mux is encoded mux bits for channel/mode

  outa[cs] := 0                                         ' activate adc
  dira[dio] := 1                                        ' dio is output

  ' output mux bits, MSBFIRST
  
  mux <<= constant(32-5)                                ' prep for msb output
  repeat 5                                              ' send mux bits
    outa[dio] := (mux <-= 1) & 1                        ' output a bit
    outa[clk] := 1                                      ' clock the bit
    outa[clk] := 0

  ' input data bits, MSBPOST
  
  dira[dio] := 0                                        ' dio is input
  level := 0                                            ' clear work var  
  repeat 13                                             ' null + 12 data bits
    outa[clk] := 1                                      ' clock a bit
    outa[clk] := 0
    level := (level << 1) | ina[dio]                    ' input data bit

  outa[cs] := 1                                         ' de-activate adc
  
  return (level & $FFF)

DAT

{{

  Terms of Use: MIT License

  Permission is hereby granted, free of charge, to any person obtaining a copy of this
  software and associated documentation files (the "Software"), to deal in the Software
  without restriction, including without limitation the rights to use, copy, modify,
  merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
  permit persons to whom the Software is furnished to do so, subject to the following
  conditions:

  The above copyright notice and this permission notice shall be included in all copies
  or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
  PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 

}}                     