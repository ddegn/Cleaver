CON{{ ****** Public Notes ******  
}}
CON 
  
  _clkmode = xtal1 + pll16x
  _clkfreq = 80_000_000

  MICROSECOND = _clkfreq / 1_000_000
  MILLISECOND = _clkfreq / 1000

  ' Settings
  BUFFER_LENGTH = 255           ' Input Buffer Length must fit within input/output 'Index' ranges (currently a byte)
  ERROR_BUFFER_SIZE = 128        ' Size of buffer to save bad commands. (Most commands aren't long.)
  OUTPUT_COPY_BUFFER_SIZE = ERROR_BUFFER_SIZE
  PREVIOUS_BUFFER_SIZE = ERROR_BUFFER_SIZE
 
  SCALED_MULTIPLIER = 1000
  SCALED_TAU = 6_283            ' circumfrence / radius
  SCALED_CIRCLE = 360 * SCALED_MULTIPLIER
  SMALL_ARC_THRESHOLD = posx / (SCALED_MULTIPLIER * SCALED_TAU) '341 
     
  SCALED_ROBOT_CIRCUMFERENCE = Header#POSITIONS_PER_ROTATION * SCALED_MULTIPLIER / 2

  ' Motor names
  #0
  LEFT_MOTOR
  RIGHT_MOTOR

  ' Motor control modes
  #0
  POWER
  SPEED
  STOPPING
  POSITION
 
 
  ' I2C EEPROM
  SCL = 28
  SDA = 29

  I2C_CLOCK = 9
  I2C_DATA = 10

  LED_PIN = 8
  LEDS_IN_USE = 10
  MAX_LED_INDEX = LEDS_IN_USE
  DEFAULT_BRIGHTNESS = $3F
  #0, FROM_INPUT_LED, DISPLAY_POSITION_ERROR_LED
  DEFAULT_LED_MODE = DISPLAY_POSITION_ERROR_LED 'FROM_INPUT_LED '

  PING_INTERVAL = 20            ' in milliseconds
  '**141220e MIN_PING = Ping#MIN_PING
  '**141220e MAX_PING = Ping#MAX_PING

  ' ASCII commands
  NUL           = $00           ' Null character
  SOH           = $01           ' Start of Header
  STX           = $02           ' Start of Text
  ETX           = $03           ' End of Text
  EOT           = $04           ' End of Transmission
  ENQ           = $05           ' Enquiry
  ACK           = $06           ' Acknowledgment
  BEL           = $07           ' Bell
  BS            = $08           ' Backspace
  HT            = $09           ' Horizontal Tab
  LF            = $0A           ' Line feed
  VT            = $0B           ' Vertical Tab
  FF            = $0C           ' Form feed
  CR            = $0D           ' Carriage return
  SO            = $0E           ' Shift Out
  SI            = $0F           ' Shift In
  DLE           = $10           ' Data Link Escape
  DC1           = $11           ' Device Control 1 (i.e. XON)
  DC2           = $12           ' Device Control 2
  DC3           = $13           ' Device Control 3 (i.e. XOFF)
  DC4           = $14           ' Device Control 4
  NAK           = $15           ' Negative Acknowledgment
  SYN           = $16           ' Synchronous idle
  ETB           = $17           ' End of Transmission Block
  CAN           = $18           ' Cancel
  EM            = $19           ' End of Medium
  SB            = $1A           ' Substitute
  ESC           = $1B           ' Escape
  FS            = $1C           ' File Separator
  GS            = $1D           ' Group Separator
  RS            = $1E           ' Record Separator
  US            = $1F           ' Unit Separator
  DEL           = $7F           ' Delete

  QUOTE = 34 ' $22
  
  ' EEPROM constants
  I2C_ACK       = 0
  I2C_NACK      = 1
  DEVICE_CODE   = %0110 << 4
  PAGE_SIZE     = 128

  MAX_POWER = Header#MAX_POWER '7520 
  MIN_POWER = -MAX_POWER 
  
  MAX_INPUT_POWER = 127  ' Max allowed by "GO" command
  MIN_INPUT_POWER = -127
  ' "MAX_INPUT_POWER" and "MIN_INPUT_POWER" use
  ' values defined by the "Eddie Command Set"
  ' document published by Parallax.
  ' This is an arbitrary value when using this
  ' version of the firmware. 

  MAX_INPUT_SPEED = 127  ' Max allowed by "GOSPD" command
                         ' It's likely only values up to 100
                         ' will be matched.
  MIN_INPUT_SPEED = -MAX_INPUT_SPEED

  MAX_ARC_SPEED = 100

  MAX_RC_SPEED = 110
  
  SCALED_MAX_ARC_SPEED = SCALED_MULTIPLIER * MAX_ARC_SPEED
  '' The motors generally can not produce speeds matching "MAX_INPUT_SPEED".
  '' This can result is deformed arcs as the "fastMotor" does
  '' not reach the desired speed. By limiting the the value
  '' of "MAX_ARC_SPEED" to a realalist speed, the shape of the
  '' arcs should be improved.
           
  CONTROL_FREQUENCY = 50 ' Iterations per second
  HALF_SEC = CONTROL_FREQUENCY / 2   ' Iterations per unit 'dwd 141118b good name?
  'HALF_SEC changed to in some locations.
  SPEED_BUFFER_SIZE = CONTROL_FREQUENCY / 2
  POSITION_BUFFER_SIZE = CONTROL_FREQUENCY / 2
  'X_BUFFER_BITS = 4
  X_BUFFER_SIZE = HALF_SEC '1 << X_BUFFER_BITS
  'X_BUFFER_LIMIT = X_BUFFER_SIZE - 1

  'BUFFER_BITS = 4
  'SPEED_BUFFER_SIZE = 1 << BUFFER_BITS 'CONTROL_FREQUENCY / 2
  'ACCELERATION_BUFFER_SIZE = SPEED_BUFFER_SIZE
  DEADZONE      = 1 '* FOUR
  SAFEZONE      = 10
  PROMPT_SUM    = $0
  DEFAULT_CONTROL_FREQUENCY = 50
  DEFAULT_CONTROL_INTERVAL = _clkfreq / CONTROL_FREQUENCY
  DEFAULT_HALF_INTERVAL = DEFAULT_CONTROL_INTERVAL / 2 ' 1/100 of a second
  'DEFAULT_MAX_USEFUL_SPEED = 470
  CONTROL_CYCLES_TIL_FULL_POWER = CONTROL_FREQUENCY * 2
  CONTROL_CYCLES_TIL_FULL_SPEED = CONTROL_CYCLES_TIL_FULL_POWER
  'MAX_ENCODER_TICKS_PER_S = 200 ' can be 250 but use 200 to keep number managable (round)
  '' 200 encoder ticks per second equates to a measured speed of 10,000
  
  ' **141225c MAX_RAW_MEASURED_SPEED = 100 ' maxRawMeasuredSpeed this figure is not precise
                               ' the raw speed can be high as 125
                               
  ' 141209f This value is corresponds to an adjusted speed of 10,000
  ' This is 100 encoder ticks per half second (or 200 ticks per second).
  ' **141225c MAX_TIME_TO_WAIT_FOR_ENCODER = _CLKFREQ / 4 '_CLKFREQ / 2
  ' **141225c STOPPED_ENCODER_WAIT_TIME = _CLKFREQ / DEFAULT_CONTROL_FREQUENCY
  SECONDS_UNTIL_SHUTDOWN = 2
  '' "SECONDS_UNTIL_SHUTDOWN" limits the time power will be applied to a motor
  '' without movement.

  'LOW_POWER_THRESHOLD = MAX_POWER / 10 ' When to start worrying about motors stopping
                                       ' too soon.
                                       
  'SMALL_DISTANCE_REMAINING_THRESHOLD = 100 ' When to start worrying about motors stopping
                                           ' too soon. 
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
  
  'DEFAULT_MAX_POWER_ACCELERATION = 20 'MAX_POWER / CONTROL_CYCLES_TIL_FULL_POWER '4
  'DEFAULT_MAX_SPEED_ACCELERATION = MAX_INPUT_SPEED / 40 'CONTROL_CYCLES_TIL_FULL_SPEED

  'DEFAULT_KPBASE = 11
  'ADJUST_TARGET_SPEED_MULTIPLIER = 100  ' Used to compute "adjustedTargetSpeed"
  'BUFFERED_SPEED_CUTOFF = MAX_INPUT_SPEED / 10 '4
  'SINGLE_CYCLE_SPEED_THRESHOLD = 500 
  
  ' Added motor control constants  
  MAX_KILL_SWITCH_TIME = 26_500 'posx / MILLISECOND - a few tenths of a second
  MAX_KILL_SWITCH_SECONDS = MAX_KILL_SWITCH_TIME / 1000
  
  DEFAULT_DEBUG_INTERVAL = 250 '2_000 '

  ACKNOWLEDGE_SONG = 8
  ERROR_SONG = 9 '8 '1 '11

  BUFFER_SIZE = 64

  DEFAULT_TEMPO = 1500

  DEFAULT_PAUSE = 20 * MILLISECOND
  DEFAULT_REQUEST_TIMEOUT = 3_000
  
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
  MOTOR_CONTROL_STACK_SIZE = 36 ' It appears the cog monitoring the motors
  ' use 22 longs of the stack.

  ACTIVE_SERVO_POS_IN_SERVOTXT = 8
  DEC_IN_RESTORE_POS = 6
  
CON

  'XBEE_RX =
  'XBEE_TX =

  'MAX_FILE_NUMBER = 9999
 
  'LOG_NUMBER_NAME_LOCATION = 4
  'BYTES_TO_BUFFER = 11
  'ROWS_TO_RECORD = 10

  'END_OF_RECORD = 9999

  ' Servos are attached to the slave board not this board. 

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
  
  FIRST_SHARP_ADC_CHAN = 0
  
  '_CarriageReturn = 13

  ' sdFlag enumeration
  #0, NOT_FOUND_SD, IN_USE_SD, INITIALIZING_SD, NEW_LOG_CREATED_SD, LOG_FOUND_SD, {
    } NO_LOG_YET_SD, USED_BY_OTHER_SD

  
  #0, PLAY_BACK_SUCCESS, PLAY_BACK_ERROR_NOT_FOUND, PLAY_BACK_ERROR_OTHER


  #0, COM_SERIAL, AUX_SERIAL

  #0, SLAVE_CONTROL_SERIAL, USB_CONTROL_SERIAL, NO_ACTIVE_CONTROL_SERIAL

  #0, SLAVE_COM
  ' ports on the USB_CONTROL_SERIAL
  #0, DEBUG_AUX
  
  ' controlMode enumeration
  #0, ROAM_MODE, RC_POWER_MODE, RC_SPEED_MODE

  ' sensorMode
  #0, PRIORITY_TO_SENSOR, IGNORE_DANGER_SENSOR
  
