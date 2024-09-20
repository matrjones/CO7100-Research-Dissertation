import os
import lgpio
import time
from datetime import datetime

h = lgpio.gpiochip_open(0)
lgpio.gpio_write(h, 17, 1)  #light off
lgpio.gpio_write(h, 27, 1)  #heating off
