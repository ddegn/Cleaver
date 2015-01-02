CON{{ ****** Public Notes ******

  
  
}}
CON{
  ****** Duane's Working Notes ******

  Change name from "Cleaver141231a" to "CleaverSlave141231a".
  141231a Start modifying code to use as a slave to the main Cleaver board.
  
}
CON 
  
  _clkmode = xtal1 + pll16x
  _clkfreq = 80_000_000

  MICROSECOND = _clkfreq / 1_000_000
  MILLISECOND = _CLKFREQ / 1000
  ' Settings
  BUFFER_LENGTH = 255           ' Input Buffer Length must fit within input/output 'Index' ranges (currently a byte)

  SCALED_MULTIPLIER = 1000
  SCALED_TAU = 6_283            ' circumfrence / radius
  SCALED_CIRCLE = 360 * SCALED_MULTIPLIER
  SMALL_ARC_THRESHOLD = posx / (SCALED_MULTIPLIER * SCALED_TAU) '341 
     
  SCALED_ROBOT_CIRCUMFERENCE = Header#POSITIONS_PER_ROTATION * SCALED_MULTIPLIER / 2

  ' Motor names
  #0
  LEFT_MOTOR
  RIGHT_MOTOR

  ' Pin assignments
  ' Ping))) sensors
  PING_0 = 0
  PING_1 = 1
 
  ' I2C EEPROM
  SCL = 28
  SDA = 29
  I2C_CLOCK = SCL
  I2C_DATA = SDA

  MAX_ALLOWED_PINGS = Header#MAX_ALLOWED_PINGS
  PING_INTERVAL = 20            ' in milliseconds
  '**141220e MIN_PING = Ping#MIN_PING
  '**141220e MAX_PING = Ping#MAX_PING
 
  
  ' Terminal Settings
  BAUDMODE = Header#BAUDMODE

  ' ASCII commands
  NUL           = $00           ' Null character
  BEL           = $07           ' Bell
  BS            = $08           ' Backspace
  CR            = $0D           ' Carriage return
 

  ' EEPROM constants
  I2C_ACK       = 0
  I2C_NACK      = 1
  DEVICE_CODE   = %0110 << 4
  PAGE_SIZE     = 128

      
  CONTROL_FREQUENCY = 50 ' Iterations per second
  HALF_SEC = CONTROL_FREQUENCY / 2   ' Iterations per unit 'dwd 141118b good name?
  'HALF_SEC changed to in some locations.

  DEFAULT_CONTROL_FREQUENCY = 50
  DEFAULT_CONTROL_INTERVAL = _CLKFREQ / CONTROL_FREQUENCY
  DEFAULT_HALF_INTERVAL = DEFAULT_CONTROL_INTERVAL / 2 ' 1/100 of a second
  'DEFAULT_MAX_USEFUL_SPEED = 470
  CONTROL_CYCLES_TIL_FULL_POWER = CONTROL_FREQUENCY * 2
  CONTROL_CYCLES_TIL_FULL_SPEED = CONTROL_CYCLES_TIL_FULL_POWER


  MANAGABLE_BIT_ADJUSTMENT = 6
  ' **141225c MANAGABLE_ADJUSTMENT = 1 << 6
  SPEED_NUMERATOR = 62_500_000
  '' The values "SPEED_NUMERATOR" and "MANAGABLE_BIT_ADJUSTMENT" are used to
  '' calculate the speed from the time between encoder ticks.
  '' The value produced from this calculation is a number 100 times
  '' as large as the value of the speed calculated with the original
  '' technique.
  '' Hopefully these extra digits are significant and the speed values
  '' calculated from the time between encoder ticks will allow for
  '' better control of the motors.
  


CON '' Debug Levels
'' Use these constants to indicate which sections of code should be debugged.
'' If the value of the "debugFlag" variable is larger than the value assigned to these
'' constants, then the cooresponding section of code will output debug messages.
'' For example, if "debugFlag" is set to "LIGHT_DEBUG" (1) then sections of code with a
'' constant set to "NO_DEBUG" or higher will display debug messages.

  '' debugFlag enumeration
  #0, NO_DEBUG, LIGHT_DEBUG, MODERATE_DEBUG, FULL_DEBUG, DEBUGGING_DEBUG

  '' The various debugging constants allow only certain debug statements to be turn
  '' on. The higher the value of "debugFlag", the more debugging statements will
  '' be displayed. If "debugFlag" is set to zero, none of the debugging statements
  '' will be displayed.
  
  PING_CMD_DEBUG = FULL_DEBUG
  PING_DEBUG = LIGHT_DEBUG
  INTRO_DEBUG = LIGHT_DEBUG ' any debugFlag other than zero will allow debugging
  PROP_CHARACTER_DEBUG = FULL_DEBUG
  KILL_SWITCH_DEBUG = LIGHT_DEBUG
  INPUT_WARNINGS_DEBUG = LIGHT_DEBUG
  SCRIPT_INTRO_DEBUG = LIGHT_DEBUG
  SCRIPT_DEBUG = MODERATE_DEBUG
  SCRIPT_EXECUTE_DEBUG = SCRIPT_DEBUG - 1
  SCRIPT_WARNING_DEBUG = INPUT_WARNINGS_DEBUG
  MAIN_DEBUG = LIGHT_DEBUG
  PARSE_DEBUG = MAIN_DEBUG + 1
  ARC_DEBUG = FULL_DEBUG
  SERVO_DEBUG = FULL_DEBUG
  TURN_DEBUG = FULL_DEBUG
  HEADING_DEBUG = LIGHT_DEBUG
  INTERPOLATE_MID_DEBUG = FULL_DEBUG
  PARSE_DEC_DEBUG = DEBUGGING_DEBUG
  POWER_DEBUG = LIGHT_DEBUG
  PID_DEBUG = LIGHT_DEBUG
  PID_P_DEBUG = PID_DEBUG
  PID_I_DEBUG = PID_DEBUG
  PID_D_DEBUG = PID_DEBUG
  PID_POSITION_DEBUG = PID_DEBUG
  PID_SPEED_DEBUG = PID_DEBUG

