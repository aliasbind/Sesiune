:- op(100, fx, lungimea_lui).
:- op(200, xfy, este).

% determina lungimea lui L si o pune in R.
R este lungimea_lui L :- length(L, R).
