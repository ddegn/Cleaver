CON{{ ****** Public Notes ******  
}}
CON{ Latest Commit Notes

  150105 Rename many of the serial post IDs.
  Move MainLoop code to separate methods.
  Remove calls to serial methods using locks.
  Try to get Laser Rangefinder to work. It doesn't work (with this code) yet.
  Add a bunch of constants to use with the EasyVR module. EasyVR isn't used yet.
  
}  
CON 
  
  _clkmode = xtal1 + pll16x
  _clkfreq = 80_000_000

  MICROSECOND = _clkfreq / 1_000_000
  MILLISECOND = _clkfreq / 1000
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
  SERVO_PIN_0 = Header#FIRST_SERVO_PIN
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

  STARBOARD_TILT_UP = 510 '580
  STARBOARD_TILT_HORIZONTAL = 1370 '1620
  STARBOARD_TILT_DOWN = 2060 '2500
  STARBOARD_TILT_EDGE_MODE = STARBOARD_TILT_DOWN

  STARBOARD_PAN_REAR_STARBOARD = 500
  STARBOARD_PAN_DUE_STARBOARD = 900
  STARBOARD_PAN_45_STARBOARD = 1315
  STARBOARD_PAN_CENTER = 1650 ' 22.5 degrees
  STARBOARD_PAN_FORWARD = 1800 '1990
  STARBOARD_PAN_PRACTICAL_PORT = 2260
  STARBOARD_PAN_MAX_PORT = 500
  STARBOARD_PAN_EDGE_MODE = STARBOARD_PAN_45_STARBOARD


  MIDDLE_TILT_UP = 840
  MIDDLE_TILT_HORIZONTAL = 1030
  MIDDLE_TILT_DOWN = 1970
  MIDDLE_TILT_DOWN_45 = MIDDLE_TILT_HORIZONTAL + 500 '1360 '330
  
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

  #0, X_DIMENSION, Y_DIMENSION, Z_DIMENSION
  
  PSEUDO_MULTIPLIER = 1000
           
  NUMBER_OF_SHARP_SENSORS = 2
  NUMBER_OF_UNIQUE_ADC = 4
  NUMBER_OF_ADC_VALUES = 8
  NUMBER_OF_PING_SENSORS = 2
  NUMBER_OF_SERVOS = Header#SERVOS_IN_USE

  MAX_SHARP_INDEX = NUMBER_OF_SHARP_SENSORS - 1
  MAX_UNIQUE_ADC_INDEX = NUMBER_OF_UNIQUE_ADC - 1
  MAX_ADC_VALUES_INDEX = NUMBER_OF_ADC_VALUES - 1
  MAX_PING_INDEX = NUMBER_OF_PING_SENSORS - 1
  MAX_SERVO_INDEX = NUMBER_OF_SERVOS - 1

  DEFAULT_SERVO_INIT_DELAY = 500 * MILLISECOND
  
  ' sdFlag enumeration
  #0, NOT_FOUND_SD, IN_USE_SD, INITIALIZING_SD, NEW_LOG_CREATED_SD, LOG_FOUND_SD, {
    } NO_LOG_YET_SD, USED_BY_OTHER_SD

  
  #0, PLAY_BACK_SUCCESS, PLAY_BACK_ERROR_NOT_FOUND, PLAY_BACK_ERROR_OTHER

  #0, MASTER_SERIAL, COM_SERIAL

  #0, MASTER_CONTROL_SERIAL, USB_CONTROL_SERIAL, NO_ACTIVE_CONTROL_SERIAL

  #0, MASTER_COM', GPS_COM
  
  #0, DEBUG_AUX, SR02_AUX', EASY_VR_AUX, EMIC_AUX

