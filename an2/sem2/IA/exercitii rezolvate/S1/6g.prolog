% concat(+L1, +L2, -L) (concateneaza doua liste)

concat([], L, L).
concat([H1|L1], L2, L) :- concat(L1, L2, LX), L = [H1|LX].
