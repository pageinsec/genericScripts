# Simple client, will connect, send a message, and close
import socket

# Get info for server
hostIP = input("Host IP: ")
hostPort = int(input("Host Port: "))

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect((hostIP, hostPort))
print("Connected")
message = input("What's the message? ")
client.sendall(message.encode())
client.close()
