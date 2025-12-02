
class node():
    name: str
    start_state: bool
    end_state: bool
    deltas: list["Delta"]
    def __init__(self, name, deltas = [], start_state=False, end_state=False):
        self.name = name
        self.start_state = start_state
        self.end_state = end_state
        self.deltas = []
    def addDelta(self, delta):
        self.deltas.append(delta)

        
class Delta():
    read_symbol: str
    write_symbol: str
    move_direction: str
    next_node: node
    def __init__(self, read_symbol, write_symbol, move_direction, next_node):
        self.read_symbol = read_symbol
        self.write_symbol = write_symbol
        self.move_direction = move_direction
        self.next_node = next_node
    
    def setReadSymbol(self, read_symbol):
        self.read_symbol = read_symbol
    def setWriteSymbol(self, write_symbol):
        self.write_symbol = write_symbol
    def setMoveDirection(self, move_direction):
        self.move_direction = move_direction
    def setNextNode(self, next_node):
        self.next_node = next_node
    

class TMmachine():
    blank_symbol: str
    tape_alphabet: list[str]
    alphabet: list[str]
    states: list[node]
    tape: list[str]
    head_pos: int
    current_state: node
    def __init__(self, states= [], tape =[], head_pos=1, current_state=None, start_state=None, alphabet = [], tape_alphabet = [], blank_symbol = "_"):
        self.states = states
        self.tape = tape
        self.head_pos = head_pos
        self.current_state = current_state
        self.alphabet = alphabet
        self.tape_alphabet = tape_alphabet
        self.blank_symbol = blank_symbol
        self.start_state = start_state

    def runTMRec(self, input_string:str):

        return_list = []
        f = open(input_string, "r")
        if f.readline().strip() != "Recognizer":
            raise Exception("Input type mismatch: expected Recognizer")
        line = f.readline().strip()
        while True:
            if not line:
                break
            self.tape = list(self.blank_symbol + line + self.blank_symbol)
            halt = False
            while not halt:
                print("Current tape:", "".join(self.tape))
                print("Head position:", self.head_pos)
                print("Current state:", self.current_state.name)
                current_symbol = self.tape[self.head_pos]
                transition_found = False
                for delta in self.current_state.deltas:
                    if delta.read_symbol == current_symbol:
                        transition_found = True
                        self.tape[self.head_pos] = delta.write_symbol
                        if delta.move_direction == "R":
                            self.head_pos += 1
                        elif delta.move_direction == "L":
                            self.head_pos -= 1
                        self.current_state = delta.next_node
                        break
                if not transition_found:
                    halt = True
                    return_list.append("Rejected")
                    print("rejected")
                elif self.current_state.end_state:
                    halt = True
                    return_list.append("Accepted")
                    print("accepted")
            line = f.readline().strip()
            self.tape = []
            self.head_pos = 1
            self.current_state = self.start_state
        
        return return_list
                
    

            






    def runTMTrans(self, input_string:str):
        return_list = []
        f = open(input_string, "r")
        if f.readline().strip() != "Transducer":
            raise Exception("Input type mismatch: expected Transducer")
        line = f.readline().strip()
        while True:
            if not line:
                break
            self.tape = list(self.blank_symbol + line + self.blank_symbol)
            halt = False
            while not halt:
                print("Current tape:", "".join(self.tape))
                print("Head position:", self.head_pos)
                print("Current state:", self.current_state.name)

                # ensure head_pos is within tape bounds
                if self.head_pos < 0:
                    self.tape.insert(0, self.blank_symbol)
                    self.head_pos = 0
                if self.head_pos >= len(self.tape):
                    self.tape.append(self.blank_symbol)

                current_symbol = self.tape[self.head_pos]
                transition_found = False
                for delta in self.current_state.deltas:
                    if delta.read_symbol == current_symbol:
                        transition_found = True
                        self.tape[self.head_pos] = delta.write_symbol
                        if delta.move_direction == "R":
                            self.head_pos += 1
                        elif delta.move_direction == "L":
                            self.head_pos -= 1
                        self.current_state = delta.next_node
                        break

                if not transition_found:
                    halt = True
                    return_list.append("Rejected")
                    print("rejected")
                elif self.current_state.end_state:
                    halt = True
                    # convert tape to string and strip surrounding blank symbols
                    out = "".join(self.tape)
                    if out.startswith(self.blank_symbol):
                        out = out[1:]
                    if out.endswith(self.blank_symbol):
                        out = out[:-1]
                    return_list.append(out)
            line = f.readline().strip()
            self.tape = []
            self.head_pos = 1
            self.current_state = self.start_state
        
        return return_list
        


    # ugly function to read in TM definition from file (at least i put comments right?)
    def readDefinitions(self, tm_definition_file: str):
        f = open(tm_definition_file, "r")
        line = ""
        while(True):
            line = f.readline()
            if line == "TM\n":
                break
        if not line:
            raise Exception("invalid file format: TM marker not found")
        print("TM found.")
        line = f.readline()
        index = 0
        # reading states
        while(True):
            if line[index] == "\n":
                break
            if line[index] == " " or line[index] == ",":
                index += 1
                continue
            state_name = ""
            while(line[index] != " " and line[index] != "\n" and line[index] != ","):
                state_name += line[index]
                index += 1
            self.states.append(node(state_name))
        line = f.readline()
        index = 0
        #reading alphabet
        while(True):
            if line[index] == "\n":
                break
            if line[index] == ",":
                index += 1
                continue
            self.alphabet.append(line[index])
            index += 1
        line = f.readline()
        index = 0
        #reading tape alphabet
        while(True):
            if line[index] == "\n":
                break
            if line[index] == ",":
                index += 1
                continue
            self.tape_alphabet.append(line[index])
            index += 1
        line = f.readline().strip()
        #reading inital state
        for state in self.states:
            if state.name == line:
                state.start_state = True
                self.current_state = state
                self.start_state = state
                break
        # reading blank symbol
        self.blank_symbol = f.readline().strip()
        # reading final states
        line = f.readline()
        index = 0
        while(True):
            if line[index] == "\n":
                break
            if line[index] == " " or line[index] == ",":
                index += 1
                continue
            final_state_name = ""
            while(line[index] != " " and line[index] != "\n" and line[index] != ","):
                final_state_name += line[index]
                index += 1
            for state in self.states:
                if state.name == final_state_name:
                    state.end_state = True
                    break
        # reading transitions
        while(True):
            line = f.readline()
            if not line: #reached end of file
                break
            index = 1 #skip first "("
            # getting current state
            name = ""
            while(line[index] != "," and line[index] != " "):
                name += line[index]
                index += 1
            temp_state = node("") 
            for state in self.states:
                if state.name == name:
                    temp_state = state
                    break
            if temp_state.name == "":
                raise Exception("State not found: " + name)
            # getting read symbol
            while(line[index] == "," or line[index] == " "):
                index += 1
            read_symbol = line[index]
            index += 1

            #getting next state
            while(line[index] == "," or line[index] == " "):
                index += 1
            next_state_name = ""
            while(line[index] != "," and line[index] != " "):
                next_state_name += line[index]
                index += 1
            next_state = node("")
            for state in self.states:
                if state.name == next_state_name:
                    next_state = state
                    break
            if next_state.name == "":
                raise Exception("State not found: " + next_state_name)
            #getting write symbol
            while(line[index] == "," or line[index] == " "):
                index += 1
            write_symbol = line[index]
            index += 1
            #getting move direction
            while(line[index] == "," or line[index] == " "):
                index += 1  
            move_direction = line[index]
            index += 1
            #creating delta and adding it to state
            delta = Delta(read_symbol, write_symbol, move_direction, next_state)
            temp_state.addDelta(delta)
            


