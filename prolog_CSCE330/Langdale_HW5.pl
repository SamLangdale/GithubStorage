
% 6. A
exactly_3([_,_,_]).
/*
 ?- exactly_3([1,2,3]).
   Call: (12) exactly_3([1, 2, 3]) ? creep
   Exit: (12) exactly_3([1, 2, 3]) ? creep
true.
*/

%6. B
at_least_3([_,_,_|_]).

/* 
 ?- at_least_3([1,2,3,4]).
   Call: (12) at_least_3([1, 2, 3, 4]) ? creep
   Exit: (12) at_least_3([1, 2, 3, 4]) ? creep
true.
*/

%6. C
at_most_3([]).
at_most_3([_]).
at_most_3([_,_]).
at_most_3([_,_,_]).
/*
?- at_most_3([1,2,3,4]).
   Call: (12) at_most_3([1, 2, 3, 4]) ? creep
   Fail: (12) at_most_3([1, 2, 3, 4]) ? creep
false.

 at_most_3([1,2]).
   Call: (12) at_most_3([1, 2]) ? creep
   Exit: (12) at_most_3([1, 2]) ? creep
true .
*/

%6 D. use Member and no recursion

intersect(X,Y) :- member(E,X), member(E,Y). % incorrect
/*
?- intersect([1,2,3],[4,5,6,7,8,3]).
   Call: (12) intersect([1, 2, 3], [4, 5, 6, 7, 8, 3]) ? creep
   Call: (13) lists:member(_115044, [1, 2, 3]) ? creep
   Exit: (13) lists:member(1, [1, 2, 3]) ? creep
   Call: (13) lists:member(1, [4, 5, 6, 7, 8, 3]) ? creep
   Fail: (13) lists:member(1, [4, 5, 6, 7, 8, 3]) ? creep
   Redo: (13) lists:member(_115044, [1, 2, 3]) ? creep
   Exit: (13) lists:member(2, [1, 2, 3]) ? creep
   Call: (13) lists:member(2, [4, 5, 6, 7, 8, 3]) ? creep
   Fail: (13) lists:member(2, [4, 5, 6, 7, 8, 3]) ? creep
   Redo: (13) lists:member(_115044, [1, 2, 3]) ? creep
   Exit: (13) lists:member(3, [1, 2, 3]) ? creep
   Call: (13) lists:member(3, [4, 5, 6, 7, 8, 3]) ? creep
   Exit: (13) lists:member(3, [4, 5, 6, 7, 8, 3]) ? creep
   Exit: (12) intersect([1, 2, 3], [4, 5, 6, 7, 8, 3]) ? creep
true.

*/
% 6. E





