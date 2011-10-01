% sum_colf(+M, -L)
% calculeaza suma pe coloane a matricei M si o pune in L
sum_colf(M, []) :- fullofempties(M).
sum_colf(M, L) :- sum_col(M, S), dropmat(M, M1), sum_colf(M1, L1), 
                  L = [S|L1], !.

% sum_col(+M, -S)
% calculeaza suma de pe prima coloana a matricii
sum_col([], 0).
sum_col([[HH|_]|T], S) :- sum_col(T, S1), S is HH+S1.

% drop(+LIST, -TAIL).
% returneaza coada listei
drop([], []).
drop([_|L], L).

% dropmat(+MATIN, -MATOUT).
% din fiecare rand scoate primul element
dropmat([], []).
dropmat([H|T], L) :- drop(H,H1), dropmat(T, L1), L = [H1|L1].

% fullofempties([[]]).
% verifica daca M este alcatuit doar din liste vide
fullofempties([[]]).
fullofempties([H|M]) :- H = [], fullofempties(M).
