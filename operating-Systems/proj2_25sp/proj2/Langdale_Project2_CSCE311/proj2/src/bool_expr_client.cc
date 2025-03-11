// copyright Sam Langdale
#include <sys/un.h>
#include <unistd.h>
#include <sys/socket.h>
#include <iostream>
#include <cstring>
#include <vector>
#include <algorithm>
#include <cstdio>
#include <string>


std::string buffer_To_string(std::vector<char> buffer, char endOfTransmission) {
    auto end = std::find(buffer.begin(), buffer.end(), endOfTransmission);
    return std::string(buffer.begin(), end);
}

int main(int argc, char *argv[]) {
    if (argc < 3) {
        std::cerr << "Usage: ./bool-expr-client <socket_name> <truth_values>"
                  << std::endl;
        return 1;
    }

    std::string socketName = argv[1];
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

    if (connect(clientSocket, (struct sockaddr *)&serverAddr,
            sizeof(serverAddr)) == -1) {
        perror("connect");
        return 1;
    }

    std::cout << "BoolExprClient connecting..." << std::endl;

    // Receive US and EOT characters
    recv(clientSocket, &unitSeparator, 1, 0);
    recv(clientSocket, &endOfTransmission, 1, 0);

    // Send the truth values
    std::string truthValues = "";
    for (int i = 2; i < argc; i++) {
        truthValues += argv[i];
        if (i != argc - 1) {
            truthValues += unitSeparator;
        }
    }
    truthValues += endOfTransmission;
    send(clientSocket, truthValues.c_str(), truthValues.size(), 0);

    // Receive the summary from the server
    std::vector<char> buffer(5000);
    recv(clientSocket, buffer.data(), buffer.size(), 0);
    std::string summary = buffer_To_string(buffer, endOfTransmission);
    std::cout << summary << std::endl;
    std::string trueCount = "", falsecount = "", unableToEvaluateCount = "";
    int unitCount = 0;

    for (char var : summary) {
        if (var != unitSeparator && unitCount == 0) {
            trueCount = trueCount + var;
        }
        if (var != unitSeparator && unitCount == 1) {
            falsecount = falsecount + var;
        }
        if (var != unitSeparator && unitCount == 2) {
            unableToEvaluateCount = unableToEvaluateCount + var;
        }
        if (var == unitSeparator)
            unitCount++;
    }
    std::cout << "summary\nTrue Evaluated : " << trueCount
              << "\nFalse Evaluation : " << falsecount <<
              "\nunable to evaluate : " << unableToEvaluateCount << std::endl;
    close(clientSocket);  // Close socket
    return 0;
}
