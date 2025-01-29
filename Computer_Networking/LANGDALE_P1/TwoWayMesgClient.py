# Implementation of the one way message client in python
# Sam Langdale
# Import socket related methods
from socket import *

# Import argv related methods
from sys import *

import threading

# Client needs server's contact information
if len(argv) != 3:
    print("usage:", argv[0], "<server name> <server port>")
    exit()

# Get server's whereabouts
serverName = argv[1]
serverPort = int(argv[2])

# Create a socket
sock = socket(AF_INET, SOCK_STREAM)

# Connect to the server
sock.connect((serverName, serverPort))
print(f"Connected to server at ('{serverName}', '{serverPort}')");

# Make a file stream out of socket
sockFile = sock.makefile(mode='w')





def Msg_In() :
        ServerSockFile = sock.makefile()
        # reads message from server (added)
        message = ServerSockFile.readline()
        if not message:
            print('Client closed connection')
            ServerSockFile.close()
            sock.close()
        print('Server:', message, end='')
        ServerSockFile.close()
    # done
    #print("Closing connection")
    #sock.close()

def Msg_Out() :
    for line in stdin:
        #  Send the line to server
        sock.send(line.encode())
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

        
     

