% sum_lin(+M, -L)
% calculeaza suma pe linii a matricei M si o pune in L
sum_lin([], []).
sum_lin([H|T], [X|L]) :- sumlist(H, X), sum_lin(T, L).
