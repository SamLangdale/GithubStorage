//
// Copyright Sam Langdale
//

#include <unordered_map>
#include <string>
#include "util.h"


std::unordered_map<char, bool> assignBool(int argc, char* boolList[]) {
    std::unordered_map<char, bool> values;
    int varIndex = 0;
    for (int i = 2; i < argc; ++i) {
        char var = 'a' + varIndex;  //  Variables are a, b, c, ...
        values[var] = (boolList[i][0] == 'T');
        varIndex++;
    }
    return values;
}

