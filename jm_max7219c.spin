'' =================================================================================================
''
''   File....... jm_max7219.spin
''   Purpose.... MAX7219/MAX7221 serial LED driver
''   Author..... Jon "JonnyMac" McPhalen
''               Copyright (c) 2013-14 Jon McPhalen
''               -- see below for terms of use
''   E-mail..... jon@jonmcphalen.com
''   Started.... 
''   Updated.... 11 OCT 2014
''
'' =================================================================================================


con { fixed io pins }

  RX1 = 31                                                      ' programming / terminal
  TX1 = 30
  
  SDA = 29                                                      ' eeprom / i2c
  SCL = 28


con { max7219 registers }

  NO_OP     = $00
  
  DIG_0     = $01
  DIG_1     = $02
  DIG_2     = $03
  DIG_3     = $04
  DIG_4     = $05
  DIG_5     = $06
  DIG_6     = $07
  DIG_7     = $08

  DECODE    = $09
  BRIGHT    = $0A
  SCAN      = $0B
  SHUTDN    = $0C

  DISP_TEST = $0F

  NO_DECIMAL_POINT = DIG_7 + 1
  
con { segments / character maps }


  BLANK    = %00000000

  SEG_DP   = %10000000
  SEG_A    = %01000000
  SEG_B    = %00100000
  SEG_C    = %00010000
  SEG_D    = %00001000
  SEG_E    = %00000100
  SEG_F    = %00000010
  SEG_G    = %00000001

  DASH     = %00000001

  
'            ─── a ───
'           │         │
'           f         b
'           │         │
'            ─── g ───     
'           │         │
'           e         c
'           │         │
'        DP  ─── d ───    

            '  .abcdefg
  _A        = %01110111
  _b        = %00011111 { lowercase } 
  _C        = %01001110
  _c2       = %00001101 { lc }
  _d        = %00111101 { lc }
  _E        = %01001111 
  _F        = %01000111
  _G        = %01011111 { 6 }
  _H        = %00110111
  _I        = %00110000 { 1 }
  _J        = %00111100
  _L        = %00001110
  _l2       = %00110000 { lc }
  _n        = %00010101 { lc } 
  _O        = %01111110 { 0 }
  _o2       = %00011101 { lc }
  _P        = %01100111
  _Q        = %01110011 { 9 }  
  _r        = %00000101 { lc }
  _S        = %01011011 { 5 }
  _t        = %00001111 { lc }
  _U        = %00111110
  _u2       = %00011100 { lc }
  _Y        = %00111011

            '  .abcdefg
  _0        = %01111110
  _1        = %00110000
  _2        = %01101101
  _3        = %01111001
  _4        = %00110011
  _5        = %01011011
  _6        = %01011111
  _7        = %01110000
  _8        = %01111111
  _9        = %01110011  


con

  DIGITS_PER_DISPLAY = 8
  MAX_DIGIT_INDEX = DIGITS_PER_DISPLAY - 1
  MAX_ALLOWED_DISPLAYS = 2

  LARGEST_DIVISOR = 10_000_000
  SMALL_DIVISOR = 1_000
  MIN_DISPLAYABLE = -9_999_999
  MAX_DISPLAYABLE = 99_999_999
  MIN_DISPLAYABLE_SMALL = -999
  MAX_DISPLAYABLE_SMALL = 9_999

  #0, NO_PAD, SPACE_PAD, ZERO_PAD
  PADDED = SPACE_PAD | ZERO_PAD
  
var

  long  started                                                 ' true when pins are setup

  long  cs                                                      ' to MAX7219.12 
  long  mosi                                                    ' to MAX7219.1
  long  sck                                                     ' to MAX7219.13

  byte  decodebits                                              ' state of decode bits
  
  byte  segments[8]                                             ' internal segments register buffer
  
var

  byte displaysInUse
  byte brightness
  
pub init(cspin, dpin, cpin, numberOfDisplays, brightness_) | reg

'' Assign and configures pins for MAX7219/21

  stop
  displaysInUse := numberOfDisplays
  brightness := brightness_
  
  longmove(@cs, @cspin, 3)

  outa[cs] := 1                                                 ' preset output/high (deselect MAX7221)
  dira[cs] := 1
  
  dira[mosi] := 1                                               ' data pin is output

  outa[sck] := 0                                                ' preset clock to output/low
  dira[sck] := 1

  repeat displaysInUse
    out(SHUTDN, 0)                    
  
  repeat displaysInUse
    repeat reg from DIG_0 to DIG_7                                ' clear segment/digit registers
      out(reg, $00)
  
  reset
  
  started := true


pub reset
                  
  repeat displaysInUse
    out(DISP_TEST, 0)                    
  repeat displaysInUse
    out(SCAN,   7)                                      ' use all digits
  repeat displaysInUse
    out(BRIGHT, brightness)                                      ' set display brightness
  repeat displaysInUse
    out(DECODE, 0)                                      ' all digits = raw segments
  repeat displaysInUse
    out(SHUTDN, 1)                                      ' normal operation
  
pub stop

'' Releases MAX7219 pins if previously assigned

  if (started)
    dira[mosi] := 0
    dira[sck] := 0
    dira[cs] := 0
    started := false


pub out(reg, value) | bits

'' Update register in MAX7219 with value

  bits.byte[3] := reg                                           ' set register
  bits.byte[2] := value                                         ' set value

  if (reg == DECODE)                                            ' save decode register bits      
    decodebits := value.byte[0]

  outa[cs] := 0                                                 ' enable                          

  repeat 16                                                     ' shift out reg & value (MSBFIRST)
    outa[mosi] := (bits <-= 1)
    outa[sck] := 1
    outa[sck] := 0

  outa[cs] := 1                                                 ' load into MAX7219/21


