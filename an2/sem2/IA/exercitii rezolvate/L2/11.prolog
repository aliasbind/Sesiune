% print_matrix(+M).
% afiseaza matricea M pe stdout.
print_matrix([]).
print_matrix([H|L]) :- print_list(H), write('\n'), print_matrix(L).

% print_list(+L)
% afiseaza lista L pe stdout.
print_list([]).
print_list([H|L]) :- writef('%q ', [H]), print_list(L).
