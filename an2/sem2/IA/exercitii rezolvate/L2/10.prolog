% print_list(+L)
% afiseaza lista L pe stdout in ordine inversa

print_list([]).
print_list([H|L]) :- print_list(L), writef('%q ', [H]).
