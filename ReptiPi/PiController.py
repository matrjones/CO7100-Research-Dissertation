import os
import lgpio
import time as t
import requests
import json
from datetime import time
from datetime import datetime


# GPIO SETUP
h = lgpio.gpiochip_open(0)
lgpio.gpio_claim_output(h, 17)
lgpio.gpio_claim_output(h, 27)


# VARIABLES
base_address = "http://192.168.1.153:8080/api"
selected_vivarium = {}


# READ TEMPERATURE SENSOR
def read_temp_raw():
	base_dir = '/sys/bus/w1/devices/'
	device_folder = [d for d in os.listdir(base_dir) if d.startswith('28-')][0]
	device_file = base_dir + device_folder + '/w1_slave'
	with open(device_file, 'r') as f:
		lines = f.readlines()
	return lines


# CONVERTS TEMP SENSOR VALUE TO CELCIUS
def read_temp():
	lines = read_temp_raw()
	while lines[0].strip()[-3:] != 'YES':
		t.sleep(0.2)
		lines = read_temp_raw()
	equals_pos = lines[1].find('t=')
	if equals_pos != -1:
		temp_string = lines[1][equals_pos + 2:]
		temp_c = float(temp_string) / 1000.0
		return temp_c


# API CALL
def get_all_vivaria():
	url = f"{base_address}/Vivarium/GetAll"
	parameters = {}
	response = requests.get(url, params=parameters)
	if(response.status_code != 200):
		raise requests.exceptions.HTTPError("Error 400")
	return json.loads(response.text);


# UPDATE VIVARIUM
def update_vivarium(current_temp, current_light):
	url = f"{base_address}/Environment/Update"
	data = {
		"Id": selected_vivarium["Environment"]["Id"],
		"Temperature": current_temp,
		"Light": current_light == 1
	}
	
	print(data)
	
	response = requests.post(url, json=data)
	if(response.status_code != 200):
		raise requests.exceptions.HTTPError(f"Error {response.status_code}")
	return "Updated Sucessfully"
	

# MAIN LOOP
try:
	# EVERYTHING STARTS TURNED OFF
	lgpio.gpio_write(h, 17, 1)  #light off
	lgpio.gpio_write(h, 27, 1)  #heating off

	# SELECT A VIVARIUM FROM DATABASE
	print("Select an index number for a specific vivarium")
	vivaria = get_all_vivaria()
	viv_index = -1
	for index, vivarium in enumerate(vivaria):
		print(f'Index: {index +1}, Vivarium: {vivarium["Name"]}')
		
	# SELECT SPECIFIC VIVARIUM
	while viv_index < 1 or viv_index > len(vivaria):
		try:
			viv_index = int(input())
		except ValueError:
			viv_index = -1
	selected_vivarium = vivaria[viv_index -1]

	# 
	while True:
		current_temperature = read_temp()
		current_time = datetime.now().time()
		current_lighting = 0
		time_format = "%H:%M:%S"
		vivaria = get_all_vivaria()
		selected_vivarium =  vivaria[viv_index -1]
		light_on = datetime.strptime(selected_vivarium["Parameter"]["LightOn"], time_format).time()
		light_off = datetime.strptime(selected_vivarium["Parameter"]["LightOff"], time_format).time()
		print(f'Current temperature: {current_temperature:.2f}\u00b0C')
		t.sleep(0.8)

		# SELECT DAY OR NIGHT TEMPERATURE (00, 00)
		if light_on < current_time < light_off:
			desired_temperature = selected_vivarium["Parameter"]["DayTemp"]
		else:
			desired_temperature = selected_vivarium["Parameter"]["NightTemp"]

		# TURN LIGHTING ON
		if light_on <= current_time < light_off:
			lgpio.gpio_write(h, 17, 0)
			print("Light on")
			current_lighting = 1
		# TURN LIGHTING OFF
		else:
			lgpio.gpio_write(h, 17, 1)
			print("Light off")
			current_lighting = 0

		# TURN HEATING ELEMENT ON
		if current_temperature < desired_temperature:
			lgpio.gpio_write(h, 27, 0)
			print("Heating on")		
		# TURN HEATING ELEMENT OFF
		else:
			lgpio.gpio_write(h, 27, 1)
			print("Heating off")
		print(update_vivarium(current_temperature, current_lighting))

# STOP THE PROGRAM
except Exception as e:
	print(e)
	lgpio.gpio_write(h, 17, 1)
	lgpio.gpio_write(h, 27, 1)
	print('Temperature reading stopped.')
# STOP THE PROGRAM
except KeyboardInterrupt:
	lgpio.gpio_write(h, 17, 1)
	lgpio.gpio_write(h, 27, 1)
	print('Temperature reading stopped.')
