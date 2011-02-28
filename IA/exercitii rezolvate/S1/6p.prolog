% suma(+Lista, -Suma) (calculeaza suma elementelor din lista)

suma([], 0).
suma([H|T], S) :- suma(T, S1), S is H+S1.
