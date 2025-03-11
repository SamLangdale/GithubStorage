// Copyright Sam Langdale

#ifndef BOOL_EXPR_SERVER_H
#define BOOL_EXPR_SERVER_H


#include <string>
#include <vector>
#include <unordered_map>
#include <csignal>

// signal handler to properly CTRL-C out of the server without causing socket issues
void signal_handler(int signal);


// converts a buffer into a string
std::string buffer_To_string(std::vector<char> buffer, char endOfTransmission);

// the method that perfoms the sending and recieving of information and results
int clientThread(std::string exprFile, char unitSeparator, char endOfTransmission, int clientSocket);



#endif // BOOL_EXPR_SERVER_H