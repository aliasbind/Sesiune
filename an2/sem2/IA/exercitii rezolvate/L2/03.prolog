% prim(+X) (determina daca X e prim).
prim(X) :- X >= 2, prim1(2, X).

prim1(X, X).
prim1(N, X) :- \+ X mod N =:= 0, N1 is N+1, prim1(N1, X), !.
