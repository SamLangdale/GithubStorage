% This is the family relations exercise at the end of Ch.4 [L].
child(alberto,guido). child(alberto,antonietta).
child(giulia,enrico). child(giulia,annamaria).
child(dante,marco).   child(clara,marco).
child(dante,laura).   child(clara,laura).
child(marco,alberto).   child(marco,giulia).
child(laura,lawrence).  child(laura,julie).
child(emily,lawrence).  child(emily, julie).
child(claire,lawrence). child(claire, julie).
child(sam,emily). child(ben,emily).
child(sam,dave). child(ben,dave).
child(eve,claire). child(annabelle,claire).
child(eve,ed). child(annabelle,ed).
child(giulio,guido). child(donata,giulio).
child(sara,donata). child(marco2,donata).
child(giulio,antonietta). child(gioia,clara).

male(guido). male(enrico).
male(marco). male(dante). male(alberto). male(lawrence).
male(sam). male(ben). male(dave). male(ed).
male(giulio). male(marco2).
female(antonietta). female(annamaria).
female(clara).  female(laura).  female(giulia). female(julie).
female(emily). female(claire). female(eve). female(annabelle).
female(donata). female(sara). female(gioia).

%Clauses from Figure 3.1, as required by Exercise of Ch.4[L] 
parent(Y,X) :- child(X,Y).
father(Y,X) :- child(X,Y), male(Y).
opp_sex(X,Y) :- male(X), female(Y).
opp_sex(Y,X) :- male(X), female(Y).
grand_father(X,Z) :- father(X,Y), parent(Y,Z).

% New clauses for Exercise of Ch.4[L] follow

% 1.
mother(Y,X) :- parent(Y,X), female(Y).
grand_parent(Y,X) :- parent(Y,Z), child(X,Z).
great_grand_mother(Y,X) :- grand_parent(Y,Z), parent(Z,X), mother(Y,X).

% 2. 
sibling(Y,X) :- child(Y,Z), child(X,Z).
brother(Y,X) :- sibling(Y,X), male(Y).
sister(Y,X) :- sibling(Y,X), female(Y).

% 3. 
half_sibling(Y,X) :- sibling(X,Y), parent(Z,X), \* parent(Z,Y).
full_sibling(Y,X) :- sibling(Y,X), parent(Z,X), child(Y,Z), parent(P,X), child(Y,P), P\=Z.

% 4.
first_cousin(Y,X) :- grand_parent(Z,Y), parent(Z,P), child(X,P). % you share a grand parent
second_cousin(Y,X) :- grand_parent(Z,P), parent(P,Y), grand_parent(Z,K), parent(K,X).

% 5. 
half_first_cousin(Y,X) :- parent(Z,Y), parent(P,X), half_sibling(Z,P).
double_first_cousin(Y,X) :- parent(Z,Y), sibling(Z,P), child(X,P), parent(R,X), sibling(R,M), child(Y,M).

% 6. 
first_cousin_once_removed(Y,X) :- parent(Z,Y), first_cousin(Z,X).
first_cousin_twice_removed(Y,X) :- grand_parent(Z,Y), first_cousin(Z,X).

% 7. 
decendant(Y,X) :- child(Y,X).
decendant(Y,X) :- child(Y,Z), decendant(Z,X).
ancestor(Y,X) :- decendant(Y,X). % check

% 8.
cousin(Y,X) :- first_cousin(Y,X)
cousin(Y,X) :- parent(A,X), parent(B,Y), cousin(A,B).

% 9.
closest_common_ancestor(X,Y,Z) :- ancestor(X,Y), ancestor(X,Z), decendant(A,X), \* ancestor(A,Y), \* ancestor(A,Z).

% 10. 
write_child(X,Y) :- write(X),write('is a child of'),write(Y),nl.

write_descendant_chain(X,Y) :- child(X,Y), write_child(X,Y)
write_descendant_chain(X,Y) :-child(X,Z), write_descendant_chain(Z,Y).