pub dec(displayId, value) | divisor, register

  value := MIN_DISPLAYABLE #> value <# MAX_DISPLAYABLE

  divisor := LARGEST_DIVISOR
  
  register := DIG_7 
  if value < 0
    outTo(displayId, register--, DASH)
    -value
    divisor /= 10

  repeat
    outTo(displayId, register--, HexDigits[value / divisor])
    value //= divisor
    divisor /= 10
  while register => DIG_0

pub decSmall(displayId, value, decimalPoint) | divisor, register, end, array

  value := MIN_DISPLAYABLE_SMALL #> value <# MAX_DISPLAYABLE_SMALL
  
  divisor := SMALL_DIVISOR
  array := displayId / 2
  if displayId // 2
    register := DIG_3
    end := DIG_0
  else
    register := DIG_7
    end := DIG_4

  decimalPoint += end
    
  if value < 0
    
    result := DASH
    if register == decimalPoint
      result |= SEG_DP
    outTo(array, register--, result)
    -value
    divisor /= 10

  repeat
    result := HexDigits[value / divisor]
    if register == decimalPoint
      result |= SEG_DP
    outTo(array, register--, result)
    value //= divisor
    divisor /= 10
  while register => end

{pub decold(displayId, value)

  DecFormatted(displayId, value, DIGITS_PER_DISPLAY, SPACE_PAD)
  
PUB DecFormatted(displayId, value, digits, padFlag) : characterDisplayedFlag | divisor, register

  digits := 1 #> digits <# DIGITS_PER_DISPLAY
  register := DIG_7
  value := MIN_DISPLAYABLE #> value <# MAX_DISPLAYABLE
    
  if value < 0
    ||value                                                       'If negative, make positive; adjust for max negative
    outTo(displayId, register--, DASH)

  divisor := LARGEST_DIVISOR
  
  if padFlag & PADDED
    if digits < MAX_DISPLAYABLE   ' less than max digits?
      repeat (MAX_DISPLAYABLE - digits)  '   yes, adjust divisor
        divisor /= 10
        
  repeat digits
    if value => divisor
      outTo(displayId, register--, HexDigits[value / divisor])
      value //= divisor
      characterDisplayedFlag~~
    elseif (divisor == 1) or characterDisplayedFlag or (padFlag & ZERO_PAD)
      outTo(displayId, register--, HexDigits[0])
    elseif padFlag & SPACE_PAD
      outTo(displayId, register--, 0)
    divisor /= 10
 } 
pub outTo(displayId, reg, value) | bits, arrays

'' Update register in MAX7219 with value

  if displayId => displaysInUse
    return
    
  arrays := displaysInUse
  arrays -= displayId++
  arrays--
  bits.byte[3] := reg                                           ' set register
  bits.byte[2] := value                                         ' set value

  if (reg == DECODE)                                            ' save decode register bits      
    decodebits := value.byte[0]

  outa[cs] := 0                                                 ' enable

  repeat displayId                       
    repeat 16                                                   
      outa[mosi] := 0
      outa[sck] := 1
      outa[sck] := 0
      
  repeat 16                                                     ' shift out reg & value (MSBFIRST)
    outa[mosi] := (bits <-= 1)
    outa[sck] := 1
    outa[sck] := 0

  repeat arrays                     
    repeat 16                                                   
      outa[mosi] := 0
      outa[sck] := 1
      outa[sck] := 0
      
  outa[cs] := 1                                                 ' load into MAX7219/21


pub outAll(reg, value) | bits

'' Update register in all MAX7219 displays with value

  outa[cs] := 0                 ' enable

  repeat displaysInUse
    bits.byte[3] := reg         ' set register
    bits.byte[2] := value       ' set value

    if (reg == DECODE)          ' save decode register bits      
      decodebits := value.byte[0]
      
    repeat 16                   ' shift out reg & value (MSBFIRST)
      outa[mosi] := (bits <-= 1)
      outa[sck] := 1
      outa[sck] := 0
      
  outa[cs] := 1                 ' load into MAX7219/21


pub set_decode(digit, state) | mask

'' Sets digit to raw or decoded state
'' -- digit is 0 to 7
'' -- if state = 0, raw segments, else decimal decoded

  mask := 1 << digit

  if (state)
    decodebits |= mask                                          ' set to decode
  else
    decodebits &= !mask                                         ' set for raw segments

  out(DECODE, decodebits)                                       ' update displa   


pub write_buf(p_buf, n, reg)

'' Writes n (1 to 8) bytes at p_buf to MAX7219/21
'' -- if p_buf is zero or negative, use internal segments buffer
'' -- reg (1..8) is first register to write
'' -- uses existing register modes

  if (p_buf =< 0)
    p_buf := @segments                                          ' use internal buffer

  n <#= (9 - reg)                                               ' keep n legal

  repeat n                                                      ' write n registers
    out(reg++, byte[p_buf++])  


pub set_dp(p_buf, digit, state)

'' Sets decimal point segment for selected digit register
'' -- if p_buf is zero or negative, use internal segments
'' -- use write_buf() to update display

  if (p_buf =< 0)
    p_buf := @segments                                          ' use internal buffer

  if (state)
    byte[p_buf][digit] |= SEG_DP                                ' dp led on
  else
    byte[p_buf][digit] &= !SEG_DP                               ' dp led off


pub hex_map(d)

'' Returns segments map for hex digit d

  if ((d => $0) and (d =< $F))
    return HexDigits[d]
  else
    return 0

dat

  HexDigits             byte    _0, _1, _2, _3, _4, _5, _6, _7
                        byte    _8, _9, _A, _b, _C, _d, _E, _F
                                

dat { license }

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