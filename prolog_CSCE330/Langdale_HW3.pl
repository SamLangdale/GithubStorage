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
/*
[trace]  ?- mother(emily,sam).
   Call: (12) mother(emily, sam) ? creep
   Call: (13) parent(emily, sam) ? creep
   Call: (14) child(sam, emily) ? creep
   Exit: (14) child(sam, emily) ? creep
   Exit: (13) parent(emily, sam) ? creep
   Call: (13) female(emily) ? creep
   Exit: (13) female(emily) ? creep
   Exit: (12) mother(emily, sam) ? creep
true .

*/
grand_parent(Y,X) :- parent(Y,Z), child(X,Z).
/*
[trace]  ?- grand_parent(guido,marco).
   Call: (12) grand_parent(guido, marco) ? creep
   Call: (13) parent(guido, _35972) ? creep
   Call: (14) child(_35972, guido) ? creep
   Exit: (14) child(alberto, guido) ? creep
   Exit: (13) parent(guido, alberto) ? creep
   Call: (13) child(marco, alberto) ? creep
   Exit: (13) child(marco, alberto) ? creep
   Exit: (12) grand_parent(guido, marco) ? creep
true .


*/
great_grand_mother(Y,X) :- female(Y), grand_parent(Y,Z), parent(Z,X).
/*
[trace]  ?- great_grand_mother(julie,gioia).
   Call: (12) great_grand_mother(julie, gioia) ? creep
   Call: (13) female(julie) ? creep
   Exit: (13) female(julie) ? creep
   Call: (13) grand_parent(julie, _9908) ? creep
   Call: (14) parent(julie, _10504) ? creep
   Call: (15) child(_10504, julie) ? creep
   Exit: (15) child(laura, julie) ? creep
   Exit: (14) parent(julie, laura) ? creep
   Call: (14) child(_9908, laura) ? creep
   Exit: (14) child(dante, laura) ? creep
   Exit: (13) grand_parent(julie, dante) ? creep
   Call: (13) parent(dante, gioia) ? creep
   Call: (14) child(gioia, dante) ? creep
   Fail: (14) child(gioia, dante) ? creep
   Fail: (13) parent(dante, gioia) ? creep
   Redo: (14) child(_9908, laura) ? creep
   Exit: (14) child(clara, laura) ? creep
   Exit: (13) grand_parent(julie, clara) ? creep
   Call: (13) parent(clara, gioia) ? creep
   Call: (14) child(gioia, clara) ? creep
   Exit: (14) child(gioia, clara) ? creep
   Exit: (13) parent(clara, gioia) ? creep
   Exit: (12) great_grand_mother(julie, gioia) ? creep
true .
*/

% 2. 
sibling(Y,X) :- child(Y,Z), child(X,Z), Y \= X.
/*
Call: (12) sibling(dante, clara) ? creep
   Call: (13) child(dante, _25470) ? creep
   Exit: (13) child(dante, marco) ? creep
   Call: (13) child(clara, marco) ? creep
   Exit: (13) child(clara, marco) ? creep
   Exit: (12) sibling(dante, clara) ? creep
true .
*/

brother(Y,X) :- sibling(Y,X), male(Y), Y \= X.
/*
 brother(dante,clara).
   Call: (12) brother(dante, clara) ? creep
   Call: (13) sibling(dante, clara) ? creep
   Call: (14) child(dante, _31970) ? creep
   Exit: (14) child(dante, marco) ? creep
   Call: (14) child(clara, marco) ? creep
   Exit: (14) child(clara, marco) ? creep
   Exit: (13) sibling(dante, clara) ? creep
   Call: (13) male(dante) ? creep
   Exit: (13) male(dante) ? creep
   Exit: (12) brother(dante, clara) ? creep
true .
*/