CON '' EasyVR Constants

  WORDSET_LABEL_SIZE = 11 ' limit words to ten characters (same limit as GUI)
  LISTENING_TEXT_SIZE = 21
  BASE_TEXT_SIZE = 11
  DEFAULT_WAKE_ATTEMPTS = 8
  TIMEOUT_ATTEMPTS = 3
  LANGUAGE_ATTEMPTS = TIMEOUT_ATTEMPTS
  
  SECONDS_TO_WAIT = 4
  RX_TIME_WAIT = 500
  ATTEMPT_DELAY = 40_000_000
  
  MAX_ERROR_CHARACTERS = 2
  ERROR_BUFFER_SIZE = MAX_ERROR_CHARACTERS + 1
  TEMP_BUFFER_SIZE = 40
  'WORDSET_ATTEMPTS = 8
  'TX_DELAY = 80_000
  QUOTE = 34
  'I_SET_SIZE_0 = 1
  'I_SET_SIZE_1 = 8
  'I_SET_SIZE_2 = 6
  'I_SET_SIZE_3 = 11

  'GROUP_SIZE_1 = 2
  'GROUP_SIZE_2 = 7
  'GROUP_SIZE_3 = 0
  'GROUP_SIZE_PASSWORD = 1
  NOT_LISTENING_SIZE = 1

  LED_ON = 0    ' cathode controlled (common anode) LED use "1" for anode controlled LEDs
  LED_OFF = 1   ' switch these values for common cathode LEDs
    
  ' communication enumeration
  #0, EASYVR_COM, DEBUG_COM

  ' listeningMode enumeration
  #0, LISTEN_FOR_WORDSET_0, LISTEN_FOR_WORDSET_1, LISTEN_FOR_WORDSET_2, {
    } LISTEN_FOR_WORDSET_3, LISTEN_FOR_GROUP_1, LISTEN_FOR_GROUP_2, LISTEN_FOR_GROUP_3, {
    } LISTEN_FOR_GROUP_4, LISTEN_FOR_GROUP_5, LISTEN_FOR_GROUP_6, LISTEN_FOR_GROUP_7, {
    } LISTEN_FOR_GROUP_8, LISTEN_FOR_GROUP_9, LISTEN_FOR_GROUP_10, LISTEN_FOR_GROUP_11, {
    } LISTEN_FOR_GROUP_12, LISTEN_FOR_GROUP_13, LISTEN_FOR_GROUP_14, LISTEN_FOR_GROUP_15, {
    } LISTEN_FOR_PASSWORD, LISTEN_FOR_NOTHING

  INITIAL_MODE = LISTEN_FOR_GROUP_1
  LAST_LISTENING_MODE_INDEX = LISTEN_FOR_NOTHING
  LISTENING_MODES = LAST_LISTENING_MODE_INDEX + 1

  ' wordset1 enumeration
  #0, ACTION_WS1, MOVE_WS1, TURN_WS1, RUN_WS1, LOOK_WS1, ATTACK_WS1, STOP_WS1, HELLO_WS1

  ' wordset2 enumeration
  #0, LEFT_WS2, RIGHT_WS2, UP_WS2, DOWN_WS2, FORWARD_WS2, BACKWARD_WS2

  ' wordset3 enumeration
  #0, ZERO_WS3, ONE_WS3, TWO_WS3, THREE_WS3, FOUR_WS3, FIVE_WS3, SIX_WS3, SEVEN_WS3, {
    } EIGHT_WS3, NINE_WS3, TEN_WS3

  ' group1 enumeration
  #0, LED_G1, OTHER_G1

  ' group2 enumeration
  #0, RED_G2, YELLOW_G2, GREEN_G2, BLUE_G2, VIOLET_G2, OFF_G2, EXIT_G2

  '' Add other group enumerations here.
  
  ' next action enumeration 
  #0, NO_NEXT_ACTION, ACTION_NEXT, MOVE_LEFT_NEXT, MOVE_RIGHT_NEXT, {
    } MOVE_UP_NEXT, MOVE_DOWN_NEXT, MOVE_FORWARD_NEXT, MOVE_BACKWARD_NEXT, {
    } TURN_LEFT_NEXT, TURN_RIGHT_NEXT, TURN_UP_NEXT, TURN_DOWN_NEXT, {
    } TURN_FORWARD_NEXT, TURN_BACKWARD_NEXT, RUN_NEXT, LOOK_LEFT_NEXT, {
    } LOOK_RIGHT_NEXT, LOOK_UP_NEXT, LOOK_DOWN_NEXT, LOOK_FORWARD_NEXT, {
    } LOOK_BACKWARD_NEXT, ATTACK_LEFT_NEXT, ATTACK_RIGHT_NEXT, ATTACK_UP_NEXT, {
    } ATTACK_DOWN_NEXT, ATTACK_FORWARD_NEXT, ATTACK_BACKWARD_NEXT, STOP_NEXT, {
    } HELLO_NEXT, LED_NEXT

  ' numericInputType enumeration
  #0, NO_NUMERIC_INPUT, FIXED_DIGIT_INPUT, TEN_TERMINATED_INPUT
  
