/*
1. 
A. = tests for if two terms are identical
B. =:= tests if two nunbers are equal
C. is assignes the result on the right to the variable on the left
*/

% 2. france, switzerland, italy, belgium, germany, austria, the netherlands red yellow orange 

solution(F,S,I,B,G,A,N) :-
    color(F), color(S), color(I), color(B), color(G), color(A), color(N),
    \+ F=S, \+ S=I, \+ I=A, \+ B=G,\+ G=A,
    \+ F=B, \+ S=A, \+ B=N, \+ G=N,
    \+ F=G, \+ S=G,
    \+ F=I.
    color(red).
    color(yellow).
    color(orange).
/*

    ?- solution(F,S,I,B,G,A,N) .
F = A, A = N, N = red,
S = B, B = yellow,
I = G, G = orange .
*/

 %. 3. CryptoArithmetic CROSS + ROADS = DANGER
 solution2(C,O,S,R,A,D,N,G,E) :-
    dig(S), 
    R is (S+S) mod 10, C1 is (S+S) // 10 ,
    dig(S), dig(D),
    E is (S+D+C1) mod 10, C10 is (S+D+C1) // 10,
    dig(O), dig(A),
    G is (O+A+C10) mod 10, C100 is (O+A+C10) // 10,
    dig(R), dig(O),
    N is (R+O+C100) mod 10, C1000 is (R+O+C100) // 10,
    dig(C), C > 0, dig(R), R > 0,
    A is (C+R+C1000) mod 10, D is (C+R+C1000) // 10,
    uniq_digits(C,O,S,R,A,D,N,G,E).


    uniq_digits(C,O,S,R,A,D,N,G,E) :-
    dig(C), dig(R), dig(O), dig(S), dig(A), dig(D), dig(N), dig(G), dig(E),
    \+ C=R, \+ R=O, \+O=S, \+S=A, \+A=D, \+D=N, \+N=G, \+G=E,
    \+ C=O, \+ R=S, \+O=A, \+S=D, \+A=N, \+D=G, \+N=E,
    \+ C=S, \+ R=A, \+O=D, \+S=N, \+A=G, \+D=E,
    \+ C=A, \+ R=D, \+O=N, \+S=G, \+A=E,
    \+ C=D, \+ R=N, \+O=G, \+S=E,
    \+ C=N, \+ R=G, \+O=E,
    \+ C=G, \+ R=E, 
    \+ C=E.

    dig(0). dig(1). dig(2). dig(3). dig(4). dig(5). dig(6). dig(7). dig(8). dig(9).   
     /*
     ?- solution2(C,O,S,R,A,D,N,G,E)
|    .
C = 9,
O = 2,
S = 3,
R = 6,
A = 5,
D = 1,
N = 8,
G = 7,
E = 4 .

  96233
+ 62513
 158746
 */

% 3. person food and drink puzzle

solution3(Pizza,David,Danny,Doreen,Donna) :-
    sol(David,Danny,Doreen,Donna,Chicken,Lasagna,Steak,Pizza,Coffee,Water,Coke,Milk),
    match(Pizza,Danny,'Danny'),
    match(Pizza,Donna,'Donna'),
    match(Pizza,Doreen,'Doreen'),
    match(Pizza,David,'David').

match(X,X,Name) :- write(Name), write(' ordered the pizza.').
match(X,Y,_) :- \+ X=Y.



sol(David,Danny,Doreen,Donna,Chicken,Lasagna,Steak,Pizza,Coffee,Water,Coke,Milk) :-
    uniq_pos(Donna,Danny,David,Doreen),
    uniq_pos(Chicken,Lasagna,Steak,Pizza),
    uniq_pos(Coffee,Water,Coke,Milk),
    across(Danny,David),
    across(Donna,Doreen),
    beside(Doreen,Steak),  
    Chicken = Coke,        
    across(Lasagna,Milk),  
    \+ David = Coffee,    
    Donna = Water,         
    \+ Danny = Steak,
    uniq_pos(Donna,Danny,David,Doreen),
    uniq_pos(Chicken,Lasagna,Steak,Pizza),
    uniq_pos(Coffee,Water,Coke,Milk). 
    

uniq_pos(P1,P2,P3,P4) :- 
    pos(P1), pos(P2), pos(P3), pos(P4),
    \+ P1=P2,\+ P2=P3,\+ P3=P4,
    \+ P1=P3,\+ P2=P4,
    \+ P1=P4.

pos(1). pos(2). pos(3). pos(4).

beside(1,2). beside(2,1). beside(3,4). beside(4,3).
across(1,3). across(3,1). across(2,4). across(4,2).

/*
?- solution3(Pizza,David,Danny,Doreen,Donna).
Donna ordered the pizza.
Pizza = Donna, Donna = 1,
David = 4,
Danny = 2,
Doreen = 3 
*/





















  
