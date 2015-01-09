CON{{ ****** Public Notes ******

  

}}
CON{
  ****** Duane's Working Notes ******

  Rename from "HeaderEddieAbHb25Encoders141231a" to "HeaderCleaver141231a".
}  
CON '' Master Pin Assignments

  MASTER_TO_SLAVE_TX = 6
  MASTER_FROM_SLAVE_RX = 7
  ' Encoders
  ENCODERS_PIN = 14

  ENABLE_0 = 12
  ENABLE_1 = 13
 
  ' ADC (Activity Board)
  ADC_CS = 21                                        
  ADC_SCL = 20 
  ADC_DO = 19 
  ADC_DI = 18

  MASTER_USB_BAUD = 115_200                                   
  
CON '' Shared Pin Assignments and Other Shared Constants

    ' PC COMMUNICATION
  USB_TX = 30 
  USB_RX = 31

  ' Serial Port Settings
  BAUDMODE = %0000
  PROP_TO_PROP_BAUD = 9_600 '115_200                                 
 
  
CON '' Slave Pin Assignments

  PING_0 = 0                                          
  PING_1 = 1                                           

  FIRST_SERVO_PIN = 2

  SLAVE_TO_MASTER_TX = 8
  SLAVE_FROM_MASTER_RX = 9
  
  EMIC_RX = 13
  EMIC_TX = 12
  EASY_VR_RX = 15
  EASY_VR_TX = 14
  'XBEE_RX =
  'XBEE_TX =
  SR02_RX = 11
  SR02_TX = 10
  
  'SR02_TRIGGER_PIN = 10
  SEVEN_SEGMENT_DATA = 16
  SEVEN_SEGMENT_LATCH = 17
  SEVEN_SEGMENT_CLOCK = 18
  
  SLAVE_USB_BAUD = 9_600 '115_200                                   
  EASY_VR_BAUD = 9_600
  EMIC_BAUD = 9_600
  SR02_BAUD = 9_600

  INITIAL_PING = |< PING_0 | |< PING_1                
  
CON 
 
  '' distance travelled per encoder tick = 2,455mm / 720 = 3.410mm
  '' bot radius = 59.88 ticks 
  MICROMETERS_PER_TICK = 3410                           '' User changable
  POSITIONS_PER_ROTATION = 748 ' 744                    '' User changable
  ' "POSITIONS_PER_ROTATION" is the distance one wheel needs to travel to rotate the
  ' robot a full revolution while one wheel remains stationary.
  
  ' Motor names
  #0
  LEFT_MOTOR
  RIGHT_MOTOR

 
  ' Ping))) sensors
  PINGS_IN_USE = 2  
  SERVOS_IN_USE = 6
  MAX_SERVO_INDEX = SERVOS_IN_USE - 1
  
  MAX_POWER = 7520

  SCALED_POWER = MAX_POWER / 500
 
  STOP_PULSE = 1_500

  TOO_SMALL_TO_FIX = 0                                  
  DEFAULT_INTEGRAL_NUMERATOR = 200                    
  DEFAULT_INTEGRAL_DENOMINATOR = 100                  

  TAU = 2.0 * pi
  TAU_OVER_4 = pi / 2.0
  US_PER_TAU = 4000
  US_PER_QUARTER_TAU = US_PER_TAU / 4
  F_US_PER_RADIAN = float(US_PER_TAU) / TAU
  F_RADIAN_PER_US = TAU / float(US_PER_TAU) 

  F_LASER_HEIGHT = 320.0 ' in millimeters

  INVALID_LASER_READING = -999
  
CON '' Emic Codes

  #0, INTRO_EMIC, GOOD_COM_EMIC, BAD_COM_EMIC, SPEED_EMIC, FIGURE_8_EMIC', _EMIC, _EMIC, _EMIC, _EMIC
    
OBJ

  '' The analog to digital converter object does not start a new cog.
  '' The ADC object is required to use the "ADC" command
  Motors : "Servo32v9Shared"
   
PUB StartMotors

  Motors.Start

PUB SetMotorPower(side, power)

  Motors.Set(enablePin[side], STOP_PULSE + (power / SCALED_POWER))

DAT

enablePin     long ENABLE_0, ENABLE_1