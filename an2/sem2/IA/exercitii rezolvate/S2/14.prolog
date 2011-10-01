% Problema rezolvata de Laura.

% operator care returneaza linia N dintr-o matrice
% LRez este N linie M

:-op(100,yfx,linie).
:-op(100,xfy,este).

Lrez este N linie M :- linie(M, N, Lrez).

% linie(+M,+N,-L)
% returneaza linia N din matricea M si o pune in L
linie([H|T], 1, H).
linie([H|T], Contor, L) :- Contor1 is Contor-1, linie(T, Contor1, L).
