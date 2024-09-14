
% Subway example



% 1. an example of a sentence that isnt entailed by the KB is bay is west of yonge.
% 2. even though the statement is true there is no definition that defines what being right of something means.

% leftOf(yonge,bay).
leftOf(bay,yonge).
leftOf(spadina,stgeorge).
leftOf(christie,bathurst).
leftOf(stgeorge,bay).
leftOf(bathurst,spadina).

westOf(X,Z) :- leftOf(X,Y), westOf(Y,Z).

% westOf(X,Z) :- westOf(X,Y), leftOf(Y,Z).

westOf(X,Y) :- leftOf(X,Y).

eastOf(X,Y) :- westOf(Y,X).   

% 3.
% ?- westOf(spadina,stgeorge).
% true.
% 
% ?- eastOf(yonge,bay).
% true.
% 
% ?- westOf(christie,spadina).
% true .
% 
% ?- westOf(yonge,yonge).
% false.
% 
% ?- 
% |    eastOf(stgeorge,bathurst).
% true .
% 
% ?- westOf(bay,sheborne).
% false.

% 4. this sentence causes a infinite loop.
% ?- westOf(yonge,yonge).
% ERROR: Stack limit (1.0Gb) exceeded
% ERROR:   Stack sizes: local: 1.0Gb, global: 48.8Mb, trail: 0Kb
% ERROR:   Stack depth: 6,390,118, last-call: 0%, Choice points: 6,390,110
% ERROR:   Probable infinite recursion (cycle):
% ERROR:     [6,390,118] user:westOf(yonge, _12802182)
% ERROR:     [6,390,117] user:westOf(yonge, _12802202)
%    Exception: (6,385,825) westOf(yonge, _12793528) ? 

% 5. there are no values that will entail spadina becides stgeorge but i couldnt get it to work.
% ERROR: Stack limit (1.0Gb) exceeded
% ERROR:   Stack sizes: local: 1.0Gb, global: 48.8Mb, trail: 0Kb
% ERROR:   Stack depth: 6,390,937, last-call: 0%, Choice points: 6,390,929
% ERROR:   In:
% ERROR:     [6,390,937] user:leftOf(bay, _12785578)
% ERROR:     [6,390,936] user:westOf(bay, stgeorge)
% ERROR:     [6,390,935] user:westOf(yonge, stgeorge)
% ERROR:     [6,390,934] user:westOf(bay, stgeorge)
% ERROR:     [6,390,933] user:westOf(yonge, stgeorge)
% ERROR: 
% ERROR: Use the --stack_limit=size[KMG] command line option or
% ERROR: ?- set_prolog_flag(stack_limit, 2_147_483_648). to double the limit.
%    Exception: (6,386,240) westOf(bay, stgeorge) ? 
% bay is west of sherbourne brings up a infinite loop
% ?- westOf(bay,sherbourne).
% ERROR: Stack limit (1.0Gb) exceeded
% ERROR:   Stack sizes: local: 1.0Gb, global: 48.8Mb, trail: 0Kb
% ERROR:   Stack depth: 6,391,040, last-call: 0%, Choice points: 6,391,032
% ERROR:   Possible non-terminating recursion:
% ERROR:     [6,391,039] user:westOf(yonge, sherbourne)
% ERROR:     [6,391,038] user:westOf(bay, sherbourne)


