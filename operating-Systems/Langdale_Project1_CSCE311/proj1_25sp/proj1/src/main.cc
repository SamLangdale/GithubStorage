//
// Copyright Sam Langdale
//
#include <iostream>
#include <string>
#include <unordered_map>
#include "boolean_expression_parser.h"
#include "util.h"

int main(int argc, char* argv[]) {
    if (argc < 3) {
        std::cerr << "Usage: " << argv[0] << " <expression> <values>\n";
        std::cerr << "Example: " << argv[0] <<
                    " \"a + b * c + a * d * e\" F T T T F\n";
        return 1;
    }

    // Read the expression
    std::string expression = argv[1];
    // Read variable values
    std::unordered_map<char, bool> values = assignBool(argc, argv);
    // Create and use the parser
    BooleanExpressionParser parser(expression, values);
    bool result = parser.parse();  //  parses
    std::cout << ((result) ? "True" : "false") << std::endl;  //  awsome turnary

    if (parser.hasError()) {
          return 1;
    }
}
