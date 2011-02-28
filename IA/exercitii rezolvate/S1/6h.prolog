% intercl(+L1, +L2, -L) (interclaseaza doua liste)

intercl([], L, L).
intercl(L, [], L).
intercl([H1|L1], [H2|L2], L) :- intercl(L1, L2, LX), L = [H1,H2|LX].
