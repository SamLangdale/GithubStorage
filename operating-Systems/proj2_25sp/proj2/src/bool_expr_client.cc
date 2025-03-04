#include <iostream>
#include <sstream>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <cstring>
//#include "boolean_expression.h"
#//include "domain_socket.h"

using namespace std;

int main(int argc, char *argv[]) {
    if (argc < 3) {
        cerr << "Usage: ./bool-expr-client <socket_name> <truth_values>" << endl;
        return 1;
    }

    string socketName = argv[1];
    char unitSeparator;
    char endOfTransmission;

    // Create socket and connect to the server
    int clientSocket = socket(AF_UNIX, SOCK_STREAM, 0);
    if (clientSocket < 0) {
        perror("socket");
        return 1;
    }

    struct sockaddr_un serverAddr;
    memset(&serverAddr, 0, sizeof(serverAddr));
    serverAddr.sun_family = AF_UNIX;
    strcpy(serverAddr.sun_path, socketName.c_str());

    if (connect(clientSocket, (struct sockaddr *)&serverAddr, sizeof(serverAddr)) == -1) {
        perror("connect");
        return 1;
    }

    cout << "BoolExprClient connecting..." << endl;

    // Receive US and EOT characters
    recv(clientSocket, &unitSeparator, 1, 0);
    recv(clientSocket, &endOfTransmission, 1, 0);

    // Send the truth values
    string truthValues = "";
    for (int i = 2; i < argc; i++) {
        truthValues += argv[i];
        if (i != argc - 1) {
            truthValues += unitSeparator;
        }
    }
    truthValues += endOfTransmission;
    send(clientSocket, truthValues.c_str(), truthValues.size(), 0);

    // Receive the summary from the server
    char buffer[1024];
    int bytesRead = recv(clientSocket, buffer, sizeof(buffer), 0);
    if (bytesRead > 0) {
        string summary(buffer, bytesRead);
        cout << "Results" << endl;
        cout << summary << endl;
    }

    // Close socket
    close(clientSocket);

    return 0;
}
