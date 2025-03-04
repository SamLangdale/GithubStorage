# GroupChat Server by Sam Langdale

# Import socket related methods
from socket import *

# Import argv related methods
from sys import *

# Import select method
from select import *

from _thread import *


# Server needs the port number to listen on
if len(argv) != 2:
    print('usage:', argv[0], '<port>')
    exit()

# Get the port on which server should listen
serverPort = int(argv[1])

# Create the server socket
serverSock = socket(AF_INET, SOCK_STREAM)

# Bind the socket to the given port
serverSock.bind(('', serverPort))

# Set the server for listening
serverSock.listen()
clients = [] # list of tuples containing the clients (name, conn, addr)

# Wait to receive a connection request
print('Waiting for a client ...')

def clientThread(conn, addr, name):
    # welcomes new client 
    broadcast(f"Welcome {name} to the server\n", conn)
    
    while True:
        try:
            message = conn.recv(1024).decode('utf-8')
            if message:
                # sends it out to all
                broadcast_message = f"{name}: {message}"
                broadcast(broadcast_message, conn)
            else:
                # Client disconnected
                print(f"Client {name} disconnected")
                remove(conn)
                break
        except Exception as e:
            print(f"Error in client thread: {e}")
            remove(conn)
            break

def broadcast(message, sender_conn):
    print(f"Broadcasting message: {message}")
    for client in clients:
        client_name, client_conn, client_addr = client
        if client_conn != sender_conn:  # Don't send to the sender
            try:
                if not message.endswith('\n'):
                    message += '\n'
                client_conn.send(message.encode('utf-8'))
            except Exception as e:
                print(f"Error broadcasting to {client_name}: {e}")
                client_conn.close()
                remove(client_conn)

def remove(conn):
    for i, client in enumerate(clients):
        if client[1] == conn:
            print(f"Removing client {client[0]}")
            del clients[i]
            break

def getname(conn):
    print("Retrieving name...")
    try:
        name = conn.recv(1024).decode('utf-8').strip()
        print(f"Got name: {name}")
        return name
    except Exception as e:
        print(f"Error getting name: {e}")
        return "Anonymous"

while True:
    try:
        conn, addr = serverSock.accept()
        print(f"New connection from {addr}")
        
        name = getname(conn)
        clients.append((name, conn, addr))
        
        print(f"Client {name} connected from {addr}")
        
        # Start a new thread for the client
        start_new_thread(clientThread, (conn, addr, name))
    except Exception as e:
        print(f"Error accepting connection: {e}")


conn.close()
serverSock.close()