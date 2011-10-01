% L1 biggerthan L2.
% verifica daca lista L1 are toate elementele mai mari ca L2
:- op(100, xfy, biggerthan).

[X] biggerthan L :- isbig(X, L), !.
[H1|T1] biggerthan L :- isbig(H1, L), T1 biggerthan L.

% isbig(+EL, +L).
% verifica daca EL e mai mare decat oricare element din L
isbig(_, []).
isbig(EL, [H|T]) :- EL > H, isbig(EL, T), !.