CON '' Cog Usage
{{
  The objects, "Com", "Aux", "Ping" and "Servo" each start
  their own cog.
  
  This top object uses two cogs bringing the total of cogs used to 7.

  I still want to add a GPS unit and EasyVR module.
  
}}
VAR

  long error                                            ' Error message pointer for verbose responses  
  long lastUpdated[2]
  
  '' Keep variables below in order.
  long pingCount, pingResults[Header#PINGS_IN_USE]
  long pingStack[PING_STACK_SIZE]
  '' Keep variables above in order.

  long servoControlStack[64]
  
  long activeParameter
  long activeParTxtPtr
 
  long lastComTime

 
  long pingMax[NUMBER_OF_PING_SENSORS], pingMin[NUMBER_OF_PING_SENSORS]
  long headingAtMax[NUMBER_OF_PING_SENSORS], headingAtMin[NUMBER_OF_PING_SENSORS]
  long previousServo[NUMBER_OF_SERVOS]
  long laserRange, loopCount
  long previousDistance[NUMBER_OF_SERVOS], pseudoAcceleration[NUMBER_OF_SERVOS]
  long previousPeriod[NUMBER_OF_SERVOS], servoPatternPeriod
  long servoPattern, previousServoPattern
  long patternPhase
  long segmentPeriodSet[NUMBER_OF_SERVOS], segmentPhaseSet[NUMBER_OF_SERVOS]
  long nextSegmentSet[NUMBER_OF_SERVOS], segmentStartPtrSet[NUMBER_OF_SERVOS]
  long segmentEndPtrSet[NUMBER_OF_SERVOS], activeServoSet[NUMBER_OF_SERVOS]
  long maxActiveServoSetIndex, servoDataPtr
  long mainLoopCount, laserLock
  long laserServos[4], laserDistance
  long laserTargetX, laserTargetY, laserTargetZ
  
  byte pingsInUse, maxPingIndex
  byte inputBuffer[BUFFER_LENGTH], outputBuffer[BUFFER_LENGTH] 
  byte inputIndex, parseIndex, outputIndex
  byte pingPauseFlag
       
DAT '' variables which my have non-zero initial values

pingMask                        long %11
pingInterval                    long PING_INTERVAL
controlInterval                 long _clkfreq / 50
           
maxPowAccel                     long 470        ' Maximum allowed motor power acceleration
maxPosAccel                     long 800        ' Maximum allowed positional acceleration

smallChange                     long 1
bigChange                       long 10

servoMin                        long PORT_PAN_FORWARD, PORT_TILT_UP
                                long MIDDLE_PAN_STARBOARD, MIDDLE_TILT_HORIZONTAL 'MIDDLE_TILT_UP
                                long STARBOARD_PAN_DUE_STARBOARD, STARBOARD_TILT_UP
                                
servoMid                        long PORT_PAN_45_PORT, PORT_TILT_HORIZONTAL
                                long MIDDLE_PAN_CENTER, MIDDLE_TILT_HORIZONTAL
                                long STARBOARD_PAN_45_STARBOARD, STARBOARD_TILT_HORIZONTAL 
                                
servoMax                        long PORT_PAN_DUE_PORT, PORT_TILT_DOWN
                                long MIDDLE_PAN_PORT, MIDDLE_TILT_DOWN_45
                                long STARBOARD_PAN_FORWARD, STARBOARD_TILT_DOWN
                                
servoLowRange                   long 0-0[6]                                
servoHighRange                  long 0-0[6]                                
servoLowSlope                   long 0-0[6]                                
servoHighSlope                  long 0-0[6]
servoSlope                      long 0-0[6]
halfPeriod                      long 0-0[6]
quarterPeriod                   long 0-0[6]
threeQuartersPeriod             long 0-0[6]

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
servoPosition                   long PORT_PAN_CENTER, PORT_TILT_HORIZONTAL
                                long MIDDLE_PAN_CENTER, MIDDLE_TILT_HORIZONTAL
                                long STARBOARD_PAN_CENTER, STARBOARD_TILT_HORIZONTAL

servoPeriod                     long 400, 0
                                long 800, 2300
                                long 400, 0

servoPhase                      long 100, 0
                                long 400, 0
                                long 300, 0
                                                                                                
controlFrequency                long DEFAULT_CONTROL_FREQUENCY
halfInterval                    long DEFAULT_HALF_INTERVAL

stopServoFlag                   long 0

debugFlag                       byte FULL_DEBUG
                      
mode                            byte 0                  ' Current mode of the control system
controlSerial                   byte NO_ACTIVE_CONTROL_SERIAL

activeServo                     byte 6

servoPins                       byte PORT_PAN_PIN, PORT_TILT_PIN
                                byte MIDDLE_PAN_PIN, MIDDLE_TILT_PIN
                                byte STARBOARD_PAN_PIN, STARBOARD_TILT_PIN
                                
OBJ                             
                                
  Header : "HeaderCleaver"         
  
  'Com : "FullDuplexSerial4portB"                        ' uses one cog
  'ComIo : "DataIo4PortB"

  F32 : "F32"
                                                        ' uses one cog
  Aux : "FullDuplexSerial4port"                         ' uses one cog
  AuxIo : "DataIo4Port"
  Ping : "EddiePingMonitor"                             ' uses one cog
  
  Servo : "Servo32v9Shared"                             ' uses one cog

  Leds : "jm_max7219c"
  
  Format : "StrFmt"             ' same formatting code used by serial object so
                                ' so adding this doesn't cost us any RAM.
  
PUB Main 

  {Com.Init ' Initialize MASTER_SERIAL driver
  Com.AddPort(MASTER_COM, Header#SLAVE_FROM_MASTER_RX, Header#SLAVE_TO_MASTER_TX, -1, -1, 0, BAUDMODE, {
  } Header#PROP_TO_PROP_BAUD)}
  {Com.AddPort(0, Header#SR02_RX, Header#SR02_TX, -1, -1, 0, BAUDMODE, {
  } 19200)}
  'Com.Start                                             'Start the ports
 
  Aux.Init
  Aux.AddPort(DEBUG_AUX, Header#USB_RX, Header#USB_TX, -1, -1, 0, BAUDMODE, Header#SLAVE_USB_BAUD)
  'Aux.AddPort(EMIC_AUX, Header#EMIC_RX, Header#EMIC_TX, -1, -1, Com#DEFAULTTHRESHOLD, 0, Header#EMIC_BAUD)
  Aux.AddPort(SR02_AUX, Header#SR02_RX, Header#SR02_TX, -1, -1, Aux#DEFAULTTHRESHOLD, 0, Header#SR02_BAUD)
  'Aux.AddPort(EASY_VR_AUX, Header#EASY_VR_RX, Header#EASY_VR_TX, -1, -1, Com#DEFAULTTHRESHOLD, 0, Header#EASY_VR_BAUD)
  Aux.Start                                         'Start the ports    
 
  Leds.init(Header#SEVEN_SEGMENT_LATCH, Header#SEVEN_SEGMENT_DATA, Header#SEVEN_SEGMENT_CLOCK, 3, 2)
  
  longfill(@pingStack, FILL_LONG, PING_STACK_SIZE)
  Ping.Start(pingMask, pingInterval, @pingResults)
  ' Continuously trigger and read pulse widths on PING))) pins
  pingsInUse := Ping.GetPingsInUse
  maxPingIndex := pingsInUse - 1
  controlSerial := NO_ACTIVE_CONTROL_SERIAL 'DEFAULT_CONTROL_COM
  laserLock := locknew
  
  if debugFlag => INTRO_DEBUG
    Aux.Str(DEBUG_AUX, string(11, 13, "CleaverSlave"))
      
    Aux.Tx(DEBUG_AUX, 7) ' Bell sounds in terminal to catch reset issues
    waitcnt(clkfreq / 4 + cnt)
    Aux.Tx(DEBUG_AUX, 7)
    waitcnt(clkfreq / 4 + cnt)
    Aux.Tx(DEBUG_AUX, 7)

  servoDataPtr := InitializeServos(DEFAULT_SERVO_INIT_DELAY)

  F32.Start
  
  cognew(ServoControl, @servoControlStack)   
  'activeParameter := @targetPower[RIGHT_MOTOR]
  'activeParTxtPtr := @targetPowerRTxt

  MainLoop

PUB MainLoop | rxcheck, lastDebugTime

  Aux.Str(DEBUG_AUX, string(11, 13, "Starting MainLoop"))  
  lastComTime := cnt
  repeat
    mainLoopCount++
    Aux.Str(DEBUG_AUX, string(11, 13, "mainLoopCount"))
    AuxIo.Dec(DEBUG_AUX, mainLoopCount) 
    result := CheckSerial
    DigestCharacter(result)

    'Aux.Str(DEBUG_AUX, string(11, 13, "Before GetLaserRange call."))
    
    laserDistance := GetLaserRange
    'Aux.Str(DEBUG_AUX, string(11, 13, "After GetLaserRange call."))
    if laserDistance <> Header#INVALID_LASER_READING
      CalculateLaserPosition(laserDistance, @laserTargetX)
      'Com.Str(string("LSR "))
      
    if debugFlag => MAIN_DEBUG
      TempDebug
        
PUB CheckSerial : rxcheck
      
  if controlSerial == NO_ACTIVE_CONTROL_SERIAL or controlSerial == MASTER_CONTROL_SERIAL
    rxcheck := -1 'Com.RxCheck(MASTER_COM) ***
    if rxcheck <> -1
      controlSerial := MASTER_CONTROL_SERIAL
    { 'if debugFlag => PROP_CHARACTER_DEBUG
      '  Aux.Str(DEBUG_AUX, string(11, 13, "From Prop:", 34))
      '  Aux.Tx(DEBUG_AUX, rxcheck)
      '  Aux.Tx(DEBUG_AUX, 34)}
  if controlSerial == NO_ACTIVE_CONTROL_SERIAL or controlSerial == USB_CONTROL_SERIAL
    rxcheck := Aux.RxCheck(DEBUG_AUX) 
    if rxcheck <> -1
      controlSerial := USB_CONTROL_SERIAL
     
PUB DigestCharacter(localCharacter)

  if localCharacter < 0
    return
  else
    inputBuffer[inputIndex++] := localCharacter
       
  if inputIndex == constant(BUFFER_LENGTH)            ' Check for a full buffer
    OutputStr(@nack)                                  ' Ready error response
    Aux.Str(DEBUG_AUX, @overflow)
    'OutputStr(@overflow)
    repeat                                            ' Ignore all inputs other than NUL or CR (terminating a command) 
      case Rx(controlSerial)                          ' Send the correct error response for the transmission mode
        {
        NUL :                                         '   Checksum mode
          SendChecksumResponse
          quit
        }
        CR :                                          '   Plain text mode
          SendResponse(controlSerial)
          quit
    controlSerial := NO_ACTIVE_CONTROL_SERIAL      
  else                                                ' If there isn't a buffer overflow...                              
    case localCharacter                  ' Parse the character
      
      NUL :                                           ' End command in checksum mode:
        if debugFlag => INPUT_WARNINGS_DEBUG
          Aux.Str(DEBUG_AUX, string(11, 13, 7, "Error, NUL character received.", 7))
          Aux.Str(DEBUG_AUX, Error)
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
          ifnot inputIndex
            controlSerial := NO_ACTIVE_CONTROL_SERIAL
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
            Aux.Str(DEBUG_AUX, error)
            'if verbose
              'OutputStr(error)
   
          SendResponse(controlSerial) '   Send a response if no error
         
        else                                          '   For an empty buffer, clear the pointer
          inputIndex~                                 '   to start receiving a new command
        controlSerial := NO_ACTIVE_CONTROL_SERIAL
         
      1..BEL, 10..12, 14..31, 127..255 :            ' Ignore invalid characters
        if debugFlag => INPUT_WARNINGS_DEBUG
          Aux.Str(DEBUG_AUX, string(11, 13, 7, "Invalid Character Error = <$"))
          AuxIo.Hex(DEBUG_AUX, localCharacter, 2)
          Aux.Tx(DEBUG_AUX, ">")
          inputIndex--
          waitcnt(clkfreq / 2 + cnt)

PRI UpdateActive(changeAmount)

  if inputIndex == 1
    long[activeParameter] += changeAmount
    if activeParameter == @servoPosition[activeServo]
      Servo.Set(servoPins[activeServo], servoPosition[activeServo])
    elseif activeParameter == @controlFrequency
      halfInterval := clkfreq / controlFrequency / 2
    elseif activeParTxtPtr == @kProportionalTxt 
      long[activeParameter + 4] += changeAmount ' adjust right also
    inputIndex--
    controlSerial := NO_ACTIVE_CONTROL_SERIAL
    lastComTime := cnt

PRI TempDebug
    
  Aux.Tx(DEBUG_AUX, 11)
  Aux.Tx(DEBUG_AUX, 1) ' home
  Aux.Str(DEBUG_AUX, string(11, 13, "CleaverSlave"))

  Aux.Str(DEBUG_AUX, string(", mode = "))
  AuxIo.Dec(DEBUG_AUX, mode)
  Aux.Str(DEBUG_AUX, string(" = "))
  Aux.Str(DEBUG_AUX, FindString(@modeAsText, mode)) 
      'controlSerialTxt
  Aux.Str(DEBUG_AUX, string(11, 13, "activeParameter = "))
  Aux.Str(DEBUG_AUX, activeParTxtPtr)  
  Aux.Str(DEBUG_AUX, string(" = "))
  AuxIo.Dec(DEBUG_AUX, long[activeParameter])   
  Aux.Str(DEBUG_AUX, string(11, 13, "mainLoopCount = "))
  AuxIo.Dec(DEBUG_AUX, mainLoopCount)  
  DisplayServoData

  DisplayLaserData
  
   {
  if debugFlag => PING_DEBUG
    Aux.Str(DEBUG_AUX, string(11, 13, "pingCount = "))
    AuxIo.Dec(DEBUG_AUX, pingCount)
    Aux.Str(DEBUG_AUX, string(", pingMask = "))
    AuxIo.Dec(DEBUG_AUX, pingMask)
    Aux.Str(DEBUG_AUX, string(", pingInterval = "))
    AuxIo.Dec(DEBUG_AUX, pingInterval)
    
    Aux.Str(DEBUG_AUX, string(", pingResults = "))
    AuxIo.Dec(DEBUG_AUX, pingResults[0])
    Aux.Str(DEBUG_AUX, string(", "))
    AuxIo.Dec(DEBUG_AUX, pingResults[1])
   }
  'PingStackDebug(port) 
                
  Aux.Tx(DEBUG_AUX, 11)
  Aux.Tx(DEBUG_AUX, 13)
      
PUB DisplayServoData

  Aux.Str(DEBUG_AUX, string(11, 13, "DisplayServoData"))  
  repeat result from 0 to 5
    Aux.Str(DEBUG_AUX, string(11, 13, "servoPosition["))
    AuxIo.Dec(DEBUG_AUX, result)
    Aux.Str(DEBUG_AUX, string("] = "))
    AuxIo.Dec(DEBUG_AUX, servoPosition[result]) 
    Aux.Str(DEBUG_AUX, string(", servoPeriod = "))
    AuxIo.Dec(DEBUG_AUX, servoPeriod[result]) 
    Aux.Str(DEBUG_AUX, string(", servoPhase = "))
    AuxIo.Dec(DEBUG_AUX, servoPhase[result]) 
       
PUB DisplayLaserData

  if laserDistance == Header#INVALID_LASER_READING
    Aux.Str(DEBUG_AUX, string(11, 13, "Laser Data Invalid"))
    return
  Aux.Str(DEBUG_AUX, string(11, 13, "laserDistance = "))
  AuxIo.Dec(DEBUG_AUX, laserDistance) 
  
  Aux.Str(DEBUG_AUX, string(11, 13, "Laser Target (XYZ) = "))
  AuxIo.Dec(DEBUG_AUX, laserTargetX)
  Aux.Str(DEBUG_AUX, string(", "))
  AuxIo.Dec(DEBUG_AUX, laserTargetY)
  Aux.Str(DEBUG_AUX, string(", "))
  AuxIo.Dec(DEBUG_AUX, laserTargetZ)
  Leds.Dec(2, laserTargetX) 
  Leds.Dec(1, laserTargetY) 
  Leds.Dec(0, laserTargetZ) 
  Aux.Str(DEBUG_AUX, string(11, 13, "Laser Servos Pan  = "))
  AuxIo.Dec(DEBUG_AUX, laserServos[0])
  Aux.Str(DEBUG_AUX, string(" & "))
  AuxIo.Dec(DEBUG_AUX, laserServos[2])
  Aux.Str(DEBUG_AUX, string(", ave = "))
  AuxIo.Dec(DEBUG_AUX, (laserServos[0] + laserServos[2]) / 2)
  Aux.Str(DEBUG_AUX, string(11, 13, "Laser Servos Tilt = "))
  AuxIo.Dec(DEBUG_AUX, laserServos[1])
  Aux.Str(DEBUG_AUX, string(" & "))
  AuxIo.Dec(DEBUG_AUX, laserServos[3])
  Aux.Str(DEBUG_AUX, string(", ave = "))
  AuxIo.Dec(DEBUG_AUX, (laserServos[1] + laserServos[3]) / 2)

PUB PingStackDebug(port)

  Aux.Str(DEBUG_AUX, string(11, 13, "Ping Stack = ", 11, 13))
  DumpBufferLong(@pingStack, PING_STACK_SIZE, 12)

PUB DumpBuffer(bufferPtr, bufferSize, interestedLocationPtr, offset) : localIndex

  bufferSize--

  repeat localIndex from 0 to bufferSize
    if long[interestedLocationPtr] - offset == localIndex
      Aux.Tx(DEBUG_AUX, "*")
    AuxIo.Dec(DEBUG_AUX, long[bufferPtr][localIndex])
    
    if localIndex // 8 == 7 and localIndex <> bufferSize
      Aux.Tx(DEBUG_AUX, 11)
      Aux.Tx(DEBUG_AUX, 13)
    elseif localIndex <> bufferSize  
      Aux.Tx(DEBUG_AUX, ",")
      Aux.Tx(DEBUG_AUX, 32)  

PRI DumpBufferLong(localPtr, localSize, localColumns) | localIndex

 
  Aux.Str(DEBUG_AUX, string("DumpBufferLong @ $"))
  AuxIo.Dec(DEBUG_AUX, localPtr)

  Aux.Tx(DEBUG_AUX, 11) 
  
  repeat localIndex from 0 to localSize - 1
    if localIndex // localColumns == 0
      Aux.Tx(DEBUG_AUX, 11) 
      Aux.Tx(DEBUG_AUX, 13) 
    else
      Aux.Tx(DEBUG_AUX, 32)  
    Aux.Tx(DEBUG_AUX, "$")  
    AuxIo.Hex(DEBUG_AUX, long[localPtr][localIndex], 8)

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
    
PUB SafeDebug(ptr, size)

  repeat size
    SafeTx(byte[ptr++])
    
PUB SafeTx(character)

  case character
    32.."~":
      Aux.Tx(DEBUG_AUX, character)
    other:
      Aux.Tx(DEBUG_AUX, "<")
      Aux.Tx(DEBUG_AUX, "$")
      AuxIo.Hex(DEBUG_AUX, character, 2)
      Aux.Tx(DEBUG_AUX, ">")
      
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
    Servo.Set(servoPins[parameter[0]], parameter[1])
    activeServo := parameter[0]
    servoPosition[parameter[0]] := parameter[1]
    activeParameter := @servoPosition[parameter[0]]
    activeParTxtPtr := @servoTxt
    servoTxt[ACTIVE_SERVO_POS_IN_SERVOTXT] := "0" + activeServo ' insert servo #
          
  elseif strcomp(@InputBuffer, string("SMALL"))        
    parameter := ParseDec(NextParameter)
    CheckLastParameter
    smallChange := parameter
  elseif strcomp(@InputBuffer, string("X"))             ' Command: Stop the motors now.
    CheckLastParameter
    !stopServoFlag
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
    Aux.Str(DEBUG_AUX, string(11, 13, "ParseDec"))
  repeat 11
    if debugFlag => PARSE_DEC_DEBUG
      Aux.Str(DEBUG_AUX, string(", byte[] ="))
      SafeTx(byte[pointer])
      'Aux.E
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

PRI Rx(serialDriver)

  if serialDriver == USB_CONTROL_SERIAL
    'Aux.Lock
    result := Aux.Rx(DEBUG_AUX)
    'Aux.E
  else
    'Com.Lock  
    '''result := Com.Rx(MASTER_COM)
    'Com.E
    
PRI SendResponse(serialDriver)  '' Transmit the string in the output buffer and clear the buffer

  if serialDriver == USB_CONTROL_SERIAL
    'Aux.Lock
    Aux.Str(DEBUG_AUX, @outputBuffer)  ' Transmit the buffer contents
    Aux.Str(DEBUG_AUX, @prompt)       ' Transmit the prompt
  else
    'Com.Lock
    '''Com.Str(MASTER_COM, @outputBuffer)  ' Transmit the buffer contents
    '''Com.Str(MASTER_COM, @prompt)       ' Transmit the prompt
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
'*** Make sure and turn of the EasyVR module while the Emic2 is speaking.

  return {
  Aux.Tx(EMIC_AUX, "S")
  Aux.Str(EMIC_AUX, FindString(@introEmic, messageId))
  if value <> posx
    AuxIo.Dec(EMIC_AUX, value)
  Aux.Tx(EMIC_AUX, 13)

  result := Aux.Rx(EMIC_AUX)
       }
PRI ServoControl | nextCnt

  nextCnt := cnt + controlInterval
  repeat
    waitcnt(nextCnt += controlInterval)
    AdvanceServos
    repeat while stopServoFlag
      nextCnt := cnt + controlInterval
      
PUB AdvanceServos

  repeat result from 0 to 5
    servoPhase[result]++
    if servoPhase[result] => servoPeriod[result]
      servoPhase[result] := 0
    if servoPeriod[result]  
      PositionServo(result, LINEAR_RAMP) 'ACCELERATION_RAMP) ' 

PUB UpdateServos : servoIndex

  repeat servoIndex from 0 to MAX_SERVO_INDEX
    Servo.Set(servoPins[servoIndex], servoPosition[servoIndex])  

PUB InitializeServos(interServoDelay) | servoIndex

  result := Servo.Start
  repeat servoIndex from 0 to MAX_SERVO_INDEX
    waitcnt(interServoDelay + cnt)
    servoLowRange[servoIndex] := servoMid[servoIndex] - servoMin[servoIndex]
    servoHighRange[servoIndex] := servoMax[servoIndex] - servoMid[servoIndex]                        
    if servoPeriod[servoIndex]                            
      servoLowSlope[servoIndex] := SCALED_MULTIPLIER * 4 * servoLowRange[servoIndex] / {
      } servoPeriod[servoIndex]
      servoHighSlope[servoIndex] := SCALED_MULTIPLIER * 4 * servoHighRange[servoIndex] / {
      } servoPeriod[servoIndex]
      servoSlope[servoIndex] := SCALED_MULTIPLIER * 2 * (servoMax[servoIndex] - {
      } servoMin[servoIndex]) / servoPeriod[servoIndex]
      pseudoAcceleration[servoIndex] := PSEUDO_MULTIPLIER * 8 * (servoMax[servoIndex] - {
      } servoMin[servoIndex]) / (servoPeriod[servoIndex] * servoPeriod[servoIndex])
    else
      servoLowSlope[servoIndex] := 0
      servoHighSlope[servoIndex] := 0
      servoSlope[servoIndex] := 0
      pseudoAcceleration[servoIndex] := 0
    halfPeriod[servoIndex] := DivideWithRound(servoPeriod[servoIndex], 2)
    quarterPeriod[servoIndex] := DivideWithRound(servoPeriod[servoIndex], 4)
    threeQuartersPeriod[servoIndex] := DivideWithRound(servoPeriod[servoIndex] * 3, 4)
     
    Servo.Set(servoPins[servoIndex], servoPosition[servoIndex])  

{PUB SetServos(servosId, positionPtr) | lowestId, highestId, servoIndexStep

  case servosId
    PORT_PAN_SERVO..STARBOARD_TILT_SERVO:
      lowestId := servosId
      highestId := servosId
      servoIndexStep := 1
    ALL_SERVOS:
      lowestId := 0
      highestId := MAX_SERVO_INDEX
      servoIndexStep := 1
    PAN_SERVOS:
      lowestId := 0
      highestId := MAX_SERVO_INDEX - 1
      servoIndexStep := 2
    TILT_SERVOS:
      lowestId := 1
      highestId := MAX_SERVO_INDEX
      servoIndexStep := 2
    PORT_SERVOS:
      lowestId := PORT_PAN_SERVO
      highestId := PORT_TILT_SERVO
      servoIndexStep := 1
    MIDDLE_SERVOS:
      lowestId := MIDDLE_PAN_SERVO
      highestId := MIDDLE_TILT_SERVO
      servoIndexStep := 1
    STARBOARD_SERVOS:
      lowestId := STARBOARD_PAN_SERVO
      highestId := STARBOARD_TILT_SERVO
      servoIndexStep := 1
       }
  ' ** still need to set the positions
    
{PUB PositionServos(servosId, startPtr, endPtr, phase, period, rampType) | start, end, {
} lowestId, highestId, servoIndexStep

  case servosId
    PORT_PAN_SERVO..STARBOARD_TILT_SERVO:
      lowestId := servosId
      highestId := servosId
      servoIndexStep := 1
    ALL_SERVOS:
      lowestId := 0
      highestId := MAX_SERVO_INDEX
      servoIndexStep := 1
    PAN_SERVOS:
      lowestId := 0
      highestId := MAX_SERVO_INDEX - 1
      servoIndexStep := 2
    TILT_SERVOS:
      lowestId := 1
      highestId := MAX_SERVO_INDEX
      servoIndexStep := 2
    PORT_SERVOS:
      lowestId := PORT_PAN_SERVO
      highestId := PORT_TILT_SERVO
      servoIndexStep := 1
    MIDDLE_SERVOS:
      lowestId := MIDDLE_PAN_SERVO
      highestId := MIDDLE_TILT_SERVO
      servoIndexStep := 1
    STARBOARD_SERVOS:
      lowestId := STARBOARD_PAN_SERVO
      highestId := STARBOARD_TILT_SERVO
      servoIndexStep := 1

  if phase == 0 or phase == period
    'SendServos(lowestId, highestId, servoIndexStep, startPtr)
  elseif phase == (period + 1) / 2 
    'SendServos(lowestId, highestId, servoIndexStep, endPtr)
  else  
    repeat servosId from lowestId to highestId step servoIndexStep
      result := PositionServo(servosId, LINEAR_RAMP)
      'SendServo(servosId, result)
             }
PRI PositionServo(servoIndex, rampType) : position {| halfPeriod, {
} quarterPeriod, threeQuartersPeriod, halfway, distance, halfDistance, roundTripDistance }
'' If period had the value of 2 (min allowed)
'' then when phase equals zero the position would be
'' the start position (as it will whenever phase is zero)
'' The position will always be end when phase equals
'' half the period.

  case rampType
    LINEAR_RAMP:
      PositionServoLinear(servoIndex)
    ACCELERATION_RAMP:
      PositionServoAccelerate(servoIndex)
  {case servoIndex
    2, 3:
      repeat until not lockset(laserLock) }   
  Servo.Set(servoPins[servoIndex], servoPosition[servoIndex])
  {case servoIndex
    2, 3:
      lockclr(laserLock)  }
PRI PositionServoLinear(servoIndex)

  if servoPhase[servoIndex] < halfPeriod[servoIndex]
    servoPosition[servoIndex] := servoMin[servoIndex] + ((servoSlope[servoIndex] * {
    } servoPhase[servoIndex]) / SCALED_MULTIPLIER)
  else
    servoPosition[servoIndex] := servoMax[servoIndex] - ((servoSlope[servoIndex] * {
    } (servoPhase[servoIndex] - halfPeriod[servoIndex])) / SCALED_MULTIPLIER)
  
  
PRI PositionServoLinearOld(servoIndex)

  if servoPhase[servoIndex] == 0 
    servoPosition[servoIndex] := servoMin[servoIndex]
  elseif servoPhase[servoIndex] < quarterPeriod[servoIndex]
    servoPosition[servoIndex] := servoMin[servoIndex] + ((servoLowSlope[servoIndex] * {
    } servoPhase[servoIndex]) / SCALED_MULTIPLIER)
  elseif servoPhase[servoIndex] == quarterPeriod[servoIndex]
    servoPosition[servoIndex] := servoMid[servoIndex]
  elseif servoPhase[servoIndex] < halfPeriod[servoIndex]
    servoPosition[servoIndex] := servoMid[servoIndex] + ((servoHighSlope[servoIndex] * {
    } (servoPhase[servoIndex] - quarterPeriod[servoIndex])) / SCALED_MULTIPLIER)
  elseif servoPhase[servoIndex] == halfPeriod[servoIndex]
    servoPosition[servoIndex] := servoMax[servoIndex]
  elseif servoPhase[servoIndex] < threeQuartersPeriod[servoIndex]
    servoPosition[servoIndex] := servoMax[servoIndex] - ((servoHighSlope[servoIndex] * {
    } (servoPhase[servoIndex] - halfPeriod[servoIndex])) / SCALED_MULTIPLIER)
  elseif servoPhase[servoIndex] == threeQuartersPeriod[servoIndex]
    servoPosition[servoIndex] := servoMid[servoIndex]
  else
    servoPosition[servoIndex] := servoMid[servoIndex] - ((servoLowSlope[servoIndex] * {
    } (servoPhase[servoIndex] - threeQuartersPeriod[servoIndex])) / SCALED_MULTIPLIER)
  
  
PRI PositionServoAccelerate(servoIndex)

  PositionServoLinear(servoIndex)

  {if distance <> previousDistance[servoIndex] or {
    } period <> previousPeriod[servoIndex] 
    'pseudoAcceleration[servoIndex] := pseudoHalfDistance / (quarterPeriod * quarterPeriod)
    'equation below should be the same as the one above with less rounding error
    pseudoAcceleration[servoIndex] := distance * PSEUDO_MULTIPLIER * 8 / (period * period)
    previousDistance[servoIndex] := distance
    previousPeriod[servoIndex] := period    }
  if servoPhase[servoIndex] < quarterPeriod[servoIndex]
    servoPosition[servoIndex] := SpeedUp(servoIndex)
  elseif servoPhase[servoIndex] < halfPeriod[servoIndex]
    servoPosition[servoIndex] := SlowDown(servoIndex)
  elseif servoPhase[servoIndex] < threeQuartersPeriod[servoIndex]
    servoPosition[servoIndex] := SpeedBackUp(servoIndex)
  else
    servoPosition[servoIndex] := SlowBackDown(servoIndex) 
          
PRI SpeedUp(servoIndex) 
' y = 1/2 a t^2
' a = 2*y / t*t
' distance = 2*y
' formula should really use quarterPeriod and halfDistance but
' we'll use period, distance and scale result

  result := servoMin[servoIndex] + (pseudoAcceleration[servoIndex] * {
  } servoPhase[servoIndex] * servoPhase[servoIndex] / PSEUDO_MULTIPLIER) 
  
PRI SlowDown(servoIndex) | phase

  phase := halfPeriod[servoIndex] - servoPhase[servoIndex]
  result := servoMax[servoIndex] - (pseudoAcceleration[servoIndex] * phase * phase / {
  } PSEUDO_MULTIPLIER) 
  
PRI SpeedBackUp(servoIndex) | phase

  phase := servoPhase[servoIndex] - halfPeriod[servoIndex]
  result := servoMax[servoIndex] - (pseudoAcceleration[servoIndex] * phase * phase / {
  } PSEUDO_MULTIPLIER) 
  
PRI SlowBackDown(servoIndex) | phase

  phase := servoPeriod[servoIndex] - servoPhase[servoIndex]
  result := servoMin[servoIndex] + (pseudoAcceleration[servoIndex] * phase * phase / {
  } PSEUDO_MULTIPLIER) 

PUB AngleToPulse(fAngle)                       
'' Return integer pulse length based on floating point angle (in radians).

  result := F32.FRound(F32.FMul(fAngle, Header#F_US_PER_RADIAN)) 
   
PUB GetLaserRange | inputcharacter, newData

  Aux.Str(DEBUG_AUX, string(11, 13, "Start of GetLaserRange method."))
  'dira[SR02_TRIGGER_PIN] := 1
  'Aux.E
  'repeat until not lockset(laserLock)
  'repeat while lockset(laserLock)
  
  Aux.Tx(SR02_AUX, "D")
  longmove(@laserServos, @servoPosition[2], 2)
  
  'Com.Tx(0, "D")
  Aux.Str(DEBUG_AUX, string(11, 13, "After Tx call."))
  if debugFlag
    Aux.Str(DEBUG_AUX, string(11, 13, "GetLaserRange"))
  'dira[SR02_TRIGGER_PIN] := 0
  newData := 0
  repeat
    'if debugFlag
      'Aux.Str(DEBUG_AUX, string(11, 13, "Before RxTime Call.")) 
    inputcharacter := Aux.RxTime(SR02_AUX, 100)
    ifnot newData
      'lockclr(laserLock)
      longmove(@laserServos[2], @servoPosition[2], 2)
  
      newData := 1
    'inputcharacter := Com.RxTime(0, 100)
    'inputcharacter := Aux.RxCheck(SR02_AUX)
    'Aux.Str(DEBUG_AUX, string(11, 13, "After RxTime Call.")) 
    if debugFlag
      SafeTx(inputcharacter)
    'Aux.Str(DEBUG_AUX, string(11, 13, "After SafeTx Call.")) 
    case inputcharacter
      "0".."9":
        
        result := (result * 10) + (inputcharacter - "0") 
  until inputcharacter == 13 or inputcharacter == -1
  if debugFlag
    Aux.Str(DEBUG_AUX, string(11, 13, "laserRange = "))
    AuxIo.Dec(DEBUG_AUX, result)

PUB CalculateLaserPosition(distance, resultPointer) | servoAverages[2], gndD

  Aux.Str(DEBUG_AUX, string(11, 13, "CalculateLaserPosition, distance  = "))
  AuxIo.Dec(DEBUG_AUX, distance)
  Aux.Str(DEBUG_AUX, string(" cm"))   
  repeat result from 0 to 1
    servoAverages[result] := (laserServos[result] + laserServos[result + 2]) / 2

  {servoAverages[0] := F32.FMul(Header#F_RADIAN_PER_US, F32.FFloat(MIDDLE_PAN_CENTER - {
  } servoAverages[0]))
  servoAverages[1] := F32.FMul(Header#F_RADIAN_PER_US, F32.FFloat(servoAverages[1] - {
  } MIDDLE_TILT_DOWN))
  }
  servoAverages[0] := F32.FMul(Header#F_RADIAN_PER_US, F32.FFloat(MIDDLE_PAN_CENTER - {
  } servoAverages[0]))
  servoAverages[1] := F32.FMul(Header#F_RADIAN_PER_US, F32.FFloat(servoAverages[1] - {
  } MIDDLE_TILT_DOWN))
  
  distance := F32.FFloat(distance * 10)
  gndD := F32.FMul(distance, F32.Cos(servoAverages[1]))
  {long[resultPointer][Z_DIMENSION] := F32.FRound(F32.FSub(Header#F_LASER_HEIGHT, F32.FMul(distance, {
  } F32.Sin(servoAverages[1]))))}
  long[resultPointer][Z_DIMENSION] := F32.FRound(F32.FSub(Header#F_LASER_HEIGHT, F32.FMul(distance, {
  } F32.Sin(servoAverages[1]))))
  long[resultPointer][X_DIMENSION] := F32.FRound(F32.FMul(distance, F32.Cos(servoAverages[0])))
  long[resultPointer][Y_DIMENSION] := F32.FRound(F32.FMul(distance, F32.Sin(servoAverages[0])))


  Aux.Str(DEBUG_AUX, string(11, 13, "Laser Servos Pan  = "))
  AuxIo.Dec(DEBUG_AUX, laserServos[0])
  Aux.Str(DEBUG_AUX, string(" & "))
  AuxIo.Dec(DEBUG_AUX, laserServos[2])
  Aux.Str(DEBUG_AUX, string(", ave = "))
  AuxIo.Dec(DEBUG_AUX, (laserServos[0] + laserServos[2]) / 2)
  Aux.Str(DEBUG_AUX, string(11, 13, "Laser Servos Tilt = "))
  AuxIo.Dec(DEBUG_AUX, laserServos[1])
  Aux.Str(DEBUG_AUX, string(" & "))
  AuxIo.Dec(DEBUG_AUX, laserServos[3])
  Aux.Str(DEBUG_AUX, string(", ave = "))
  AuxIo.Dec(DEBUG_AUX, (laserServos[1] + laserServos[3]) / 2)
  
PUB GetPing(numberOfSensors, pointer)
'' Is this method really needed?
'' Yes, it will eventually do more.
  Aux.Str(DEBUG_AUX, string(11, 13, "GetPing("))
  AuxIo.Dec(DEBUG_AUX, numberOfSensors)
  Aux.Str(DEBUG_AUX, string(", $"))
  AuxIo.Hex(DEBUG_AUX, pointer, 4)
  Aux.Tx(DEBUG_AUX, ")")
  ' ** currently this code is useless
  'Aux.Str(DEBUG_AUX, string(11, 13, "pingNew = "))
  'AuxIo.Dec(DEBUG_AUX, pingNew[0])
  'Aux.Str(DEBUG_AUX, string(", "))
  'AuxIo.Dec(DEBUG_AUX, pingNew[1])
   

PUB DivideWithRound(numerator, denominator)

  numerator += denominator
  result := numerator / denominator

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

serialTxt                       byte "COM_SERIAL", 0
                                byte "AUX_SERIAL", 0
                                                                
controlSerialTxt                byte "MASTER_CONTROL_SERIAL", 0
                                byte "USB_CONTROL_SERIAL", 0
                                byte "NO_ACTIVE_CONTROL_SERIAL", 0

                                
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
                                