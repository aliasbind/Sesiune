% rem_el(+Lista, +E, -X) (sterge elementul E din lista)

rem_el([], _, []).
rem_el([H|T], H, T) :- rem_el(T, H, T1), T = T1, !.
rem_el([H|T], E, X) :- rem_el(T, E, T1), X = [H|T1], !.
