:- op(100, xfy, pana_la).
:- op(200, xfy, este).

% determina distanta de la X la Y
R este X pana_la Y :- dist(X, Y, R).

% dist(:PT1, :PT2, -DIST)
% calculeaza distanta intre pt1 si pt2
pt(X, Y, Z) :- number(X), number(Y), number(Z).
dist(pt(X1, Y1, Z1), pt(X2, Y2, Z2), DIST) :-
  DIST is sqrt( (X1-X2)^2 + (Y1-Y2)^2 + (Z1-Z2)^2 ).
