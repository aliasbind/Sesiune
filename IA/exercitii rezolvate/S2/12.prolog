:- op(100, fx, +++).
:- op(200, xfy, este).

R este L1 +++ L2 :- sumlists(L1, L2, R).

% sumlists(+L1, +L2, -L)
% calculeaza suma dintre cele doua liste,
% conform cerintei, si o pune in L
sumlists([], [], []).
sumlists([H1|T1], [], L) :- sumlists(T1, [], L1), L = [H1|L1], !.
sumlists([], [H2|T2], L) :- sumlists([], T2, L1), L = [H2|L1], !.
sumlists([H1|T1], [H2|T2], L) :- S1 is H1+H2, sumlists(T1, T2, L1),
                                 L = [S1|L1], !.
