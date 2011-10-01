% last(+L, -X) (determina ultimul element al listei L)

last([], _) :- fail.
last([H|[]], H).
last([_|L], X) :- last(L, X1), !, X = X1.
