import RPi.GPIO as GPIO
import time
import random

led1 = 21
led2 = 12
led3 = 25
led4 = 23
led5 = 18
btn1 = 26
btn2 = 19
btn3 = 5
btn4 = 22
btn5 = 17

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

GPIO.setup(led1, GPIO.OUT)
GPIO.setup(led2, GPIO.OUT)
GPIO.setup(led3, GPIO.OUT)
GPIO.setup(led4, GPIO.OUT)
GPIO.setup(led5, GPIO.OUT)

GPIO.setup(btn1, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(btn2, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(btn3, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(btn4, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(btn5, GPIO.IN, pull_up_down=GPIO.PUD_UP)

random.seed(None)

start_time = time.time()
roundTime = 10
maxIntervalTime = 10
points = 0
totalPoints = 0

GPIO.output(led1, False)
GPIO.output(led2, False)
GPIO.output(led3, False)
GPIO.output(led4, False)
GPIO.output(led5, False)

try:
    while (time.time() - start_time) < roundTime:
        number = random.randint(1,101) % 5
        lap_time = time.time()
        
        if number == 0:
            GPIO.output(led1, True)
            btn1_state = GPIO.input(btn1)
            
            while (btn1_state == True) and (time.time() - lap_time < maxIntervalTime):
                btn1_state = GPIO.input(btn1)
            
            points = round(10-(time.time() - lap_time))
            totalPoints += points
            
            GPIO.output(led1, False)
            time.sleep(0.5)
            
        elif number == 1:
            GPIO.output(led2, True)
            btn2_state = GPIO.input(btn2)
            
            while (btn2_state == True) and (time.time() - lap_time < maxIntervalTime):
                btn2_state = GPIO.input(btn2)
            
            points = round(10-(time.time() - lap_time))
            totalPoints += points
            
            GPIO.output(led2, False)
            time.sleep(0.5)
            
        elif number == 2:
            GPIO.output(led3, True)
            btn3_state = GPIO.input(btn3)
            
            while (btn3_state == True) and (time.time() - lap_time < maxIntervalTime):
                btn3_state = GPIO.input(btn3)
            
            points = round(10-(time.time() - lap_time))
            totalPoints += points
            
            GPIO.output(led3, False)
            time.sleep(0.5)

        elif number == 3:
            GPIO.output(led4, True)
            btn4_state = GPIO.input(btn4)
            
            while (btn4_state == True) and (time.time() - lap_time < maxIntervalTime):
                btn4_state = GPIO.input(btn4)
            
            points = round(10-(time.time() - lap_time))
            totalPoints += points
            
            GPIO.output(led4, False)
            time.sleep(0.5)
        
        elif number == 4:
            GPIO.output(led5, True)
            btn5_state = GPIO.input(btn5)
            
            while (btn5_state == True) and (time.time() - lap_time < maxIntervalTime):
                btn5_state = GPIO.input(btn5)
            
            points = round(10-(time.time() - lap_time))
            totalPoints += points
            
            GPIO.output(led5, False)
            time.sleep(0.5)
    
    GPIO.output(led1, False)
    GPIO.output(led2, False)
    GPIO.output(led3, False)
    GPIO.output(led4, False)
    GPIO.output(led5, False)
    totalPointsInt=int(totalPoints)
    print (totalPointsInt)

except:
    GPIO.cleanup()

