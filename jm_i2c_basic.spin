'' =================================================================================================
''
''   File....... jm_i2c_basic.spin
''   Purpose.... Minimal I2C driver
''   Author..... Jon "JonnyMac" McPhalen (aka Jon Williams)
''               Copyright (c) 2009-2011 Jon McPhalen
''               -- see below for terms of use
''   E-mail..... jon@jonmcphalen.com
''   Started.... 28 JUL 2009
''   Updated.... 04 SEP 2011
''
'' =================================================================================================

{{

   Low level I2C routines.
 
   Assumes that SCL and SDA are fixed in a given application and can be set on
   initialization of the object.  Code does not drive SCL or SDA pins high; pull-ups
   are required on both pins.
  
}}   


con

   #0, ACK, NAK

  #28, BOOT_SCL, BOOT_SDA                                       ' Propeller I2C pins



var

  long  scl
  long  sda
      

pub init(sclpin, sdapin) | okay

'' Define I2C SCL (clock) and SDA (data) pins

  longmove(@scl, @sclpin, 2)                                    '  copy pins
  dira[scl] := 0                                                '  float to pull-up
  outa[scl] := 0                                                '  write 0 to output reg
  dira[sda] := 0
  outa[sda] := 0

  {
  repeat 9                                                      ' reset buss
    dira[scl] := 1
    dira[scl] := 0
    if (ina[sda])
      quit
  }

pub terminate

'' Clear I2C pins 

  dira[scl] := 0
  dira[sda] := 0
  

pub wait(id) | ackbit

'' Waits for I2C device to be ready for new command

  repeat
    start
    ackbit := write(id & $FE)
  until ackbit == ACK


pub start

'' Create I2C start sequence
'' -- will wait if I2C buss SCL pin is held low

  dira[sda] := 0                                                ' float SDA (1)
  dira[scl] := 0                                                ' float SCL (1)
  repeat while (ina[scl] == 0)                                  ' allow "clock stretching"

  outa[sda] := 0
  dira[sda] := 1                                                ' SDA low (0)

  
pub write(i2cbyte) | ackbit

'' Write byte to I2C buss

  outa[scl] := 0
  dira[scl] := 1                                                ' SCL low

  i2cbyte <<= constant(32-8)                                    ' move msb (bit7) to bit31
  repeat 8                                                      ' output eight bits
    dira[sda] := ((i2cbyte <-= 1) ^ 1)                          ' send msb first
    dira[scl] := 0                                              ' SCL   (float to p/u) 
    dira[scl] := 1                                              ' SCL   

  dira[sda] := 0                                                ' relase SDA to read ack bit
  dira[scl] := 0                                                ' SCL   (float to p/u)  
  ackbit := ina[sda]                                            ' read ack bit
  dira[scl] := 1                                                ' SCL    

  return (ackbit & 1)


pub read(ackbit) | i2cbyte

'' Read byte from I2C buss

  outa[scl] := 0                                                ' prep to write low
  dira[sda] := 0                                                ' make input for read

  repeat 8
    dira[scl] := 0                                              ' SCL   (float to p/u)
    i2cbyte := (i2cbyte << 1) | ina[sda]                        ' read the bit
    dira[scl] := 1                                              ' SCL   
                             
  dira[sda] := !ackbit                                          ' output ack bit 
  dira[scl] := 0                                                ' SCL   (float to p/u)
  dira[scl] := 1                                                ' SCL    

  return (i2cbyte & $FF)


pub stop

'' Create I2C stop sequence 

  outa[sda] := 0
  dira[sda] := 1                                                ' SDA low
  
  dira[scl] := 0                                                ' float SCL
  repeat while (ina[scl] == 0)                                  ' hold for clock stretch
  
  dira[sda] := 0                                                ' float SDA


pri scl_high
 
  dira[scl] := 0


pri scl_low

  outa[scl] := 0 
  dira[scl] := 1


pri sda_high
 
  dira[sda] := 0


pri sda_low

  outa[sda] := 0 
  dira[sda] := 1 


dat

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