CON 

  #0, MASTER_COM, ALT_COM

  FILL_LONG = $AA55_55AA   ' used to test stack sizes.
 
  PING_STACK_SIZE = 24 ' It appears the cog monitoring the Pings use 23 longs
  'of the stack.

  ACTIVE_SERVO_POS_IN_SERVOTXT = 8
  DEC_IN_RESTORE_POS = 6
  
CON

  EMIC_RX = 5
  EMIC_TX = 4
  'XBEE_RX =
  'XBEE_TX =
  SR02_RX_PIN = 17
  SR02_TX_PIN = 16
  
  SR02_TRIGGER_PIN = 19

  ' Servos are attached to the slave board not this board.
  SERVO_PIN_0 = 2
  SERVO_PIN_1 = SERVO_PIN_0 + 1
  SERVO_PIN_2 = SERVO_PIN_1 + 1
  SERVO_PIN_3 = SERVO_PIN_2 + 1
  SERVO_PIN_4 = SERVO_PIN_3 + 1
  SERVO_PIN_5 = SERVO_PIN_4 + 1

  STARBOARD_PAN_PIN = SERVO_PIN_4
  STARBOARD_TILT_PIN = SERVO_PIN_5
  PORT_PAN_PIN = SERVO_PIN_0
  PORT_TILT_PIN = SERVO_PIN_1
  MIDDLE_PAN_PIN = SERVO_PIN_2
  MIDDLE_TILT_PIN = SERVO_PIN_3
  
  PORT_TILT_UP = 500
  PORT_TILT_HORIZONTAL = 1430
  PORT_TILT_DOWN = 2310
  
  PORT_PAN_REAR_PORT = 2490
  PORT_PAN_DUE_PORT = 2180
  PORT_PAN_45_PORT = 1630
  PORT_PAN_CENTER = 1425 ' 22.5 degrees
  PORT_PAN_FORWARD = 1150
  PORT_PAN_PRACTICAL_STARBOARD = 880
  PORT_PAN_MAX_STARBOARD = 500

  STARBOARD_TILT_UP = 580
  STARBOARD_TILT_HORIZONTAL = 1620
  STARBOARD_TILT_DOWN = 2500

  STARBOARD_PAN_REAR_STARBOARD = 500
  STARBOARD_PAN_DUE_STARBOARD = 900
  STARBOARD_PAN_45_STARBOARD = 1315
  STARBOARD_PAN_CENTER = 1650 ' 22.5 degrees
  STARBOARD_PAN_FORWARD = 1990
  STARBOARD_PAN_PRACTICAL_PORT = 2260
  STARBOARD_PAN_MAX_PORT = 500


  MIDDLE_TILT_UP = 840
  MIDDLE_TILT_HORIZONTAL = 1030
  MIDDLE_TILT_DOWN = 1970
  
  MIDDLE_PAN_PORT = 2000
  MIDDLE_PAN_CENTER = 1480
  MIDDLE_PAN_STARBOARD = 1000

  #0, PORT_PAN_SERVO, PORT_TILT_SERVO, MIDDLE_PAN_SERVO, MIDDLE_TILT_SERVO
      STARBOARD_PAN_SERVO, STARBOARD_TILT_SERVO, ALL_SERVOS, PAN_SERVOS, TILT_SERVOS
      PORT_SERVOS, MIDDLE_SERVOS, STARBOARD_SERVOS

  ' rampType enumeration
  #0, LINEAR_RAMP, ACCELERATION_RAMP ', CONSTANT_JERK_RAMP

  ' servoSweep mode
  #0, INCREASING_SWEEP, DECREASING_SWEEP

  ' servoPattern mode
  #0, STRAIGHT_AHEAD_SEARCH, UNISON_SIDE_TO_SIDE_SEARCH, OPPOSING_SIDES_SLOW_SF2_SEARCH
      FULL_SEARCH

  PSEUDO_MULTIPLIER = 1000
           
  NUMBER_OF_SHARP_SENSORS = 2
  NUMBER_OF_UNIQUE_ADC = 4
  NUMBER_OF_ADC_VALUES = 8
  NUMBER_OF_PING_SENSORS = 2
  NUMBER_OF_SERVOS = 6

  MAX_SHARP_INDEX = NUMBER_OF_SHARP_SENSORS - 1
  MAX_UNIQUE_ADC_INDEX = NUMBER_OF_UNIQUE_ADC - 1
  MAX_ADC_VALUES_INDEX = NUMBER_OF_ADC_VALUES - 1
  MAX_PING_INDEX = NUMBER_OF_PING_SENSORS - 1
  MAX_SERVO_INDEX = NUMBER_OF_SERVOS - 1


  ' sdFlag enumeration
  #0, NOT_FOUND_SD, IN_USE_SD, INITIALIZING_SD, NEW_LOG_CREATED_SD, LOG_FOUND_SD, {
    } NO_LOG_YET_SD, USED_BY_OTHER_SD

  
  #0, PLAY_BACK_SUCCESS, PLAY_BACK_ERROR_NOT_FOUND, PLAY_BACK_ERROR_OTHER

  #0, MASTER_SERIAL, COM_SERIAL
  #0, DEBUG_COM, EMIC_COM, SR02_COM', XBEE_COM

