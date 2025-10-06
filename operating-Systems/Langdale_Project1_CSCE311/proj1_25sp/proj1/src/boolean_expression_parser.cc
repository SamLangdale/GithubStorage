/*
* copyright Sam Langdale
*/
#include <string>
#include <unordered_map>
#include <iostream>
#include <vector>
#include "boolean_expression_parser.h"



BooleanExpressionParser::BooleanExpressionParser(const std::string& expression,
                            const std::unordered_map<char, bool>& values)
        : expression(expression), values(values), currentIndex(0), error(0) {
      // empty
    }

    bool BooleanExpressionParser::parse() {
        bool result = parseExpr();
        if (error || currentIndex > expression.size()) {
            reportError("Unexpected tokens after parsing.");

            return false;  //  Indicate parse error
        }

        return result;
    }

    bool BooleanExpressionParser::hasError() const {
        return error;
    }

    // Get the current character
    char BooleanExpressionParser::currentChar() const {
        if (currentIndex < expression.size()) {
            return expression[currentIndex];
        }
        return '\0';
    }

    // Advance to the next character
    void BooleanExpressionParser::consume() {
        if (currentIndex +1 < expression.size()) {
            //  consumes 2 to account for the space character
            currentIndex += 2;
        }
    }

    // Parse OR ('+') expressions
    bool BooleanExpressionParser::parseExpr() {
        bool result;
        while (currentIndex +1 < expression.size()) {
            result = parseTerm();  //  Parse AND expressions first
            while (currentChar() == '+') {
                if (result) {  // checks for T + {term} = T
                    return result;  //  return true early
                }
                if (expression[currentIndex+4]  == '*') {
                    //  checks if next factor is tied to a term ex a + b * c
                    consume();
                    //  skips calculating next + because
                    //  F + {Term} = Term
                    break;  //  breaks while loop
                }
                consume();  //  Consume the '+'
                result = result || parseTerm();
                if (error) return false;  //  Halt on error
        }
        }
        return result;
    }

    // Parse AND ('*') expressions
    bool BooleanExpressionParser::parseTerm() {
        bool result = parseFactor();  //  Parse primary values first
        while (currentChar() == '*') {
            consume();  //  Consume the '*'
            result = result && parseFactor();
            if (std::isalpha(currentChar())) {
                 //  ensures that the current char is an operation
                 //  after the second call to parse
                consume();
            }
            if (error) return false;  //  Halt on error
        }
        return result;
    }

    // Parse primary values: variables (a-z)
    bool BooleanExpressionParser::parseFactor() {
        char token = currentChar();
        if (std::isalpha(token)) {
            consume();
            if (values.find(token) != values.end()) {
                return values.at(token);
            } else {
                reportError("Undefined variable: " + std::string(1, token));
                return false;
            }
        } else {
            reportError("Unexpected token: " + std::string(1, token));
            return false;
        }
    }

    void BooleanExpressionParser::reportError(const std::string& message) {
        if (!error) {
            std::cerr << "Error: " << message << std::endl;
            error = true;
        }
    }



