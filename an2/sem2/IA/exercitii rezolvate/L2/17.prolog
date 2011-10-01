% print_down_up(+M)
% afiseaza matricea M de jos in sus
print_down_up([]).
print_down_up([H|T]) :- print_down_up(T), print_list(H), nl.

% print_list(+L)
% afiseaza lista L pe stdout
print_list([]).
print_list([H|L]) :- writef('%q ', [H]), print_list(L).
