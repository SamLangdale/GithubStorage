// copyright Sam Langdale
#include "../include/bool_expr_server.h"
#include <boolean_expression_parser.h>  //  change this when submitting
#include <unistd.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <csignal>
#include <iostream>
#include <fstream>
#include <ostream>
#include <string>
#include <cstring>
#include <unordered_map>
#include <vector>
#include <algorithm>
#include <cstdio>

using std::cerr;
using std::cout;
using std::endl;
using std::string;
using std::perror;
using std::string;
volatile sig_atomic_t stop_flag = 0;

void signal_handler(int signal) {
    if (signal == SIGINT) {
        cout << "evaluate one more client" <<endl;
        stop_flag = 1;
    }
}

string buffer_To_string(std::vector<char> buffer, char endOfTransmission) {
    auto end = std::find(buffer.begin(),
                   buffer.end(), endOfTransmission);  // finding the eot
    return string(buffer.begin(), end);
}

int clientThread(std::string exprFile, char unitSeparator,
                 char endOfTransmission, int clientSocket)  {
    cout << "client connected" << endl;
    send(clientSocket, &unitSeparator, 1, 0);
    send(clientSocket, &endOfTransmission, 1, 0);

    std::vector<char> buffer(5000);

    recv(clientSocket, buffer.data(), buffer.size(), 0);

    string truthTable;
    truthTable = buffer_To_string(buffer, endOfTransmission);

    const char* parm1 = truthTable.c_str();
    const string truthExploded = Explode(parm1, unitSeparator);
    std::unordered_map<char, bool> boolMap = BuildMap(truthExploded);
    std::ifstream file(exprFile);
    string line;
    int trueCount = 0, falsecount = 0, unableToEvaluateCount = 0;

    while (std::getline(file, line)) {
        bool skipEval = false;
        parm1 = line.c_str();
        for (char var : line) {    // make this a helper
            if (var != '+' && var != '*' && var != '\'' && var != ' ') {
                if (boolMap.find(var) == boolMap.end()) {
                    unableToEvaluateCount++;
                    skipEval = true;
                    break;
                }
            }
        }
        if (skipEval)
            continue;

        // check if num of variables matches amount of truth values givin
        BooleanExpressionParser parcer(Explode(parm1), boolMap);
        bool sol = parcer.Parse();
        (sol) ? trueCount++ : falsecount++;
    }

    string summary = std::to_string(trueCount) + unitSeparator
                     + std::to_string(falsecount) + unitSeparator
                     + std::to_string(unableToEvaluateCount)
                     + endOfTransmission;

    send(clientSocket, summary.c_str(), summary.length(), 0);
    close(clientSocket);
    std::cout << "client disconnected" << endl;
    return 0;
}

int main(int argc, char *argv[]) {
    if (argc != 5) {
        cerr << "Usage: ./bool-expr-server <expr_file> <socket_name> <US> <EOT>"
            << endl;
        return 1;
    }
    std::cout << "assigning args" << endl;

    string exprFile = argv[1];
    string socketName = argv[2];
    char unitSeparator = argv[3][0];
    char endOfTransmission = argv[4][0];  // making variables for args

    std::cout << "starting socket stuff" << endl;

    int serverSocket = socket(AF_UNIX, SOCK_STREAM, 0);  // makes a new socket
    if (serverSocket < 0) {
        perror("socket issue");
        return 1;
    }

    struct sockaddr_un serverAddr;
    memset(&serverAddr, 0, sizeof(serverAddr));
    serverAddr.sun_family = AF_UNIX;
    strcpy(serverAddr.sun_path, socketName.c_str());

    if (bind(serverSocket, (struct sockaddr *)&serverAddr,
    sizeof(serverAddr)) == -1) {  // assigns an ip and a port number to a socket
        perror("bind issue");
        return 1;
    }

    if (listen(serverSocket, 5) == -1) {
        perror("listen issue");
        return 1;
    }
    std::signal(SIGINT, signal_handler);
    while (!stop_flag) {
        std::cout << "waiting for client . . . " << endl;
        int clientSocket = accept(serverSocket,
                     nullptr, nullptr);  // awaits client to connect
                                                    // to the socket and creates
                                                       // a new socket
        if (clientSocket < 0) {
            perror("accept issue");
            return 1;
        }
        clientThread(exprFile, unitSeparator, endOfTransmission, clientSocket);
    }
    shutdown(serverSocket, SHUT_RDWR);
    unlink(socketName.c_str());;
    close(serverSocket);
}
