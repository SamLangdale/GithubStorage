
% Subway example

leftOf(bay,yonge).
leftOf(spadina,stgeorge).
leftOf(christie,bathhurst).
leftOf(stgeorge,bay).
leftOf(bathhurst,spadina).

leftOf(X,Y) :- westOf(x,Y).
leftOf(X,Z) :- leftOf(X,Y),leftOf(Y,Z).
eastOf(X,Y) :- westOf(Y,X).