sister(Y,X) :- sibling(Y,X), female(Y).
/*
 ?- sister(clara,dante).
   Call: (12) sister(clara, dante) ? creep
   Call: (13) sibling(clara, dante) ? creep
   Call: (14) child(clara, _40244) ? creep
   Exit: (14) child(clara, marco) ? creep
   Call: (14) child(dante, marco) ? creep
   Exit: (14) child(dante, marco) ? creep
   Exit: (13) sibling(clara, dante) ? creep
   Call: (13) female(clara) ? creep
   Exit: (13) female(clara) ? creep
   Exit: (12) sister(clara, dante) ? creep
true .
*/

% 3. 
half_sibling(Y,X) :- sibling(X,Y), parent(Z,X), \+ parent(Z,Y).
full_sibling(Y,X) :- sibling(Y,X), parent(Z,X), child(Y,Z), parent(P,X), child(Y,P), P \= Z.
/*
 full_sibling(sam,ben).
   Call: (12) full_sibling(sam, ben) ? Unknown option (h for help)
   Call: (12) full_sibling(sam, ben) ? creep
   Call: (13) sibling(sam, ben) ? creep
   Call: (14) child(sam, _49112) ? creep
   Exit: (14) child(sam, emily) ? creep
   Call: (14) child(ben, emily) ? creep
   Exit: (14) child(ben, emily) ? creep
   Exit: (13) sibling(sam, ben) ? creep
   Call: (13) parent(_52084, ben) ? creep
   Call: (14) child(ben, _52084) ? creep
   Exit: (14) child(ben, emily) ? creep
   Exit: (13) parent(emily, ben) ? creep
   Call: (13) child(sam, emily) ? creep
   Exit: (13) child(sam, emily) ? creep
   Call: (13) parent(_55650, ben) ? creep
   Call: (14) child(ben, _55650) ? creep
   Exit: (14) child(ben, emily) ? creep
   Exit: (13) parent(emily, ben) ? creep
   Call: (13) child(sam, emily) ? creep
   Exit: (13) child(sam, emily) ? creep
   Call: (13) emily\=emily ? creep
   Fail: (13) emily\=emily ? creep
   Redo: (13) child(sam, emily) ? creep
   Fail: (13) child(sam, emily) ? creep
   Redo: (14) child(ben, _55650) ? creep
   Exit: (14) child(ben, dave) ? creep
   Exit: (13) parent(dave, ben) ? creep
   Call: (13) child(sam, dave) ? creep
   Exit: (13) child(sam, dave) ? creep
   Call: (13) dave\=emily ? creep
   Exit: (13) dave\=emily ? creep
   Exit: (12) full_sibling(sam, ben) ? creep
true .


*/

