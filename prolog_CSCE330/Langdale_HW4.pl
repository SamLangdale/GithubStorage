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
 



