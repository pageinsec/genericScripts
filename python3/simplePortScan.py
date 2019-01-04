# Simple port scanner
import socket

target = input("Target IP: ")
ports = input("Port range (Ex 1-100): ")

portStart = int(ports.split('-')[0])
portStop = int(ports.split('-')[1])

print("Scanning", target, " from", portStart, " to", portStop)

for port in range(portStart, portStop):
    svr = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    status = svr.connect_ex((target, port))
    if (status == 0):
        print("**Port",port," - OPEN**")
    else:
        print("Port",port," - closed")
    svr.close()
