''******************************************************************
''*  DataIO4port   version 1.0       1/22/2012                     *
''*  Author: Tracy Allen                                           *
''*  Copyright (c), EME Systems and others under MIT licence       *
''*  See end of file for terms of use.                             *
''*  adapted from pcFullDuplexSerial4fc by Tim Moore 2008          *
''*  Merged Debug_PC (Jon Williams)                                *
''*  Merged Parallax Serial Terminal numeric input  (Jeff Martin,  *
''*  Andy Lindsay, Chip Gracey)                                    *
''*                                                                *
''*  Release Notes:                                                *
''*  These are methods for string and numeric output and input     *
''*  using fullDuplexSerial4port, my adaptation of Tim Moore's     *
''*  pcFullDuplexSerial4fc.   In the original these were included  *
''*  in the main program, but here I have broken them off as pass- *
''*  through routines, and added string and numeric input methods. *
''*  These methods are called with reference to a port as defined  *
''*  when FullDuplexSerial4port is initialized.                    *
''*                                                                *
''*  If you do want to merge these methods back into the main      *
''*  object, simply remove all the "uarts." object references      *
''*                                                                *
''*  I made these separate, because for my own work I often use a  *
''*  completely different set of string & numeric i/o methods.     *
''*                                                                *
''******************************************************************

CON
  FF                            = 12                    ' form feed
  CR                            = 13                    ' carriage return
  NL                            = 13


  MAXSTR_LENGTH                = 32                     ' this limits the size of a binary string that can be entered

  DEFAULTTHRESHOLD = uarts#DEFAULTTHRESHOLD
  
VAR
   byte  str_buffer[MAXSTR_LENGTH+1]                     'String buffer for numerical string input only
                                                        ' This is in VAR space.  If multiple cogs will be _inputing_ numerical data
                                                        ' simultaneously, it is necessary to delare another instance so that
                                                        ' the buffers do not clash!  That applies to numerical parsing only.


DAT

debugLock    long -1

OBJ
  uarts :  "FullDuplexSerial4port"


PUB Init

  result := uarts.Init
  
PUB AddPort(port,rxpin,txpin,ctspin,rtspin,rtsthreshold,mode,baudrate)

  result := uarts.AddPort(port,rxpin,txpin,ctspin,rtspin,rtsthreshold,mode,baudrate)
  
PUB Start 

  result := uarts.Start 
  
PUB getCogID

  result := uarts.getCogID
  
PUB rxcheck(port)

  result := uarts.rxcheck(port)
  
PUB SetLock

  debugLock := locknew

PUB rxtime(port,ms)

  result := uarts.rxtime(port,ms)
  
PUB rx(port)

  result := uarts.rx(port)
  
PUB tx(port,txbyte)

  result := uarts.tx(port,txbyte)
  
PUB txs(port,txbyte)

  DebugCog(port)
  result := uarts.tx(port,txbyte)
  
PUB txe(port,txbyte)

  result := uarts.tx(port,txbyte)
  E
  
PUB rxHowFull(port)

  result := uarts.rxHowFull(port)
  
PUB rxflush(port)

  result := uarts.rxflush(port)

PUB Lock
'' set lock without sending cog ID

  'repeat until not lockset(debugLock)
  repeat while lockset(debugLock)

PUB DebugCog(port)
'' display cog ID at the beginning of debug statements

  Lock
  Tx(port, 11)
  Tx(port, 13)
  dec(port, cogid)
  Tx(port, ":")
  Tx(port, 32)
  
PUB E

  lockclr(debugLock) 

PUB str(port,stringptr)
'' Send string                    
  repeat strsize(stringptr)
    uarts.tx(port,byte[stringptr++])

PUB strs(port,stringptr)
'' Send string                    
  DebugCog(port)
  str(port,stringptr)

PUB stre(port,stringptr)
'' Send string                    
  str(port,stringptr)
  E
  
PUB strse(port,stringptr)
'' Send string                    
  strs(port,stringptr)
  E
  
PUB strln(port,strAddr)
'' Print a zero-terminated string
  str(port,strAddr)
  uarts.tx(port,CR)

PUB dec(port,value) | i
'' Print a decimal number
  decl(port,value,10,0)

PUB decs(port,value) | i
'' Print a decimal number

  DebugCog(port)
  dec(port,value)

PUB dece(port,value) | i
'' Print a decimal number

  dec(port,value)
  E
  
PUB decf(port,value, width) | i
'' Prints signed decimal value in space-padded, fixed-width field
  decl(port,value,width,1)

PUB decx(port,value, digits) | i
'' Prints zero-padded, signed-decimal string
'' -- if value is negative, field width is digits+1
  decl(port,value,digits,2)

PUB decl(port,value,digits,flag) | i, x
  digits := 1 #> digits <# 10
  x := value == NEGX                                                            'Check for max negative
  if value < 0
    value := ||(value+x)                                                        'If negative, make positive; adjust for max negative
    uarts.tx(port,"-")

  i := 1_000_000_000
  if flag & 3
    if digits < 10                                      ' less than 10 digits?
      repeat (10 - digits)                              '   yes, adjust divisor
        i /= 10
  repeat digits
    if value => i
      uarts.tx(port,value / i + "0")
      value //= i
      result~~
    elseif (i == 1) OR result OR (flag & 2)
      uarts.tx(port,"0")
    elseif flag & 1
      uarts.tx(port," ")
    i /= 10