CON '' Cog Usage
{{
  The objects, "Com", "Ping", "Servo", "Encoder" and "AltCom" each start
  their own cog.
  
  This top object uses two cogs bringing the total of cogs used to 7.
  Depending on the motor controller used.
  
  The object "Music" is not presently active and each require
  a cog to use.
 
}}
VAR

  long error                                            ' Error message pointer for verbose responses  
  long lastUpdated[2]
  
  '' Keep variables below in order.
  long pingCount, pingResults[Header#PINGS_IN_USE]
  long pingStack[PING_STACK_SIZE]
  '' Keep variables above in order.

  long activeParameter
  long activeParTxtPtr
 
  long lastComTime

  long addressOffsetCorrection

  byte pingsInUse, maxPingIndex
  byte inputBuffer[BUFFER_LENGTH], outputBuffer[BUFFER_LENGTH] 
  byte inputIndex, parseIndex, outputIndex
  byte pingPauseFlag
       
DAT '' variables which my have non-zero initial values

pingMask                        long %11
pingInterval                    long PING_INTERVAL
           
maxPowAccel                     long 470        ' Maximum allowed motor power acceleration
maxPosAccel                     long 800        ' Maximum allowed positional acceleration

smallChange                     long 1
bigChange                       long 10
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
servoPosition                   long 1500
controlFrequency                long DEFAULT_CONTROL_FREQUENCY
halfInterval                    long DEFAULT_HALF_INTERVAL

debugFlag                       byte 0 ' FULL_DEBUG
                      
mode                            byte 0                  ' Current mode of the control system

activeServo                     byte 6

OBJ                             
                                
  Header : "HeaderCleaver"         

  Master : "Serial4PortLocks"                         ' uses one cog
  Com : "Serial4LocksA"                            ' uses one cog
  Ping : "EddiePingMonitor"                               ' uses one cog
  
  Servo : "Servo32v9Shared"                             ' uses one cog

  Nunchuck : "jm_nunchuk_ez_v3"
  Format : "StrFmt"             ' same formatting code used by serial object so
                                ' so adding this doesn't cost us any RAM.
  
PUB Main 

  Master.Init
  Master.AddPort(0, Header#MASTER_RX, Header#MASTER_TX, -1, -1, 0, BAUDMODE, Header#MASTER_BAUD)
  Master.Start                                             'Start the ports
 
  Com.Init
  Com.AddPort(DEBUG_COM, Header#USB_RX, Header#USB_TX, -1, -1, 0, BAUDMODE, Header#SLAVE_USB_BAUD)
  Com.AddPort(EMIC_COM, EMIC_RX, EMIC_TX, -1, -1, Com#DEFAULTTHRESHOLD, 0, Header#EMIC_BAUD)
  Com.AddPort(SR02_COM, SR02_RX_PIN, SR02_TX_PIN, -1, -1, Com#DEFAULTTHRESHOLD, 0, Header#SR02_BAUD)
  Com.Start                                         'Start the ports    
 
  Servo.Start
        
  Nunchuck.Init(I2C_CLOCK, I2C_DATA)
    
  longfill(@pingStack, FILL_LONG, PING_STACK_SIZE)
  Ping.Start(pingMask, pingInterval, @pingResults)
  ' Continuously trigger and read pulse widths on PING))) pins
  pingsInUse := Ping.GetPingsInUse
  maxPingIndex := pingsInUse - 1
  addressOffsetCorrection := @addressOffsetTest - addressOffsetTest

  if debugFlag => INTRO_DEBUG
    Master.Strs(MASTER_COM, string(11, 13, "CleaverSlave"))
      
    Master.Tx(MASTER_COM, 7) ' Bell sounds in terminal to catch reset issues
    waitcnt(clkfreq / 4 + cnt)
    Master.Tx(MASTER_COM, 7)
    waitcnt(clkfreq / 4 + cnt)
    Master.Txe(MASTER_COM, 7)
  
    
  'activeParameter := @targetPower[RIGHT_MOTOR]
  'activeParTxtPtr := @targetPowerRTxt

  MainLoop

PUB MainLoop | rxcheck, lastDebugTime
    
  lastComTime := cnt
  repeat                                                ' Main loop (repeats forever) 
    repeat           ' Read a byte from the command UART
    
      Master.Lock
      rxcheck := Master.RxCheck(MASTER_COM)
      Master.E ' clear lock 
      
   
      if rxcheck <> -1
      
      'else
      {Com.Lock
      rxcheck := Com.RxCheck(0)
      Com.E
      if rxcheck <> -1
        'if debugFlag => PROP_CHARACTER_DEBUG
        '  Master.Strs(MASTER_COM, string(11, 13, "From Prop:", 34))
        '  Master.Tx(MASTER_COM, rxcheck)
        '  Master.Txe(MASTER_COM, 34)  
        controlCom := ALT_COM
      }        
      
      
      ' Stop motors if no communication has been received in the allowed time
      ' (dwd 141125b I changed time keeping variables from original code.)
      ' The allowed time (in millieseconds) may be changed with the "KILL" command.
      ' The "WATCH" command will change the time in seconds.
     
      if true 'cnt - lastDebugTime > debugInterval
        'lastDebugTime += debugInterval
        if debugFlag => MAIN_DEBUG
          TempDebug(MASTER_COM)
    while rxcheck < 0
       
    inputBuffer[inputIndex++] := rxcheck

    if inputIndex == constant(BUFFER_LENGTH)            ' Check for a full buffer
      OutputStr(@nack)                                  ' Ready error response
      if true
        OutputStr(@overflow)
      repeat                                            ' Ignore all inputs other than NUL or CR (terminating a command) 
        case Rx(MASTER_COM)                        ' Send the correct error response for the transmission mode
          {
          NUL :                                         '   Checksum mode
            SendChecksumResponse
            quit
          }
          CR :                                          '   Plain text mode
            SendResponse    ' branch # 1 termination 
            quit
    else                                                ' If there isn't a buffer overflow...                              
      case inputBuffer[inputIndex - 1]                  ' Parse the character
        
        NUL :                                           ' End command in checksum mode:
          if debugFlag => INPUT_WARNINGS_DEBUG
            Master.Strs(MASTER_COM, string(11, 13, 7, "Error, NUL character received.", 7))
            Master.Stre(MASTER_COM, Error)
            waitcnt(clkfreq * 2 + cnt)

          {if inputIndex > 1                             '   Only parse buffer if it has content
            ifnot Error := \ChecksumParse               '   Run the parser and trap and report errors
              outputIndex~                              '    Handle errors, if they occurred
              OutputStr(@nack)
              if verbose
                OutputStr(Error)
            SendChecksumResponse                        '   Send a response if no error
          else                                          '   For an empty buffer, clear the pointer
            inputIndex~                                 '   to start receiving a new command
           }
        BS :                                            ' Process backspaces
          if --inputIndex                               ' Ignore the BS character itself
            --inputIndex                                ' Ignore previous character if exists

        "+" :
          UpdateActive(smallChange)
        "-" :
          UpdateActive(-1 * smallChange)
        "*" :
          UpdateActive(bigChange)
        "/" :
          UpdateActive(-1 * bigChange)
          
        CR:                                             ' End command in plaintext mode:
          if inputIndex > 1                             '   Only parse buffer if it has content
            if error := \Parse                          '   Run the parser and trap and report errors
              outputIndex~                              '    Handle errors, if they occurred
              OutputStr(@nack)

              if true
                OutputStr(error)

            SendResponse                                '   Send a response if no error
           
          else                                          '   For an empty buffer, clear the pointer
            inputIndex~                                 '   to start receiving a new command
           
        1..BEL, 8..12, 14..31, 127..255 :            ' Ignore invalid characters
         
            inputIndex--
           
                      
PRI UpdateActive(changeAmount)

  if inputIndex == 1
    long[activeParameter] += changeAmount
    if activeParameter == @servoPosition
      Servo.Set(activeServo, servoPosition)
    elseif activeParameter == @controlFrequency
      halfInterval := clkfreq / controlFrequency / 2
    elseif activeParTxtPtr == @kProportionalTxt 
      long[activeParameter + 4] += changeAmount ' adjust right also
    inputIndex--
    lastComTime := cnt

PRI TempDebug(port)

  if port <> MASTER_COM
    return
              
  Master.Txs(port, 11)
  Master.Tx(port, 1) ' home
  Master.Str(MASTER_COM, string(11, 13, "CleaverSlave"))

  Master.Str(port, string(", mode = "))
  Master.Dec(port, mode)
  Master.Str(port, string(" = "))
  Master.Str(port, FindString(@modeAsText, mode)) 
 
  Master.Str(port, string(11, 13, "activeParameter = "))
  Master.Str(port, activeParTxtPtr)  
  Master.Str(port, string(" = "))
  Master.Dec(port, long[activeParameter])


  if debugFlag => PING_DEBUG
    Master.Str(port, string(11, 13, "pingCount = "))
    Master.Dec(port, pingCount)
    Master.Str(port, string(", pingMask = "))
    Master.Dec(port, pingMask)
    Master.Str(port, string(", pingInterval = "))
    Master.Dec(port, pingInterval)
    
    Master.Str(port, string(", pingResults = "))
    Master.Dec(port, pingResults[0])
    Master.Str(port, string(", "))
    Master.Dec(port, pingResults[1])

  'PingStackDebug(port) 
                
  Master.Tx(port, 11)
  Master.Txe(port, 13)
      
PUB PingStackDebug(port)

  Master.Str(port, string(11, 13, "Ping Stack = ", 11, 13))
  DumpBufferLong(port, @pingStack, PING_STACK_SIZE, 12)

PUB DumpBuffer(port, bufferPtr, bufferSize, interestedLocationPtr, offset) : localIndex

  bufferSize--

  repeat localIndex from 0 to bufferSize
    if long[interestedLocationPtr] - offset == localIndex
      Master.Tx(port, "*")
    Master.Dec(port, long[bufferPtr][localIndex])
    
    if localIndex // 8 == 7 and localIndex <> bufferSize
      Master.Tx(port, 11)
      Master.Tx(port, 13)
    elseif localIndex <> bufferSize  
      Master.Tx(port, ",")
      Master.Tx(port, 32)  

PRI DumpBufferLong(port, localPtr, localSize, localColumns) | localIndex

 
  Master.Str(port, string("DumpBufferLong @ $"))
  Master.Dec(port, localPtr)

  Master.Tx(port, 11) 
  
  repeat localIndex from 0 to localSize - 1
    if localIndex // localColumns == 0
      Master.Tx(port, 11) 
      Master.Tx(port, 13) 
    else
      Master.Tx(port, 32)  
    Master.Tx(port, "$")  
    Master.Hex(port, long[localPtr][localIndex], 8)

PUB FindString(firstStr, stringIndex)      '' Called from DebugCog
'' Finds start address of one string in a list
'' of string. "firstStr" is the address of 
'' string #0 in the list. "stringIndex"
'' indicates which of the strings in the list
'' the method is to find.
'' Version from HexapodRemote140128a
'' Version Hexapod140129a, removed commented
'' out code.

  result := firstStr 
  repeat while stringIndex    
    repeat while byte[result++]  
    stringIndex--
    
PUB SafeDebug(port, ptr, size)

  repeat size
    SafeTx(port, byte[ptr++])
    
PUB SafeTx(port, character)

  case character
    32.."~":
      Master.Tx(port, character)
    other:
      Master.Tx(port, "<")
      Master.Tx(port, "$")
      Master.Hex(port, character, 2)
      Master.Tx(port, ">")
      
PRI Parse                                               '' Parse the command in the input buffer
'' Since Spin only allows 16 "elseif" statements in a row, the parsing
'' of the command is split into multiple lists of "elseif" conditions.
'' The method to parse the commands will be selected based on the first
'' letter of the command.
  
  inputBuffer[inputIndex - 1]~                          ' Ensure buffer is NUL terminated (may have been CR terminated)

  repeat parseIndex from 0 to inputIndex - 2            ' Find the end of the command in the input buffer             
    case inputBuffer[parseIndex]                         
      "a".."z" :                                        ' Set all command characters to uppercase
        inputBuffer[parseIndex] -= constant("a" - "A")
      9, " " :                                         ' Determine command length by finding the first whitespace character
        inputBuffer[parseIndex]~                        ' Null terminate the command
        quit                                            ' parseIndex now points to the null at the end of the command string (before the first parameter, if present)

  ' parameter[n] := ParseDec(NextParameter) caches the parameters to check for their existence before running the command
  ' CheckLastParameter checks for too many parameters
  ' The Output...() methods write responses to the output buffer
  ' Check command against the following strings:

  case inputBuffer[0]
    "A".."Z":
      ParseAZ
    other:
      abort @invalidCommand

  lastComTime := cnt
  return 0

PRI ParseAZ | index, parameter[3]
'' 16 Commands (including soon to be added "ARC")
'' "ACC", "ACP", "ADC", "ARC", "AKP", "AKPM", "AKPB", "AKPD", "BIG", "BLNK"  ' 10
'' "DEBUG", "DECIN", "DECOUT", "DEMO", "DIFF", "DIST" ' 6
   
  if strcomp(@InputBuffer, string("BIG"))        
    Parameter := ParseDec(NextParameter)
    CheckLastParameter
    bigChange := parameter
  elseif strcomp(@InputBuffer, string("DEBUG"))        
    parameter := ParseDec(NextParameter)
    CheckLastParameter
    debugFlag := parameter
  elseif strcomp(@InputBuffer, string("PING"))          ' Command: Respond with status of active PING))) sensors
    CheckLastParameter
          
    repeat index from 0 to maxPingIndex
      OutputDec(pingResults[index])
      if index < maxPingIndex                      
        OutputChr(" ")
  elseif strcomp(@InputBuffer, string("SAY"))
    parameter[0] := ParseDec(NextParameter)
    parameter[1] := ParseDec(NextParameter)
    CheckLastParameter
    Say(parameter[0], parameter[1]) 
  elseif strcomp(@InputBuffer, string("SERVO"))        
    parameter[0] := ParseDec(NextParameter)
    parameter[1] := ParseDec(NextParameter)
    CheckLastParameter
    Servo.Set(parameter[0], parameter[1])
    activeServo := parameter[0]
    servoPosition := parameter[1]
    activeParameter := @servoPosition
    activeParTxtPtr := @servoTxt
    servoTxt[ACTIVE_SERVO_POS_IN_SERVOTXT] := "0" + activeServo ' insert servo #
          
  elseif strcomp(@InputBuffer, string("SMALL"))        
    parameter := ParseDec(NextParameter)
    CheckLastParameter
    smallChange := parameter
   
  else
    abort @invalidCommand

  return 0

PRI NextParameter                                       '' Condition the next input parameter and return its pointer

  repeat until ++parseIndex => inputIndex               ' Ignore whitespace
    case inputBuffer[parseIndex]                        ' First character is always whitespace
      0, 9, " ":
      other:
        quit                                            ' parseIndex points to first non-whitespace character
  if parseIndex => inputIndex                           ' If at the end of the buffer (or passed it, just in case)
    abort @tooFewParameters                             '  then there are no more parameters
  result := @inputBuffer[parseIndex]                    ' When responding, point to the next parameter,

  repeat parseIndex from parseIndex to inputIndex - 1   ' But first...
    case inputBuffer[parseIndex]                         
      NUL, 9, " " :                                    '  Null terminate the parameter           
        inputBuffer[parseIndex]~
        quit
      "a".."z" :                                        '  Set all command characters to uppercase
        inputBuffer[parseIndex] -= constant("a" - "A")


PRI CheckLastParameter                                  '' Abort if there are any unparsed input parameters

  repeat until (inputBuffer[parseIndex] <> 0 and inputBuffer[parseIndex] <> " " and inputBuffer[parseIndex] <> 9) or parseIndex == inputIndex - 1
    ++parseIndex

  ifnot parseIndex == inputIndex - 1                    '   Ensure that there are no further arguments           
    abort @tooManyParameters                            '   To prevent changes with a "Too many parameters" error

PRI ParseDec(pointer) | character, sign                       '' Interpret an ASCII decimal string

  sign := 1
  if debugFlag => PARSE_DEC_DEBUG
    Master.Strse(MASTER_COM, string(11, 13, "ParseDec"))
  repeat 11
    if debugFlag => PARSE_DEC_DEBUG
      Master.Strs(MASTER_COM, string(", byte[] ="))
      SafeTx(MASTER_COM, byte[pointer])
      Master.E
    case character := byte[pointer++]
      NUL:
        result *= sign
        return result
      "0".."9" :
        result := (result * 10) + (character - "0")
      "-" :
        sign := -1
     
      other :
        abort @invalidParameter
        
  result *= sign
  
  if byte[pointer]                                      ' Make sure there are no remaining characters after parsing first eight.                        
    abort @invalidParameter

PRI OutputChr(char)                                     '' Add a character to the output buffer

  if outputIndex < BUFFER_LENGTH - 3
    outputBuffer[outputIndex++] := char
    outputBuffer[outputIndex]~
  
PRI OutputStr(pointer)                                  '' Concatenate a string to the end of the output buffer

  if strsize(pointer) + 1 =< BUFFER_LENGTH - outputIndex                        ' Check for overflow
    bytemove(@outputBuffer + outputIndex, pointer, strsize(pointer) + 1)        ' Copy the string to the buffer, including the terminator
    outputIndex += strsize(pointer)                                             ' Increment the output buffer index by the length of the sting, not including the terminator

PRI OutputDec(value) | i, x                             '' Create a decimal string and concatenate the end of the output buffer
'' Print a decimal number

  x := value == negx                                    ' Check for max negative
  if value < 0
    value := ||(value + x)                              ' If negative, make positive; adjust for max negative
    OutputChr("-")                                      ' and output sign

  i := 1_000_000_000                                    ' Initialize CONTROL_FREQUENCY

  repeat 10                                             ' Loop for 10 digits
    if value => i                                                               
      OutputChr(value / i + "0" + x * (i == 1))         ' If non-zero digit, output digit; adjust for max negative
      value //= i                                       ' and digit from value
      result := 1                                       ' flag non-zero found
    elseif result or i == 1
      OutputChr("0")                                    ' If zero digit (or only digit) output it
    i /= 10                                             ' Update CONTROL_FREQUENCY

PRI Rx(port)

  if port == ALT_COM
    return '**141220d 
    '**141220d Com.Lock
    '**141220d result := Com.Rx(0)
    '**141220d Com.E
  else
    Master.Lock  
    result := Master.Rx(0)
    Master.E
    
PRI SendResponse                                        '' Transmit the string in the output buffer and clear the buffer

  Master.Lock
  Master.Str(0, @outputBuffer)  ' Transmit the buffer contents
  Master.Stre(0, @prompt)       ' Transmit the prompt
  inputIndex := 0               ' Clear the buffers
  '** Why clear inputIndex here?
  
  outputBuffer := 0             ' is this needed?
  outputIndex := 0

PRI ReadEEPROM(startAddr, endAddr, eeStart) | addr

  ''Copy from EEPROM beginning at eeStart address to startAddr..endAddr in main RAM.
  
  SetAddr(eeStart)                                      ' Set EEPROM's address pointer 
  i2cstart
  SendByte(%10100001)                                   ' EEPROM I2C address + read operation
  if startAddr == endAddr
    addr := startAddr
  else
    repeat addr from startAddr to endAddr - 1           ' Main RAM index startAddr to endAddr
      byte[addr] := GetByte                             ' GetByte byte from EEPROM & copy to RAM 
      SendAck(I2C_ACK)                                  ' Acknowledge byte received
  byte[addr] := GetByte                                 ' GetByte byte from EEPROM & copy to RAM 
  SendAck(I2C_NACK)
  i2cstop                                               ' Stop sequential read
  
PRI WriteEEPROM(startAddr, endAddr, eeStart) | addr, page, eeAddr

  ''Copy startAddr..endAddr from main RAM to EEPROM beginning at eeStart address.

  addr := startAddr                                     ' Initialize main RAM index
  eeAddr := eeStart                                     ' Initialize EEPROM index
  repeat
    page := addr +PAGE_SIZE -eeAddr // PAGE_SIZE <# endaddr +1 ' Find next EEPROM page boundary
    SetAddr(eeAddr)                                     ' Give EEPROM starting address
    repeat                                              ' Bytes -> EEPROM until page boundary
      SendByte(byte[addr++])
    until addr == page
    i2cstop                                             ' From 24LC256's page buffer -> EEPROM
    eeaddr := addr - startAddr + eeStart                ' Next EEPROM starting address
  until addr > endAddr                                  ' Quit when RAM index > end address

PRI SetAddr(addr) : ackbit

  'Sets EEPROM internal address pointer.

  ' Poll until acknowledge.  This is especially important if the 24LC256 is copying from buffer to EEPROM.
  ackbit~~                                              ' Make acknowledge 1
  repeat                                                ' Send/check acknowledge loop
    i2cstart                                            ' Send I2C start condition
    ackbit := SendByte(%10100000)                       ' Write command with EEPROM's address
  while ackbit                                          ' Repeat while acknowledge is not 0

  SendByte(addr >> 8)                                   ' Send address high byte
  SendByte(addr)                                        ' Send address low byte

PRI I2cStart

  ' I2C start condition.  SDA transitions from high to low while the clock is high.
  ' SCL does not have the pullup resistor called for in the I2C protocol, so it has to be
  ' set high. (It can't just be set to inSendByte because the resistor won't pull it up.)

  dira[SCL]~                                            ' SCL pin outSendByte-high
  dira[SDA]~                                            ' Let pulled up SDA pin go high
  dira[SDA]~~                                           ' SDA -> outSendByte for SendByte method

PRI I2cStop

  ' Send I2C stop condition.  SCL must be high as SDA transitions from low to high.
  ' See note in i2cStart about SCL line.

  dira[SDA]~~
  dira[SCL]~                                            ' SCL -> high
  dira[SDA]~                                            ' SDA -> inSendByte GetBytes pulled up
  
PRI SendAck(ackbit)

  ' Transmit an acknowledgment bit (ackbit).

  dira[SDA] := !ackbit                                  ' Set SDA output state to ackbit
  dira[SDA]~~                                           ' Make sure SDA is an output
  dira[SCL]~                                            ' Send a pulse on SCL
  dira[SCL]~~
  dira[SDA]~                                            ' Let go of SDA

PRI GetAck : ackbit

  ' GetByte and return acknowledge bit transmitted by EEPROM after it receives a byte.
  ' 0 = I2C_ACK, 1 = I2C_NACK.

  dira[SDA]~                                            ' SDA -> SendByte so 24LC256 controls
  dira[SCL]~                                            ' Start a pulse on SCL
  ackbit := ina[SDA]                                    ' GetByte the SDA state from 24LC256
  dira[SCL]~~                                           ' Finish SCL pulse
  dira[SDA]~~                                           ' SDA -> outSendByte, master controls
  
PRI SendByte(b) : ackbit | i

  ' Shift a byte to EEPROM, MSB first.  Return if EEPROM acknowledged.  Returns
  ' acknowledge bit.  0 = I2C_ACK, 1 = I2C_NACK.

  b ><= 8                                               ' Reverse bits for shifting MSB right
  dira[SCL]~~                                           ' SCL low, SDA can change
  repeat 8                                              ' 8 reps sends 8 bits
    dira[SDA] := !b                                     ' Lowest bit sets state of SDA
    dira[SCL]~                                          ' Pulse the SCL line
    dira[SCL]~~
    b >>= 1                                             ' Shift b right for next bit
  ackbit := GetAck                                      ' Call GetByteAck and return EEPROM's Ack

PRI GetByte : value

  ' Shift in a byte, MSB first.  

  value~                                                ' Clear value
  dira[SDA]~                                            ' SDA input so 24LC256 can control
  repeat 8                                              ' Repeat shift in eight times
    dira[SCL]~                                          ' Start an SCL pulse
    value <-= 1                                         ' Shift the value left
    value |= ina[SDA]                                   ' Add the next most significant bit
    dira[SCL]~~                                         ' Finish the SCL pulse

PUB Say(messageId, value)

  Com.Tx(EMIC_COM, "S")
  Com.Str(EMIC_COM, FindString(@introEmic, messageId))
  if value <> posx
    Com.Dec(EMIC_COM, value)
  Com.Tx(EMIC_COM, 13)

  result := Com.Rx(EMIC_COM)
  
DAT

prompt                          byte CR, 0
checkSumPrompt
'nullString                      byte 0
nack                            byte "ERROR", 0
overflow                        byte " - Overflow", 0
badChecksum                     byte " - Bad checksum", 0
invalidCommand                  byte " - Invalid command", 0
invalidParameter                byte " - Invalid parameter", 0
tooFewParameters                byte " - Too few parameters", 0
tooManyParameters               byte " - Too many parameters", 0
encoderError                    byte " - Encoder error", 0
'nonCommand                      byte " - Nothing happens", 0

''' Used by DebugTemp
modeAsText                      byte "POWER", 0
                                byte "SPEED", 0
                                byte "STOPPING", 0
                                byte "POSITION", 0
                                byte "ARC_POSITION", 0

kpControlTypeTxt                byte "TARGET_DEPENDENT", 0
                                byte "CURRENT_SPEED_DEPENDENT", 0
                                
comTxt                          byte "MASTER_COM", 0
                                byte "ALT_COM", 0
  
' Active Parameter Text
maxPowAccelTxt                  byte "maxPowAccel", 0 
maxPosAccelTxt                  byte "maxPosAccel", 0

kProportionalTxt                byte "kProportional", 0
kProportionalRightTxt           byte "kProportionalRight", 0
kProportionalLeftTxt            byte "kProportionalLeft", 0  

kIntegralDenominatorTxt         byte "kIntegralDenominator", 0
kIntegralNumeratorTxt           byte "kIntegralNumerator", 0
  
servoTxt                        byte "servo #   ", 0
targetPowerLTxt                 byte "targetPower[LEFT]", 0
targetPowerRTxt                 byte "targetPower[RIGHT]", 0
targetSpeedLTxt                 byte "targetSpeed[LEFT]", 0
targetSpeedRTxt                 byte "targetSpeed[RIGHT]", 0
controlFrequencyTxt             byte "controlFrequency", 0

DAT introEmic                   byte "Robot Cleaver Ready", 0
                                byte "Communication With Propeller Enabled", 0
                                byte "Error no Propeller communicaion, Error", 0
                                byte "The speed is ", 0
                                byte "Initiating a figure eight", 0

DAT ' script buffers

configDec                       byte "DECIN 1", 0
restoreConfig                   byte "DECIN ?", 0

{introTempo                      byte "TEMPO 1500", 0
midTempo                        byte "TEMPO 1500", 0
endTempo                        byte "TEMPO 1500", 0
finalTempo                      byte "TEMPO 1500", 0
introSong                       byte "SONG 7", 0
midSong                         byte "SONG 9", 0
endSong                         byte "SONG 3", 0
finalSong                       byte "SONG 3", 0  }
leftCircleF500mm                byte "ARC -360 149 50", 0
rightCircleF500mm               byte "ARC 360 149 50", 0
leftCircleF299mm                byte "ARC -360 89 50", 0
rightCircleF299mm               byte "ARC 360 89 50", 0

straightF2000mm                 byte "TRVL 596 50", 0
straightF1000mm                 byte "TRVL 298 50", 0
straightF500mm                  byte "TRVL 149 50", 0
straightF2000mmFast             byte "TRVL 596 100", 0
straightF1000mmFast             byte "TRVL 298 100", 0
straightF500mmFast              byte "TRVL 149 100", 0

leftTurn                        byte "TURN -90 50", 0
rightTurn                       byte "TURN 90 50", 0
leftTurnFast                    byte "TURN -90 100", 0
rightTurnFast                   byte "TURN 90 100", 0
left180                         byte "TURN -180 50", 0
right180                        byte "TURN 180 50", 0
leftSpin5Rev100                 byte "TURN -1800 100", 0
rightSpin5Rev100                byte "TURN 1800 100", 0
rightSpin10Rev50                byte "TURN 3600 50", 0
leftSpin10Rev50                 byte "TURN -3600 50", 0

DAT

addressOffsetTest               word @addressOffsetTest

twoByOneMRectanglePlusTwo8s     word @configDec
                                word @straightF2000mm, @leftTurn, @straightF1000mm, @leftTurn
                                word @straightF2000mm, @leftTurn, @straightF1000mm, @right180
                                word @straightF1000mm, @rightTurn, @straightF2000mm, @rightTurn
                                word @straightF1000mm, @rightTurn, @straightF2000mm, @left180
                                word @straightF1000mm, @leftTurn, @straightF500mm
                                word @rightCircleF299mm, @leftCircleF299mm
                                word @rightCircleF500mm, @leftCircleF500mm, 0
                                