% R este X modul Y.
% pune in R valoarea operatiei |X-Y|. ("|" = modul).
:- op(100, xfy, modul).
:- op(200, xfy, este).

R este X modul Y :- (X > Y) -> (R is X-Y) ; (R is Y-X). 
