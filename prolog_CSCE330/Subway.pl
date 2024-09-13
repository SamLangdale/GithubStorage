
% Subway example



% 1. an example of a sentence that isnt entailed by the KB is bay is west of yonge.
% 2. even though the statement is true there is no definition that defines what being right of something means.

leftOf(bay,yonge).
leftOf(spadina,stgeorge).
leftOf(christie,bathurst).
leftOf(stgeorge,bay).
leftOf(bathurst,spadina).

westOf(X,Z) :- leftOf(X,Y), westOf(Y,Z).

westOf(X,Y) :- leftOf(X,Y).

eastOf(X,Y) :- westOf(Y,X).   