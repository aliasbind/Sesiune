% take(+L, +N, -LF) (ia primele N elemente dintr-o lista)
take(_, 0, []).
take([H|L], N, LF) :- LF = [H|LFX], N1 is N-1, take(L, N1, LFX), !.

% drop(+L, +N, -LF) (arunca primele N elemente dintr-o lista)
drop(L, 0, L).
drop([_|L], N, LF) :- LF = LFX, N1 is N-1, drop(L, N1, LFX), !.

% split(+L, -L1, -L2) (imparte o lista in doua de la mijloc)
split(L, L1, L2) :- length(L, LEN), 
                    take(L, floor(LEN/2), LX1), 
                    drop(L, floor(LEN/2), LX2),
                    L1 = LX1, L2 = LX2.

% merge(+L1, +L2, -LF) (interclaseaza doua liste sortate)
merge([], [], []).
merge([], [H|T], LF) :- merge([], T, LFX), LF = [H|LFX].
merge([H|T], [], LF) :- merge(T, [], LFX), LF = [H|LFX].
merge([H1|T1], [H2|T2], LF) :- (H1 < H2, 
                                merge(T1, [H2|T2], LFX), LF = [H1|LFX]); 
                               (H1 >= H2,
                                merge([H1|T1], T2, LFX), LF = [H2|LFX]).

% msort(+Lista, -Lista) (sorteaza elementele din lista)
msort([], []):- !.
msort([A], [A]).
msort(L, LF) :- split(L, LL, LR), 
                msort(LL, LF1), msort(LR, LF2),
                merge(LF1, LF2, LFX), LF = LFX, !.
