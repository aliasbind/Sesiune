% nat(+X). (verifica daca un numar e natural).
nat(0).
nat(X) :- number(X), X >= 0, X1 is X-1, nat(X1).

% int(+X). (verifica daca un numar e intreg).
int(X) :- nat(X); (X1 is -X, nat(X1)).