% 4.
first_cousin(Y,X) :- grand_parent(Z,Y), grand_parent(Z,X). % you share a grand parent
/*
[trace]  ?- first_cousin(clara,sam).
   Call: (12) first_cousin(clara, sam) ? creep
   Call: (13) grand_parent(_29388, clara) ? creep
   Call: (14) parent(_29388, _29984) ? creep
   Call: (15) child(_29984, _29388) ? creep
   Exit: (15) child(alberto, guido) ? creep
   Exit: (14) parent(guido, alberto) ? creep
   Call: (14) child(clara, alberto) ? creep
   Fail: (14) child(clara, alberto) ? creep
   Redo: (15) child(_29984, _29388) ? creep
   Exit: (15) child(alberto, antonietta) ? creep
   Exit: (14) parent(antonietta, alberto) ? creep
   Call: (14) child(clara, alberto) ? creep
   Fail: (14) child(clara, alberto) ? creep
   Redo: (15) child(_29984, _29388) ? creep
   Exit: (15) child(giulia, enrico) ? creep
   Exit: (14) parent(enrico, giulia) ? creep
   Call: (14) child(clara, giulia) ? creep
   Fail: (14) child(clara, giulia) ? creep
   Redo: (15) child(_29984, _29388) ? creep
   Exit: (15) child(giulia, annamaria) ? creep
   Exit: (14) parent(annamaria, giulia) ? creep
   Call: (14) child(clara, giulia) ? creep
   Fail: (14) child(clara, giulia) ? creep
   Redo: (15) child(_29984, _29388) ? creep
   Exit: (15) child(dante, marco) ? creep
   Exit: (14) parent(marco, dante) ? creep
   Call: (14) child(clara, dante) ? creep
   Fail: (14) child(clara, dante) ? creep
   Redo: (15) child(_29984, _29388) ? creep
   Exit: (15) child(clara, marco) ? creep
   Exit: (14) parent(marco, clara) ? creep
   Call: (14) child(clara, clara) ? creep
   Fail: (14) child(clara, clara) ? creep
   Redo: (15) child(_29984, _29388) ? creep
   Exit: (15) child(dante, laura) ? creep
   Exit: (14) parent(laura, dante) ? creep
   Call: (14) child(clara, dante) ? creep
   Fail: (14) child(clara, dante) ? creep
   Redo: (15) child(_29984, _29388) ? creep
   Exit: (15) child(clara, laura) ? creep
   Exit: (14) parent(laura, clara) ? creep
   Call: (14) child(clara, clara) ? creep
   Fail: (14) child(clara, clara) ? creep
   Redo: (15) child(_29984, _29388) ? creep
   Exit: (15) child(marco, alberto) ? creep
   Exit: (14) parent(alberto, marco) ? creep
   Call: (14) child(clara, marco) ? creep
   Exit: (14) child(clara, marco) ? creep
   Exit: (13) grand_parent(alberto, clara) ? creep
   Call: (13) grand_parent(alberto, sam) ? creep
   Call: (14) parent(alberto, _58498) ? creep
   Call: (15) child(_58498, alberto) ? creep
   Exit: (15) child(marco, alberto) ? creep
   Exit: (14) parent(alberto, marco) ? creep
   Call: (14) child(sam, marco) ? creep
   Fail: (14) child(sam, marco) ? creep
   Fail: (13) grand_parent(alberto, sam) ? creep
   Redo: (14) child(clara, marco) ? creep
   Fail: (14) child(clara, marco) ? creep
   Redo: (15) child(_29984, _29388) ? creep
   Exit: (15) child(marco, giulia) ? creep
   Exit: (14) parent(giulia, marco) ? creep
   Call: (14) child(clara, marco) ? creep
   Exit: (14) child(clara, marco) ? creep
   Exit: (13) grand_parent(giulia, clara) ? creep
   Call: (13) grand_parent(giulia, sam) ? creep
   Call: (14) parent(giulia, _3672) ? creep
   Call: (15) child(_3672, giulia) ? creep
   Exit: (15) child(marco, giulia) ? creep
   Exit: (14) parent(giulia, marco) ? creep
   Call: (14) child(sam, marco) ? creep
   Fail: (14) child(sam, marco) ? creep
   Fail: (13) grand_parent(giulia, sam) ? creep
   Redo: (14) child(clara, marco) ? creep
   Fail: (14) child(clara, marco) ? creep
   Redo: (15) child(_104, _102) ? creep
   Exit: (15) child(laura, lawrence) ? creep
   Exit: (14) parent(lawrence, laura) ? creep
   Call: (14) child(clara, laura) ? creep
   Exit: (14) child(clara, laura) ? creep
   Exit: (13) grand_parent(lawrence, clara) ? creep
   Call: (13) grand_parent(lawrence, sam) ? creep
   Call: (14) parent(lawrence, _13178) ? creep
   Call: (15) child(_13178, lawrence) ? creep
   Exit: (15) child(laura, lawrence) ? creep
   Exit: (14) parent(lawrence, laura) ? creep
   Call: (14) child(sam, laura) ? creep
   Fail: (14) child(sam, laura) ? creep
   Redo: (15) child(_13178, lawrence) ? creep
   Exit: (15) child(emily, lawrence) ? creep
   Exit: (14) parent(lawrence, emily) ? creep
   Call: (14) child(sam, emily) ? creep
   Exit: (14) child(sam, emily) ? creep
   Exit: (13) grand_parent(lawrence, sam) ? creep
   Exit: (12) first_cousin(clara, sam) ? creep
true .

*/
second_cousin(Y,X) :- first_cousin(Y,Z), first_cousin(X,Z). % great grandparents are in common

