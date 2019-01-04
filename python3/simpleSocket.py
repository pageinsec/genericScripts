# Simple Python3 server 

import socket

hostIP = input("Host IP: ")
hostPort = int(input("Host Port: "))

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind((hostIP, hostPort))
server.listen(1)
print("Server initiated. Waiting for connection.")
connection, address = server.accept()
print("Connection from:", address)
while 1:
  data = connection.recv(1024)
  if not data: break
  connection.sendall(b'--Message Received --\n')
  print(data.decode('utf-8'))
connection.close()
