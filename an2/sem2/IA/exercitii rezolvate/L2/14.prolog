% get(+M, +X, -R)
% ia din lista M elementul de pe pozitia X.
get([H|_], 1, H) :- !.
get([_|M], X, R) :- X1 is X-1, get(M, X1, R).

% diag1(+M)
% afiseaza elementele de pe diagonala principala
diag2(MAT) :- length(MAT, LEN), diag21(MAT, 1, LEN), !.

diag21(MAT, POZ1, _) :- length(MAT, LEN), POZ1 > LEN.
diag21(MAT, POZ1, POZ2) :- length(MAT, LEN), POZ1 =< LEN,
                    get(MAT, POZ1, L), get(L, POZ2, EL), 
                    writef('%q ', [EL]), POZ1X is POZ1+1, 
                    POZ2X is POZ2-1, diag21(MAT, POZ1X, POZ2X).