CON

  VALID_NUNCHUCK_ID = $04C4B400
  
  CENTER_STICK_NUNCHUCK_X = 129
  CENTER_STICK_NUNCHUCK_Y = 127
  DEADZONE_NUNCHUCK_STICK = 8
  CENTER_NUNCHUCK_X_MIN = CENTER_STICK_NUNCHUCK_X - DEADZONE_NUNCHUCK_STICK
  CENTER_NUNCHUCK_X_MAX = CENTER_STICK_NUNCHUCK_X + DEADZONE_NUNCHUCK_STICK
  CENTER_NUNCHUCK_Y_MIN = CENTER_STICK_NUNCHUCK_Y - DEADZONE_NUNCHUCK_STICK
  CENTER_NUNCHUCK_Y_MAX = CENTER_STICK_NUNCHUCK_Y + DEADZONE_NUNCHUCK_STICK
  NUNCHUCK_X_RANGE_RIGHT = 255 - CENTER_NUNCHUCK_X_MAX + 1
  NUNCHUCK_X_RANGE_LEFT = CENTER_NUNCHUCK_X_MIN + 1
  NUNCHUCK_Y_RANGE_FORWARD = 255 - CENTER_NUNCHUCK_Y_MAX + 1
  NUNCHUCK_Y_RANGE_REVERSE = CENTER_NUNCHUCK_Y_MIN + 1
  NUNCHUCK_X_RANGE_R_HALF = NUNCHUCK_X_RANGE_RIGHT / 2
  NUNCHUCK_X_RANGE_L_HALF = NUNCHUCK_X_RANGE_LEFT / 2
  NUNCHUCK_Y_RANGE_F_HALF = NUNCHUCK_Y_RANGE_FORWARD / 2
  NUNCHUCK_Y_RANGE_R_HALF = NUNCHUCK_Y_RANGE_REVERSE / 2
  
  NUNCHUCK_ACC_MIN_X = 259 'port side down
  NUNCHUCK_ACC_MAX_X = 752 'starboard side down
  NUNCHUCK_ACC_MID_X = (NUNCHUCK_ACC_MIN_X + NUNCHUCK_ACC_MAX_X) / 2 'top side up
  NUNCHUCK_ACC_MIN_Y = 275 'front up
  NUNCHUCK_ACC_MAX_Y = 763 'front down
  NUNCHUCK_ACC_MID_Y = (NUNCHUCK_ACC_MIN_X + NUNCHUCK_ACC_MAX_X) / 2 'top side up
  NUNCHUCK_ACC_MIN_Z = 256 'top side down
  NUNCHUCK_ACC_MAX_Z = 735 'top side up
  NUNCHUCK_ACC_MID_Z = (NUNCHUCK_ACC_MIN_Z + NUNCHUCK_ACC_MAX_Z) / 2 'top side pointing horizontal
  NUNCHUCK_ACC_RANGE_Z = NUNCHUCK_ACC_MID_Z + NUNCHUCK_ACC_MIN_Z
  NUNCHUCK_ACC_RANGE_Y = NUNCHUCK_ACC_MID_Y + NUNCHUCK_ACC_MIN_Y
  NUNCHUCK_ACC_RANGE_X = NUNCHUCK_ACC_MID_X + NUNCHUCK_ACC_MIN_X
  DEADZONE_NUNCHUCK_ACC_Z = NUNCHUCK_ACC_RANGE_Z / 16
  NUNCHUCK_VERTICAL_MIN_Z = NUNCHUCK_ACC_MID_Z - DEADZONE_NUNCHUCK_ACC_Z
  NUNCHUCK_VERTICAL_MAX_Z = NUNCHUCK_ACC_MID_Z + DEADZONE_NUNCHUCK_ACC_Z
  DEADZONE_NUNCHUCK_ACC_Y = NUNCHUCK_ACC_RANGE_Y / 16
  NUNCHUCK_VERTICAL_MIN_Y = NUNCHUCK_ACC_MID_Y - DEADZONE_NUNCHUCK_ACC_Y
  NUNCHUCK_VERTICAL_MAX_Y = NUNCHUCK_ACC_MID_Y + DEADZONE_NUNCHUCK_ACC_Y
  DEADZONE_NUNCHUCK_ACC_X = NUNCHUCK_ACC_RANGE_X / 16
  NUNCHUCK_VERTICAL_MIN_X = NUNCHUCK_ACC_MID_X - DEADZONE_NUNCHUCK_ACC_X
  NUNCHUCK_VERTICAL_MAX_X = NUNCHUCK_ACC_MID_X + DEADZONE_NUNCHUCK_ACC_X
  NUNCHUCK_UP_THRESHOLD = NUNCHUCK_ACC_MIN_Y + (NUNCHUCK_ACC_RANGE_Y / 10)
  NUNCHUCK_DOWN_THRESHOLD = NUNCHUCK_ACC_MAX_Y - (NUNCHUCK_ACC_RANGE_Y / 10)  

  MAX_STICK_NUNCHUCK = $FF
  MAX_ACC_NUNCHUCK = 1_023

  ABS_MAX_HEIGHT = NUNCHUCK_ACC_RANGE_Y
  F_ABS_MAX_HEIGHT = float(ABS_MAX_HEIGHT)
  
  NUNCHUCK_BUTTON_Z = 1
  NUNCHUCK_BUTTON_C = 2

  #0, X_ACCEL, Y_ACCEL, Z_ACCEL
  
CON ' colors

  '             RR GG BB
  OFF        = $00_00_00
  BLACK      = $00_00_00
  RED        = $FF_00_00
  GREEN      = $00_FF_00
  BLUE       = $00_00_FF
  WHITE      = $FF_FF_FF
  CYAN       = $00_FF_FF
  MAGENTA    = $FF_00_FF
  YELLOW     = $FF_FF_00
  CHARTREUSE = $7F_FF_00
  ORANGE     = $FF_60_00
  AQUAMARINE = $7F_FF_D4
  PINK       = $FF_5F_5F
  TURQUOISE  = $3F_E0_C0
  REALWHITE  = $C8_FF_FF
  INDIGO     = $3F_00_7F
  VIOLET     = $BF_7F_BF
  MAROON     = $32_00_10
  BROWN      = $0E_06_00
  CRIMSON    = $DC_28_3C
  PURPLE     = $8C_00_FF

  