PUB decDp(port,value,places) | divisor  ' prints out a fixed point number with a decimal point, places
  divisor := 1
  repeat places
    divisor := divisor * 10
  dec(port,value/divisor)
  uarts.tx(port,".")
  decx(port,||value//divisor,places)


PUB hex(port,value, digits)
'' Print a hexadecimal number
  value <<= (8 - digits) << 2
  repeat digits
    uarts.tx(port,lookupz((value <-= 4) & $F : "0".."9", "A".."F"))

PUB ihex(port,value, digits)
'' Print an indicated hexadecimal number
  uarts.tx(port,"$")
  hex(port,value,digits)

PUB bin(port,value, digits)
'' Print a binary number
  value <<= 32 - digits
  repeat digits
    uarts.tx(port,(value <-= 1) & 1 + "0")

PUB padchar(port,count, txbyte)
  repeat count
     uarts.tx(port,txbyte)

PUB ibin(port,value, digits)
'' Print an indicated binary number
  uarts.tx(port,"%")
  bin(port,value,digits)

PUB putc(port,txbyte)
'' Send a byte to the terminal
  uarts.tx(port,txbyte)

PUB newline(port)
  putc(port,CR)

PUB cls(port)
  putc(port,FF)

PUB getc(port)
'' Get a character
'' -- will not block if nothing in uart buffer
   return uarts.rxcheck(port)
'  return rx

con
{the following added from PST primarily for data input}
PUB StrIn(port,stringptr)
{{TTA from PST.
Receive a string (carriage return terminated) and stores it (zero terminated) starting at stringptr.
Waits until full string received.
  Parameter:
    stringptr - pointer to memory in which to store received string characters.
                Memory reserved must be large enough for all string characters plus a zero terminator.}}

  StrInMax(port, stringptr, -1)

PUB StrInMax(port, stringptr, maxcount) | char, ticks
{{from PST, modified
Receive a string of characters (either carriage return terminated or maxcount in length) and stores it (zero terminated)
starting at stringptr.  Waits until either full string received or maxcount characters received.
  Parameters:
    stringptr - pointer to memory in which to store received string characters.
                Memory reserved must be large enough for all string characters plus a zero terminator (maxcount + 1).
    maxcount  - maximum length of string to receive, or -1 for unlimited.}}

  maxcount <#= MAXSTR_LENGTH
  repeat maxcount                                                    'While maxcount not reached
    if (byte[stringptr++] := uarts.rx(0)) == NL                                      'Get chars until NL
      quit
  byte[stringptr+(byte[stringptr-1] == NL)]~                                    'Zero terminate string; overwrite NL or append 0 char


PUB StrInB(port, stringptr, seconds) | char, ticks
  ticks := clkfreq*seconds+cnt
  repeat MAXSTR_LENGTH
    repeat
      char := uarts.rxcheck(port)
    until char > -1
    case char
      32..126 : byte[stringptr++] := char   ' encompasses all numeric chars in dec and hex
      8, 127 :stringptr--
      13 : quit
    if ticks -= cnt < 0
      quit
  byte[stringptr]~

PUB DecIn(port) : value
{{PST.
Receive carriage return terminated string of characters representing a decimal value.
  Returns: the corresponding decimal value.}}

  StrInMax(port, @str_buffer, MAXSTR_LENGTH)
  value := StrToBase(@str_buffer, 10)


PUB HexIn(port) : value
{{from PST.
Receive carriage return terminated string of characters representing a hexadecimal value.
  Returns: the corresponding hexadecimal value.}}

  StrInMax(port, @str_buffer, MAXSTR_LENGTH)
  value := StrToBase(@str_buffer, 16)

PUB BinIn(port) : value
{{from PST.
Receive carriage return terminated string of characters representing a binary value.
 Returns: the corresponding binary value.   Note that the constant MAXSTR_LENGTH limits the # of digits}}

  StrInMax(port, @str_buffer, MAXSTR_LENGTH)
  value := StrToBase(@str_buffer, 2)


PRI StrToBase(stringptr, base) : value | chr, index
{from PST.
Converts a zero terminated string representation of a number to a value in the designated base.
Ignores all non-digit characters (except negative (-) when base is decimal (10)).}

  value := index := 0
  repeat until ((chr := byte[stringptr][index++]) == 0)
    chr := -15 + --chr & %11011111 + 39*(chr > 56)                              'Make "0"-"9","A"-"F","a"-"f" be 0 - 15, others out of range
    if (chr > -1) and (chr < base)                                              'Accumulate valid values into result; ignore others
      value := value * base + chr
  if (base == 10) and (byte[stringptr] == "-")                                  'If decimal, address negative sign; ignore otherwise
    value := - value


DAT
'***********************************
'* Assembly language serial driver *
'***********************************
{{

┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                                   TERMS OF USE: MIT License                                                  │                                                            
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation    │ 
│files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,    │
│modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software│
│is furnished to do so, subject to the following conditions:                                                                   │
│                                                                                                                              │
│The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.│
│                                                                                                                              │
│THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE          │
│WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR         │
│COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,   │
│ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                         │
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
}}