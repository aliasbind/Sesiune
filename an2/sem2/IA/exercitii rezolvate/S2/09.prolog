% R este X la_puterea Y.
% pune in R valoarea operatiei X^Y. ("|" = puterea).
:- op(100, xfy, la_puterea).
:- op(200, xfy, este).

1 este _ la_puterea 0 :- !.
R este X la_puterea Y :- Y1 is Y-1, R1 este X la_puterea Y1, R is R1 * X. 