CON '' Cog Usage
{{
  The objects, "Header", "Encoders", "Slave", "Com", "Music" and "Led" each start
  their own cog.
  
  This top object uses two cogs bringing the total of cogs used to 8.
  Depending on the motor controller used.
 
}}
VAR

  long error                                            ' Error message pointer for verbose responses                        
  'long speedBufferTotal[2], scratchbuffer1[10]                ' Current motor speeds reported from position controllers  
  long lastUpdated[2]
  long stack[MOTOR_CONTROL_STACK_SIZE]                  ' Stack for cog running position control system
  
  '' Keep variables below in order.
  long pingCount, pingResults[Header#PINGS_IN_USE]
  '' Keep variables above in order.

  long activeParameter
  long activeParTxtPtr
 
  long positionDifference[2] 

  long newPowerTarget[2], lastComTime

  long rampedPower[2]

  long targetPower[2]

  long integral[2]
  long targetSpeed[2]

  long motorPosition[2], motorSpeed[2]
 
  long motorPositionBuffer[2 * POSITION_BUFFER_SIZE]
  long bufferIndex
  long motPosOffset[2] ' Offset between Physical and internal motor position
  long midPosition[2] ' Position the PD loop is attempting to hold
  long midPosAcc[2] ' fractional part  DWD I don't understand how this is used.
  long midVelocity[2] ' Current position change velocity
  long midVelAcc[2] ' fractional part DWD I don't understand how this is used.
  long setPosition[2] ' Position that midPosition is approaching
  long decel[2] ' Deceleration rate DWD Why is this different than acceleration?
  long previousDifference[2], gDifference[2]
  long stillCnt[2] ' Number of iterations in a row that the motor hasn't moved
  long addressOffsetCorrection, activePositionAcceleration[2]

  long joyX, joyY
  long nunchuckAcceleration[3]
  long nuchuckIdPtr
  long fullBrightnessArray[LEDS_IN_USE]
  
  byte positionErrorFlag[2]
 
  byte pingsInUse, maxPingIndex
  byte inputBuffer[BUFFER_LENGTH], outputBuffer[BUFFER_LENGTH] 
  byte inputIndex, parseIndex, outputIndex
  byte midReachedSetFlag[2]

  byte sdFlag
  byte previousControlMode, controlMode, sensorMode
  byte rightX, rightY, nunchuckButton, previousButton
  byte badDataFlag, nunchuckReadyFlag, nunchuckReceiverConnectedFlag
  byte tempString[64]
       
DAT '' variables which my have non-zero initial values 

maxPowAccel                     long 470        ' Maximum allowed motor power acceleration
maxPosAccel                     long 800        ' Maximum allowed positional acceleration

kProportional                   long 117[2] 
kIntegralNumerator              long Header#DEFAULT_INTEGRAL_NUMERATOR 
kIntegralDenominator            long Header#DEFAULT_INTEGRAL_DENOMINATOR
tempo                           long 1500
smallChange                     long 1
bigChange                       long 10
killSwitchTimer                 long 0 '1000 * MILLISECOND ' default Eddie delay. Set to 0 to turn off.
debugInterval                   long DEFAULT_DEBUG_INTERVAL * MILLISECOND                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        

controlFrequency                long DEFAULT_CONTROL_FREQUENCY
halfInterval                    long DEFAULT_HALF_INTERVAL
directionFlag                   long 1[2], 1[10]
pauseTime                       long DEFAULT_PAUSE
direction                       long 1[2] 

demoFlag                        byte 0 ' set to 255 or -1 to continuously run demo
                                       ' other non-zero values will instuct the 
                                       ' program the number of times it should execute
                                       ' the method "ScriptedProgram".
                                       
debugFlag                       byte FULL_DEBUG

volume                          byte 30
pingPauseFlag                   byte 0
                        
mode                            byte 0                  ' Current mode of the control system
controlSerial                   byte NO_ACTIVE_CONTROL_SERIAL

verbose                         byte true '      ' Verbosity level (Currently nonzero = verbose)
pauseForRxFlag                  byte 0
brightness                      byte DEFAULT_BRIGHTNESS
ledMode                         byte DEFAULT_LED_MODE

OBJ                             
                                
  Header : "HeaderCleaver"                              ' uses one cog 
   
  Encoders : "Quadrature_Encoder"                       ' uses one cog
  Com : "Serial4PortLocks"                            ' uses one cog

  Aux : "Serial4LocksA"                                 ' uses one cog
  Music : "s2_music"                                    ' uses one cog
  Nunchuck : "jm_nunchuk_ez_v3"
  Led : "jm_ws2812"                                     ' uses one cog
                                                      
  Adc : "ActivityBoardAdc"             ' 4-channel 12-bits
  Format : "StrFmt"             ' same formatting code used by serial object so
                                ' so adding this doesn't cost us any RAM.
  
PUB Main 

  controlMode := RC_SPEED_MODE
  mode := POWER
  longfill(@activePositionAcceleration, maxPosAccel, 2)
           
  Com.Init
  Com.AddPort(SLAVE_COM, Header#MASTER_FROM_SLAVE_RX, Header#MASTER_TO_SLAVE_TX, -1, -1, 0, {
  } Header#BAUDMODE, Header#PROP_TO_PROP_BAUD)
  Com.Start                                             'Start the ports
 
  Aux.Init
  Aux.AddPort(DEBUG_AUX, Header#USB_RX, Header#USB_TX, -1, -1, 0, Header#BAUDMODE, {
  } Header#MASTER_USB_BAUD)
  Aux.Start                                         'Start the ports    
 
  Adc.Init(Header#ADC_CS, Header#ADC_SCL, Header#ADC_DI, Header#ADC_DO)
        
  Nunchuck.Init(I2C_CLOCK, I2C_DATA)

  addressOffsetCorrection := @addressOffsetTest - addressOffsetTest
  Music.start_tones
  Music.SetVolume(volume)
  longfill(@stack, FILL_LONG, MOTOR_CONTROL_STACK_SIZE)
  result := cognew(PDLoop, @stack)                      ' Run the position controller in another core  
  Led.start(LED_PIN, LEDS_IN_USE)

  longmove(@fullBrightnessArray, @rainbow, LEDS_IN_USE)
  AdjustAndSet(@fullBrightnessArray, brightness, LEDS_IN_USE)
  if debugFlag => INTRO_DEBUG
    Aux.Str(DEBUG_AUX, string(11, 13, "Cleaver"))
     
    Aux.Tx(DEBUG_AUX, 7) ' Bell sounds in terminal to catch reset issues
    waitcnt(clkfreq / 4 + cnt)
    Aux.Tx(DEBUG_AUX, 7)
    waitcnt(clkfreq / 4 + cnt)
    Aux.Tx(DEBUG_AUX, 7)
    
  activeParameter := @targetPower[RIGHT_MOTOR]
  activeParTxtPtr := @targetPowerRTxt

  ExecuteStoredCommand(@introSong)
  waitcnt(clkfreq + cnt)
  Say(Header#INTRO_EMIC)

  mode := POWER                                   ' Stop PDIteration from modifying mid-positions 
  InterpolateMidVariables 
  
  targetSpeed[LEFT_MOTOR] := 0          
  targetSpeed[RIGHT_MOTOR] := 0

  longfill(@stillCnt, 0, 2)
  mode := SPEED

    
  MainLoop

PUB MainLoop | rxcheck, lastDebugTime
    
  lastComTime := cnt
  repeat

    if demoFlag
      ScriptedProgram
      if demoFlag <> $FF
        demoFlag--
        
    CheckNunchuck
    CheckKillSwitch
      
    result := CheckSerial
    DigestCharacter(result)

    if debugFlag => MAIN_DEBUG
      TempDebug
        
PUB CheckSerial : rxCheck
      
  if controlSerial == NO_ACTIVE_CONTROL_SERIAL or controlSerial == SLAVE_CONTROL_SERIAL
    'Com.Lock
    rxCheck := Com.RxCheck(SLAVE_COM)
    'Com.E ' clear lock
    if rxCheck <> -1
      controlSerial := SLAVE_CONTROL_SERIAL
      if debugFlag => PROP_CHARACTER_DEBUG
        if inputIndex == 0 
          Aux.Str(DEBUG_AUX, string(11, 13, "From Prop:", 34))
        if rxCheck == 13
          Aux.Tx(DEBUG_AUX, 34)
        Aux.Tx(DEBUG_AUX, rxCheck)
      
  if controlSerial == NO_ACTIVE_CONTROL_SERIAL or controlSerial == USB_CONTROL_SERIAL
    'Aux.Lock
    rxCheck := Aux.RxCheck(DEBUG_AUX)
    'Aux.E ' clear lock    
    if rxCheck <> -1
      controlSerial := USB_CONTROL_SERIAL
      
PUB DigestCharacter(localCharacter)

  if localCharacter < 0
    return
  else
    inputBuffer[inputIndex++] := localCharacter
       
  if inputIndex == constant(BUFFER_LENGTH)            ' Check for a full buffer
    OutputStr(@nack)                                  ' Ready error response
    Aux.Str(DEBUG_AUX, @overflow)
    'if verbose                                        ' If in verbose mode, add a description
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
             ' OutputStr(error)
   
          SendResponse(controlSerial) '   Send a response if no error
         
        else                                          '   For an empty buffer, clear the pointer
          inputIndex~                                 '   to start receiving a new command
        controlSerial := NO_ACTIVE_CONTROL_SERIAL
         
      SOH..BEL, LF..FF, SO..US, 127..255 :            ' Ignore invalid characters
        if debugFlag => INPUT_WARNINGS_DEBUG
          Aux.Str(DEBUG_AUX, string(11, 13, 7, "Invalid Character Error = <$"))
          Aux.Hex(DEBUG_AUX, localCharacter, 2)
          Aux.Tx(DEBUG_AUX, ">")
          inputIndex--
          waitcnt(clkfreq / 2 + cnt)
                      
PUB CheckKillSwitch
'' Stop motors if no communication has been received in the allowed time
'' The allowed time (in millieseconds) may be changed with the "KILL" command.
'' The "WATCH" command will change the time in seconds.

  if killSwitchTimer ' if killSwitchTimer is zero don't check time
    if cnt - lastComTime > killSwitchTimer
      'ifnot pDRunning
      Header.SetMotorPower(0, 0)
      Header.SetMotorPower(1, 0)
      if debugFlag => KILL_SWITCH_DEBUG
        Aux.Str(DEBUG_AUX, string(13, "Motors Stopped"))
      waitcnt(constant(_clkfreq / CONTROL_FREQUENCY) + cnt)
      targetPower[LEFT_MOTOR] := 0
      targetPower[RIGHT_MOTOR] := 0
      targetSpeed[LEFT_MOTOR] := 0
      targetSpeed[RIGHT_MOTOR] := 0
      longfill(@stillCnt, 0, 2)
      mode := POWER
    if true 'cnt - lastDebugTime > debugInterval
      'lastDebugTime += debugInterval
      if debugFlag => MAIN_DEBUG
        TempDebug

PUB CheckNunchuck

  if controlMode <> previousControlMode 
    Aux.Str(DEBUG_AUX, string(11, 13, "*** new controlMode ***"))
      {Aux.Dec(DEBUG_AUX, controlMode)
      Aux.Str(DEBUG_AUX, string(" = ")) 
      Aux.Str(DEBUG_AUX, FindString(@controlModeTxt, controlMode))}
    previousControlMode := controlMode
    {previousHeading := heading
    size := \Request(HEAD, @heading, true)
    if size > 1
      Aux.Str(DEBUG_AUX, string(13, "Request call appears to have aborted, error string = "))
      SafeDebug(DEBUG_AUX, size, strsize(size))
      }
  Aux.Str(DEBUG_AUX, string(11, 13, "a joy = "))
  Aux.Dec(DEBUG_AUX, joyX)
  Aux.Str(DEBUG_AUX, string(", "))
  Aux.Dec(DEBUG_AUX, joyY)
   
  GetNunchuckData
  Aux.Str(DEBUG_AUX, string(11, 13, "b joy = "))
  Aux.Dec(DEBUG_AUX, joyX)
  Aux.Str(DEBUG_AUX, string(", "))
  Aux.Dec(DEBUG_AUX, joyY)

PRI UpdateActive(changeAmount)

  if inputIndex == 1
    long[activeParameter] += changeAmount
    if activeParameter == @controlFrequency
      halfInterval := clkfreq / controlFrequency / 2
    elseif activeParTxtPtr == @kProportionalTxt 
      long[activeParameter + 4] += changeAmount ' adjust right also
    inputIndex--
    controlSerial := NO_ACTIVE_CONTROL_SERIAL
    lastComTime := cnt

PUB ScriptedProgram
'' The current scripted program.
'' Set the "demoFlag" variable to 1 to run the scripted section
'' of this program.

  '' Initialize Script Portion of Program
  if debugFlag => SCRIPT_INTRO_DEBUG 
    Aux.Str(DEBUG_AUX, string(11, 13, "Starting Demo", 11, 13))
   
  waitcnt(clkfreq / 4 + cnt)
  if debugFlag => SCRIPT_DEBUG
    'Aux.Lock
    Aux.Tx(DEBUG_AUX, 12) ' clear below

  PlayRoute(@twoByOneMRectanglePlusTwo8s)
 
  waitcnt(clkfreq / 4 + cnt)
  '' Finalize Script Portion of Program
 

  inputIndex := 0            
  if debugFlag => SCRIPT_INTRO_DEBUG
    Aux.Str(DEBUG_AUX, string(11, 13, "End of Demo", 11, 13))

PRI PlayRoute(routePtr)

  repeat while word[routePtr]
    ExecuteAndWait(word[routePtr] + addressOffsetCorrection)
    routePtr += 2
    
PRI ExecuteStoredCommand(commandPtr)

  inputIndex := strsize(commandPtr) + 1
  bytemove(@inputBuffer, commandPtr, inputIndex)
  if debugFlag => SCRIPT_EXECUTE_DEBUG
    Aux.Tx(DEBUG_AUX, 11)
    Aux.Tx(DEBUG_AUX, 13)
    Aux.Str(DEBUG_AUX, commandPtr)
  if error := \Parse                          '   Run the parser and trap and report errors
    if debugFlag => SCRIPT_WARNING_DEBUG
      Aux.Str(DEBUG_AUX, error)  

PRI ExecuteAndWait(pointer)

  ExecuteStoredCommand(pointer)
  waitcnt(clkfreq * 3 + cnt) ' wait for motors to get some speed
  repeat while motorSpeed[0] or motorSpeed[1] or {
  } ||gDifference[0] > Header#TOO_SMALL_TO_FIX or ||gDifference[1] > Header#TOO_SMALL_TO_FIX
  ' wait while motors are still turning and until the final destination is reached.

PRI TempDebug
     
  Aux.Tx(DEBUG_AUX, 11)
  Aux.Tx(DEBUG_AUX, 1) ' home
  Aux.Str(DEBUG_AUX, string(11, 13, "Cleaver"))
 
  Aux.Str(DEBUG_AUX, string(", mode = "))
  Aux.Dec(DEBUG_AUX, mode)
  Aux.Str(DEBUG_AUX, string(" = "))
  Aux.Str(DEBUG_AUX, FindString(@modeAsText, mode)) 
 
  Aux.Str(DEBUG_AUX, string(11, 13, "activeParameter = "))
  Aux.Str(DEBUG_AUX, activeParTxtPtr)  
  Aux.Str(DEBUG_AUX, string(" = "))
  Aux.Dec(DEBUG_AUX, long[activeParameter])
    'controlSerialTxt

 { Aux.Str(DEBUG_AUX, string(11, 13, "kIN = "))
  Aux.Dec(DEBUG_AUX, kIntegralNumerator) 
  Aux.Str(DEBUG_AUX, string(", kID = "))
  Aux.Dec(DEBUG_AUX, kIntegralDenominator)} 

  Aux.Str(DEBUG_AUX, string(11, 13, "nunchuckReadyFlag = "))
  Aux.Dec(DEBUG_AUX, nunchuckReadyFlag) 
  Aux.Str(DEBUG_AUX, string(", nunchuckReceiverConnectedFlag = "))
  Aux.Dec(DEBUG_AUX, nunchuckReceiverConnectedFlag)
  Aux.Str(DEBUG_AUX, string(", Nunchuck's ID = "))
  Aux.Hex(DEBUG_AUX, long[nuchuckIdPtr], 8)

  
  
 { if debugFlag => PING_DEBUG
    Aux.Str(DEBUG_AUX, string(11, 13, "pingCount = "))
    Aux.Dec(DEBUG_AUX, pingCount)

    
    Aux.Str(DEBUG_AUX, string(", pingResults = "))
    Aux.Dec(DEBUG_AUX, pingResults[0])
    Aux.Str(DEBUG_AUX, string(", "))
    Aux.Dec(DEBUG_AUX, pingResults[1])  }
  
  repeat result from 0 to 1
    if debugFlag => POWER_DEBUG
      Aux.Str(DEBUG_AUX, string(11, 13, 11, 13, "targetPower["))
      Aux.Dec(DEBUG_AUX, result)
      Aux.Str(DEBUG_AUX, string("] = "))
      Aux.Dec(DEBUG_AUX, targetPower[result])
      Aux.Str(DEBUG_AUX, string(", rampedPower = "))
      Aux.Dec(DEBUG_AUX, rampedPower[result])
      Aux.Str(DEBUG_AUX, string(", targetPower = "))
      Aux.Dec(DEBUG_AUX, targetPower[result])
      Aux.Str(DEBUG_AUX, string(", difference = "))
      Aux.Dec(DEBUG_AUX, targetPower[result] - rampedPower[result])
     
    if debugFlag => PID_SPEED_DEBUG
     
      Aux.Str(DEBUG_AUX, string(11, 13, "targetSpeed["))
      Aux.Dec(DEBUG_AUX, result)
      Aux.Str(DEBUG_AUX, string("] = "))
      Aux.Dec(DEBUG_AUX, targetSpeed[result])
 
      Aux.Str(DEBUG_AUX, string(", gDifference = "))
      Aux.Dec(DEBUG_AUX, gDifference[result])
      Aux.Str(DEBUG_AUX, string(", setPosition = "))
      Aux.Dec(DEBUG_AUX, setPosition[result])
      Aux.Str(DEBUG_AUX, string(", integral = "))
      Aux.Dec(DEBUG_AUX, integral[result])

      Aux.Str(DEBUG_AUX, string(11, 13, "midVelocity = "))
      Aux.Dec(DEBUG_AUX, midVelocity[result])
      
      Aux.Str(DEBUG_AUX, string(11, 13, "motorPosition["))
      Aux.Dec(DEBUG_AUX, result)
      Aux.Str(DEBUG_AUX, string("] = "))
      Aux.Dec(DEBUG_AUX, motorPosition[result])       
      Aux.Str(DEBUG_AUX, string(", motorSpeed = "))
      Aux.Dec(DEBUG_AUX, motorSpeed[result])
        
    if debugFlag => PID_POSITION_DEBUG
      Aux.Str(DEBUG_AUX, string(11, 13, "kProportional = "))
      Aux.Dec(DEBUG_AUX, kProportional[result])
      
     
      
  'MotorControlStackDebug(port)
      
  {if debugFlag => PID_POSITION_DEBUG
    Aux.Str(DEBUG_AUX, string(11, 13, "motorPositionBuffer[LEFT] = ", 11, 13))
    DumpBuffer(DEBUG_AUX, @motorPositionBuffer, POSITION_BUFFER_SIZE, @bufferIndex, 0)
    Aux.Str(DEBUG_AUX, string(11, 13, "motorPositionBuffer[RIGHT] = ", 11, 13))
    DumpBuffer(@motorPositionBuffer + (POSITION_BUFFER_SIZE * 4), POSITION_BUFFER_SIZE, {
    } @bufferIndex, 0)  }
   
  
  {if inputIndex
    Aux.Str(DEBUG_AUX, string(11, 13, "InputBuffer = ")) 
    SafeDebug(@InputBuffer, inputIndex) }

  
                
  Aux.Tx(DEBUG_AUX, 11)
  Aux.Tx(DEBUG_AUX, 13)

PUB MotorControlStackDebug

  Aux.Str(DEBUG_AUX, string(11, 13, "Motor Control Stack = ", 11, 13))
  DumpBufferLong(@stack, MOTOR_CONTROL_STACK_SIZE, 12)

PUB DumpBuffer(bufferPtr, bufferSize, interestedLocationPtr, offset) : localIndex

  bufferSize--

  repeat localIndex from 0 to bufferSize
    if long[interestedLocationPtr] - offset == localIndex
      Aux.Tx(DEBUG_AUX, "*")
    Aux.Dec(DEBUG_AUX, long[bufferPtr][localIndex])
    
    if localIndex // 8 == 7 and localIndex <> bufferSize
      Aux.Tx(DEBUG_AUX, 11)
      Aux.Tx(DEBUG_AUX, 13)
    elseif localIndex <> bufferSize  
      Aux.Tx(DEBUG_AUX, ",")
      Aux.Tx(DEBUG_AUX, 32)  

PRI DumpBufferLong(localPtr, localSize, localColumns) | localIndex

 
  Aux.Str(DEBUG_AUX, string("DumpBufferLong @ $"))
  Aux.Dec(DEBUG_AUX, localPtr)

  Aux.Tx(DEBUG_AUX, 11) 
  
  repeat localIndex from 0 to localSize - 1
    if localIndex // localColumns == 0
      Aux.Tx(DEBUG_AUX, 11) 
      Aux.Tx(DEBUG_AUX, 13) 
    else
      Aux.Tx(DEBUG_AUX, 32)  
    Aux.Tx(DEBUG_AUX, "$")  
    Aux.Hex(DEBUG_AUX, long[localPtr][localIndex], 8)

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
      Aux.Hex(DEBUG_AUX, character, 2)
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
      HT, " " :                                         ' Determine command length by finding the first whitespace character
        inputBuffer[parseIndex]~                        ' Null terminate the command
        quit                                            ' parseIndex now points to the null at the end of the command string (before the first parameter, if present)

  ' parameter[n] := ParseDec(NextParameter) caches the parameters to check for their existence before running the command
  ' CheckLastParameter checks for too many parameters
  ' The Output...() methods write responses to the output buffer
  ' Check command against the following strings:

  case inputBuffer[0]
    "A".."F":
      ParseAF
    "G".."I":
      ParseGI
    "J", "K":
      ParseJK
    "L".."N":
      ParseLN
    "O".."R":
      ParseOR
    "S".."Z":
      ParseSZ
    other:
      abort @invalidCommand

  lastComTime := cnt
  return 0

PRI ParseAF | index, parameter[3]
'' 16 Commands (including soon to be added "ARC")
'' "ACC", "ACP", "ADC", "ARC", "AKP", "AKPM", "AKPB", "AKPD", "BIG", "BLNK"  ' 10
'' "DEBUG", "DECIN", "DECOUT", "DEMO", "DIFF", "DIST" ' 6
   
  if strcomp(@InputBuffer, string("ACC"))
    parameter := ParseDec(NextParameter)
    CheckLastParameter
    case Parameter
      1..2047:                                   
        maxPosAccel := Parameter
        activeParameter := @maxPosAccel
        activeParTxtPtr := @maxPosAccelTxt
      other:
        abort @invalidParameter
  elseif strcomp(@InputBuffer, string("ACP"))
    parameter := ParseDec(NextParameter)
    CheckLastParameter
    case Parameter
      1..2047:                                   
        maxPowAccel := Parameter
        activeParameter := @maxPowAccel
        activeParTxtPtr := @maxPowAccelTxt
      other:
        abort @invalidParameter
  elseif strcomp(@InputBuffer, string("ADC"))           ' Command: Respond with voltages from ADC
    CheckLastParameter
    OutputDec(Adc.Read(0))                     ' Show output from first ADC
    repeat index from 1 to 7                            ' For the remaining 7
      OutputChr(" ")                                    ' Transmit a space character
      OutputDec(Adc.Read(Index))               ' Then the output from the ADC
  elseif strcomp(@InputBuffer, string("ARC"))
  ' Command: Turn a specified number of degrees around a circle of a specified radius
    parameter[0] := ParseDec(NextParameter)           ' degrees
    parameter[1] := ParseDec(NextParameter)           ' radius in encoder ticks
    parameter[2] := ParseDec(NextParameter)           ' speed (of center of bot)
    CheckLastParameter

    Arc(parameter[0], parameter[1] * SCALED_TAU, parameter[2])
 
  elseif strcomp(@InputBuffer, string("ARCMM"))
  ' Command: Turn a specified number of degrees around a circle of a specified radius
    parameter[0] := ParseDec(NextParameter)           ' degrees
    parameter[1] := ParseDec(NextParameter)           ' radius in encoder ticks
    parameter[2] := ParseDec(NextParameter)           ' speed (of center of bot)
    CheckLastParameter

    if parameter[1] < SMALL_ARC_THRESHOLD
      Arc(parameter[0], parameter[1] * SCALED_TAU * 1000 / Header#MICROMETERS_PER_TICK, parameter[2])
    else
      Arc(parameter[0], (1000 * SCALED_TAU / Header#MICROMETERS_PER_TICK) * parameter[1] , parameter[2])
    
  elseif strcomp(@InputBuffer, string("BIG"))        
    Parameter := ParseDec(NextParameter)
    CheckLastParameter
    bigChange := parameter
  elseif strcomp(@InputBuffer, string("DEBUG"))        
    parameter := ParseDec(NextParameter)
    CheckLastParameter
    debugFlag := parameter
  elseif strcomp(@InputBuffer, string("DEMO"))        
    parameter := ParseDec(NextParameter)
    CheckLastParameter
    case Parameter
      -1, $FF:
        demoFlag := $FF
      0..$7F:
        demoFlag := parameter
      other:
        abort @invalidParameter    
  elseif strcomp(@InputBuffer, string("DIFF"))        ' TODO: remove
    CheckLastParameter
    OutputDec(midPosition[LEFT_MOTOR] - motorPosition[LEFT_MOTOR])
    OutputChr(" ")                                           
    OutputDec(midPosition[RIGHT_MOTOR] - motorPosition[RIGHT_MOTOR])
  elseif strcomp(@InputBuffer, string("DIST"))        ' Command: Respond with the accumulative distance each motor has traveled, relative to last reset
    CheckLastParameter
    OutputDec(motorPosition[LEFT_MOTOR] + motPosOffset[LEFT_MOTOR])
    OutputChr(" ")
    OutputDec(motorPosition[RIGHT_MOTOR] + motPosOffset[RIGHT_MOTOR])
  
  else
    abort @invalidCommand

  return 0
  
PRI ParseGI | parameter[3]
'' 9 Commands
'' "GO", "GOSPD", "GOX", "HEAD", "HIGH", "HIGHS", "HWVER", "IN", "INS" ' 9

  if strcomp(@InputBuffer, string("GO"))          ' Command: Set the motors to a specified power
    parameter[0] := ParseDec(NextParameter)           '   Read both parameters before processing them
    parameter[1] := ParseDec(NextParameter)           '   To prevent changes with a "Too few parameters" error
    CheckLastParameter
   
    mode := POWER

    targetPower[LEFT_MOTOR] := parameter[0] * MAX_POWER / MAX_INPUT_POWER 
    targetPower[RIGHT_MOTOR] := parameter[1] * MAX_POWER / MAX_INPUT_POWER
 
  elseif strcomp(@InputBuffer, string("GOSPD"))         ' Command: Set the motors to a specified power
    parameter[0] := ParseDec(NextParameter)
    parameter[1] := ParseDec(NextParameter)
    CheckLastParameter

    mode := POWER                                   ' Stop PDIteration from modifying mid-positions 
    InterpolateMidVariables 
  
    targetSpeed[LEFT_MOTOR] := parameter[0]           
    targetSpeed[RIGHT_MOTOR] := parameter[1]

    longfill(@stillCnt, 0, 2)
    mode := SPEED
  elseif strcomp(@InputBuffer, string("GOX"))          ' Command: Set the motors to a specified power
    parameter[0] := ParseDec(NextParameter)           '   Read both parameters before processing them
    parameter[1] := ParseDec(NextParameter)           '   To prevent changes with a "Too few parameters" error
    CheckLastParameter
    
    mode := POWER
  
    targetPower[LEFT_MOTOR] := parameter[0] 
    targetPower[RIGHT_MOTOR] := parameter[1]
 
  elseif strcomp(@InputBuffer, string("HEAD"))        ' Command: Respond with the current heading, relative to last reset
    CheckLastParameter
    result := (((motorPosition[LEFT_MOTOR] + motPosOffset[LEFT_MOTOR]) - {
    } (motorPosition[RIGHT_MOTOR] + motPosOffset[RIGHT_MOTOR])) // {
    } Header#POSITIONS_PER_ROTATION) * 360 / Header#POSITIONS_PER_ROTATION
    OutputDec(result)
    if debugFlag => HEADING_DEBUG
      ExtraHeadingDebug(result)
  else
    abort @invalidCommand

  return 0
  
PRI ParseJK | parameter[3]
'' 4 Commands
'' "KID", "KILL", "KIN", "KP" ' 4

  if strcomp(@InputBuffer, string("KID"))        
    parameter := ParseDec(NextParameter)
    CheckLastParameter
    kIntegralDenominator := parameter
    activeParameter := @kIntegralDenominator
    activeParTxtPtr := @kIntegralDenominatorTxt 
  elseif strcomp(@InputBuffer, string("KILL"))        
    parameter := ParseDec(NextParameter)
    CheckLastParameter

    parameter[1] := 0 #> parameter[0] <# MAX_KILL_SWITCH_TIME
    
    killSwitchTimer := parameter[1] * MILLISECOND
    lastComTime := cnt
  elseif strcomp(@InputBuffer, string("KIN"))        
    parameter := ParseDec(NextParameter)
    CheckLastParameter
    kIntegralNumerator := parameter
    activeParameter := @kIntegralNumerator
    activeParTxtPtr := @kIntegralNumeratorTxt 
  elseif strcomp(@InputBuffer, string("KP"))        
    parameter := ParseDec(NextParameter)
    CheckLastParameter
    kProportional[0] := kProportional[1] := parameter
    activeParameter := @kProportional
    activeParTxtPtr := @kProportionalTxt
  
  else
    abort @invalidCommand

  return 0
  
PRI ParseLN | parameter[3], index
'' 5 Commands
'' "L", "LOW", "LOWS", "LS" ' 4
'' "NAME" ' 1

  if strcomp(@InputBuffer, string("L"))           ' Command: Set left motor to a specified power
    parameter[0] := ParseDec(NextParameter)         
    CheckLastParameter
    mode := POWER

    targetPower[LEFT_MOTOR] := parameter[0] 

    activeParameter := @targetPower
    activeParTxtPtr := @targetPowerLTxt
  elseif strcomp(@InputBuffer, string("LS"))         ' Command: Set left motor to a specified speed
    parameter[0] := ParseDec(NextParameter)
    CheckLastParameter
    mode := POWER                                   ' Stop PDIteration from modifying mid-positions 
    InterpolateMidVariables

    targetSpeed[LEFT_MOTOR] := parameter[0]

    longfill(@stillCnt, 0, 2)
    mode := SPEED
    activeParameter := @targetSpeed
    activeParTxtPtr := @targetSpeedLTxt
 
  else
    abort @invalidCommand

  return 0
  
PRI ParseOR | parameter[3], index
'' 7 Commands
'' "OUT", "OUTS", "PWR" ' 3
'' "R", "READ", "RS", "RST"  ' 4

  if strcomp(@InputBuffer, string("R"))             ' Command: Set right motor to a specified power
    parameter[0] := ParseDec(NextParameter)         
    CheckLastParameter
    mode := POWER
    targetPower[RIGHT_MOTOR] := parameter[0] 
   
    activeParameter := @targetPower + 4
    activeParTxtPtr := @targetPowerRTxt
  elseif strcomp(@InputBuffer, string("RS"))         ' Command: Set left motor to a specified speed
    parameter[0] := ParseDec(NextParameter)
    CheckLastParameter
    mode := POWER                                   ' Stop PDIteration from modifying mid-positions 
    InterpolateMidVariables
    targetSpeed[RIGHT_MOTOR] := parameter[0]
   
    longfill(@stillCnt, 0, 2)
    mode := SPEED
    activeParameter := @targetSpeed + 4
    activeParTxtPtr := @targetSpeedRTxt
  elseif strcomp(@InputBuffer, string("RST"))         ' Command: Reset heading and accumulated distance
    CheckLastParameter
    motPosOffset[LEFT_MOTOR] := -motorPosition[LEFT_MOTOR]
    motPosOffset[RIGHT_MOTOR] := -motorPosition[RIGHT_MOTOR]
    positionErrorFlag[0] := 0
    positionErrorFlag[1] := 0 
 
  else
    abort @invalidCommand

  return 0
  
PRI ParseSZ | parameter[3]
'' 10 Commands
'' "SMALL", "SONG", "SPD", "STOP" ' 4
'' "TRVL", "TURN", "VERB", "VOL", "WATCH", "X" ' 6

  if strcomp(@InputBuffer, string("SMALL"))        
    parameter := ParseDec(NextParameter)
    CheckLastParameter
    smallChange := parameter
  elseif     strcomp(@InputBuffer, string("SONG"))     ' Command: Play song
    parameter := ParseDec(NextParameter)
    CheckLastParameter
    Music.play_song(parameter, tempo)
  elseif     strcomp(@InputBuffer, string("SPD"))     ' Command: Respond with the current motor speeds
    CheckLastParameter
    OutputDec(motorSpeed[LEFT_MOTOR])
    OutputChr(" ")
    OutputDec(motorSpeed[RIGHT_MOTOR])
  elseif strcomp(@InputBuffer, string("STOP"))        ' Command: Slow to a stop over a specified distance
    parameter := ParseDec(NextParameter)
    CheckLastParameter
    if parameter
      mode := POWER                                   ' Stop PDIteration from modifying mid-positions 
      InterpolateMidVariables      
      case targetPower[LEFT_MOTOR]
        -1..negx:
          setPosition[LEFT_MOTOR] := motorPosition[LEFT_MOTOR] - parameter
        1..posx:
          setPosition[LEFT_MOTOR] := motorPosition[LEFT_MOTOR] + parameter
        other:
          setPosition[LEFT_MOTOR] := motorPosition[LEFT_MOTOR]
      case targetPower[RIGHT_MOTOR]
        -1..negx:
          setPosition[RIGHT_MOTOR] := motorPosition[RIGHT_MOTOR] - parameter
        1..posx:
          setPosition[RIGHT_MOTOR] := motorPosition[RIGHT_MOTOR] + parameter
        other:
          setPosition[RIGHT_MOTOR] := motorPosition[RIGHT_MOTOR]
      decel[LEFT_MOTOR] := ||(-HALF_SEC * midVelocity[LEFT_MOTOR] * midVelocity[LEFT_MOTOR] / (midVelocity[LEFT_MOTOR] - HALF_SEC * ||(setPosition[LEFT_MOTOR] - motorPosition[LEFT_MOTOR])))
      decel[RIGHT_MOTOR] := ||(-HALF_SEC * midVelocity[RIGHT_MOTOR] * midVelocity[RIGHT_MOTOR] / (midVelocity[RIGHT_MOTOR] - HALF_SEC * ||(setPosition[RIGHT_MOTOR] - motorPosition[RIGHT_MOTOR])))
      longfill(@stillCnt, 0, 2)
      mode := STOPPING
    else                                              '   For a zero stopping distance:
      targetPower[LEFT_MOTOR]~                           '     Disable power to both motors
      targetPower[RIGHT_MOTOR]~
      longfill(@stillCnt, 0, 2)
      mode := POWER                                   '     Set the motors to power mode
  elseif     strcomp(@InputBuffer, string("TEMPO"))     ' Command: Change tempo used to play songs
    parameter := ParseDec(NextParameter)
    CheckLastParameter
    tempo := parameter
  elseif strcomp(@InputBuffer, string("TRVL"))
    ' Command: Travel a specified distance at a specified speed
    parameter[0] := ParseDec(NextParameter)                                                                     
    parameter[1] := ParseDec(NextParameter)
    CheckLastParameter
    
    Travel(parameter[0], parameter[1])
              
  elseif strcomp(@InputBuffer, string("TURN"))
    '' Command: Turn a specified number of degrees around a circle of a specified radius
    ' Read both parameters before processing them (and adjust encoder positions per
    ' revolution / 2 wheels)
    parameter[0] := ParseDec(NextParameter) 
    parameter[1] := ParseDec(NextParameter)
       
    CheckLastParameter
      
    if parameter[1] < 0
      abort @invalidParameter
      
    Travels(parameter[0] * Header#POSITIONS_PER_ROTATION / 720, {
    } parameter[0] * Header#POSITIONS_PER_ROTATION / -720, parameter[1], parameter[1]) 

  elseif strcomp(@InputBuffer, string("VERB"))        ' Command: Set verbose mode
    parameter := ParseDec(NextParameter)
    CheckLastParameter
    case Parameter
      0..1:
        verbose := parameter
      other:
        abort @invalidParameter
  elseif     strcomp(@InputBuffer, string("VOL"))     ' Command: Change volume used when playing songs
    Parameter := ParseDec(NextParameter)
    CheckLastParameter
    volume := 0 #> Parameter <#100
    Music.SetVolume(volume)
  elseif strcomp(@InputBuffer, string("WATCH"))         ' Command: Set number of seconds to use
                                                        ' in watch mode
    parameter := ParseDec(NextParameter)
    CheckLastParameter
    case parameter
      0..MAX_KILL_SWITCH_SECONDS:
        killSwitchTimer := parameter * clkfreq  
      other:
        abort @invalidParameter
  elseif strcomp(@InputBuffer, string("X"))             ' Command: Stop the motors now.
    targetPower[LEFT_MOTOR] := 0
    targetPower[RIGHT_MOTOR] := 0
    targetSpeed[LEFT_MOTOR] := 0
    targetSpeed[RIGHT_MOTOR] := 0
    mode := POWER
    InterpolateMidVariables
    CheckLastParameter
    targetPower[LEFT_MOTOR] := 0
    targetPower[RIGHT_MOTOR] := 0
    targetSpeed[LEFT_MOTOR] := 0
    targetSpeed[RIGHT_MOTOR] := 0
        
  else
    abort @invalidCommand

  return 0
     
PRI Arc(arcDegrees, scaledArcCircumference, arcSpeed) | scaledArcRatioOuter, {
} scaledArcRatioInner, scaledVInside, scaledVOutside, arcDistanceInside, arcDistanceOutside
   
  if scaledArcCircumference == 0
    abort @invalidParameter
  elseif scaledArcCircumference < 0
    -arcSpeed
    -scaledArcCircumference

  arcDistanceInside := ||arcDegrees * (scaledArcCircumference - {
  } SCALED_ROBOT_CIRCUMFERENCE) / SCALED_CIRCLE
  arcDistanceOutside := ||arcDegrees * (scaledArcCircumference + {
  } SCALED_ROBOT_CIRCUMFERENCE) / SCALED_CIRCLE
  ' distances may have different signs

  scaledArcRatioOuter := (SCALED_MULTIPLIER * (scaledArcCircumference + {
  } SCALED_ROBOT_CIRCUMFERENCE)) / scaledArcCircumference 
  scaledArcRatioInner := (SCALED_MULTIPLIER * (scaledArcCircumference - {
  } SCALED_ROBOT_CIRCUMFERENCE)) / scaledArcCircumference 
  ' Since "scaledArcCircumference" is always positive, the outer wheel will always have
  ' farther to travel (and have to turn faster) than the inner wheel .
  scaledVOutside := -SCALED_MAX_ARC_SPEED #> scaledArcRatioOuter * arcSpeed <# {
  } SCALED_MAX_ARC_SPEED
  arcSpeed := scaledVOutside / scaledArcRatioOuter
  scaledVInside := scaledArcRatioInner * arcSpeed
    
  if arcDegrees > 0 '' turn right
    Travels(arcDistanceOutside, arcDistanceInside, scaledVOutside / SCALED_MULTIPLIER, {
    } scaledVInside / SCALED_MULTIPLIER)
  else
    Travels(arcDistanceInside, arcDistanceOutside, scaledVInside / SCALED_MULTIPLIER, {
    } scaledVOutside / SCALED_MULTIPLIER)

PRI Travel(distance, travelSpeed)

  if speed < 0 ' only allow positive speeds. Use negative distance to go backward.
    abort @invalidParameter

  Travels(distance, distance, travelSpeed, travelSpeed)

PRI Travels(distanceLeft, distanceRight, speedLeft, speedRight)

  if speedLeft < 0 
    -speedLeft
    -distanceLeft
  if speedRight < 0
    -speedRight
    -distanceRight

  mode := POWER               ' Stop PDIteration from modifying mid-positions 
  InterpolateMidVariables

  longmove(@targetSpeed, @speedLeft, 2)
  
  setPosition[LEFT_MOTOR] := midPosition[LEFT_MOTOR] + distanceLeft 
  setPosition[RIGHT_MOTOR] := midPosition[RIGHT_MOTOR] + distanceRight
  
  if speedLeft > speedRight
    activePositionAcceleration[LEFT_MOTOR] := maxPosAccel
    activePositionAcceleration[RIGHT_MOTOR] := maxPosAccel * speedRight / speedLeft
  elseif speedLeft < speedRight
    activePositionAcceleration[LEFT_MOTOR] := maxPosAccel * speedLeft / speedRight
    activePositionAcceleration[RIGHT_MOTOR] := maxPosAccel  
  else
    longfill(@activePositionAcceleration, maxPosAccel, 2)
     
  longfill(@stillCnt, 0, 2)

  repeat result from LEFT_MOTOR to RIGHT_MOTOR
    if distanceLeft[result] < 0
      direction[result] := -1
    else
      direction[result] := 1

  mode := POSITION
     
PRI ExtraHeadingDebug(heading)
 
  Aux.Str(DEBUG_AUX, string(11, 13, "Heading = ((("))
  Aux.Dec(DEBUG_AUX, motorPosition[LEFT_MOTOR])
  Aux.Str(DEBUG_AUX, string(" + "))
  Aux.Dec(DEBUG_AUX, motPosOffset[LEFT_MOTOR])
  Aux.Str(DEBUG_AUX, string(") - ("))
  Aux.Dec(DEBUG_AUX, motorPosition[RIGHT_MOTOR])
  Aux.Str(DEBUG_AUX, string(" + "))
  Aux.Dec(DEBUG_AUX, motPosOffset[RIGHT_MOTOR])
   
  Aux.Str(DEBUG_AUX, string(")) // "))
  Aux.Dec(DEBUG_AUX, Header#POSITIONS_PER_ROTATION)
  Aux.Str(DEBUG_AUX, string(") * 360 / "))
  Aux.Dec(DEBUG_AUX, Header#POSITIONS_PER_ROTATION)
  Aux.Str(DEBUG_AUX, string(11, 13, " = "))
  Aux.Dec(DEBUG_AUX, heading)
        
  Aux.Tx(DEBUG_AUX, 11) ' clear end
  Aux.Tx(DEBUG_AUX, 13)

PRI InterpolateMidVariables : side | difference  ' called from parsing cog
'' Sets midVelocity and midPosition variables to values that would create the current
'' targetPower at the current motorPosition

  bytefill(@midReachedSetFlag, 0, 2)
  longfill(@gDifference, 0, 2)
  longfill(@midVelAcc, 0, 2)
  longfill(@midPosAcc, 0, 2)
  longmove(@midPosition, @motorPosition, 2)
  longmove(@midVelocity, @motorSpeed, 2)

PRI PDLoop : side | nextControlCycle
'' Measure, set, and maintain wheel position

  Encoders.Start(Header#ENCODERS_PIN, 2, 0, @motorPosition)
  Header.StartMotors
  
  nextControlCycle := cnt                                        ' Set up a timed loop
  repeat
    repeat side from LEFT_MOTOR to RIGHT_MOTOR
      waitcnt(nextControlCycle += DEFAULT_HALF_INTERVAL)
      PDIteration(side)                ' Service 
      Header.SetMotorPower(side, rampedPower[side])
      
    bufferIndex++
    bufferIndex //= POSITION_BUFFER_SIZE
    
PRI PDIteration(side) | motorPositionSample, difference, limit
'' Read the wheel's speed and position, and set its power
'' The power is set by use of a global variable "rampedPower".
  
  motorPositionSample := motorPosition[side] ' Sample at the beginning to remove jitter
 
  motorSpeed[side] := motorPositionSample - motorPositionBuffer[side * POSITION_BUFFER_SIZE + bufferIndex]
  motorPositionBuffer[side * POSITION_BUFFER_SIZE + bufferIndex] := motorPositionSample

  if motorSpeed[side] or rampedPower[side] == 0  ' Keep track of how long the motor hasn't been moving
    stillCnt[side] := 0
  else
    stillCnt[side]++
    stillCnt[side] <#= CONTROL_FREQUENCY * SECONDS_UNTIL_SHUTDOWN
    
  ' Keep the mid point from traveling too far away from the current motor position     
  difference := midPosition[side] - motorPositionSample

  ' Check to see if offset is higher than it should be for the current power level (When motor is moving)
  ' dwd 141225c I don't understand the code below.
  if ||difference > SAFEZONE and ||difference > ||targetPower[side] / kProportional[side] + {
    } DEADZONE
    ' If so, bring the set point closer to the physical position
    ' MidPosition equals MotorPositionSample approaching MidPosition, as limited by SetPower / Kp + DEADZONE
    midPosition[side] := motorPositionSample - (-(targetPower[side] / kProportional[side] + {
      } DEADZONE) #> -difference <# (targetPower[side] / kProportional[side] + DEADZONE))
    
  if stillCnt[side] => CONTROL_FREQUENCY * SECONDS_UNTIL_SHUTDOWN and {
    } midReachedSetFlag[side] == 0
    ' If the motor hasn't moved (when it was supposed to) shut off power to motor
    targetPower[side] := 0
    targetSpeed[side] := 0
    midPosition[side] := motorPositionSample
    positionDifference[side] := difference  
    positionErrorFlag[side] := 1
          
         
  case mode                     ' Set motor power based on current control method
    POWER:                      ' Run the motors at a set power level
      ' rampedPower approaches targetPower as limited by maxPowAccel
      'stillCnt[side] := 0 ' in POWER mode, we don't care if we've been sitting still?
      rampedPower[side] += -maxPowAccel #> (targetPower[side] - rampedPower[side]) <# maxPowAccel
      
    SPEED:                      ' Maintain the motors at a set velocity
      ' midVelocity / HALF_SEC approaches targetSpeed as limited by maxPosAccel
      midVelAcc[side] += -activePositionAcceleration[side] #> {
      }(targetSpeed[side] - midVelocity[side]) * HALF_SEC - midVelAcc[side] {
      } <# activePositionAcceleration[side]
      midVelocity[side] += midVelAcc[side] / HALF_SEC
      midVelAcc[side] //= HALF_SEC

      ' midPosition / HALF_SEC increases by midVelocity / 25 positions per half second
      midPosAcc[side] += midVelocity[side]                             
      midPosition[side] += midPosAcc[side] / HALF_SEC
      midPosAcc[side] //= HALF_SEC

      ' Measure motors physical distance from the set point
      difference := midPosition[side] - motorPositionSample

      if difference => DEADZONE                         ' Adjust for the deadzone   
        difference -= DEADZONE
      elseif difference =< -DEADZONE
        difference += DEADZONE
      else
        difference~

      ' targetPower is proportional to the motors physical distance from the set point,
      ' limited by MAX_POWER
     
      targetPower[side] := MIN_POWER #> difference * kProportional[side] <# MAX_POWER

      ' rampedPower approaches targetPower as limited by maxPowAccel
      rampedPower[side] += -maxPowAccel #> (targetPower[side] - rampedPower[side]) <# maxPowAccel

    STOPPING:                   ' Slow to a stop at a set position
      ' midPosition / HALF_SEC approaches setPosition as limited by the deceleration curve
      ' dwd 141118b, HALF_SEC is the value 25 since the control cycle occurs 50 times a second
      ' there are 25 control cycles in half a second.
     
      limit := ^^(constant(8 * HALF_SEC * HALF_SEC) * (setPosition[side] - midPosition[side])/ decel ) * decel / 2
      midPosAcc[side] += -limit #> (setPosition[side] - midPosition[side]) * constant(HALF_SEC * HALF_SEC) + midPosAcc[side] <# limit
      midPosition[side] += midPosAcc[side] / constant(HALF_SEC * HALF_SEC)
      midPosAcc[side] //= constant(HALF_SEC * HALF_SEC)

      ' Measure motors physical distance from the set point
      difference := midPosition[side] - motorPositionSample

      if difference => DEADZONE                         ' Adjust for the deadzone   
        difference -= DEADZONE
      elseif difference =< -DEADZONE
        difference += DEADZONE
      else
        difference~

      ' targetPower is proportional to the motors physical distance from the set point,
      ' limited by MAX_POWER
      targetPower[side] := MIN_POWER #> difference * kProportional[side] <# MAX_POWER

      ' rampedPower approaches targetPower as limited by maxPowAccel
      rampedPower[side] += -maxPowAccel #> (targetPower[side] - rampedPower[side]) <# maxPowAccel
  
    POSITION:                ' Travel to a set position
         
      ' Measure motors physical distance from the set point

      ' midVelocity / HALF_SEC approaches targetSpeed as limited
      'by maxPosAccel / CONTROL_FREQUENCY
      midVelAcc[side] += -activePositionAcceleration[side] #> {
      } (targetSpeed[side] - midVelocity[side]) * HALF_SEC - midVelAcc[side] <# {
      } activePositionAcceleration[side]
      
      midVelocity[side] += midVelAcc[side] / HALF_SEC 
      midVelAcc[side] //= HALF_SEC 
       
      ' midPosition approaches setPosition as limited by the deceleration curve
      limit := midVelocity[side] * HALF_SEC + midVelAcc[side] {
      }<# ^^(constant(8 * HALF_SEC * HALF_SEC) * (setPosition[side] - midPosition[side])/ {
      } activePositionAcceleration[side]) * activePositionAcceleration[side] / 2

      midPosAcc[side] += -limit #> (setPosition[side] - midPosition[side]) * {
      } constant(HALF_SEC * HALF_SEC) + midPosAcc[side] <# limit
      
      midPosition[side] += midPosAcc[side] / constant(HALF_SEC * HALF_SEC)
      midPosAcc[side] //= constant(HALF_SEC * HALF_SEC)
         
      ' Measure motors physical distance from the set point
      previousDifference[side] := gDifference[side]

      if midReachedSetFlag[side]
        gDifference[side] := difference := setPosition[side] - MotorPositionSample
      else
        gDifference[side] := difference := midPosition[side] - MotorPositionSample
      ' The "g" in "gDifference" stands for "global" I wanted a global variable
      ' as a debugging aid.

      if midPosition[side] == setPosition[side] or midReachedSetFlag[side]
        midReachedSetFlag[side] := 1 ' The "midPosition" can change so make sure the
        ' target position stays the same.
        if ||gDifference[side] > Header#TOO_SMALL_TO_FIX
          integral[side] += gDifference[side] 
        else
          integral[side] := 0
          difference := 0
          activePositionAcceleration[side] := maxPosAccel ' reset to standard acceleration
      else
        integral[side] := 0
        
      ' targetPower is proportional to the motors physical distance from the set point,
      ' limited by MAX_POWER
      '''targetPower[side] := -MAX_ON_TIME #> difference * kP <# MAX_ON_TIME
      newPowerTarget[side] := (difference * kProportional[side]) + {
      } (integral[side] * kIntegralNumerator / kIntegralDenominator)
      targetPower[side] := MIN_POWER #> newPowerTarget[side] <# MAX_POWER

      ' rampedPower approaches targetPower as limited by maxPowAccel
      rampedPower[side] += -maxPowAccel #> (targetPower[side] - rampedPower[side]) {
      } <# maxPowAccel

    other: ' Invalid state
      rampedPower[side] := 0 ' Stop the motor
      targetPower[side] := 0
      targetSpeed[side] := 0

PRI NextParameter                                       '' Condition the next input parameter and return its pointer

  repeat until ++parseIndex => inputIndex               ' Ignore whitespace
    case inputBuffer[parseIndex]                        ' First character is always whitespace
      0, HT, " ":
      other:
        quit                                            ' parseIndex points to first non-whitespace character
  if parseIndex => inputIndex                           ' If at the end of the buffer (or passed it, just in case)
    abort @tooFewParameters                             '  then there are no more parameters
  result := @inputBuffer[parseIndex]                    ' When responding, point to the next parameter,

  repeat parseIndex from parseIndex to inputIndex - 1   ' But first...
    case inputBuffer[parseIndex]                         
      NUL, HT, " " :                                    '  Null terminate the parameter           
        inputBuffer[parseIndex]~
        quit
      "a".."z" :                                        '  Set all command characters to uppercase
        inputBuffer[parseIndex] -= constant("a" - "A")


PRI CheckLastParameter                                  '' Abort if there are any unparsed input parameters

  repeat until (inputBuffer[parseIndex] <> 0 and inputBuffer[parseIndex] <> " " and inputBuffer[parseIndex] <> HT) or parseIndex == inputIndex - 1
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
      result~~                                          ' flag non-zero found
    elseif result or i == 1
      OutputChr("0")                                    ' If zero digit (or only digit) output it
    i /= 10                                             ' Update CONTROL_FREQUENCY

PRI Rx(serialDriver)

  if serialDriver == USB_CONTROL_SERIAL
    Aux.Lock
    result := Aux.Rx(DEBUG_AUX)
    Aux.E
  else
    Com.Lock  
    result := Com.Rx(0)
    Com.E
    
PRI SendResponse(serialDriver)  '' Transmit the string in the output buffer and clear the buffer

  if serialDriver == USB_CONTROL_SERIAL
    Aux.Lock
    Aux.Str(DEBUG_AUX, @outputBuffer)  ' Transmit the buffer contents
    Aux.Stre(DEBUG_AUX, @prompt)       ' Transmit the prompt
  else
    Com.Lock
    Com.Str(SLAVE_COM, @outputBuffer)  ' Transmit the buffer contents
    Com.Stre(SLAVE_COM, @prompt)       ' Transmit the prompt
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

PUB Say(messageId)

  Com.Str(SLAVE_COM, string("say "))
  Com.Dec(SLAVE_COM, messageId)
  Com.Tx(SLAVE_COM, 13)
  
PUB GetSharpDistance(firstChannel, lastChannel, avePtr, rawPtr)
'' The ADC values should be read prior to calling this method.

  Aux.Str(DEBUG_AUX, string(11, 13, "GetSharpDistance("))
  Aux.Dec(DEBUG_AUX, firstChannel)
  Aux.Str(DEBUG_AUX, string(", "))
  Aux.Dec(DEBUG_AUX, lastChannel)
  Aux.Str(DEBUG_AUX, string(", $"))
  Aux.Hex(DEBUG_AUX, avePtr, 4)
  Aux.Str(DEBUG_AUX, string(", $"))
  Aux.Hex(DEBUG_AUX, rawPtr, 4)
  Aux.Tx(DEBUG_AUX, ")")
  
  repeat result from firstChannel to lastChannel
    long[avePtr][result] := (long[rawPtr][result] + long[rawPtr][result + NUMBER_OF_UNIQUE_ADC]) / 2
    
PUB GetNunchuckData | localMax, localParameter[2], pointer
'' Called by debug cog
'' Nunchuck's coordinate system is different from robot's.
'' 
  if nunchuckReceiverConnectedFlag == 0
    CheckForNunchuck
    if nunchuckReceiverConnectedFlag == 0
      Aux.Str(DEBUG_AUX, string(11, 13, "No Nunchuck Receiver Found")) 
      return
      
  'Aux.Str(DEBUG_AUX, string(11, 13, "Before Nunchuck.Scan"))
  Nunchuck.Scan
  'Aux.Str(DEBUG_AUX, string(11, 13, "After Nunchuck.Scan"))
  rightX := Nunchuck.joyx
  rightY := Nunchuck.joyy
  nunchuckAcceleration[0] := Nunchuck.accx
  nunchuckAcceleration[1] := Nunchuck.accy
  nunchuckAcceleration[2] := Nunchuck.accz
  nunchuckButton := Nunchuck.buttons

  if nunchuckAcceleration[0] == 1023 and nunchuckAcceleration[1] == 1023 and {
    } nunchuckAcceleration[2] == 1023
    nunchuckReadyFlag := 0
    Aux.Str(DEBUG_AUX, string(11, 13, "No Nunchuck Transmitter Found"))
    targetSpeed[LEFT_MOTOR] := 0
    targetSpeed[RIGHT_MOTOR] := 0
    targetPower[LEFT_MOTOR] := 0
    targetPower[RIGHT_MOTOR] := 0
    return
  else
    nunchuckReadyFlag := 1
    
  DisplayTwoDataPoints(rightX * MAX_LED_INDEX / 255, GREEN, rightY * MAX_LED_INDEX / 255, RED, OFF)
  
  Aux.Str(DEBUG_AUX, string(11, 13, "Nunchuck = "))
  Aux.Dec(DEBUG_AUX, rightX)
  Aux.Str(DEBUG_AUX, string(", "))
  Aux.Dec(DEBUG_AUX, rightY)
  Aux.Str(DEBUG_AUX, string(" & "))
  Aux.Dec(DEBUG_AUX, nunchuckAcceleration[0])
  Aux.Str(DEBUG_AUX, string(", "))
  Aux.Dec(DEBUG_AUX, nunchuckAcceleration[1])
  Aux.Str(DEBUG_AUX, string(", "))
  Aux.Dec(DEBUG_AUX, nunchuckAcceleration[2])
  Aux.Str(DEBUG_AUX, string(" : ButtonsZC = "))
  Aux.Dec(DEBUG_AUX, nunchuckButton)
 

  case nunchuckButton
    NUNCHUCK_BUTTON_Z:
      if CheckPointedUp
        controlMode := RC_POWER_MODE
      elseif CheckPointedDown
        controlMode := ROAM_MODE
      else
        result := 3
        'SendCommand(SONG, 1, @result, true)
    NUNCHUCK_BUTTON_C:
      targetSpeed[LEFT_MOTOR] := 0
      targetSpeed[RIGHT_MOTOR] := 0
        
    'NUNCHUCK_BUTTON_Z + NUNCHUCK_BUTTON_C:
            
  badDataFlag := 0

  if controlMode == RC_SPEED_MODE
    localMax :=  MAX_RC_SPEED
    pointer := @targetSpeed
  else' if controlMode == RC_POWER_MODE
    localMax :=  MAX_POWER
    pointer := @targetPower

  case rightX
    0..CENTER_NUNCHUCK_X_MIN - 1:
      joyX := rightX - CENTER_NUNCHUCK_X_MIN
      joyX := ((joyX * localMax) + NUNCHUCK_X_RANGE_L_HALF) / NUNCHUCK_X_RANGE_LEFT 
    CENTER_NUNCHUCK_X_MIN..CENTER_NUNCHUCK_X_MAX:
      joyX := 0
    CENTER_NUNCHUCK_X_MAX + 1..MAX_STICK_NUNCHUCK:
      joyX := rightX - CENTER_NUNCHUCK_X_MAX
      joyX := ((joyX * localMax) + NUNCHUCK_X_RANGE_R_HALF) / NUNCHUCK_X_RANGE_RIGHT
  case rightY
    0..CENTER_NUNCHUCK_Y_MIN - 1:
      joyY := rightY - CENTER_NUNCHUCK_Y_MIN
      joyY := ((joyY * localMax) + NUNCHUCK_Y_RANGE_R_HALF) / NUNCHUCK_Y_RANGE_REVERSE
    CENTER_NUNCHUCK_Y_MIN..CENTER_NUNCHUCK_Y_MAX:
      joyY := 0
    CENTER_NUNCHUCK_Y_MAX + 1..MAX_STICK_NUNCHUCK:
      joyY := rightY - CENTER_NUNCHUCK_Y_MAX
      joyY := ((joyY * localMax) + NUNCHUCK_Y_RANGE_F_HALF) / NUNCHUCK_Y_RANGE_FORWARD
      
  previousButton := nunchuckButton
  ' *** speed isn't computed yet 
  'targetSpeed[LEFT_MOTOR] := -MAX_RC_SPEED #> joyY + joyX <# MAX_RC_SPEED
  'targetSpeed[RIGHT_MOTOR] := -MAX_RC_SPEED #> joyY - joyX <# MAX_RC_SPEED
  'targetSpeed[LEFT_MOTOR] := joyY + joyX
  'targetSpeed[RIGHT_MOTOR] := joyY - joyX
  localParameter[LEFT_MOTOR] := joyY + joyX
  localParameter[RIGHT_MOTOR] := joyY - joyX
    
 
  Aux.Str(DEBUG_AUX, string(11, 13, "joy = "))
  Aux.Dec(DEBUG_AUX, joyX)
  Aux.Str(DEBUG_AUX, string(", "))
  Aux.Dec(DEBUG_AUX, joyY)

  Aux.Str(DEBUG_AUX, string(", localParameter = "))
  Aux.Dec(DEBUG_AUX, localParameter[LEFT_MOTOR])
  Aux.Str(DEBUG_AUX, string(", "))
  Aux.Dec(DEBUG_AUX, localParameter[RIGHT_MOTOR])
  if ||localParameter[LEFT_MOTOR] > localMax or ||localParameter[RIGHT_MOTOR] > localMax
    localParameter[LEFT_MOTOR] := -localMax #> localParameter[LEFT_MOTOR] <# localMax
    localParameter[RIGHT_MOTOR] := -localMax #> localParameter[RIGHT_MOTOR] <# localMax
    Aux.Str(DEBUG_AUX, string(", limited = "))
    Aux.Dec(DEBUG_AUX, localParameter[LEFT_MOTOR])
    Aux.Str(DEBUG_AUX, string(", "))
    Aux.Dec(DEBUG_AUX, localParameter[RIGHT_MOTOR])
    
    'result := pauseForRxFlag
    'pauseForRxFlag := 1
    PauseForRx
    'pauseForRxFlag := result
    
  longmove(pointer, @localParameter, 2)
  
PUB CheckForNunchuck

  Nunchuck.Init(I2C_CLOCK, I2C_DATA)
  Aux.Str(DEBUG_AUX, string("Nunchuck ID = ", QUOTE))   
  SafeDebug(nuchuckIdPtr, 4)
  Aux.Tx(DEBUG_AUX, QUOTE) 
  if long[nuchuckIdPtr] == VALID_NUNCHUCK_ID '$04C4B400
    nunchuckReceiverConnectedFlag := 1
  
PUB CheckPointedUp

  if nunchuckAcceleration[Y_ACCEL] < NUNCHUCK_UP_THRESHOLD
    result := true

PUB CheckPointedDown

  if nunchuckAcceleration[Y_ACCEL] > NUNCHUCK_DOWN_THRESHOLD
    result := true
  
PUB PauseForRx

  if pauseForRxFlag
    Aux.Tx(DEBUG_AUX, 11)
    Aux.Tx(DEBUG_AUX, 13)
    Aux.Str(DEBUG_AUX, @pressToTxt)
    Say(@pressToTxt)
    Aux.Rx(DEBUG_AUX)
  else
    waitcnt(pauseTime + cnt)

PUB DisplayTwoDataPoints(value0, color0, value1, color1, backgroundColor) | freezeError[2]

  value0 := 0 #> value0 <# MAX_LED_INDEX
  value1 := 0 #> value1 <# MAX_LED_INDEX
  
  longfill(@fullBrightnessArray, backgroundColor, LEDS_IN_USE)
  
  fullBrightnessArray[value0] |= color0
  fullBrightnessArray[value1] |= color1
  
  AdjustAndSet(@fullBrightnessArray, brightness, LEDS_IN_USE)
      
PUB DisplayPositionError | freezeError[2]

  longmove(@freezeError, @gDifference, 2)
  longfill(@fullBrightnessArray, 0, LEDS_IN_USE)
  freezeError[0] *= direction[0]
  freezeError[1] *= direction[1]
  if freezeError[0] > freezeError[1]
    OrColors(0, freezeError[0] - freezeError[1] - 1, $FF0000)
  elseif freezeError[0] < freezeError[1]
    OrColors(0, freezeError[1] - freezeError[0] - 1, $FF00)
  AdjustAndSet(@fullBrightnessArray, brightness, LEDS_IN_USE)
      
PUB AdjustAndSet(colorPtr, localBrightness, size)

  size--
  repeat result from 0 to size
    Led.set(result, AdjustBrightness(long[colorPtr][result], localBrightness))
  
PUB AdjustBrightness(color, localBrightness) | localIndex, temp

  repeat localIndex from 0 to 2
    'byte[@result][localIndex] := byte[@color][localIndex] * localBrightness / 255  'doesn't work
    temp := byte[@color][localIndex] * localBrightness / 255
    byte[@result][localIndex] := temp
    
PUB OrColors(firstLed, lastLed, localColor) : colorIndex
  
  firstLed := 0 #> firstLed <# MAX_LED_INDEX
  lastLed := 0 #> lastLed <# MAX_LED_INDEX

  repeat colorIndex from firstLed to lastLed
    fullBrightnessArray[colorIndex] |= localColor

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
                                
controlSerialTxt                byte "SLAVE_CONTROL_SERIAL", 0
                                byte "USB_CONTROL_SERIAL", 0
                                byte "NO_ACTIVE_CONTROL_SERIAL", 0
                                
pressToTxt                      byte "Any key to continue.", 0

  
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

DAT ' color buffers

rainbow                         long RED, ORANGE, YELLOW, CHARTREUSE, GREEN
                                long CYAN, BLUE, INDIGO, VIOLET, REALWHITE
 
DAT ' script buffers

introTempo                      byte "TEMPO 1500", 0
midTempo                        byte "TEMPO 1500", 0
endTempo                        byte "TEMPO 1500", 0
finalTempo                      byte "TEMPO 1500", 0
introSong                       byte "SONG 7", 0
midSong                         byte "SONG 9", 0
endSong                         byte "SONG 3", 0
finalSong                       byte "SONG 3", 0  
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

twoByOneMRectanglePlusTwo8s     word @straightF2000mm, @leftTurn, @straightF1000mm, @leftTurn
                                word @straightF2000mm, @leftTurn, @straightF1000mm, @right180
                                word @straightF1000mm, @rightTurn, @straightF2000mm, @rightTurn
                                word @straightF1000mm, @rightTurn, @straightF2000mm, @left180
                                word @straightF1000mm, @leftTurn, @straightF500mm
                                word @rightCircleF299mm, @leftCircleF299mm
                                word @rightCircleF500mm, @leftCircleF500mm, 0
                                