% 5. 
half_first_cousin(Y,X) :- parent(Z,Y), parent(P,X), half_sibling(Z,P).
double_first_cousin(Y,X) :- parent(Z,Y), sibling(Z,P), child(X,P), parent(R,X), sibling(R,M), child(Y,M).

% 6. 
first_cousin_once_removed(Y,X) :- parent(Z,Y), first_cousin(Z,X).
first_cousin_twice_removed(Y,X) :- grand_parent(Z,Y), first_cousin(Z,X).

% 7. 
decendant(Y,X) :- child(Y,X).
decendant(Y,X) :- child(Y,Z), decendant(Z,X).    
/*
Call: (12) decendant(gioia, lawrence) ? creep
   Call: (13) child(gioia, lawrence) ? creep
   Fail: (13) child(gioia, lawrence) ? creep
   Redo: (12) decendant(gioia, lawrence) ? creep
   Call: (13) child(gioia, _73 910) ? creep
   Exit: (13) child(gioia, clara) ? creep
   Call: (13) decendant(clara, lawrence) ? creep
   Call: (14) child(clara, lawrence) ? creep
   Fail: (14) child(clara, lawrence) ? creep
   Redo: (13) decendant(clara, lawrence) ? creep
   Call: (14) child(clara, _77476) ? creep
   Exit: (14) child(clara, marco) ? creep
   Call: (14) decendant(marco, lawrence) ? creep
   Call: (15) child(marco, lawrence) ? creep
   Fail: (15) child(marco, lawrence) ? creep
   Redo: (14) decendant(marco, lawrence) ? creep
   Call: (15) child(marco, _81042) ? creep
   Exit: (15) child(marco, alberto) ? creep
   Call: (15) decendant(alberto, lawrence) ? creep
   Redo: (16) child(alberto, _84608) ? creep
   Exit: (16) child(alberto, antonietta) ? creep
   Call: (16) decendant(antonietta, lawrence) ? creep
   Call: (17) child(antonietta, lawrence) ? creep
   Fail: (17) child(antonietta, lawrence) ? creep
   Redo: (16) decendant(antonietta, lawrence) ? creep
   Call: (17) child(antonietta, _93522) ? creep
   Fail: (17) child(antonietta, _93522) ? creep
   Fail: (16) decendant(antonietta, lawrence) ? creep
   Fail: (15) decendant(alberto, lawrence) ? creep
   Redo: (15) child(marco, _81042) ? creep
   Exit: (15) child(marco, giulia) ? creep
   Call: (15) decendant(giulia, lawrence) ? creep
   Call: (16) child(giulia, lawrence) ? creep
   Fail: (16) child(giulia, lawrence) ? creep
   Redo: (15) decendant(giulia, lawrence) ? creep
   Call: (16) child(giulia, _99464) ? creep
   Exit: (16) child(giulia, enrico) ? creep
   Call: (16) decendant(enrico, lawrence) ? creep
   Call: (17) child(enrico, lawrence) ? creep
   Fail: (17) child(enrico, lawrence) ? creep
   Redo: (16) decendant(enrico, lawrence) ? creep
   Call: (17) child(enrico, _103030) ? creep
   Fail: (17) child(enrico, _103030) ? creep
   Fail: (16) decendant(enrico, lawrence) ? creep
   Redo: (16) child(giulia, _99464) ? creep
   Exit: (16) child(giulia, annamaria) ? creep
   Call: (16) decendant(annamaria, lawrence) ? creep
   Call: (17) child(annamaria, lawrence) ? creep
   Fail: (17) child(annamaria, lawrence) ? creep
   Redo: (16) decendant(annamaria, lawrence) ? creep
   Call: (17) child(annamaria, _108378) ? creep
   Fail: (17) child(annamaria, _108378) ? creep
   Fail: (16) decendant(annamaria, lawrence) ? creep
   Fail: (15) decendant(giulia, lawrence) ? creep
   Fail: (14) decendant(marco, lawrence) ? creep
   Redo: (14) child(clara, _77476) ? creep
   Exit: (14) child(clara, laura) ? creep
   Call: (14) decendant(laura, lawrence) ? creep
   Call: (15) child(laura, lawrence) ? creep
   Exit: (15) child(laura, lawrence) ? creep
   Exit: (14) decendant(laura, lawrence) ? creep
   Exit: (13) decendant(clara, lawrence) ? creep
   Exit: (12) decendant(gioia, lawrence) ? creep
true .
*/
ancestor(Y,X) :- decendant(X,Y). % check
/*

|    
|    
% c:/users/samla/desktop/githubstorage/prolog_csce330/langdale_hw3 compiled 0.00 sec, 0 clauses
|    decendant(gioia,lawrence).
   Call: (12) decendant(gioia, lawrence) ? creep
   Call: (13) child(gioia, lawrence) ? creep
   Fail: (13) child(gioia, lawrence) ? creep
   Redo: (12) decendant(gioia, lawrence) ? creep
   Call: (13) child(gioia, _127818) ? creep
   Exit: (13) child(gioia, clara) ? creep
   Call: (13) decendant(clara, lawrence) ? creep
   Call: (14) child(clara, lawrence) ? creep
   Fail: (14) child(clara, lawrence) ? creep
   Redo: (13) decendant(clara, lawrence) ? creep
   Call: (14) child(clara, _131384) ? creep
   Exit: (14) child(clara, marco) ? creep
   Call: (14) decendant(marco, lawrence) ? creep
   Call: (15) child(marco, lawrence) ? creep
   Fail: (15) child(marco, lawrence) ? creep
   Redo: (14) decendant(marco, lawrence) ? creep
   Call: (15) child(marco, _134950) ? creep
   Exit: (15) child(marco, alberto) ? creep
   Call: (15) decendant(alberto, lawrence) ? creep
   Call: (16) child(alberto, lawrence) ? creep
   Fail: (16) child(alberto, lawrence) ? creep
   Redo: (15) decendant(alberto, lawrence) ? creep
   Call: (16) child(alberto, _138516) ? creep
   Exit: (16) child(alberto, guido) ? creep
   Call: (16) decendant(guido, lawrence) ? creep
   Call: (17) child(guido, lawrence) ? creep
   Fail: (17) child(guido, lawrence) ? creep
   Redo: (16) decendant(guido, lawrence) ? creep
   Call: (17) child(guido, _142082) ? creep
   Fail: (17) child(guido, _142082) ? creep
   Fail: (16) decendant(guido, lawrence) ? creep
   Redo: (16) child(alberto, _138516) ? creep
   Exit: (16) child(alberto, antonietta) ? creep
   Call: (16) decendant(antonietta, lawrence) ? creep
   Call: (17) child(antonietta, lawrence) ? creep
   Fail: (17) child(antonietta, lawrence) ? creep
   Redo: (16) decendant(antonietta, lawrence) ? creep
   Call: (17) child(antonietta, _147430) ? creep
   Fail: (17) child(antonietta, _147430) ? creep
   Fail: (16) decendant(antonietta, lawrence) ? creep
   Fail: (15) decendant(alberto, lawrence) ? creep
   Redo: (15) child(marco, _134950) ? creep
   Exit: (15) child(marco, giulia) ? creep
   Call: (15) decendant(giulia, lawrence) ? creep
   Call: (16) child(giulia, lawrence) ? creep
   Fail: (16) child(giulia, lawrence) ? creep
   Redo: (15) decendant(giulia, lawrence) ? creep
   Call: (16) child(giulia, _153372) ? creep
   Exit: (16) child(giulia, enrico) ? creep
   Call: (16) decendant(enrico, lawrence) ? creep
   Call: (17) child(enrico, lawrence) ? creep
   Fail: (17) child(enrico, lawrence) ? creep
   Redo: (16) decendant(enrico, lawrence) ? creep
   Call: (17) child(enrico, _156938) ? creep
   Fail: (17) child(enrico, _156938) ? creep
   Fail: (16) decendant(enrico, lawrence) ? creep
   Redo: (16) child(giulia, _153372) ? creep
   Exit: (16) child(giulia, annamaria) ? creep
   Call: (16) decendant(annamaria, lawrence) ? creep
   Call: (17) child(annamaria, lawrence) ? creep
   Fail: (17) child(annamaria, lawrence) ? creep
   Redo: (16) decendant(annamaria, lawrence) ? creep
   Call: (17) child(annamaria, _162286) ? creep
   Fail: (17) child(annamaria, _162286) ? creep
   Fail: (16) decendant(annamaria, lawrence) ? creep
   Fail: (15) decendant(giulia, lawrence) ? creep
   Fail: (14) decendant(marco, lawrence) ? creep
   Redo: (14) child(clara, _131384) ? creep
   Exit: (14) child(clara, laura) ? creep
   Call: (14) decendant(laura, lawrence) ? creep
   Call: (15) child(laura, lawrence) ? creep
   Exit: (15) child(laura, lawrence) ? creep
   Exit: (14) decendant(laura, lawrence) ? creep
   Exit: (13) decendant(clara, lawrence) ? creep
   Exit: (12) decendant(gioia, lawrence) ? creep
true .

*/

