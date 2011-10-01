% nat(+X). (verifica daca un numar e natural).
nat(0).
nat(X) :- number(X), X >= 0, X1 is X-1, nat(X1).

% gen_int(+A, +B, -X)
% genereaza toate numerele naturale din intervalul [A, B]
gen_int(A, B, A) :- B >= A, nat(A), nat(B).
gen_int(A, B, X) :- A < B, A1 is A+1, gen(A1, B, X).
