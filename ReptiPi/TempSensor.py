import os
import time

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
		
try:
	while True:
		temperature = read_temp()
		print(f'Current temp: {temperature:.2f}^C')
		time.sleep(5)
		
except KeyboardInterrupt:
	print('Temperature reading stopped.')
