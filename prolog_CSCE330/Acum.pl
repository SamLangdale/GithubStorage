

list_length([], Length).
list_length([_|Tail], Length) :-
    NewAcc is Length + 1,
    list_length(Tail, NewAcc).


   power_of_two(128, Solution) :-
    findall(Pow, (between(0, 10, Pow), 2**Pow =:= 128), Solution).
