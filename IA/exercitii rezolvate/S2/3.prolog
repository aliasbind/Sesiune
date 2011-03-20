% par L.
% verifica daca lista L contine doar numere pare
:- op(100, fx, par).

par [X] :- X mod 2 =:= 0, !.
par [H|T] :- H mod 2 =:= 0, par T.
