'' =================================================================================================
''
''   File....... jm_nunchuk_ez_v3.spin
''   Purpose.... Manual Wii Nunchuk interface (universal)  
''   Author..... Jon "JonnyMac" McPhalen 
''               Copyright (c) 2011 Jon McPhalen
''               -- see below for terms of use
''   E-mail..... jon@jonmcphalen.term
''   Started.... 
''   Updated.... 06 MAR 2011
''
'' =================================================================================================

{{

   Wii Nunchuk connector (looking into it):

   ┌──┐     ┌──┐  
   │  └─────┘  │  
   │   C x G   │  
   │           │  
   │   V x D   │  
   └───────────┘  

   • V........ 3.3v                                                         
   • G........ Ground                                                       
   • D........ SDA (requires pull-up to Vdd; can be shared with boot EEPROM)
   • C........ SCL (requires pull-up to Vdd; can be shared with boot EEPROM)


   Wii Nunchuk wiring (if connector removed):

   • Red...... 3.3v
   • White.... Ground
   • Green.... SDA (requires pull-up to Vdd; can be shared with boot EEPROM)
   • Yellow... SCL (requires pull-up to Vdd; can be shared with boot EEPROM)  

   Note: Some Propeller boards do not include a pull-up on the SCL line;
         -- jm_i2c_basic (used by this object) requires the SCL pull-up.


   Protocol Reference:

   • http://wiibrew.org/wiki/Wiimote        

}}


con

  WII_WR = $A4                                                  ' write address
  WII_RD = $A5                                                  ' read address
 

obj

  i2c  : "jm_i2c_basic"                                         ' low-level I2C routines


var

  byte  device                                                  ' device type
  byte  id[6]
  byte  raw[6]


pub init(sclpin, sdapin)

'' Initializes I2C buss and activates Wii nunchuk
'' -- type allows for Nintendo or non-Nintendo controllers

  i2c.init(sclpin, sdapin)                                      ' setup i2c buss
                                                      
  i2c.start                                                     ' start with new protocol                                             
  i2c.write(WII_WR)
  i2c.write($F0)
  i2c.write($55)  
  i2c.stop
  i2c.start 
  i2c.write(WII_WR)
  i2c.write($FB)
  i2c.write($00)  
  i2c.stop

  waitcnt(clkfreq / 100 + cnt)                                  ' wait 10ms
  bytefill(@id, $00, 6)                                         ' do not remove
  readid                                                        ' okay to remove


pri readid | idx

'' Reads ID from controller

  i2c.start                                                     ' point to ID                                                     
  i2c.write(WII_WR)
  i2c.write($FA) 
  i2c.stop

  waitcnt(clkfreq / 2_000 + cnt)                                ' 0.5ms delay  

  i2c.start                                                     ' read it
  i2c.write(WII_RD)                                               
  repeat idx from 0 to 4
    id[idx] := i2c.read(i2c#ACK)                                
  id[5] := i2c.read(i2c#NAK)                                    
  i2c.stop


pub idpntr   

'' Returns address of controller id

  return @id
    

pub scan | idx

'' Scans Wii nunchuk
'' -- bytes are read and decoded

  repeat 3                                                      ' allow wireless to sync
    waitcnt(clkfreq / 2_000 + cnt)                              ' 0.5ms delay
    i2c.start                                                   ' start conversion                                                     
    i2c.write(WII_WR)
    i2c.write($00) 
    i2c.stop
   
  waitcnt(clkfreq / 2_000 + cnt)                                ' 0.5ms delay
  i2c.start                                                     ' read channels
  i2c.write(WII_RD)                                               
  repeat idx from 0 to 4                                        ' read raw values 
    raw[idx] := i2c.read(i2c#ACK)                                
  raw[5] := i2c.read(i2c#NAK)                                    
  i2c.stop
                                                                 

pub joyx

'' Returns X joystick value, 0..255

  return raw[0]


pub joyy

'' Returns Y joystick value, 0..255 

  return raw[1]


pub accx

'' Returns X accelerometer value, 0..1023 

  return (raw[2] << 2) | ((raw[5] >> 2) & %11) 


pub accy

'' Returns Y accelerometer value, 0..1023

  return (raw[3] << 2) | ((raw[5] >> 4) & %11)


pub accz

'' Returns Z accelerometer value, 0..1023

  return (raw[4] << 2) | ((raw[5] >> 6) & %11)


pub btnz

'' Returns state of Z button
'' -- 1 = pressed
'' -- 0 = not pressed

  return (!raw[5] & %10) >> 1


pub btnc

'' Returns state of C button
'' -- 1 = pressed
'' -- 0 = not pressed

  return !raw[5] & %01


pub buttons

'' Returns state of buttons as 2-bit value: ZC
'' -- 1 = pressed
'' -- 0 = not pressed

  return !raw[5] & %11
 
                      
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