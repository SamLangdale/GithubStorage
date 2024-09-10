
% Subway example

leftOf(bay,yonge).
leftOf(spadina,stgeorge).
leftOf(christie,bathhurst).
leftOf(stgeorge,bay).
leftOf(bathhurst,spadina).

westOf(X,Y) :- leftOf(X,Y).
leftOf(X,Z) :- leftOf(X,Y),leftOf(Y,Z).
eastOf(X,Y) :- westOf(Y,X).