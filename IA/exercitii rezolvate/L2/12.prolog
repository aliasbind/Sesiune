% print_matrix(+M).
% afiseaza matricea M pe stdout de jos in sus.
print_matrix([]).
print_matrix([H|L]) :- print_list(H), write('\n'), print_matrix(L).

% print_list(+L)
% afiseaza lista L pe stdout in ordine inversa.
print_list([]).
print_list([H|L]) :- print_list(L), writef('%q ', [H]). 
