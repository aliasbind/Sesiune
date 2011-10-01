% multipli(+N, +MAX, -L)
% returneaza lista multiplilor lui N mai mici ca MAX
multipli(N, MAX, L) :- multipli1(N, MAX, L).

multipli1(N, N, [N]).
multipli1(N, CONTOR, L) :- C1 is CONTOR-1, CONTOR mod N =:= 0,
    (L = [CONTOR|T], multipli1(N, C1, T)), !.
multipli1(N, CONTOR, L) :- C1 is CONTOR-1, CONTOR mod N =\= 0,
    (multipli1(N, C1, L)), !.
