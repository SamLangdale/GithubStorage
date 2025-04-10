# Implementation of a one way message server in python
# Sam Langdale
# Import socket related methods
from socket import *

# Import argv related methods
from sys import *

import threading 
# Server needs the port number to listen on
if len(argv) != 2:
    print('usage:', argv[0], '<port>')
    exit()

# Get the port on which server should listen */
serverPort = int(argv[1])

# Create the server socket
serverSock = socket(AF_INET, SOCK_STREAM)

# Bind the socket to the given port
serverSock.bind(('', serverPort))

# Set the server for listening */
serverSock.listen()

# Wait to receive a connection request
print('Waiting for a client ...')
clientSock, clientAddr = serverSock.accept()
print('Connected to a client at', clientAddr)

# No other clients, close the server socket
#serverSock.close()



#makes the server write file(added)
sockFile = serverSock.makefile(mode='w')
# Keep serving the client

def Msg_In() :
    clientSockFile = clientSock.makefile()
    # Read a message from the client
    message = clientSockFile.readline()

    # If no message ==> client closed the connection
    if not message:
        print('Client closed connection')
        clientSockFile.close()
        clientSock.close()

    # Display the line
    print('Client:', message, end='')
    clientSockFile.close()

def Msg_Out() :
     # Make a file stream out of client socket
     #clientSockFile = clientSock.makefile()
     for line in stdin:
        # Send the line to server
        clientSock.send(line.encode())
        break

t_In = threading.Thread(target=Msg_In)
t_In.start



if __name__ == "__main__":
     while True :
          t_In.join
          if(stdin.isatty()) :
               t_Out = threading.Thread(target=Msg_Out)
               t_Out.start
               t_Out.join



