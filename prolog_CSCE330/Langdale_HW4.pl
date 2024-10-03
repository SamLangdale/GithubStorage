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
    color(blue).
/*

    ?- solution(F,S,I,B,G,A,N) .
F = A, A = N, N = red,
S = B, B = yellow,
I = G, G = blue .
*/
