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
  DEFAULT_LASER_SAMPLES = 4 '8
  MAX_LASER_SAMPLES = 32
  RAW_LASER_BUFFER_SIZE = 12
  'MEDIAN_BUFFER = 8
  'MAX_LASER_SAMPLE_INDEX = LASER_SAMPLES - 1
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
      SERVO_COG_MENU_DEBUG, SERVO_COG_DEBUG

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
  LASER_CALC_DEBUG = SERVO_COG_DEBUG
  
CON 

  
  FILL_LONG = $AA55_55AA   ' used to test stack sizes.
 
  PING_STACK_SIZE = 24 ' It appears the cog monitoring the Pings use 23 longs
  'of the stack.
  SERVO_STACK_SIZE = 356
  
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

  US_PER_CYCLE = 10 '5 
  QUIET_SERVO_PAN = 10 '20 movement noticeable ' 40 too much
  QUIET_SERVO_TILT = 60 'worked once but then because noisy again '40 still noisy ' 20 still noisy
  'OVERSHOOT_CYCLES = QUIET_SERVO_BACKLASH / US_PER_CYCLE
  APPROACH_DISTANCE = 200
  
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

  'ACCELERATION_SLOPE_PAN = -50
  'ACCELERATION_SLOPE_TILT = 50
  SPEED_SLOPE_PAN = -50
  SPEED_SLOPE_TILT = 50
  POINT_SPEED_LIMIT = 20
  'ACCELERATION_MAX_PAN = 10
  'ACCELERATION_MAX_TILT = 10

  CALIBRATION_VERSION = 15_01_15_0

  ' calibrationStatus enumerarion
  #0, NO_LOWER_DATA, NEW_LOW_NO_HIGH_CAL_DATA, NEW_LOW_OLD_HIGH_CAL_DATA, IDENTICAL_CAL_DATA, {
  } INCOMPLETE_CAL_DATA
  
  ' calibrationState enumerarion
  #0, CHECK_FOR_CAL, INITILIZE_CAL, CHOOSE_CAL, USE_CAL, NEW_CAL

  DEFAULT_CAL_STATE = CHECK_FOR_CAL
  
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

  TILT_CAL_MAX = MIDDLE_TILT_DOWN_45
  TILT_CAL_MIN = (MIDDLE_TILT_DOWN_45 + MIDDLE_TILT_HORIZONTAL) / 2

  PAN_CAL_MAX = MIDDLE_PAN_CENTER + 250 '' start cal position
  PAN_CAL_MIN = MIDDLE_PAN_CENTER - 250

  PAN_CAL_POINTS = 5 '10 '20
  PAN_CAL_GAPS = PAN_CAL_POINTS - 1
  
  TILT_CAL_POINTS = 3 '5 '10
  TILT_CAL_GAPS = TILT_CAL_POINTS - 1

  CAL_GRID_SIZE = PAN_CAL_POINTS * TILT_CAL_POINTS
  MAX_CAL_GRID_INDEX = CAL_GRID_SIZE - 1

  SINGLE_LONGS_IN_CAL_DATA = 12
  TILT_ARRAYS_IN_CAL_DATA = 4
  LONGS_OF_CAL_DATA = (CAL_GRID_SIZE * 2) + (TILT_ARRAYS_IN_CAL_DATA * TILT_CAL_POINTS) + {
  } SINGLE_LONGS_IN_CAL_DATA
  PREVIOUS_CAL_LONGS = (TILT_ARRAYS_IN_CAL_DATA * TILT_CAL_POINTS) + 2
  