% 8.
cousin(Y,X) :- first_cousin(Y,X).
cousin(Y,X) :- parent(A,X), parent(B,Y), cousin(A,B).

% 9.
closest_common_ancestor(X,Y,Z) :- ancestor(X,Y), ancestor(X,Z), decendant(A,X), \+ ancestor(A,Y), \+ ancestor(A,Z).
    /*
    Call: (16) child(laura, _54392) ? creep
   Exit: (16) child(laura, lawrence) ? creep
   Call: (16) decendant(lawrence, emily) ? creep
   Call: (17) child(lawrence, emily) ? creep
   Fail: (17) child(lawrence, emily) ? creep
   Redo: (16) decendant(lawrence, emily) ? creep
   Call: (17) child(lawrence, _59254) ? creep
   Fail: (17) child(lawrence, _59254) ? creep
   Fail: (16) decendant(lawrence, emily) ? creep
   Redo: (16) child(laura, _54392) ? creep
   Exit: (16) child(laura, julie) ? creep
   Call: (16) decendant(julie, emily) ? creep
   Call: (17) child(julie, emily) ? creep
   Fail: (17) child(julie, emily) ? creep
   Redo: (16) decendant(julie, emily) ? creep
   Call: (17) child(julie, _66546) ? creep
   Fail: (17) child(julie, _66546) ? creep
   Fail: (16) decendant(julie, emily) ? creep
   Fail: (15) decendant(laura, emily) ? creep
   Fail: (14) decendant(clara, emily) ? creep
   Fail: (13) ancestor(emily, clara) ? creep
   Redo: (12) closest_common_ancestor(lawrence, clara, ben) ? creep
   Call: (13) ancestor(emily, ben) ? creep
   Call: (14) decendant(ben, emily) ? creep
   Call: (15) child(ben, emily) ? creep
   Exit: (15) child(ben, emily) ? creep
   Exit: (14) decendant(ben, emily) ? creep
   Exit: (13) ancestor(emily, ben) ? creep
   Redo: (14) child(_108, lawrence) ? creep
   Exit: (14) child(claire, lawrence) ? creep
   Exit: (13) decendant(claire, lawrence) ? creep
   Call: (13) ancestor(claire, clara) ? creep
   Call: (14) decendant(clara, claire) ? creep
   Call: (15) child(clara, claire) ? creep
   Fail: (15) child(clara, claire) ? creep
   Redo: (14) decendant(clara, claire) ? creep
   Call: (15) child(clara, _83562) ? creep
   Exit: (15) child(clara, marco) ? creep
   Call: (15) decendant(marco, claire) ? creep
   Call: (16) child(marco, claire) ? creep
   Fail: (16) child(marco, claire) ? creep
   Redo: (15) decendant(marco, claire) ? creep
   Call: (16) child(marco, _88424) ? creep
   Exit: (16) child(marco, alberto) ? creep
   Call: (16) decendant(alberto, claire) ? creep
   Call: (17) child(alberto, claire) ? creep
   Fail: (17) child(alberto, claire) ? creep
   Redo: (16) decendant(alberto, claire) ? creep
   Call: (17) child(alberto, _93286) ? creep
   Exit: (17) child(alberto, guido) ? creep
   Call: (17) decendant(guido, claire) ? creep
   Call: (18) child(guido, claire) ? creep
   Fail: (18) child(guido, claire) ? creep
   Redo: (17) decendant(guido, claire) ? creep
   Call: (18) child(guido, _98148) ? creep
   Fail: (18) child(guido, _98148) ? cree
    Fail: (17) decendant(guido, claire) ? creep
   Redo: (17) child(alberto, _93286) ? creep
   Exit: (17) child(alberto, antonietta) ? creep
   Call: (17) decendant(antonietta, claire) ? creep
   Call: (18) child(antonietta, claire) ? creep
   Fail: (18) child(antonietta, claire) ? creep
   Redo: (17) decendant(antonietta, claire) ? creep
   Call: (18) child(antonietta, _105440) ? creep
   Fail: (18) child(antonietta, _105440) ? creep
   Fail: (17) decendant(antonietta, claire) ? creep
   Fail: (16) decendant(alberto, claire) ? creep
   Redo: (16) child(marco, _88424) ? creep
   Exit: (16) child(marco, giulia) ? creep
   Call: (16) decendant(giulia, claire) ? creep
   Call: (17) child(giulia, claire) ? creep
   Fail: (17) child(giulia, claire) ? creep
   Redo: (16) decendant(giulia, claire) ? creep
   Call: (17) child(giulia, _113542) ? creep
   Exit: (17) child(giulia, enrico) ? creep
   Call: (17) decendant(enrico, claire) ? creep
   Call: (18) child(enrico, claire) ? creep
   Fail: (18) child(enrico, claire) ? creep
   Redo: (17) decendant(enrico, claire) ? creep
   Call: (18) child(enrico, _118404) ? creep
   Fail: (18) child(enrico, _118404) ? creep
   Fail: (17) decendant(enrico, claire) ? creep
   Redo: (17) child(giulia, _113542) ? creep
   Exit: (17) child(giulia, annamaria) ? creep
   Call: (17) decendant(annamaria, claire) ? creep
   Call: (18) child(annamaria, claire) ? creep
   Fail: (18) child(annamaria, claire) ? creep
   Redo: (17) decendant(annamaria, claire) ? creep
   Call: (18) child(annamaria, _125696) ? creep
   Fail: (18) child(annamaria, _125696) ? creep
   Fail: (17) decendant(annamaria, claire) ? creep
   Fail: (16) decendant(giulia, claire) ? creep
   Fail: (15) decendant(marco, claire) ? creep
   Redo: (15) child(clara, _110) ? creep
   Exit: (15) child(clara, laura) ? creep
   Call: (15) decendant(laura, claire) ? creep
   Call: (16) child(laura, claire) ? creep
   Fail: (16) child(laura, claire) ? creep
   Redo: (15) decendant(laura, claire) ? creep
   Call: (16) child(laura, _4946) ? creep
   Exit: (16) child(laura, lawrence) ? creep
   Call: (16) decendant(lawrence, claire) ? creep
   Call: (17) child(lawrence, claire) ? creep
   Fail: (17) child(lawrence, claire) ? creep
   Redo: (16) decendant(lawrence, claire) ? creep
   Call: (17) child(lawrence, _9808) ? creep
   Fail: (17) child(lawrence, _9808) ? creep
   Fail: (16) decendant(lawrence, claire) ? creep
   Redo: (16) child(laura, _4946) ? creep
   Exit: (16) child(laura, julie) ? creep
   Call: (16) decendant(julie, claire) ? creep
   Call: (17) child(julie, claire) ? cree
    Fail: (17) child(julie, claire) ? creep
   Redo: (16) decendant(julie, claire) ? creep
   Call: (17) child(julie, _17100) ? creep
   Fail: (17) child(julie, _17100) ? creep
   Fail: (16) decendant(julie, claire) ? creep
   Fail: (15) decendant(laura, claire) ? creep
   Fail: (14) decendant(clara, claire) ? creep
   Fail: (13) ancestor(claire, clara) ? creep
   Redo: (12) closest_common_ancestor(lawrence, clara, ben) ? creep
   Call: (13) ancestor(claire, ben) ? creep
   Call: (14) decendant(ben, claire) ? creep
   Call: (15) child(ben, claire) ? creep
   Fail: (15) child(ben, claire) ? creep
   Redo: (14) decendant(ben, claire) ? creep
   Call: (15) child(ben, _26826) ? creep
   Exit: (15) child(ben, emily) ? creep
   Call: (15) decendant(emily, claire) ? creep
   Call: (16) child(emily, claire) ? creep
   Fail: (16) child(emily, claire) ? creep
   Redo: (15) decendant(emily, claire) ? creep
   Call: (16) child(emily, _31688) ? creep
   Exit: (16) child(emily, lawrence) ? creep
   Call: (16) decendant(lawrence, claire) ? creep
   Call: (17) child(lawrence, claire) ? creep
   Fail: (17) child(lawrence, claire) ? creep
   Redo: (16) child(emily, _31688) ? creep
   Exit: (16) child(emily, julie) ? creep
   Call: (16) decendant(julie, claire) ? creep
   Call: (17) child(julie, claire) ? creep
   Fail: (17) child(julie, claire) ? creep
   Redo: (16) decendant(julie, claire) ? creep
   Call: (17) child(julie, _43842) ? creep
   Fail: (17) child(julie, _43842) ? creep
   Fail: (16) decendant(julie, claire) ? creep
   Fail: (15) decendant(emily, claire) ? creep
   Redo: (15) child(ben, _26826) ? creep
   Exit: (15) child(ben, dave) ? creep
   Call: (15) decendant(dave, claire) ? creep
   Call: (16) child(dave, claire) ? creep
   Fail: (16) child(dave, claire) ? creep
   Redo: (15) decendant(dave, claire) ? creep
   Call: (16) child(dave, _51944) ? creep
   Fail: (16) child(dave, _51944) ? creep
   Fail: (15) decendant(dave, claire) ? creep
   Fail: (14) decendant(ben, claire) ? creep
   Fail: (13) ancestor(claire, ben) ? creep
   Redo: (12) closest_common_ancestor(lawrence, clara, ben) ? creep
   Exit: (12) closest_common_ancestor(lawrence, clara, ben) ? creep
true 
*/
% 10. 
write_child(X,Y) :- write(X), write(' is a child of '), write(Y), nl.

write_descendant_chain(X,Y) :- child(X,Y).
write_descendant_chain(X,Y) :-child(X,Z), write_child(X,Z), write_descendant_chain(Z,Y).
/*
write_decendant_chain(gioia,lawrence).
Correct to: "write_descendant_chain(gioia,lawrence)"? yes
gioia is a child of clara
clara is a child of marco
marco is a child of alberto
alberto is a child of guido
alberto is a child of antonietta
marco is a child of giulia
giulia is a child of enrico
giulia is a child of annamaria
clara is a child of laura
true 
*/



