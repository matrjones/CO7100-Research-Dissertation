import time

sensor = "/sys/bus/iio/devices/iio:device0"
temperatureFile = "in_temp_input"
humidityFile = "in_humidityrelative_input"

def readFirstLine(filename):
	try:
		f = open(f"{sensor}/{filename}", "rt")
		value = int(f.readline())
		f.close()
		return True, value
	
	except ValueError:
		f.close()
		return False, -1
	
	except OSError:
		return False, 0
		
while True:
	try:
		flag, temperature = readFirstLine(temperatureFile)
		if flag:
			print(f"Temperature: {temperature // 1000}\u2103")
		else:
			print(f"Temperature: {temperature}")
		
		flag, humidity = readFirstLine(humidityFile)
		if flag:
			print(f"Humidity: {humidity // 1000}%")
		else:
			print(f"Humidity: {humidity}")
			
	except KeyboardInterrupt:
		break
		
