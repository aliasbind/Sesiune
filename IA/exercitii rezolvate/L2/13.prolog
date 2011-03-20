% get(+M, +X, -R)
% ia din lista M elementul de pe pozitia X.
get([H|_], 1, H) :- !.
get([_|M], X, R) :- X1 is X-1, get(M, X1, R).

% diag1(+M)
% afiseaza elementele de pe diagonala principala
diag1(MAT) :- diag11(MAT, 1), !.

diag11(MAT, POZ) :- length(MAT, LEN), POZ > LEN.
diag11(MAT, POZ) :- length(MAT, LEN), POZ =< LEN,
                    get(MAT, POZ, L), get(L, POZ, EL), writef('%q ', [EL]),
                    POZ1 is POZ+1, diag11(MAT, POZ1).
