# Standard multi-threaded TCP server
import socket
import threading

# IP and Port to listen on
bind_ip = "0.0.0.0"
bind_port = 9999

server = socket.socket(socket.AF_INET, socket.sock_STREAM)
server.bind((bind_ip, bind_port))

# Listen w/max backlog of 5
server.listen(5)
print "[*] Listening on %s:%d" % (bind_ip,bind_port)

# Client-handling thread
def handle_client(client_socket):
    # Print what client sends
    request = client_socket.recv(1024)
    print "[*] Received: %s" % request

    # Send packet back
    client_socket.send("ACK!")

    client_socket.close()

while True:
    client,addr = server.accept()
    print "[*] Accepted connection from %s:%d" % (addr[0],addr[1])

    # Spin up client thread to handle data
    client_handler = threading.Thread(target=handle_client,args=(client,))
    client_handler.start()
