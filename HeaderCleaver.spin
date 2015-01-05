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

CON '' Shared Pin Assignments

    ' PC COMMUNICATION
  USB_TX = 30 
  USB_RX = 31

  'Prop to Prop Communication
  PROP_TO_PROP_TX = 6
  PROP_TO_PROP_RX = 7
  
CON '' Slave Pin Assignments

  PING_0 = 0                                          
  PING_1 = 1                                           

  FIRST_SERVO_PIN = 2

  SLAVE_TO_MASTER_TX = 8
  SLAVE_FROM_MASTER_RX = 9
  
  ' PROP TO PROP COMMUNICATION
  'MASTER_TX = 6                                         
  'MASTER_RX = 7                                          

  'SLAVE_TX = 6                                         
  'SLAVE_RX = 7
  
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
  INITIAL_PING = |< PING_0 | |< PING_1                
   
                                   

  ' Master GPIO mask (Only high pins can be set as outputs)
  OUTPUTABLE = %00001100_00000000_00000011_11111111 
  PINGABLE = %00000000_00000000_00000011_11111111
  SERVOABLE = PINGABLE
  MAX_ALLOWED_PINGS = 10

  INITIAL_GPIO = OUTPUTABLE & !INITIAL_PING
  
  ' Serial Port Settings
  BAUDMODE = %0000
  MASTER_USB_BAUD = 115_200                                   
  SLAVE_USB_BAUD = 115_200                                   
  PROP_TO_PROP_BAUD = 115_200                                 
  'MASTER_BAUD = 115_200                                 
  'SLAVE_BAUD = MASTER_BAUD                                
  EMIC_BAUD = 9_600
  SR02_BAUD = 9_600
  
  MAX_POWER = 7520

  SCALED_POWER = MAX_POWER / 500
 
  STOP_PULSE = 1_500

  TOO_SMALL_TO_FIX = 0                                  
  DEFAULT_INTEGRAL_NUMERATOR = 200                    
  DEFAULT_INTEGRAL_DENOMINATOR = 100                  

CON

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