Boolean Evaluation Tool.
this tool takes in a expression and its true and false values as arguments that returns the result of the expression. I decided to use the approach of parsing the expression into smaller terms and factor that follow the correct order of operations. 

main.cc takes the arguments sent and creates a bool to char map called values with the help of the assignBool function in util.cc. main then takes the the values map and the string containing the expression and creates a object called parser that handles the actual parsing and solving of the expression. from there main calls parser.parse() and returns the results of the equation.

Boolean_Expression_Parser.cc is the where the expression is calculated. the parse method is where the calculation begins. i decided on a top down recursive descent parser because it was in the example and i though it was very cool how it was implemented. first you call parse expression which starts the chain of calling lower functions like parse term and parse factor. parse factor looks at the Current char and returns its value to parse term which then checks to see if the there is any *'s that need to be applied. if so parse term calls parse factor to grab the value of the next variable and *'s them. this loop continues until the end of the term is reached which is if the operator being performed is a +. then the parse term method returns the result of the first term to parse expression which calls parse term again to perform the same evaluation before but on the next term. this loop ends once the current index reaches the size of the expression and the result is returned to main.

the problems i fixed from the chat gpt code were mostly dealing with parsing terms from one another. first the original code didnt take into account that there would be more that 2 terms so i added a while loop that goes to the end of the expression. Second, i caught a case where the parser was trying to calculate a + statement without considering that one of the variables was tied to a * statement and skips calculating the term if its false because 
f + {term} = term. Lastly, i found a case if the current char is a letter and not a operation when it returns to parseExpr it returns the wrong result.


# Project Directory Structure
proj1/
├── Makefile                    # Build configuration file for make program
|
├── src/
│   ├── boolean_expression_parser.cc  # Source file for the parser logic
│   ├── main.cc                       # Main entry point to program
│   ├── util.cc                       # Source file for utility functions
|
├── include/
│   ├── boolean_expression_parser.h   # Header file for the parser logic
│   ├── util.h                        # Header file for utility declarations
|
├── bin/                        # Build directory (generated during build process)
│   ├── evaluate-boolean              # Main entry point of the program
|
├── build/                      # Compile directory (generated during build process)
│   ├── boolean_expression_parser.o   # object for the parser logic
│   ├── main.o                        # object for the+ main entry point to program
│   ├── util.o                        # object for utility functions
|
└── README.md                   # This file

