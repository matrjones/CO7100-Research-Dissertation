import os
import time
import lgpio
from datetime import datetime

h = lgpio.gpiochip_open(0)
lgpio.gpio_claim_output(h, 27)


def read_temp_raw():
	base_dir = '/sys/bus/w1/devices/'
	device_folder = [d for d in os.listdir(base_dir) if d.startswith('28-')][0]
	device_file = base_dir + device_folder + '/w1_slave'
	
	with open(device_file, 'r') as f:
		lines = f.readlines()
		
	return lines
		

def read_temp():
	lines = read_temp_raw()
	
	while lines[0].strip()[-3:] != 'YES':
		time.sleep(0.2)
		lines = read_temp_raw()
		
	equals_pos = lines[1].find('t=')
	if equals_pos != -1:
		temp_string = lines[1][equals_pos + 2:]
		temp_c = float(temp_string) / 1000.0
		return temp_c
		
# MAIN LOOP
try:
	lgpio.gpio_write(h, 27, 1)
	print("Off")
	while True:
		temperature = read_temp()
		print(f'Current temp: {temperature:.2f}^C')
		time.sleep(1)
		if temperature < 24:
			print("On")
			lgpio.gpio_write(h, 27, 0)
		else:
			print("Off")
			lgpio.gpio_write(h, 27, 1)
		
except KeyboardInterrupt:
	lgpio.gpio_write(h, 27, 1)
	print('Temperature reading stopped.')

