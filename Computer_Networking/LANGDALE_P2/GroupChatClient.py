# GroupChat Client by Sam Langdale

# Import socket related methods
from socket import *

# Import argv related methods
from sys import *

# Import select method
from select import *


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
try:
    sock.connect((serverName, serverPort))
    print(f"Connected to server at ('{serverName}', '{serverPort}')")
except Exception as e:
    print(f"Failed to connect: {e}")
    exit()

# Make a file stream out of socket
sockFile = sock.makefile(mode='r')
print("Please type your Name")
name = stdin.readline().strip() 
sock.send(name.encode())

# Make a list of inputs to watch for
inputSet = [stdin, sockFile]

# Keep sending and receiving messages from the server
while True:
    # Wait for a message from keyboard or socket
    readableSet, _, _ = select(inputSet, [], [])
    
    # Check if there is a message from the keyboard
    if stdin in readableSet:
        # Read a line from the keyboard
        line = stdin.readline()
        
        # If EOF ==> client wants to close connection
        if not line:
            print('*** Client closing connection')
            break
        
        # Send the line to server
        sock.send(line.encode())
    
    # Check if there is a message from the socket
    if sockFile in readableSet:
        # Read a message from the server
        line = sockFile.readline()
        
        # If EOF ==> server closed the connection
        if not line:
            print('*** Server closed connection')
            break
        
        print(line, end='')

# Close the connection
sockFile.close()
sock.close()