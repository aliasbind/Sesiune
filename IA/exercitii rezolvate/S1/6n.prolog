% get(+Lista, +N, -X) (afla al N-lea element din lista)

get([], _, -1).
get([H|_], 1, H).
get([_|L], N, X) :- N1 is N-1, get(L, N1, X1), X = X1, !.
