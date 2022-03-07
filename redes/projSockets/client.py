from pickle import FALSE
import socket
import signal
from statistics import mean
import sys
import psutil
import os
import time
# from math import avg

def signal_handler(sig, frame):
    print('\nDone!')
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)
print('Press Ctrl+C to exit...')

##

ip_addr = "127.0.0.1"
udp_port = 5005

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

while True:
	CPU_use = psutil.cpu_percent(interval=0.5,percpu=False)
	message= (""+str(CPU_use)+"%").encode()
	sock.sendto(message, (ip_addr, udp_port))
