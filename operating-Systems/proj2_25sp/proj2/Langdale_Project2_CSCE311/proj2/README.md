bool_Expr_Server.cc creates a socket and waits for a client to connect and is sent True/False values for the server to evaluate against a text file containing boolean expressions and send back to the client
Usage: ./bool-expr-server <expr_file> <socket_name> <Unit_Separator> <End_of_Transmission>

bool_Expr_client.cc connects to a server and sends boolean expressions to a server that sends back a summary containing how many expresseions evaluate to True, False, and unable to evaluate.
Usage: ./bool-expr-client <socket_name> <truth_values>
Ex. ./bool-expr-client socket T T T F T T

proj2/
+-- include/
|
+-- bool_expr_client.h 
|
+-- bool_expr_server.h
|
+-- src/
|
+-- bool_expr_client.cc
|
+-- bool_expr_server.cc
|
+-- README.md