CON
  
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
  
  ' lrfServoMode enumeration
  #0, AUTO_LRF_MODE, NUNCHUCK_LRF_MODE, MASTER_CONTROL_LRF_MODE

  ' sensorServoMode enumeration
  #0, AUTO_SERVO_MODE, NUNCHUCK_SERVO_MODE, MASTER_CONTROL_SERVO_MODE

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

  long servoControlStack[SERVO_STACK_SIZE]
  
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
  long laserTargetX, laserTargetY, laserTargetZ, correctedZ
  long previousServoPosition[NUMBER_OF_SERVOS]
  long joyX, joyY
  long nunchuckAcceleration[3]
  long nuchuckIdPtr
  long pointSpeed[2], pointAcceleration[2]
  long panDegrees10, tiltDegrees10
  long previousLedMessage, ledMessage[2 * Header#SEVEN_SEGMENTS_IN_USE]
  long ledMessageTime, ledMessageTimer, rangeZ, previousTargetZ
  long bufferIndex
  long scanDistanceBuffer[CAL_GRID_SIZE], scanXBuffer[CAL_GRID_SIZE]
  long scanYBuffer[CAL_GRID_SIZE], scanZBuffer[CAL_GRID_SIZE]
  long scanZMin[TILT_CAL_POINTS], scanZMax[TILT_CAL_POINTS]
  long scanZRange[TILT_CAL_POINTS], scanZAve[TILT_CAL_POINTS]
  long scanZRangeMin, scanZRangeMax, correctedZBuffer[CAL_GRID_SIZE]
  long scanZMinIndex, scanZMaxIndex, scanZAbsMin, scanZAbsMax
  long scanZMinPan, scanZMaxPan
  long scanZMinTilt, scanZMaxTilt, scanZAveScan
  long comparisons, swaps, medianBuffer[MAX_LASER_SAMPLES]
  
  byte pingsInUse, maxPingIndex
  byte inputBuffer[BUFFER_LENGTH], outputBuffer[BUFFER_LENGTH] 
  byte inputIndex, parseIndex, outputIndex
  byte pingPauseFlag
  byte previouslrfServoMode, lrfServoMode, sensorMode
  byte rightX, rightY, nunchuckButton, previousButton
  byte badDataFlag, nunchuckReadyFlag, nunchuckReceiverConnectedFlag
  byte rawLaserInput[RAW_LASER_BUFFER_SIZE]
  byte menuSelect
       
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

servoCalTiltMax                 long MIDDLE_TILT_DOWN_45 ' start cal position
servoCalTiltMin                 long (MIDDLE_TILT_DOWN_45 + MIDDLE_TILT_HORIZONTAL) / 2
                                                                                                
controlFrequency                long DEFAULT_CONTROL_FREQUENCY
halfInterval                    long DEFAULT_HALF_INTERVAL

stopServoFlag                   long 0

calibrationVersion              long 0-0 'CALIBRATION_VERSION
calibrationStatus               long NO_LOWER_DATA
calibrationPanSlope             long 0-0
calibrationTiltSlope            long 0-0
calibrationPanMin               long PAN_CAL_MIN
calibrationPanMax               long PAN_CAL_MAX  ' move from max to min
calibrationTiltMin              long TILT_CAL_MIN
calibrationTiltMax              long TILT_CAL_MAX  ' move from max to min 
calibrationPanPoints            long PAN_CAL_POINTS
calibrationTiltPoints           long TILT_CAL_POINTS
calibrationZRangeMin            long 0-0
calibrationZRangeMax            long 0-0
calibrationZMin                 long 0-0[TILT_CAL_POINTS]
calibrationZMax                 long 0-0[TILT_CAL_POINTS]
calibrationZRange               long 0-0[TILT_CAL_POINTS]
calibrationZAve                 long 0-0[TILT_CAL_POINTS]

calibrationDBuffer              long 0-0[CAL_GRID_SIZE]
calibrationZBuffer              long 0-0[CAL_GRID_SIZE]

previousZRangeMin               long 0-0
previousZRangeMax               long 0-0
previousZMin                    long 0-0[TILT_CAL_POINTS]
previousZMax                    long 0-0[TILT_CAL_POINTS]
previousZRange                  long 0-0[TILT_CAL_POINTS]
previousZAve                    long 0-0[TILT_CAL_POINTS]
rangesToSample                  long DEFAULT_LASER_SAMPLES
'maxLaserSampleIndex             long DEFAULT_LASER_SAMPLES - 1
strainReducingAdjustment        long QUIET_SERVO_PAN, QUIET_SERVO_TILT

debugFlag                       byte SERVO_COG_DEBUG 'FULL_DEBUG
                      
mode                            byte 0                  ' Current mode of the control system
controlSerial                   byte NO_ACTIVE_CONTROL_SERIAL

activeServo                     byte 6

servoPins                       byte PORT_PAN_PIN, PORT_TILT_PIN
                                byte MIDDLE_PAN_PIN, MIDDLE_TILT_PIN
                                byte STARBOARD_PAN_PIN, STARBOARD_TILT_PIN

sensorServoMode                 byte AUTO_SERVO_MODE

calibrationState                byte DEFAULT_CAL_STATE

sevenSegmentBrightness          byte Header#DEFAULT_7_SEGMENT_BRIGHTNESS
                         
OBJ                             
                                
  Header : "HeaderCleaver"         
  
  'Com : "FullDuplexSerial4portB"                        ' uses one cog
  'ComIo : "DataIo4PortB"

  F32 : "F32"
                                                        ' uses one cog
  'Aux : "FullDuplexSerial4port"                         ' uses one cog
  Aux : "DataIo4PortLocks"
  Ping : "EddiePingMonitor"                             ' uses one cog
  
  Servo : "Servo32v9Shared"                             ' uses one cog

  Leds : "jm_max7219c"
  
  Nunchuck : "jm_nunchuk_ez_v3"

  I2c : "jm_i2c_basic"
  
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
  Aux.SetLock
  {Aux.Rx(DEBUG_AUX)
  result := LongMedian(@testData, 8)
  Aux.Str(DEBUG_AUX, string(11, 13, "LongMedian := "))
  Aux.Dec(DEBUG_AUX, result)
   
  Aux.Str(DEBUG_AUX, string(11, 13, "comparisons := "))
  Aux.Dec(DEBUG_AUX, comparisons)
  Aux.Str(DEBUG_AUX, string(", swaps := "))
  Aux.Dec(DEBUG_AUX, swaps)
   
  repeat }

  {
  Leds.init(Header#SEVEN_SEGMENT_LATCH, Header#SEVEN_SEGMENT_DATA, {
  } Header#SEVEN_SEGMENT_CLOCK, Header#SEVEN_SEGMENTS_IN_USE, sevenSegmentBrightness)
  }
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
  Aux.Strse(DEBUG_AUX, string(11, 13, "After InitializeServos"))
  F32.Start
  Aux.Strs(DEBUG_AUX, string(11, 13, "After F32.Start"))
  Nunchuck.Init(Header#WII_CLOCK_SLAVE, Header#WII_DATA_SLAVE)
  I2c.Init(Header#WII_CLOCK_SLAVE, Header#WII_DATA_SLAVE) ' use same I2C driver with EEPROM
  'ServoControl
  Aux.Stre(DEBUG_AUX, string(11, 13, "After Nunchuck.Init"))
  cognew(ServoControl, @servoControlStack)   
  Aux.Strse(DEBUG_AUX, string(11, 13, "After cognew"))
  activeParameter := @rangesToSample
  activeParTxtPtr := @rangesToSampleTxt

  MainLoop

PUB MainLoop | rxcheck, lastDebugTime

  Aux.Strse(DEBUG_AUX, string(11, 13, "Starting MainLoop"))  
  lastComTime := cnt
  repeat
    mainLoopCount++
    'Aux.Str(DEBUG_AUX, string(11, 13, "mainLoopCount"))
    'Aux.Dec(DEBUG_AUX, mainLoopCount) 
    result := CheckSerial
    DigestCharacter(result)

    'Aux.Str(DEBUG_AUX, string(11, 13, "Before GetLaserRange call."))
    
    'laserDistance := GetLaserRange
    'Aux.Str(DEBUG_AUX, string(11, 13, "After GetLaserRange call."))
    Aux.Lock
    GetNunchuckData
    Aux.E
    'if laserDistance <> Header#INVALID_LASER_READING
    '  CalculateLaserPosition(laserDistance, @laserTargetX)
      'Com.Str(string("LSR "))
    'menuSelect := nunchuckButton
      
    if debugFlag => MAIN_DEBUG and debugFlag < SERVO_COG_DEBUG
      Aux.Lock
      TempDebug
      Aux.E
        
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
          Aux.Hex(DEBUG_AUX, localCharacter, 2)
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
    elseif activeParTxtPtr == @rangesToSample
      rangesToSample := 0 #> rangesToSample <# MAX_LASER_SAMPLES
    inputIndex--
    controlSerial := NO_ACTIVE_CONTROL_SERIAL
    lastComTime := cnt
                  
PRI TempDebug
 
  Aux.Tx(DEBUG_AUX, 11)
  Aux.Tx(DEBUG_AUX, 1) ' home
  Aux.Str(DEBUG_AUX, string(11, 13, "CleaverSlave"))

  Aux.Str(DEBUG_AUX, string(", mode = "))
  Aux.Dec(DEBUG_AUX, mode)
  Aux.Str(DEBUG_AUX, string(" = "))
  Aux.Str(DEBUG_AUX, FindString(@modeAsText, mode)) 
      'controlSerialTxt
  Aux.Str(DEBUG_AUX, string(11, 13, "activeParameter = "))
  Aux.Str(DEBUG_AUX, activeParTxtPtr)  
  Aux.Str(DEBUG_AUX, string(" = "))
  Aux.Dec(DEBUG_AUX, long[activeParameter])   
  Aux.Str(DEBUG_AUX, string(11, 13, "mainLoopCount = "))
  Aux.Dec(DEBUG_AUX, mainLoopCount)  
  DisplayServoData

  DisplayLaserData
  
   {
  if debugFlag => PING_DEBUG
    Aux.Str(DEBUG_AUX, string(11, 13, "pingCount = "))
    Aux.Dec(DEBUG_AUX, pingCount)
    Aux.Str(DEBUG_AUX, string(", pingMask = "))
    Aux.Dec(DEBUG_AUX, pingMask)
    Aux.Str(DEBUG_AUX, string(", pingInterval = "))
    Aux.Dec(DEBUG_AUX, pingInterval)
    
    Aux.Str(DEBUG_AUX, string(", pingResults = "))
    Aux.Dec(DEBUG_AUX, pingResults[0])
    Aux.Str(DEBUG_AUX, string(", "))
    Aux.Dec(DEBUG_AUX, pingResults[1])
   }
  'PingStackDebug(port) 
                
  Aux.Tx(DEBUG_AUX, 11)
  Aux.Tx(DEBUG_AUX, 13)
      
PUB DisplayServoData

  Aux.Str(DEBUG_AUX, string(11, 13, "DisplayServoData"))  
  repeat result from 0 to 5
    Aux.Str(DEBUG_AUX, string(11, 13, "servoPosition["))
    Aux.Dec(DEBUG_AUX, result)
    Aux.Str(DEBUG_AUX, string("] = "))
    Aux.Dec(DEBUG_AUX, servoPosition[result]) 
    Aux.Str(DEBUG_AUX, string(", servoPeriod = "))
    Aux.Dec(DEBUG_AUX, servoPeriod[result]) 
    Aux.Str(DEBUG_AUX, string(", servoPhase = "))
    Aux.Dec(DEBUG_AUX, servoPhase[result]) 
       
PUB DisplayLaserData

  if laserDistance == Header#INVALID_LASER_READING
    Aux.Str(DEBUG_AUX, string(11, 13, "Laser Data Invalid"))
    return
  Aux.Str(DEBUG_AUX, string(11, 13, "laserDistance = "))
  Aux.Dec(DEBUG_AUX, laserDistance) 

  Aux.Str(DEBUG_AUX, string(11, 13, "calibrationState = "))
  Aux.Str(DEBUG_AUX, FindString(@calibrationStateAsText, calibrationState))
  
  Aux.Str(DEBUG_AUX, string(11, 13, "Laser Target (XYZ) = "))
  Aux.Dec(DEBUG_AUX, laserTargetX)
  Aux.Str(DEBUG_AUX, string(", "))
  Aux.Dec(DEBUG_AUX, laserTargetY)
  Aux.Str(DEBUG_AUX, string(", "))
  Aux.Dec(DEBUG_AUX, laserTargetZ)
  'Leds.Dec(2, laserTargetX) 
  'Leds.Dec(1, laserTargetY) 
  'Leds.Dec(0, laserTargetZ)
  'Leds.DecSmall(4, laserTargetX, 0)

  if ledMessage[0] := @startCalLed0
    TempLedMessage
  else
    DisplayLaserLeds 
   { Leds.DecSmall(4, laserTargetX, 0) 
    Leds.DecSmall(5, laserDistance, 2)
    Leds.DecSmall(2, laserTargetY, 0) 
    Leds.DecSmall(0, laserTargetZ, 0)
    Leds.DecSmall(3, panDegrees10, 1) 
    Leds.DecSmall(1, tiltDegrees10, 1)
    
  case calibrationState
      CHECK_FOR_CAL:
        'CheckCalibration
      INITILIZE_CAL:
        'InitilizeCalibration
      NEW_CAL:

      USE_CAL:  }
      
  Aux.Str(DEBUG_AUX, string(11, 13, "Pan  = "))
  Aux.DecDp(DEBUG_AUX, panDegrees10, 1)
  Aux.Str(DEBUG_AUX, string(" degrees from forward, "))
  Aux.Str(DEBUG_AUX, string(11, 13, "Tilt = "))
  Aux.DecDp(DEBUG_AUX, tiltDegrees10, 1)
  Aux.Str(DEBUG_AUX, string(" degrees down from level"))  

  'NO_DECIMAL_POINT
  
  {Leds.DecSmall(0, 1234) 
  Leds.DecSmall(1, 111) 
  Leds.DecSmall(2, 222)
  Leds.DecSmall(3, 333) 
  Leds.DecSmall(4, 444) 
  Leds.DecSmall(5, 555) }
  '4,5
  '2,3
  '0,1 
  Aux.Str(DEBUG_AUX, string(11, 13, "Laser Servos Pan  = "))
  Aux.Dec(DEBUG_AUX, servoPosition[2])
  Aux.Str(DEBUG_AUX, string(11, 13, "Laser Servos Tilt = "))
  Aux.Dec(DEBUG_AUX, servoPosition[3])
  Aux.Str(DEBUG_AUX, string(11, 13, "Buffer Index = "))
  Aux.Dec(DEBUG_AUX, bufferIndex)
  Aux.Str(DEBUG_AUX, string(11, 13, "calibrationBuffer = "))

  'DisplayDZBuffer(@calibrationDBuffer, @calibrationZBuffer, CAL_GRID_SIZE)
  
PUB DisplayDZBuffer(DBufferPtr, ZBufferPtr, size)

  repeat result from 0 to MAX_CAL_GRID_INDEX
    if result // PAN_CAL_POINTS == 0
      Aux.Tx(DEBUG_AUX, 11)
      Aux.Tx(DEBUG_AUX, 13)
    else
      Aux.Tx(DEBUG_AUX, ",")
      Aux.Tx(DEBUG_AUX, " ")
    Aux.Tx(DEBUG_AUX, "[")
    Aux.Dec(DEBUG_AUX, long[DBufferPtr][result])

    Aux.Tx(DEBUG_AUX, "]")  
    Aux.Tx(DEBUG_AUX, " ")  
    Aux.Dec(DEBUG_AUX, long[ZBufferPtr][result])
    
PUB DisplayCalComparison

  Aux.Str(DEBUG_AUX, string(11, 13, "DisplayCalComparison"))
  Aux.Str(DEBUG_AUX, string(11, 13, "ZRangeMin: old = "))
  Aux.Dec(DEBUG_AUX, previousZRangeMin)
  Aux.Str(DEBUG_AUX, string(", new = "))
  Aux.Dec(DEBUG_AUX, calibrationZRangeMin)
  Aux.Str(DEBUG_AUX, string(11, 13, "ZRangeMax: old = "))
  Aux.Dec(DEBUG_AUX, previousZRangeMax)
  Aux.Str(DEBUG_AUX, string(", new = "))
  Aux.Dec(DEBUG_AUX, calibrationZRangeMax)

  repeat result from 0 to TILT_CAL_GAPS
    Aux.Str(DEBUG_AUX, string(11, 13, "ZMin: "))
    Aux.Dec(DEBUG_AUX, previousZMin[result])
    Aux.Str(DEBUG_AUX, string(", "))
    Aux.Dec(DEBUG_AUX, calibrationZMin[result])
    Aux.Str(DEBUG_AUX, string(", ZMax: "))
    Aux.Dec(DEBUG_AUX, previousZMax[result])
    Aux.Str(DEBUG_AUX, string(", "))
    Aux.Dec(DEBUG_AUX, calibrationZMax[result])
    Aux.Str(DEBUG_AUX, string(", ZRange: "))
    Aux.Dec(DEBUG_AUX, previousZRange[result])
    Aux.Str(DEBUG_AUX, string(", "))
    Aux.Dec(DEBUG_AUX, calibrationZRange[result])
    Aux.Str(DEBUG_AUX, string(", ZAve: "))
    Aux.Dec(DEBUG_AUX, previousZAve[result])
    Aux.Str(DEBUG_AUX, string(", "))
    Aux.Dec(DEBUG_AUX, calibrationZAve[result])
   
PUB DisplayCalData(rangeExtremePtr, zMinPtr, zMaxPtr, zRangePtr, zAvePtr)

  Aux.Str(DEBUG_AUX, string(11, 13, "DisplayCalData"))
  Aux.Str(DEBUG_AUX, string(11, 13, "ZRangeMin = "))
  Aux.Dec(DEBUG_AUX, long[rangeExtremePtr])
  Aux.Str(DEBUG_AUX, string(11, 13, "ZRangeMax = "))
  Aux.Dec(DEBUG_AUX, long[rangeExtremePtr][1])
  if rangeExtremePtr == @scanZRangeMin
    Aux.Str(DEBUG_AUX, string(11, 13, "Over All Average = "))
    Aux.Dec(DEBUG_AUX, scanZAveScan)
    Aux.Str(DEBUG_AUX, string(11, 13, "Over All Minimum = "))
    Aux.Dec(DEBUG_AUX, scanZAbsMin)
    Aux.Str(DEBUG_AUX, string(", # "))
    Aux.Dec(DEBUG_AUX, scanZMinIndex)
    Aux.Str(DEBUG_AUX, string(", pan = "))
    Aux.Dec(DEBUG_AUX, scanZMinPan)
    Aux.Str(DEBUG_AUX, string(", tilt "))
    Aux.Dec(DEBUG_AUX, scanZMinTilt)
    Aux.Str(DEBUG_AUX, string(11, 13, "Over All Maximum = "))
    Aux.Dec(DEBUG_AUX, scanZAbsMax)
    Aux.Str(DEBUG_AUX, string(", # "))
    Aux.Dec(DEBUG_AUX, scanZMaxIndex)
    Aux.Str(DEBUG_AUX, string(", pan = "))
    Aux.Dec(DEBUG_AUX, scanZMaxPan)
    Aux.Str(DEBUG_AUX, string(", tilt "))
    Aux.Dec(DEBUG_AUX, scanZMaxTilt)
    
  repeat result from 0 to TILT_CAL_GAPS
    Aux.Str(DEBUG_AUX, string(11, 13, "ZMin = "))
    Aux.Dec(DEBUG_AUX, long[zMinPtr][result])
    Aux.Str(DEBUG_AUX, string(", ZMax = "))
    Aux.Dec(DEBUG_AUX, long[zMaxPtr][result])
    Aux.Str(DEBUG_AUX, string(", ZRange = "))
    Aux.Dec(DEBUG_AUX, long[zRangePtr][result])
    Aux.Str(DEBUG_AUX, string(", ZAve = "))
    Aux.Dec(DEBUG_AUX, long[zAvePtr][result])
  Aux.Tx(DEBUG_AUX, 11)
  Aux.Tx(DEBUG_AUX, 13)
       
PUB DisplayLaserLeds 
    
    
  case calibrationState
    CHECK_FOR_CAL:
      LedStr(startCalLed0)
    INITILIZE_CAL:
      Leds.DecSmall(4, laserTargetX, 0) 
      Leds.DecSmall(5, laserDistance, 2)
      Leds.DecSmall(2, laserTargetY, 0) 
      Leds.DecSmall(0, laserTargetZ, 0)
      Leds.DecSmall(3, tiltDegrees10, 1) 
      Leds.DecSmall(1, rangeZ, 1)
    NEW_CAL:
      Leds.DecSmall(4, laserTargetX, 0) 
      Leds.DecSmall(5, laserDistance, 2)
      Leds.DecSmall(2, laserTargetY, 0) 
      Leds.DecSmall(0, laserTargetZ, 0)
      Leds.DecSmall(3, tiltDegrees10, 1) 
      Leds.DecSmall(1, previousTargetZ, 0)
    USE_CAL:
      Leds.DecSmall(4, laserTargetX, 0) 
      Leds.DecSmall(5, laserDistance, 2)
      Leds.DecSmall(2, laserTargetY, 0) 
      Leds.DecSmall(0, correctedZ, 0)
      Leds.DecSmall(3, panDegrees10, 1) 
      Leds.DecSmall(1, tiltDegrees10, 1)
     
  Aux.Str(DEBUG_AUX, string(11, 13, "Pan  = "))
  Aux.DecDp(DEBUG_AUX, panDegrees10, 1)
  Aux.Str(DEBUG_AUX, string(" degrees from forward, "))
  Aux.Str(DEBUG_AUX, string(11, 13, "Tilt = "))
  Aux.DecDp(DEBUG_AUX, tiltDegrees10, 1)
  Aux.Str(DEBUG_AUX, string(" degrees down from level"))
  'menuSelect nunchuckButton
   {saveCalLed0                     byte $02, Leds#_C, Leds#DASH, Leds#_S, Leds#_A, Leds#_u, Leds#_E, 0
saveCalLed1                     byte $01, Leds#_2, Leds#DASH, Leds#_L, Leds#_o2, Leds#_S, Leds#_E, 0
saveCalLed2                     byte $00, Leds#_C, Leds#_A, Leds#_L, 0

backupCalLed0                   byte $02, Leds#_C, Leds#DASH, Leds#_B, Leds#_A, Leds#_C, Leds#_U, Leds#_P, 0
backupCalLed1                   byte $01, Leds#_2, Leds#DASH, Leds#_n, Leds#_o2, 0
backupCalLed2                   byte $00, Leds#_C, Leds#_A, Leds#_L, 0

restoreCalLed0                  byte $02, Leds#_C, Leds#DASH, Leds#_H, Leds#_I, Leds#_G, Leds#_H, 0
restoreCalLed1                  byte $01, Leds#_2, Leds#DASH, Leds#_L, Leds#_o2, 0
restoreCalLed2                  byte $00, Leds#_C, Leds#_A, Leds#_L, 0
}
PUB TempLedMessage

  if previousLedMessage == 0
    if ledMessageTime
      ledMessageTimer := cnt
      ledMessageTime *= MILLISECOND
    repeat result from 0 to 5
      if ledMessage[result]
        LedStr(ledMessage[result])
  elseif ledMessageTime == 0
    if menuSelect
      longfill(@ledMessage, 0, 2 * Header#SEVEN_SEGMENTS_IN_USE)
  elseif cnt - ledMessageTimer > ledMessageTime
    longfill(@ledMessage, 0, 2 * Header#SEVEN_SEGMENTS_IN_USE)
        
  previousLedMessage := ledMessage[0]

PUB LedDebugCal

  Leds.DecSmall(4, laserTargetX, 0) 
  Leds.DecSmall(5, laserDistance, 2)
  Leds.DecSmall(2, laserTargetY, 0) 
  Leds.DecSmall(0, laserTargetZ, 0)
  Leds.DecSmall(3, panDegrees10, 1) 
  Leds.DecSmall(1, tiltDegrees10, 1)
      
PUB LedDebugScan

  Leds.DecSmall(4, laserTargetX, 0) 
  Leds.DecSmall(5, laserDistance, 2)
  Leds.DecSmall(2, laserTargetY, 0) 
  Leds.DecSmall(0, correctedZ, 0)
  Leds.DecSmall(3, panDegrees10, 1) 
  Leds.DecSmall(1, tiltDegrees10, 1)
      
PUB LedStr(pointer)

  case byte[pointer]
    0..$0F:
      LedStrFull(byte[pointer], pointer)
    $10..$1F:
      LedStrSmall(byte[pointer] & $F, pointer)
      
PRI LedStrFull(displayId, pointer) : emptyDigits | register
'' Returns the number of digits left blank.
  
  register := Leds#DIG_7
  
  repeat 8
    if byte[pointer] and emptyDigits == 0
      Leds.outTo(displayId, register--, byte[pointer++])
    else
      emptyDigits++
      Leds.outTo(displayId, register--, 0)
  
PRI LedStrSmall(displayId, pointer) : emptyDigits | register
'' Returns the number of digits left blank.

  if displayId // 2
    register := Leds#DIG_3
  else
    register := Leds#DIG_7
    
  displayId /= 2

  repeat 4
    if byte[pointer] and emptyDigits == 0
      Leds.outTo(displayId, register--, byte[pointer++])
    else
      emptyDigits++
      Leds.outTo(displayId, register--, 0)
      
PUB PingStackDebug(port)

  Aux.Str(DEBUG_AUX, string(11, 13, "Ping Stack = ", 11, 13))
  DumpBufferLong(@pingStack, PING_STACK_SIZE, 12)

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
  elseif strcomp(@InputBuffer, string("LS")) ' laser samples       
    parameter[0] := ParseDec(NextParameter)
    CheckLastParameter
    rangesToSample := parameter[0]
    activeParameter := @rangesToSample
    activeParTxtPtr := @rangesToSampleTxt
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
  {Aux.Strs(DEBUG_AUX, string(11, 13, "WriteEEPROM($"))
  Aux.Hex(DEBUG_AUX, startAddr, 4)
  Aux.Str(DEBUG_AUX, string(", $"))
  Aux.Hex(DEBUG_AUX, endAddr, 4)
  Aux.Str(DEBUG_AUX, string(", $"))
  Aux.Hex(DEBUG_AUX, eeStart, 4)}
  addr := startAddr                                     ' Initialize main RAM index
  eeAddr := eeStart                                     ' Initialize EEPROM index
  repeat
    page := addr +PAGE_SIZE -eeAddr // PAGE_SIZE <# endaddr +1 ' Find next EEPROM page boundary
    SetAddr(eeAddr)                                     ' Give EEPROM starting address
    {Aux.Str(DEBUG_AUX, string(11, 13, "addr = $"))
    Aux.Hex(DEBUG_AUX, addr, 4)
    Aux.Str(DEBUG_AUX, string(", page = $"))
    Aux.Hex(DEBUG_AUX, page, 4)
    Aux.Str(DEBUG_AUX, string(", eeaddr = $"))
    Aux.Hex(DEBUG_AUX, eeaddr, 4)
    Aux.Str(DEBUG_AUX, string(11, 13, "writing bytes at $"))
    }
    repeat                                              ' Bytes -> EEPROM until page boundary
      'Aux.Hex(DEBUG_AUX, addr, 4)
      'Aux.Str(DEBUG_AUX, string(", $"))
      SendByte(byte[addr++])
    until addr == page
    i2cstop                                             ' From 24LC256's page buffer -> EEPROM
    eeaddr := addr - startAddr + eeStart                ' Next EEPROM starting address
  until addr > endAddr                                  ' Quit when RAM index > end address
  {Aux.Str(DEBUG_AUX, string(11, 13, "End of WriteEEPROM. Press any key to continue"))
  Aux.Rx(DEBUG_AUX)
  Aux.E }
  
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
    Aux.Dec(EMIC_AUX, value)
  Aux.Tx(EMIC_AUX, 13)

  result := Aux.Rx(EMIC_AUX)
       }
PRI ServoControl | nextCnt, extremeIndex

  Leds.init(Header#SEVEN_SEGMENT_LATCH, Header#SEVEN_SEGMENT_DATA, {
  } Header#SEVEN_SEGMENT_CLOCK, Header#SEVEN_SEGMENTS_IN_USE, sevenSegmentBrightness)
    
  'Nunchuck.Init(Header#WII_CLOCK_SLAVE, Header#WII_DATA_SLAVE)
  'I2c.Init(Header#WII_CLOCK_SLAVE, Header#WII_DATA_SLAVE)
  
  nextCnt := cnt + controlInterval
  if debugFlag => SERVO_COG_DEBUG
    Aux.Strse(DEBUG_AUX, string(11, 13, "ServoControl")) 
     
  repeat 'while calibrationState < USE_CAL
    if debugFlag => SERVO_COG_DEBUG
      Aux.Strs(DEBUG_AUX, string(11, 13, "calibrationState = ")) 
      Aux.Stre(DEBUG_AUX, FindString(@calibrationStateAsText, calibrationState))
    case calibrationState
      CHECK_FOR_CAL:
        CheckCalibration
      INITILIZE_CAL:
        InitilizeCalibration
      CHOOSE_CAL:
        ChooseWhichCal
      USE_CAL:
        Scan
        if debugFlag => SERVO_COG_DEBUG
          DisplayCalData(@scanZRangeMin, @scanZMin, @scanZMax, @scanZRange, @scanZAve)
          'scanZAveScan  
        result := WaitForC(30 + TILT_CAL_POINTS)
        if result == 0
          extremeIndex := TargetExtreme(2)
          WaitForCWhileScanning(20 + TILT_CAL_POINTS, extremeIndex)
          outa[Header#RED_LASER_TOP] := 0
          outa[Header#RED_LASER_BOTTOM] := 0
          dira[Header#RED_LASER_TOP] := 0
          dira[Header#RED_LASER_BOTTOM] := 0
      NEW_CAL:
        NewCalibration
        
  if debugFlag => SERVO_COG_DEBUG
    Aux.Strse(DEBUG_AUX, string(7, 11, 13, "****** Calibration Done ******", 7)) 
  waitcnt(clkfreq * 2 + cnt)
    
  repeat   '*** use and new go here
    waitcnt(nextCnt += controlInterval)
    case stopServoFlag
      0:
        AdvanceServos
      other:
        PointServos  
      
PRI CheckCalibration | status

  if calibrationVersion == CALIBRATION_VERSION   
    case calibrationStatus
      NO_LOWER_DATA: ' this shouldn't happen
        calibrationState := INITILIZE_CAL 
      NEW_LOW_NO_HIGH_CAL_DATA:
        result := ChooseToBackupLow
        if result
          CopyLowToHigh
          calibrationState := USE_CAL
        else
          ClearLowCal
          calibrationState := INITILIZE_CAL  
      NEW_LOW_OLD_HIGH_CAL_DATA: ' new data was lost
        result := ChooseWhichCal
        if result
          CopyHighToLow
        else
          CopyLowToHigh
        calibrationState := USE_CAL    
      IDENTICAL_CAL_DATA:
        calibrationState := USE_CAL
        
  else  
    ReadEEPROM(@result, @result + 3, Header#CALIBRATION_VERSION_EEPROM)
    if result == CALIBRATION_VERSION
      ReadEEPROM(@calibrationVersion, @calibrationVersion + (LONGS_OF_CAL_DATA * 4) - 1, {
      } Header#CALIBRATION_VERSION_EEPROM)
      case calibrationStatus
        NO_LOWER_DATA: ' this shouldn't happen
          calibrationState := INITILIZE_CAL 
        NEW_LOW_NO_HIGH_CAL_DATA: ' this shouldn't happen 
          calibrationState := INITILIZE_CAL
        NEW_LOW_OLD_HIGH_CAL_DATA, IDENTICAL_CAL_DATA: ' new data was lost 
          CopyHighToLow
          calibrationState := USE_CAL    
       
    else
      calibrationState := INITILIZE_CAL

'NO_LOWER_DATA, NEW_LOW_NO_HIGH_CAL_DATA, NEW_LOW_OLD_HIGH_CAL_DATA, IDENTICAL_CAL_DATA
 'calibrationStatus  
PUB InitilizeCalibration | targetPosition[6], panIndex, tiltIndex, {
} validReadingsThisTilt

  'NO_LOWER_DATA, NEW_LOW_NO_HIGH_CAL_DATA, NEW_LOW_OLD_HIGH_CAL_DATA, IDENTICAL_CAL_DATA
  'calibrationStatus 
  Calibration
  DisplayCalData(@calibrationZRangeMin, @calibrationZMin, @calibrationZMax, @calibrationZRange, @calibrationZAve)
  result := ChooseToSaveLow
  if result
    calibrationVersion := CALIBRATION_VERSION
    calibrationStatus := NEW_LOW_NO_HIGH_CAL_DATA
    WriteEEPROM(@calibrationVersion, @calibrationVersion + (LONGS_OF_CAL_DATA * 4) - 1, {
     } @calibrationVersion)
    calibrationState := USE_CAL
{  calibrationStatus
#0, NO_LOWER_DATA, NEW_LOW_NO_HIGH_CAL_DATA, NEW_LOW_OLD_HIGH_CAL_DATA, IDENTICAL_CAL_DATA, {
  } INCOMPLETE_CAL_DATA

  calibrationState
  #0, CHECK_FOR_CAL, INITILIZE_CAL, CHOOSE_CAL, USE_CAL, NEW_CAL
}
PRI Calibration | targetPosition[6], panIndex, tiltIndex, {
} validReadingsThisTilt
'' The tilt servo starts pointing down and move up.
'' The pan servo starts to the port side and moves back and forth.
'' The calibration data is recorded during both directions of the
'' pan servo's motion. The data is recorded starting with the points
'' closest to the robot and added from left to right. While data
'' is located in memory from left to right, the points are scanned
'' with the pan servo moving both left to right and also right to
'' left while moving right to left, the memory locations are decreasing.
  
  bufferIndex := 0
  
  calibrationPanSlope := (calibrationPanMax - calibrationPanMin) * SCALED_MULTIPLIER / {
  } PAN_CAL_POINTS
  calibrationTiltSlope := (calibrationTiltMax - calibrationTiltMin) * SCALED_MULTIPLIER / {
  } TILT_CAL_POINTS 

  'longmove(@targetPosition, @servoPosition, Header#SERVOS_IN_USE)
  'targetPosition[2] := calibrationPanMin
  'targetPosition[3] := calibrationTiltMax
  'Aux.Lock
  'MoveFromLowerLeft(@targetPosition, US_PER_CYCLE)
  'Aux.E
  longmove(@targetPosition, @servoPosition, Header#SERVOS_IN_USE)
  
  repeat tiltIndex from 0 to TILT_CAL_GAPS
    targetPosition[3] := calibrationTiltMax - (tiltIndex * calibrationTiltSlope / {
    } SCALED_MULTIPLIER)
    'Aux.Lock
    'MoveFromLowerLeft(@targetPosition, US_PER_CYCLE)
    'Aux.E
    'longmove(@targetPosition, @servoPosition, Header#SERVOS_IN_USE)
    validReadingsThisTilt := 0
    calibrationZAve[tiltIndex] := 0

    'bufferIndex := (tiltIndex * PAN_CAL_POINTS) - 1
    {if debugFlag => SERVO_COG_DEBUG
      Aux.Strs(DEBUG_AUX, string(11, 13, "bufferIndex = "))
      Aux.Dec(DEBUG_AUX, bufferIndex)
      Aux.Str(DEBUG_AUX, string(", tiltIndex = ")) 
      Aux.Dece(DEBUG_AUX, tiltIndex)}    
    repeat panIndex from 0 to PAN_CAL_GAPS
      targetPosition[2] := calibrationPanMax - (panIndex * calibrationPanSlope / {
      } SCALED_MULTIPLIER)
      
 
      {if debugFlag => SERVO_COG_DEBUG
        Aux.Strs(DEBUG_AUX, string(11, 13, "bufferIndex = ")) 
        Aux.Dec(DEBUG_AUX, bufferIndex)
        Aux.Str(DEBUG_AUX, string(", panIndex = ")) 
        Aux.Dec(DEBUG_AUX, panIndex)
        Aux.Str(DEBUG_AUX, string(", tiltIndex = ")) 
        Aux.Dece(DEBUG_AUX, tiltIndex)}
      'Aux.Lock   
      MoveFromLowerLeft(@targetPosition, US_PER_CYCLE)
      'Aux.E
      longmove(@targetPosition, @servoPosition, Header#SERVOS_IN_USE)
      'laserDistance := GetLaserRange
      laserDistance := GetLaserRangeMedian(@medianBuffer, rangesToSample)
      
      {if debugFlag => SERVO_COG_DEBUG
        Aux.Strs(DEBUG_AUX, string(11, 13, "rawLaserInput = ")) 
        Aux.Stre(DEBUG_AUX, @rawLaserInput) }
      
      if laserDistance <> Header#INVALID_LASER_READING
        CalculateLaserPosition(laserDistance, servoPosition[2], servoPosition[3], @laserTargetX)
        validReadingsThisTilt++
        if validReadingsThisTilt == 1
          calibrationZMin[tiltIndex] := laserTargetZ
          calibrationZMax[tiltIndex] := laserTargetZ
        elseif laserTargetZ < calibrationZMin[tiltIndex] 
          calibrationZMin[tiltIndex] := laserTargetZ
        elseif laserTargetZ > calibrationZMax[tiltIndex] 
          calibrationZMax[tiltIndex] := laserTargetZ
        calibrationZAve[tiltIndex] += laserTargetZ  
      else
        laserTargetZ := Header#INVALID_LASER_READING
        if debugFlag => SERVO_COG_DEBUG
          Aux.Strs(DEBUG_AUX, string(7, 11, 13, 7, "********* Invalid rawLaserInput = ")) 
          Aux.Str(DEBUG_AUX, @rawLaserInput)
          Aux.Stre(DEBUG_AUX, string(7, 7, " **********", 7, 7))
      {if debugFlag => SERVO_COG_DEBUG
        Aux.Strs(DEBUG_AUX, string(11, 13, "laserDistance = ")) 
        Aux.Dec(DEBUG_AUX, laserDistance)    
        Aux.Str(DEBUG_AUX, string(", laserTargetZ = ")) 
        Aux.Dec(DEBUG_AUX, laserTargetZ)
        Aux.Str(DEBUG_AUX, string(11, 13, "calibrationZMin[")) 
        Aux.Dec(DEBUG_AUX, tiltIndex)    
        Aux.Str(DEBUG_AUX, string("] = ")) 
        Aux.Dec(DEBUG_AUX, calibrationZMin[tiltIndex])
        Aux.Str(DEBUG_AUX, string(", calibrationZMax = ")) 
        Aux.Dec(DEBUG_AUX, calibrationZMax[tiltIndex])
        Aux.Str(DEBUG_AUX, string(11, 13, "calibrationZRangeMin = ")) 
        Aux.Dec(DEBUG_AUX, calibrationZRangeMin)
        Aux.Str(DEBUG_AUX, string(", calibrationZRangeMax = ")) 
        Aux.Dece(DEBUG_AUX, calibrationZRangeMax)}
      calibrationDBuffer[bufferIndex] := laserDistance
      calibrationZBuffer[bufferIndex] := laserTargetZ
      bufferIndex++
      if debugFlag => SERVO_COG_MENU_DEBUG
        LedDebugCal
      if debugFlag => SERVO_COG_DEBUG
        Aux.Lock
        SimpleDebug(@calibrationDBuffer, @calibrationZBuffer)
        Aux.E

    calibrationZRange[tiltIndex] := calibrationZMax[tiltIndex] - calibrationZMin[tiltIndex]
    calibrationZAve[tiltIndex] /= validReadingsThisTilt
    if tiltIndex == 0
      calibrationZRangeMin := calibrationZRange[tiltIndex]
      calibrationZRangeMax := calibrationZRange[tiltIndex]
    elseif calibrationZRange[tiltIndex] < calibrationZRangeMin
      calibrationZRangeMin := calibrationZRange[tiltIndex]
    elseif calibrationZRange[tiltIndex] > calibrationZRangeMax
      calibrationZRangeMax := calibrationZRange[tiltIndex]
        
{
  TILT_ARRAYS_IN_CAL_DATA = 4
(TILT_ARRAYS_IN_CAL_DATA * TILT_CAL_POINTS)
calibrationZRangeMin 
calibrationZRangeMax
calibrationZMin                 long 0-0[TILT_CAL_POINTS]
calibrationZMax                 long 0-0[TILT_CAL_POINTS]
calibrationZRange               long 0-0[TILT_CAL_POINTS]
calibrationZAve                 long 0-0[TILT_CAL_POINTS]

previousZRangeMin 
previousZRangeMax
previousZMin                    long 0-0[TILT_CAL_POINTS]
previousZMax                    long 0-0[TILT_CAL_POINTS]
previousZRange                  long 0-0[TILT_CAL_POINTS]
previousZAve                    long 0-0[TILT_CAL_POINTS] }
 'PREVIOUS_CAL_LONGS
PRI NewCalibration

  if debugFlag => SERVO_COG_DEBUG
    Aux.Strse(DEBUG_AUX, string(11, 13, "NewCalibration ")) 
  'Aux.Dec(DEBUG_AUX, bufferIndex)
  longmove(@previousZRangeMin, @calibrationZRangeMin, PREVIOUS_CAL_LONGS)
  Calibration
  DisplayCalComparison
  calibrationState := CHOOSE_CAL 'calibrationStatus := NEW_LOW_OLD_HIGH_CAL_DATA

PRI Scan | targetPosition[6], panIndex, tiltIndex, validReadingsThisScan, {
} validReadingsThisTilt
'' The tilt servo starts pointing down and move up.
'' The pan servo starts to the port side and moves back and forth.
'' The calibration data is recorded during both directions of the
'' pan servo's motion. The data is recorded starting with the points
'' closest to the robot and added from left to right. While data
'' is located in memory from left to right, the points are scanned
'' with the pan servo moving both left to right and also right to
'' left while moving right to left, the memory locations are decreasing.


  validReadingsThisScan := 0
  'forward pan has a reduced pulse length
  
  bufferIndex := 0
  
  {calibrationPanSlope := (calibrationPanMax - calibrationPanMin) * SCALED_MULTIPLIER / {
  } PAN_CAL_POINTS
  calibrationTiltSlope := (calibrationTiltMax - calibrationTiltMin) * SCALED_MULTIPLIER / {
  } TILT_CAL_POINTS    }
  
  'longmove(@targetPosition, @servoPosition, Header#SERVOS_IN_USE)
  'targetPosition[2] := calibrationPanMin
  'targetPosition[3] := calibrationTiltMax
  'Aux.Lock
  'MoveFromLowerLeft(@targetPosition, US_PER_CYCLE)
  'Aux.E
  longmove(@targetPosition, @servoPosition, Header#SERVOS_IN_USE)
  scanZAveScan := 0
  repeat tiltIndex from 0 to TILT_CAL_GAPS
    targetPosition[3] := calibrationTiltMax - (tiltIndex * calibrationTiltSlope / {
    } SCALED_MULTIPLIER)
    'Aux.Lock
    'MoveFromLowerLeft(@targetPosition, US_PER_CYCLE)
    'Aux.E
    'longmove(@targetPosition, @servoPosition, Header#SERVOS_IN_USE)
    validReadingsThisTilt := 0
    scanZAve[tiltIndex] := 0
    {if debugFlag => SERVO_COG_DEBUG
      Aux.Strs(DEBUG_AUX, string(11, 13, "bufferIndex = "))
      Aux.Dec(DEBUG_AUX, bufferIndex)
      Aux.Str(DEBUG_AUX, string(", tiltIndex = ")) 
      Aux.Dece(DEBUG_AUX, tiltIndex)   } 
    repeat panIndex from 0 to PAN_CAL_GAPS
      targetPosition[2] := calibrationPanMax - (panIndex * calibrationPanSlope / {
      } SCALED_MULTIPLIER)

      {if debugFlag => SERVO_COG_DEBUG
        Aux.Strs(DEBUG_AUX, string(11, 13, "bufferIndex = ")) 
        Aux.Dec(DEBUG_AUX, bufferIndex)
        Aux.Str(DEBUG_AUX, string(", panIndex = ")) 
        Aux.Dec(DEBUG_AUX, panIndex)
        Aux.Str(DEBUG_AUX, string(", tiltIndex = ")) 
        Aux.Dece(DEBUG_AUX, tiltIndex) }
      'Aux.Lock
      MoveFromLowerLeft(@targetPosition, US_PER_CYCLE)
      'Aux.E
      longmove(@targetPosition, @servoPosition, Header#SERVOS_IN_USE)
      'QuietTiltServo
      'laserDistance := GetLaserRange
      laserDistance := GetLaserRangeMedian(@medianBuffer, rangesToSample)
      {if debugFlag => SERVO_COG_DEBUG
        Aux.Strs(DEBUG_AUX, string(11, 13, "rawLaserInput = ")) 
        Aux.Stre(DEBUG_AUX, @rawLaserInput)} 
      'correctedZ := laserTargetZ - calibrationZBuffer[bufferIndex]
      if laserDistance <> Header#INVALID_LASER_READING
        CalculateLaserPosition(laserDistance, servoPosition[2], servoPosition[3], @laserTargetX)
        correctedZ := laserTargetZ - calibrationZBuffer[bufferIndex]
        validReadingsThisTilt++
        validReadingsThisScan++
        if validReadingsThisTilt == 1
          scanZMin[tiltIndex] := correctedZ
          scanZMax[tiltIndex] := correctedZ
        elseif correctedZ < scanZMin[tiltIndex] 
          scanZMin[tiltIndex] := correctedZ
        elseif correctedZ > calibrationZMax[tiltIndex] 
          scanZMax[tiltIndex] := correctedZ
        if validReadingsThisScan == 1
          scanZMinIndex := bufferIndex
          scanZMaxIndex := bufferIndex
          scanZAbsMin := correctedZ
          scanZAbsMax := correctedZ
          scanZMinPan := targetPosition[2]
          scanZMaxPan := targetPosition[2]
          scanZMinTilt := targetPosition[3]
          scanZMaxTilt := targetPosition[3]          
        elseif correctedZ < scanZAbsMin
          scanZMinIndex := bufferIndex
          scanZAbsMin := correctedZ
          scanZMinPan := targetPosition[2]
          scanZMinTilt := targetPosition[3]
        elseif correctedZ > scanZAbsMax
          scanZMaxIndex := bufferIndex
          scanZAbsMax := correctedZ
          scanZMaxPan := targetPosition[2]
          scanZMaxTilt := targetPosition[3]  
        scanZAve[tiltIndex] += correctedZ
        scanZAveScan += correctedZ 
      else
        laserTargetZ := Header#INVALID_LASER_READING
        correctedZ := Header#INVALID_LASER_READING
      {if debugFlag => SERVO_COG_DEBUG
        Aux.Strs(DEBUG_AUX, string(11, 13, "laserDistance = ")) 
        Aux.Dec(DEBUG_AUX, laserDistance)    
        Aux.Str(DEBUG_AUX, string(", laserTargetZ = ")) 
        Aux.Dec(DEBUG_AUX, laserTargetZ)
        Aux.Str(DEBUG_AUX, string(", correctedZ = ")) 
        Aux.Dec(DEBUG_AUX, correctedZ)
         
         
        Aux.Str(DEBUG_AUX, string(11, 13, "scanZMin[")) 
        Aux.Dec(DEBUG_AUX, tiltIndex)    
        Aux.Str(DEBUG_AUX, string("] = ")) 
        Aux.Dec(DEBUG_AUX, scanZMin[tiltIndex])
        Aux.Str(DEBUG_AUX, string(", scanZMax = ")) 
        Aux.Dec(DEBUG_AUX, scanZMax[tiltIndex])
        Aux.Str(DEBUG_AUX, string(11, 13, "scanZRangeMin = ")) 
        Aux.Dec(DEBUG_AUX, scanZRangeMin)
        Aux.Str(DEBUG_AUX, string(", scanZRangeMax = ")) 
        Aux.Dece(DEBUG_AUX, scanZRangeMax) } 
      scanDistanceBuffer[bufferIndex] := laserDistance
      scanXBuffer[bufferIndex] := laserTargetX
      scanYBuffer[bufferIndex] := laserTargetY
      scanZBuffer[bufferIndex] := laserTargetZ
      correctedZBuffer[bufferIndex] := correctedZ
      bufferIndex++  
      if debugFlag => SERVO_COG_MENU_DEBUG
        LedDebugScan
      if debugFlag => SERVO_COG_DEBUG
        Aux.Lock
        SimpleDebug(@scanDistanceBuffer, @correctedZBuffer)
        Aux.E
    'calibrationZRange[tiltIndex] := calibrationZMax[tiltIndex] - calibrationZMin[tiltIndex]
    'calibrationZAve[tiltIndex] /= validReadingsThisTilt
 
    if tiltIndex == 0
      calibrationZRangeMin := calibrationZRange[tiltIndex]
      calibrationZRangeMax := calibrationZRange[tiltIndex]
    elseif calibrationZRange[tiltIndex] < calibrationZRangeMin
      calibrationZRangeMin := calibrationZRange[tiltIndex]
    elseif calibrationZRange[tiltIndex] > calibrationZRangeMax
      calibrationZRangeMax := calibrationZRange[tiltIndex]
    scanZAve[tiltIndex] /= validReadingsThisTilt
  scanZAveScan / = validReadingsThisScan
 { nextCnt := cnt

  repeat
    waitcnt(nextCnt += controlInterval)
    case stopServoFlag
      0:
        AdvanceServos
      other:
        PointServos  
  GetLaserRange
  correctedZ      }
PRI CopyLowToHigh

  calibrationStatus := IDENTICAL_CAL_DATA
  WriteEEPROM(@calibrationVersion, @calibrationVersion + (LONGS_OF_CAL_DATA * 4) - 1, {
  } Header#CALIBRATION_VERSION_EEPROM)
  WriteEEPROM(@calibrationStatus, @calibrationStatus + 3, @calibrationStatus)
  
PRI CopyHighToLow

  calibrationStatus := IDENTICAL_CAL_DATA
  'update calibrationStatus in upper
  WriteEEPROM(@calibrationStatus, @calibrationStatus + 3, {
  } Header#CALIBRATION_VERSION_EEPROM + 4)

  ' read from upper into RAM
  ReadEEPROM(@calibrationVersion, @calibrationVersion + (LONGS_OF_CAL_DATA * 4) - 1, {
  } Header#CALIBRATION_VERSION_EEPROM)

  ' copy from RAM to lower EEPROM
  WriteEEPROM(@calibrationVersion, @calibrationVersion + (LONGS_OF_CAL_DATA * 4) - 1, {
  } @calibrationVersion)
  
PRI ChooseToSaveLow

  ledMessageTime := 0
  ledMessage[1] := @saveCalLed1
  ledMessage[2] := @saveCalLed2
  ledMessage[0] := @saveCalLed0

  LedStr(ledMessage[0]) '*
  LedStr(ledMessage[1]) '*
  LedStr(ledMessage[2]) '*
  
  if debugFlag => SERVO_COG_MENU_DEBUG
    Aux.Strse(DEBUG_AUX, string(11, 13, "Press C button to save this calibration."))
   
  repeat while ledMessage[0]
    if debugFlag => SERVO_COG_MENU_DEBUG
      Aux.Txs(DEBUG_AUX, 2)
      Aux.Tx(DEBUG_AUX, 0)
      Aux.Tx(DEBUG_AUX, 20 + TILT_CAL_POINTS)
      Aux.Stre(DEBUG_AUX, string(11, 13, "Press C button to save this calibration."))
      'GetNunchuckData
      if nunchuckButton == Header#NUNCHUCK_BUTTON_C
        result := 1
        ledMessage[0] := 0
      elseif nunchuckButton == Header#NUNCHUCK_BUTTON_Z
        result := 0
        ledMessage[0] := 0
      
    {
  if menuSelect == Header#NUNCHUCK_BUTTON_C
    result := 1
  else
    result := 0
  } 
PRI ChooseToBackupLow

  ledMessageTime := 0
  ledMessage[1] := @backupCalLed1
  ledMessage[2] := @backupCalLed2
  ledMessage[0] := @backupCalLed0

  LedStr(ledMessage[0]) '*
  LedStr(ledMessage[1]) '*
  LedStr(ledMessage[2]) '*
  
  if debugFlag => SERVO_COG_MENU_DEBUG
    Aux.Strs(DEBUG_AUX, string(11, 13, "Press C button to backup this calibration."))
    Aux.Stre(DEBUG_AUX, string(11, 13, "Press Z button to not backup this calibration."))
    
  repeat while ledMessage[0]
    if debugFlag => SERVO_COG_MENU_DEBUG
      Aux.Strs(DEBUG_AUX, string(11, 13, "Press C button to backup this calibration."))
      Aux.Stre(DEBUG_AUX, string(11, 13, "Press Z button to not backup this calibration."))
      'GetNunchuckData
      if nunchuckButton == Header#NUNCHUCK_BUTTON_C
        result := 1
        ledMessage[0] := 0
      elseif nunchuckButton == Header#NUNCHUCK_BUTTON_Z
        result := 0
        ledMessage[0] := 0
  {
  if menuSelect == Header#NUNCHUCK_BUTTON_C
    result := 1
  else
    result := 0 }
    
PUB WaitForC(debugRow)

  repeat 
    if debugFlag => SERVO_COG_MENU_DEBUG
      Aux.Txs(DEBUG_AUX, 2)
      Aux.Tx(DEBUG_AUX, 0)
      Aux.Tx(DEBUG_AUX, debugRow)
      Aux.Stre(DEBUG_AUX, string(11, 13, "Press button to continue."))
      'GetNunchuckData
      if nunchuckButton == Header#NUNCHUCK_BUTTON_C
        result := 1
        'ledMessage[0] := 0
      elseif nunchuckButton == Header#NUNCHUCK_BUTTON_Z
        result := 0
      'ledMessage[0] := 0
  while nunchuckButton == Header#NUNCHUCK_BUTTON_NONE
      
PUB WaitForCWhileScanning(debugRow, extremeIndex) | extremePan, extremeTilt, extremeZ

  outa[Header#RED_LASER_TOP] := 1
  outa[Header#RED_LASER_BOTTOM] := 1
  dira[Header#RED_LASER_TOP] := 1
  dira[Header#RED_LASER_BOTTOM] := 1

  repeat
    laserDistance := GetLaserRangeMedian(@medianBuffer, rangesToSample)
    outa[Header#RED_LASER_TOP] := 1
    outa[Header#RED_LASER_BOTTOM] := 1
    dira[Header#RED_LASER_TOP] := 1
    dira[Header#RED_LASER_BOTTOM] := 1

    if scanZMinIndex == extremeIndex
      extremePan := scanZMinPan
      extremeTilt := scanZMinTilt
      extremeZ := scanZAbsMin
    else
      extremePan := scanZMaxPan
      extremeTilt := scanZMaxTilt
      extremeZ := scanZAbsMax
      
    CalculateLaserPosition(laserDistance, extremePan, extremeTilt, @laserTargetX)
    correctedZ := laserTargetZ - calibrationZBuffer[extremeIndex]
    LedDebugScan
    if debugFlag => SERVO_COG_MENU_DEBUG
      Aux.Txs(DEBUG_AUX, 2)
      Aux.Tx(DEBUG_AUX, 0)
      Aux.Tx(DEBUG_AUX, debugRow)
      Aux.Str(DEBUG_AUX, string(11, 13, "Press button to continue."))
      Aux.Str(DEBUG_AUX, string(11, 13, "extremeIndex = "))
      Aux.Dec(DEBUG_AUX, extremeIndex)
    
      Aux.Str(DEBUG_AUX, string(11, 13, "F_LASER_HEIGHT = "))
      Aux.Dec(DEBUG_AUX, F32.FRound(Header#F_LASER_HEIGHT))
      Aux.Str(DEBUG_AUX, string(11, 13, "Calculated XYZ = "))
      Aux.Dec(DEBUG_AUX, laserTargetX)
      Aux.Str(DEBUG_AUX, string(", "))
      Aux.Dec(DEBUG_AUX, laserTargetY)
      Aux.Str(DEBUG_AUX, string(", "))
      Aux.Dec(DEBUG_AUX, laserTargetZ)
      Aux.Str(DEBUG_AUX, string(11, 13, "correctedZ = "))
      Aux.Dec(DEBUG_AUX, correctedZ)
       
      Aux.Str(DEBUG_AUX, string(11, 13, "Laser Servos Pan  = "))
      Aux.Dec(DEBUG_AUX, panDegrees10)
      Aux.Str(DEBUG_AUX, string(" degrees "))
      Aux.Str(DEBUG_AUX, string(11, 13, "Laser Servos Tilt = "))
      Aux.Dec(DEBUG_AUX, tiltDegrees10)
      Aux.Stre(DEBUG_AUX, string(" degrees "))
    
      'GetNunchuckData
    if nunchuckButton == Header#NUNCHUCK_BUTTON_C
      result := 1
      'ledMessage[0] := 0
    elseif nunchuckButton == Header#NUNCHUCK_BUTTON_Z
      result := 0
      'ledMessage[0] := 0
  while nunchuckButton == Header#NUNCHUCK_BUTTON_NONE
      

  outa[Header#RED_LASER_TOP] := 0
  outa[Header#RED_LASER_BOTTOM] := 0
  dira[Header#RED_LASER_TOP] := 0
  dira[Header#RED_LASER_BOTTOM] := 0

PRI ChooseWhichCal

  ReadEEPROM(@calibrationVersion, @calibrationVersion + (LONGS_OF_CAL_DATA * 4) - 1, {
  } Header#CALIBRATION_VERSION_EEPROM)

  DisplayCalComparison
  
  ledMessageTime := 0
  ledMessage[1] := @restoreCalLed1
  ledMessage[2] := @restoreCalLed2
  ledMessage[0] := @restoreCalLed0
  
  LedStr(ledMessage[0]) '*
  LedStr(ledMessage[1]) '*
  LedStr(ledMessage[2]) '*
  
  if debugFlag => SERVO_COG_MENU_DEBUG
    Aux.Strs(DEBUG_AUX, string(11, 13, "Press C button to keep new calibration."))
    Aux.Stre(DEBUG_AUX, string(11, 13, "Press Z button to keep old calibration."))
    
  repeat while ledMessage[0]
    if debugFlag => SERVO_COG_MENU_DEBUG
      Aux.Strs(DEBUG_AUX, string(11, 13, "Press C button to keep new calibration."))
      Aux.Stre(DEBUG_AUX, string(11, 13, "Press Z button to keep old calibration."))
      'GetNunchuckData
      if nunchuckButton == Header#NUNCHUCK_BUTTON_C
        result := 1
        ledMessage[0] := 0
      elseif nunchuckButton == Header#NUNCHUCK_BUTTON_Z
        result := 0
        ledMessage[0] := 0
  {
  if menuSelect == Header#NUNCHUCK_BUTTON_C
    result := 1
  else
    result := 0 }

PRI ClearLowCal

  calibrationVersion := 0
  WriteEEPROM(@calibrationVersion, @calibrationVersion + 3, @calibrationVersion)
  
PRI TargetExtreme(extremeType) : extremeIndex | extremeZ, extremePan, extremeTilt, extremeTxt, target[6]

  case extremeType
    2:
      if ||scanZAbsMin > scanZAbsMax
        extremeType := 0
      else
        extremeType := 1
          
  case extremeType
    0:
      extremeIndex := scanZMinIndex
      extremePan := scanZMinPan
      extremeTilt := scanZMinTilt
      extremeTxt := string("in")
      extremeZ := scanZAbsMin
    1:
      extremeIndex := scanZMaxIndex
      extremePan := scanZMaxPan
      extremeTilt := scanZMaxTilt
      extremeTxt := string("ax")
      extremeZ := scanZAbsMax  
  if debugFlag => SERVO_COG_MENU_DEBUG
    Aux.Strs(DEBUG_AUX, string(11, 13, "Extreme M"))
    Aux.Str(DEBUG_AUX, extremeTxt)
    Aux.Str(DEBUG_AUX, string("imum = "))
    Aux.Dec(DEBUG_AUX, extremeZ)
    Aux.Str(DEBUG_AUX, string(", # "))
    Aux.Dec(DEBUG_AUX, extremeIndex)
    Aux.Str(DEBUG_AUX, string(", pan = "))
    Aux.Dec(DEBUG_AUX, extremePan)
    Aux.Str(DEBUG_AUX, string(", tilt = "))
    Aux.Dece(DEBUG_AUX, extremeTilt)

  longmove(@target, @servoPosition, Header#SERVOS_IN_USE)
  target[2] := extremePan
  target[3] := extremeTilt
  'Aux.Lock
  MoveFromLowerLeft(@target, US_PER_CYCLE)
  'Aux.E
  longmove(@target, @servoPosition, Header#SERVOS_IN_USE)
  outa[Header#RED_LASER_TOP] := 1
  outa[Header#RED_LASER_BOTTOM] := 1
  dira[Header#RED_LASER_TOP] := 1
  dira[Header#RED_LASER_BOTTOM] := 1
  
          
PRI MoveServos(targetPtr, moveCycles) | initialPosition[6], {
} pseudoSlope[6], nextCnt, positionIndex, change

  {Aux.Str(DEBUG_AUX, string(11, 13, "MoveServos, moveCycles = "))
  Aux.Dec(DEBUG_AUX, moveCycles)
  Aux.Str(DEBUG_AUX, string(11, 13, "index, current, target, pseudoSlope")) }
  ifnot moveCycles
    return
    
  longmove(@initialPosition, @servoPosition, Header#SERVOS_IN_USE)
  
  repeat result from 0 to MAX_SERVO_INDEX
    change := long[targetPtr][result] - initialPosition[result]
    if change
      pseudoSlope[result] := (long[targetPtr][result] - initialPosition[result]) * {
      } SCALED_MULTIPLIER / moveCycles
    else
      pseudoSlope[result] := 0
      
    {Aux.Str(DEBUG_AUX, string(11, 13, "# "))
    Aux.Dec(DEBUG_AUX, result)
    Aux.Str(DEBUG_AUX, string(", "))
    Aux.Dec(DEBUG_AUX, initialPosition[result])
    Aux.Str(DEBUG_AUX, string(", "))
    Aux.Dec(DEBUG_AUX, long[targetPtr][result])
    Aux.Str(DEBUG_AUX, string(", "))
    Aux.Dec(DEBUG_AUX, pseudoSlope[result]) }

  {Aux.Str(DEBUG_AUX, string(11, 13, "index, list of planned positions:"))
  repeat result from 0 to MAX_SERVO_INDEX
    Aux.Str(DEBUG_AUX, string(11, 13, "# "))
    Aux.Dec(DEBUG_AUX, result)
    if pseudoSlope[result]}
  moveCycles--    
  nextCnt := cnt  
  repeat positionIndex from 0 to moveCycles
    waitcnt(nextCnt += controlInterval)
    repeat result from 0 to MAX_SERVO_INDEX
      if pseudoSlope[result]
        servoPosition[result] := initialPosition[result] + {
        } DivideWithRound(pseudoSlope[result] * positionIndex, SCALED_MULTIPLIER)
        Servo.Set(servoPins[result], servoPosition[result])

PRI MoveServosQuietly(targetPtr, usPerCycle) | overshootTarget[6], tempMoveCycles, {
} maxMoveCycles

  maxMoveCycles := 0
  
  repeat result from 0 to MAX_SERVO_INDEX
    if long[targetPtr][result] - servoPosition[result] > 0
      overshootTarget[result] := long[targetPtr][result] + strainReducingAdjustment[result & 1]
    elseif long[targetPtr][result] - servoPosition[result] < 0
      overshootTarget[result] := long[targetPtr][result] - strainReducingAdjustment[result & 1]
    else
      overshootTarget[result] := long[targetPtr][result] 
    tempMoveCycles := DivideWithRound(||(servoPosition[result] - overshootTarget[result]), {
    } usPerCycle)
    if tempMoveCycles > maxMoveCycles 
      maxMoveCycles := tempMoveCycles

  tempMoveCycles := DivideWithRound(strainReducingAdjustment[1], usPerCycle)
      
  MoveServos(@overshootTarget, maxMoveCycles)
  MoveServos(targetPtr, tempMoveCycles)

  
PRI MoveFromLowerLeft(targetPtr, usPerCycle) | moveDirection[6], overshootTarget[6], {
} approachPosition[6], tempMoveCycles, changeInPosition, maxApproachCycles, {
} tempApproachCycles, maxMoveCycles

  maxMoveCycles := 0
  maxApproachCycles := 0
  tempApproachCycles := 0
  
  repeat result from 0 to MAX_SERVO_INDEX
    changeInPosition := long[targetPtr][result] - servoPosition[result]
    if changeInPosition > 0 ' move down or left
      overshootTarget[result] := long[targetPtr][result] - strainReducingAdjustment[result & 1]
      approachPosition[result] := long[targetPtr][result] + APPROACH_DISTANCE
      tempApproachCycles := DivideWithRound(||(approachPosition[result] - {
      } servoPosition[result]),  usPerCycle)
      tempMoveCycles := DivideWithRound(||(approachPosition[result] - {
      } overshootTarget[result]),  usPerCycle)
      {Aux.Str(DEBUG_AUX, string(11, 13, "move down or left # "))
      Aux.Dec(DEBUG_AUX, result)
      Aux.Str(DEBUG_AUX, string(", servoPosition ="))
      Aux.Dec(DEBUG_AUX, servoPosition[result])
      Aux.Str(DEBUG_AUX, string(", target ="))
      Aux.Dec(DEBUG_AUX, long[targetPtr][result])
      Aux.Str(DEBUG_AUX, string(", overshoot ="))
      Aux.Dec(DEBUG_AUX, overshootTarget[result])
      Aux.Str(DEBUG_AUX, string(", approach = "))
      Aux.Dec(DEBUG_AUX, approachPosition[result])}
      
    elseif changeInPosition < 0 ' move up or right
      overshootTarget[result] := long[targetPtr][result] - strainReducingAdjustment[result & 1]
      tempMoveCycles := DivideWithRound(||(servoPosition[result] - overshootTarget[result]), {
      } usPerCycle)
      approachPosition[result] := servoPosition[result]
      {Aux.Str(DEBUG_AUX, string(11, 13, "move up or right # "))
      Aux.Dec(DEBUG_AUX, result) 
      Aux.Str(DEBUG_AUX, string(", servoPosition ="))
      Aux.Dec(DEBUG_AUX, servoPosition[result])
      Aux.Str(DEBUG_AUX, string(", target ="))
      Aux.Dec(DEBUG_AUX, long[targetPtr][result])
      Aux.Str(DEBUG_AUX, string(", overshoot ="))
      Aux.Dec(DEBUG_AUX, overshootTarget[result])
      Aux.Str(DEBUG_AUX, string(", approach = "))
      Aux.Dec(DEBUG_AUX, approachPosition[result])}
    else
      overshootTarget[result] := long[targetPtr][result]
      approachPosition[result] := servoPosition[result]
      tempMoveCycles := 0
    if tempMoveCycles > maxMoveCycles 
      maxMoveCycles := tempMoveCycles
    if tempApproachCycles > maxApproachCycles 
      maxApproachCycles := tempApproachCycles

  tempMoveCycles := DivideWithRound(strainReducingAdjustment[1], usPerCycle)
  
  if maxApproachCycles
    'Aux.Str(DEBUG_AUX, string(11, 13, "move to approach maxApproachCycles = "))
    'Aux.Dec(DEBUG_AUX, maxApproachCycles)
    MoveServos(@approachPosition, maxApproachCycles)
  'Aux.Rx(DEBUG_AUX)
  {Aux.Str(DEBUG_AUX, string(11, 13, "move to overshoot maxMoveCycles = "))
  Aux.Dec(DEBUG_AUX, maxMoveCycles)}  
  MoveServos(@overshootTarget, maxMoveCycles)
  'Aux.Rx(DEBUG_AUX)
  {Aux.Str(DEBUG_AUX, string(11, 13, "move to target, target cycles = "))
  Aux.Dec(DEBUG_AUX, tempMoveCycles)}  
  MoveServos(targetPtr, tempMoveCycles)
  'Aux.Rx(DEBUG_AUX)
  
{PRI QuietTiltServo

  Servo.Set(servoPins[3], servoPosition[3] - strainReducingAdjustment[1])
  waitcnt(4 * controlInterval + cnt)
  Servo.Set(servoPins[3], servoPosition[3])
  }
PUB SimpleDebug(buffer0, buffer1)

  'GetNunchuckData
  'Aux.Rx(DEBUG_AUX)
  menuSelect := nunchuckButton
  Aux.Tx(DEBUG_AUX, 11)
  Aux.Tx(DEBUG_AUX, 1)
  
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
  Aux.Str(DEBUG_AUX, string(11, 13, "joy = "))
  Aux.Dec(DEBUG_AUX, joyX)
  Aux.Str(DEBUG_AUX, string(", "))
  Aux.Dec(DEBUG_AUX, joyY)
  
  if laserDistance == Header#INVALID_LASER_READING
    Aux.Str(DEBUG_AUX, string(11, 13, "Laser Data Invalid"))
    return
  Aux.Str(DEBUG_AUX, string(11, 13, "laserDistance = "))
  Aux.Dec(DEBUG_AUX, laserDistance) 

  Aux.Str(DEBUG_AUX, string(11, 13, "calibrationState = "))
  Aux.Str(DEBUG_AUX, FindString(@calibrationStateAsText, calibrationState))
  Aux.Str(DEBUG_AUX, string(11, 13, "calibrationStatus = "))
  Aux.Str(DEBUG_AUX, FindString(@calibrationStatusAsText, calibrationStatus))

  
  
  Aux.Str(DEBUG_AUX, string(11, 13, "Laser Target (XYZ) = "))
  Aux.Dec(DEBUG_AUX, laserTargetX)
  Aux.Str(DEBUG_AUX, string(", "))
  Aux.Dec(DEBUG_AUX, laserTargetY)
  Aux.Str(DEBUG_AUX, string(", "))
  Aux.Dec(DEBUG_AUX, laserTargetZ)

      
  Aux.Str(DEBUG_AUX, string(11, 13, "Pan  = "))
  Aux.DecDp(DEBUG_AUX, panDegrees10, 1)
  Aux.Str(DEBUG_AUX, string(" degrees from forward, "))
  Aux.Str(DEBUG_AUX, string(11, 13, "Tilt = "))
  Aux.DecDp(DEBUG_AUX, tiltDegrees10, 1)
  Aux.Str(DEBUG_AUX, string(" degrees down from level"))  


  Aux.Str(DEBUG_AUX, string(11, 13, "Laser Servos Pan  = "))
  Aux.Dec(DEBUG_AUX, servoPosition[2])
  Aux.Str(DEBUG_AUX, string(11, 13, "Laser Servos Tilt = "))
  Aux.Dec(DEBUG_AUX, servoPosition[3])
  Aux.Str(DEBUG_AUX, string(11, 13, "Buffer Index = "))
  Aux.Dec(DEBUG_AUX, bufferIndex)

  Aux.Str(DEBUG_AUX, string(", PAN_CAL_GAPS = "))
  Aux.Dec(DEBUG_AUX, PAN_CAL_GAPS)
  Aux.Str(DEBUG_AUX, string(", TILT_CAL_GAPS = "))
  Aux.Dec(DEBUG_AUX, TILT_CAL_GAPS)

  Aux.Str(DEBUG_AUX, string(11, 13, "calibrationBuffer = "))

  DisplayDZBuffer(buffer0, buffer1, CAL_GRID_SIZE) '
  'Aux.Rx(DEBUG_AUX)

PUB PointServos

  'pointAcceleration[0] := ACCELERATION_SLOPE_PAN * joyX / SCALED_MULTIPLIER
  'pointAcceleration[1] := ACCELERATION_SLOPE_TILT * joyY / SCALED_MULTIPLIER
  'pointSpeed[0] := -POINT_SPEED_LIMIT #> pointSpeed[0] + pointAcceleration[0] <# POINT_SPEED_LIMIT
  'pointSpeed[1] := -POINT_SPEED_LIMIT #> pointSpeed[1] + pointAcceleration[1] <# POINT_SPEED_LIMIT
  pointSpeed[0] := -POINT_SPEED_LIMIT #> SPEED_SLOPE_PAN * joyX / SCALED_MULTIPLIER <# POINT_SPEED_LIMIT
  pointSpeed[1] := -POINT_SPEED_LIMIT #> SPEED_SLOPE_TILT * joyY / SCALED_MULTIPLIER <# POINT_SPEED_LIMIT
  
  servoPosition[2] := servoMin[0] #> servoPosition[2] + pointSpeed[0] <# servoMax[0]
  servoPosition[3] := servoMin[1] #> servoPosition[3] + pointSpeed[1] <# servoMax[1]
  Servo.Set(servoPins[2], servoPosition[2])
  Servo.Set(servoPins[3], servoPosition[3])
  
  'previousServoPosition
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

PUB GetLaserRangeMedian(bufferPtr, readings) | maxIndex

  Aux.Strs(DEBUG_AUX, string(11, 13, "GetLaserRangeMedian, readings = "))
  Aux.Dec(DEBUG_AUX, readings)
  Aux.Stre(DEBUG_AUX, string(", data = "))
  maxIndex := readings - 1
  repeat result from 0 to maxIndex
    long[bufferPtr][result] := GetLaserRange
    Aux.Lock  
    Aux.Dec(DEBUG_AUX, long[bufferPtr][result])
    Aux.Stre(DEBUG_AUX, string(", "))
  result := LongMedian(bufferPtr, readings)
  Aux.Strs(DEBUG_AUX, string(11, 13, "median distance := "))
  Aux.Dece(DEBUG_AUX, result)
    
PUB GetLaserRange | inputcharacter, rawInputIndex, validFlag

  outa[Header#RED_LASER_TOP] := 1
  dira[Header#RED_LASER_TOP] := 1
  
  result := Aux.rxHowFull(SR02_AUX)
  if result > 1
    Aux.Strs(DEBUG_AUX, string(11, 13, "****** Flushing at least "))
    Aux.Dec(DEBUG_AUX, result)
    Aux.Stre(DEBUG_AUX, string(" bytes from rx buffer. ******")) 
    Aux.rxflush(SR02_AUX)
   
  rawInputIndex := 0
  Aux.Tx(SR02_AUX, "D")
  validFlag := 0
  result := 0
  
  repeat
    inputcharacter := Aux.RxTime(SR02_AUX, 100)
    if inputcharacter <> -1
      rawLaserInput[rawInputIndex++] := inputcharacter

    if rawInputIndex => RAW_LASER_BUFFER_SIZE
      error := string("buffer overflow")
      validFlag := 0
      quit
    case inputcharacter
      "0".."9":       
        result := (result * 10) + (inputcharacter - "0")
        validFlag := 1
  until inputcharacter == 13 or inputcharacter == -1
  rawLaserInput[rawInputIndex] := 0
  outa[Header#RED_LASER_TOP] := 0
  dira[Header#RED_LASER_TOP] := 0
  
  if validFlag == 0
    result := Header#INVALID_LASER_READING

PUB LongMedian(arrayAddress, elements) | halfTheElements, toCompareIndex, {
} compareAgainstIndex, elementsLarger, elementsSmaller, maxIndex 

  maxIndex := elements - 1
  halfTheElements := elements / 2
  repeat toCompareIndex from 0 to maxIndex
    elementsLarger := 0
    elementsSmaller := 0   
    repeat compareAgainstIndex from 0 to maxIndex
      if long[arrayAddress][toCompareIndex] > long[arrayAddress][compareAgainstIndex]
        elementsSmaller++   
      elseif long[arrayAddress][toCompareIndex] < long[arrayAddress][compareAgainstIndex]
        elementsLarger++
    if elementsSmaller =< halfTheElements and elementsLarger =< halfTheElements
      return long[arrayAddress][toCompareIndex]

PUB CalculateLaserPosition(distance, panPos, tiltPos, resultPointer) | gndD
' Debug lock should be set prior to calling this method.
' NED coordinate system. Down is positive so objects above ground level
' will have negative Z values.

  if debugFlag => LASER_CALC_DEBUG
    Aux.Str(DEBUG_AUX, string(11, 13, "CalculateLaserPosition, distance  = "))
    Aux.Dec(DEBUG_AUX, distance)
    Aux.Str(DEBUG_AUX, string(" cm"))   
    Aux.Str(DEBUG_AUX, string(11, 13, "Laser Servos Pan  = "))
    Aux.Dec(DEBUG_AUX, panPos)
    Aux.Str(DEBUG_AUX, string(11, 13, "Laser Servos Tilt = "))
    Aux.Dec(DEBUG_AUX, tiltPos)
  panPos := F32.FMul(Header#F_RADIAN_PER_US, F32.FFloat(MIDDLE_PAN_CENTER - {
  } panPos))
  tiltPos := F32.FMul(Header#F_RADIAN_PER_US, F32.FFloat(tiltPos - {
  } MIDDLE_TILT_HORIZONTAL))
  
  distance := F32.FFloat(distance * 10)
  gndD := F32.FMul(distance, F32.Cos(tiltPos))
  {long[resultPointer][Z_DIMENSION] := F32.FRound(F32.FSub(Header#F_LASER_HEIGHT, F32.FMul(distance, {
  } F32.Sin(servoAverages[1]))))}
  long[resultPointer][Z_DIMENSION] := F32.FRound(F32.FSub(Header#F_LASER_HEIGHT, F32.FMul(distance, {
  } F32.Sin(tiltPos))))
  long[resultPointer][X_DIMENSION] := F32.FRound(F32.FMul(distance, F32.Cos(panPos)))
  long[resultPointer][Y_DIMENSION] := F32.FRound(F32.FMul(distance, F32.Sin(panPos)))

  panDegrees10 := F32.FRound(F32.FMul(F32.Degrees(panPos), 10.0))
  tiltDegrees10 := F32.FRound(F32.FMul(F32.Degrees(tiltPos), 10.0))
  if debugFlag => LASER_CALC_DEBUG
    Aux.Str(DEBUG_AUX, string(11, 13, "F_LASER_HEIGHT = "))
    Aux.Dec(DEBUG_AUX, F32.FRound(Header#F_LASER_HEIGHT))
    Aux.Str(DEBUG_AUX, string(11, 13, "Calculated XYZ = "))
    Aux.Dec(DEBUG_AUX, long[resultPointer][X_DIMENSION])
    Aux.Str(DEBUG_AUX, string(", "))
    Aux.Dec(DEBUG_AUX, long[resultPointer][Y_DIMENSION])
    Aux.Str(DEBUG_AUX, string(", "))
    Aux.Dec(DEBUG_AUX, long[resultPointer][Z_DIMENSION])

    Aux.Str(DEBUG_AUX, string(11, 13, "Laser Servos Pan  = "))
    Aux.Dec(DEBUG_AUX, panDegrees10)
    Aux.Str(DEBUG_AUX, string(" degrees "))
    Aux.Str(DEBUG_AUX, string(11, 13, "Laser Servos Tilt = "))
    Aux.Dec(DEBUG_AUX, tiltDegrees10)
    Aux.Str(DEBUG_AUX, string(" degrees "))
    
  
PUB GetPing(numberOfSensors, pointer)
'' Is this method really needed?
'' Yes, it will eventually do more.
  Aux.Str(DEBUG_AUX, string(11, 13, "GetPing("))
  Aux.Dec(DEBUG_AUX, numberOfSensors)
  Aux.Str(DEBUG_AUX, string(", $"))
  Aux.Hex(DEBUG_AUX, pointer, 4)
  Aux.Tx(DEBUG_AUX, ")")
  ' ** currently this code is useless
  'Aux.Str(DEBUG_AUX, string(11, 13, "pingNew = "))
  'Aux.Dec(DEBUG_AUX, pingNew[0])
  'Aux.Str(DEBUG_AUX, string(", "))
  'Aux.Dec(DEBUG_AUX, pingNew[1])
   

PUB DivideWithRound(numerator, denominator)

  numerator += denominator
  result := numerator / denominator

PUB GetNunchuckData | localMax, localParameter[2], pointer
'' Called by debug cog
'' Nunchuck's coordinate system is different from robot's.
' Debug lock should be set prior to calling this method.
 
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
    {targetSpeed[LEFT_MOTOR] := 0
    targetSpeed[RIGHT_MOTOR] := 0
    targetPower[LEFT_MOTOR] := 0
    targetPower[RIGHT_MOTOR] := 0}
    return
  else
    nunchuckReadyFlag := 1
    
  'DisplayTwoDataPoints(rightX * MAX_LED_INDEX / 255, GREEN, rightY * MAX_LED_INDEX / 255, RED, OFF)
  
  {Aux.Str(DEBUG_AUX, string(11, 13, "Nunchuck = "))
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
  Aux.Dec(DEBUG_AUX, nunchuckButton) }
 
  if nunchuckButton <> previousButton and previousButton == Header#NUNCHUCK_BUTTON_NONE
    case nunchuckButton
      Header#NUNCHUCK_BUTTON_Z:
        Leds.Reset
      Header#NUNCHUCK_BUTTON_C:
        !stopServoFlag
        ifnot stopServoFlag
          longfill(@pointSpeed, 0, 4)
        'targetSpeed[LEFT_MOTOR] := 0
        'targetSpeed[RIGHT_MOTOR] := 0

  previousButton := nunchuckButton

  ifnot stopServoFlag 'lrfServoMode == NUNCHUCK_LRF_MODE ' MASTER_CONTROL_LRF_MODE
    return

  case rightX
    0..Header#CENTER_NUNCHUCK_X_MIN - 1:
      joyX := rightX - Header#CENTER_NUNCHUCK_X_MIN
      'joyX := ((joyX * localMax) + Header#NUNCHUCK_X_RANGE_L_HALF) / Header#NUNCHUCK_X_RANGE_LEFT 
    Header#CENTER_NUNCHUCK_X_MIN..Header#CENTER_NUNCHUCK_X_MAX:
      joyX := 0
    Header#CENTER_NUNCHUCK_X_MAX + 1..Header#MAX_STICK_NUNCHUCK:
      joyX := rightX - Header#CENTER_NUNCHUCK_X_MAX
      'joyX := ((joyX * localMax) + Header#NUNCHUCK_X_RANGE_R_HALF) / Header#NUNCHUCK_X_RANGE_RIGHT
  case rightY
    0..Header#CENTER_NUNCHUCK_Y_MIN - 1:
      joyY := rightY - Header#CENTER_NUNCHUCK_Y_MIN
      'joyY := ((joyY * localMax) + Header#NUNCHUCK_Y_RANGE_R_HALF) / Header#NUNCHUCK_Y_RANGE_REVERSE
    Header#CENTER_NUNCHUCK_Y_MIN..Header#CENTER_NUNCHUCK_Y_MAX:
      joyY := 0
    Header#CENTER_NUNCHUCK_Y_MAX + 1..Header#MAX_STICK_NUNCHUCK:
      joyY := rightY - Header#CENTER_NUNCHUCK_Y_MAX
      'joyY := ((joyY * localMax) + Header#NUNCHUCK_Y_RANGE_F_HALF) / Header#NUNCHUCK_Y_RANGE_FORWARD
      
  {' *** speed isn't computed yet 
  'targetSpeed[LEFT_MOTOR] := -MAX_RC_SPEED #> joyY + joyX <# MAX_RC_SPEED
  'targetSpeed[RIGHT_MOTOR] := -MAX_RC_SPEED #> joyY - joyX <# MAX_RC_SPEED
  'targetSpeed[LEFT_MOTOR] := joyY + joyX
  'targetSpeed[RIGHT_MOTOR] := joyY - joyX
  localParameter[LEFT_MOTOR] := joyY + joyX
  localParameter[RIGHT_MOTOR] := joyY - joyX     }
    
 
  {Aux.Str(DEBUG_AUX, string(11, 13, "joy = "))
  Aux.Dec(DEBUG_AUX, joyX)
  Aux.Str(DEBUG_AUX, string(", "))
  Aux.Dec(DEBUG_AUX, joyY) }

  {Aux.Str(DEBUG_AUX, string(", localParameter = "))
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
    'PauseForRx
    'pauseForRxFlag := result
    
  longmove(pointer, @localParameter, 2)
          }
PUB CheckForNunchuck
' Debug lock should be set prior to calling this method.

  Aux.Str(DEBUG_AUX, string(11, 13, "CheckForNunchuck Method"))
  Nunchuck.Init(Header#WII_CLOCK_SLAVE, Header#WII_DATA_SLAVE)
  Aux.Str(DEBUG_AUX, string(11, 13, "Nunchuck ID = ", QUOTE))   
  SafeDebug(nuchuckIdPtr, 4)
  Aux.Tx(DEBUG_AUX, QUOTE) 
  if long[nuchuckIdPtr] == Header#VALID_NUNCHUCK_ID '$04C4B400
    nunchuckReceiverConnectedFlag := 1
  
PUB CheckPointedUp

  if nunchuckAcceleration[Header#Y_ACCEL] < Header#NUNCHUCK_UP_THRESHOLD
    result := true

PUB CheckPointedDown

  if nunchuckAcceleration[Header#Y_ACCEL] > Header#NUNCHUCK_DOWN_THRESHOLD
    result := true

DAT
  'full displays
  '$02
  '$01
  '$00
  'small displays
  '$14, $15
  '$12, $13
  '$10, $11

  
startCalLed0                    byte $02, Leds#_S, Leds#_t, Leds#_A, Leds#_r, Leds#_t, 0
startCalLed1                    byte $01, Leds#_C, Leds#_A, Leds#_L, Leds#_I, Leds#_b, Leds#_r, Leds#_A, Leds#_t, 0
startCalLed2                    byte $00, Leds#_t, Leds#_I, Leds#_o2, Leds#_n, 0

saveCalLed0                     byte $02, Leds#_C, Leds#DASH, Leds#_S, Leds#_A, Leds#_u, Leds#_E, 0
saveCalLed1                     byte $01, Leds#_2, Leds#DASH, Leds#_L, Leds#_o2, Leds#_S, Leds#_E, 0
saveCalLed2                     byte $00, Leds#_C, Leds#_A, Leds#_L, 0

backupCalLed0                   byte $02, Leds#_C, Leds#DASH, Leds#_B, Leds#_A, Leds#_C, Leds#_U, Leds#_P, 0
backupCalLed1                   byte $01, Leds#_2, Leds#DASH, Leds#_n, Leds#_o2, 0
backupCalLed2                   byte $00, Leds#_C, Leds#_A, Leds#_L, 0

restoreCalLed0                  byte $02, Leds#_C, Leds#DASH, Leds#_H, Leds#_I, Leds#_G, Leds#_H, 0
restoreCalLed1                  byte $01, Leds#_2, Leds#DASH, Leds#_L, Leds#_o2, 0
restoreCalLed2                  byte $00, Leds#_C, Leds#_A, Leds#_L, 0

{            '  .abcdefg
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
  _Y        = %00111011     }
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

calibrationStateAsText          byte "CHECK_FOR_CAL", 0 
                                byte "INITILIZE_CAL", 0
                                byte "CHOOSE_CAL", 0
                                byte "USE_CAL", 0
                                byte "NEW_CAL", 0

calibrationStatusAsText         byte "NO_LOWER_DATA", 0
                                byte "NEW_LOW_NO_HIGH_CAL_DATA", 0
                                byte "NEW_LOW_OLD_HIGH_CAL_DATA", 0
                                byte "IDENTICAL_CAL_DATA", 0
                                byte "INCOMPLETE_CAL_DATA", 0 
   
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
rangesToSampleTxt               byte "rangesToSample", 0

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
                                