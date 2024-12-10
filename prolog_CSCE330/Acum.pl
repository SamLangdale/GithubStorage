

list_length([], Length).
list_length([_|Tail], Length) :-
    NewAcc is Length + 1,
    list_length(Tail, NewAcc).


   power_of_two(128, Solution) :-
    findall(Pow, (between(0, 10, Pow), 2**Pow =:= 128), Solution).


factorial(N,R) :- factorial(N,1,R).
factorial(0,R,R).
factorial(N,Acc,R) :-
    NewN is N-1,
    NewAcc is Acc * N,
    factorial(NewN,NewAcc,R).

pow(A, B, R) :- pow(A, B, R, 1). % Ac
pow(A, 0, R, R).
pow(A, B, R, Ac) :-
    B > 0,
    B2 is B - 1,
    Ac2 is Ac * A,
    pow(A, B2, R, Ac2).

