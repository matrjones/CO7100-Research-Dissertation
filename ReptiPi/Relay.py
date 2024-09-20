import lgpio
import time
from datetime import datetime

h = lgpio.gpiochip_open(0)
lgpio.gpio_claim_output(h, 17)

current_time = datetime.now().time()
turn_on = current_time.replace(hour=16, minute=13, second=0, microsecond=0)
turn_off = current_time.replace(hour=16, minute=14, second=0, microsecond=0)

try:
	while True:
		time.sleep(5)
		lgpio.gpio_write(h, 17, 1)
		print("Relay OFF")
		time.sleep(5)
		lgpio.gpio_write(h, 17, 0)
		print("Relay ON")
		
except KeyboardInterrupt:
	print("nope")
	
finally:
	lgpio.gpiochip_close(h)

