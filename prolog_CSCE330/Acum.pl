

list_length([], Length).
list_length([_|Tail], Length) :-
    NewAcc is Length + 1,
    list_length(Tail, NewAcc).