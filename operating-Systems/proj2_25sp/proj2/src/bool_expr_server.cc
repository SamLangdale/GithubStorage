#include <iostream>
#include "../include/bool_expr_server.h"
#include "../../util/include/bool_expr_parser.h"
#include <fstream>
#include <sstream>
#include <string>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <cstring>

using std::cerr;
using std::cout;
using std::endl;
using std::string;
using std::perror;


int main(int argc,char *argv[]) {
    if( argc != 5) {
        cerr << "Usage: ./bool-expr-server <expr_file> <socket_name> <US> <EOT>" << endl;
    }
    return 1;

    string exprFile = argv[1];
    string socketName = argv[2];
    char unitSeparator = argv[3][0];
    char endOfTransmission = argv[4][0]; // making variables for args

    int serverSocket = socket(AF_UNIX,SOCK_STREAM,0); // makes a new socket
    if(serverSocket < 0)
    {
        perror("socket issue, line 31");
        return 1;
    }

    struct sockaddr_un serverAddr;
    memset(&serverAddr, 0, sizeof(serverAddr)); // initializes ServerAddr as all 0's 
    serverAddr.sun_family = AF_UNIX;
    strcpy(serverAddr.sun_path, socketName.c_str());

    if( bind(serverSocket,(struct sockaddr *)&serverAddr,sizeof(serverAddr)) == -1) { // assigns an ip and a port number to a socket
        perror("bind issue, line 40");
        return 1;
    }

    if(listen(serverSocket,5) == -1) {
        perror("listen issue, line 46");
        return 1;
    }

    cout << "waiting for client" << endl;

    int clientSocket = accept(serverSocket,nullptr,nullptr); // awaits client to connect to the socket and creates a new socket
    if(clientSocket < 0 ) {
        perror("accept issue, line 55");
        return 1;
    }

    cout << "client connected" << endl;

    send(clientSocket, &unitSeparator, 1,0); 
    send(clientSocket, &endOfTransmission, 1, 0);

    std::ifstream file(exprFile);
    string line;
    int trueCount = 0, falsecount = 0, unableToEvaluateCount = 0;

    while (std::getline(file, line)) {
        // evaluates booleans
    }

    // summary print

    close(clientSocket);
    close(serverSocket);

    return 0;












}



