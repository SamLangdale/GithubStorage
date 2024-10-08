
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

intersect(X,Y) :- member(E,X), member(E,Y). 
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

all_intersect([],_). % base case
all_intersect([C|L],B) :- intersect(B,C), all_intersect(L,B).  

/*
?- all_intersect([[1,2,3],[1,2,5],[5,4,6]],[3,4]).
   Call: (12) all_intersect([[1, 2, 3], [1, 2, 5], [5, 4, 6]], [3, 4]) ? creep
   Call: (13) intersect([3, 4], [1, 2, 3]) ? creep
   Call: (14) lists:member(_20020, [3, 4]) ? creep
   Exit: (14) lists:member(3, [3, 4]) ? creep
   Call: (14) lists:member(3, [1, 2, 3]) ? creep
   Exit: (14) lists:member(3, [1, 2, 3]) ? creep
   Exit: (13) intersect([3, 4], [1, 2, 3]) ? creep
   Call: (13) all_intersect([[1, 2, 5], [5, 4, 6]], [3, 4]) ? creep
   Call: (14) intersect([3, 4], [1, 2, 5]) ? creep
   Call: (15) lists:member(_25740, [3, 4]) ? creep
   Exit: (15) lists:member(3, [3, 4]) ? creep
   Call: (15) lists:member(3, [1, 2, 5]) ? creep
   Fail: (15) lists:member(3, [1, 2, 5]) ? creep
   Redo: (15) lists:member(_25740, [3, 4]) ? creep
   Exit: (15) lists:member(4, [3, 4]) ? creep
   Call: (15) lists:member(4, [1, 2, 5]) ? creep
   Fail: (15) lists:member(4, [1, 2, 5]) ? creep
   Fail: (14) intersect([3, 4], [1, 2, 5]) ? creep
   Fail: (13) all_intersect([[1, 2, 5], [5, 4, 6]], [3, 4]) ? creep
   Redo: (14) lists:member(_20020, [3, 4]) ? creep
   Exit: (14) lists:member(4, [3, 4]) ? creep
   Call: (14) lists:member(4, [1, 2, 3]) ? creep
   Fail: (14) lists:member(4, [1, 2, 3]) ? creep
   Fail: (13) intersect([3, 4], [1, 2, 3]) ? creep
   Fail: (12) all_intersect([[1, 2, 3], [1, 2, 5], [5, 4, 6]], [3, 4]) ? creep
false.

all_intersect([[1,2,3],[5,4,6]],[3,4]).
   Call: (12) all_intersect([[1, 2, 3], [5, 4, 6]], [3, 4]) ? creep
   Call: (13) intersect([3, 4], [1, 2, 3]) ? creep
   Call: (14) lists:member(_43288, [3, 4]) ? creep
   Exit: (14) lists:member(3, [3, 4]) ? creep
   Call: (14) lists:member(3, [1, 2, 3]) ? creep
   Exit: (14) lists:member(3, [1, 2, 3]) ? creep
   Exit: (13) intersect([3, 4], [1, 2, 3]) ? creep
   Call: (13) all_intersect([[5, 4, 6]], [3, 4]) ? creep
   Call: (14) intersect([3, 4], [5, 4, 6]) ? creep
   Call: (15) lists:member(_49008, [3, 4]) ? creep
   Exit: (15) lists:member(3, [3, 4]) ? creep
   Call: (15) lists:member(3, [5, 4, 6]) ? creep
   Fail: (15) lists:member(3, [5, 4, 6]) ? creep
   Redo: (15) lists:member(_49008, [3, 4]) ? creep
   Exit: (15) lists:member(4, [3, 4]) ? creep
   Call: (15) lists:member(4, [5, 4, 6]) ? creep
   Exit: (15) lists:member(4, [5, 4, 6]) ? creep
   Exit: (14) intersect([3, 4], [5, 4, 6]) ? creep
   Call: (14) all_intersect([], [3, 4]) ? creep
   Exit: (14) all_intersect([], [3, 4]) ? creep
   Exit: (13) all_intersect([[5, 4, 6]], [3, 4])
 ? creep
   Exit: (12) all_intersect([[1, 2, 3], [5, 4, 6]], [3, 4])
 ? creep
true .

*/




