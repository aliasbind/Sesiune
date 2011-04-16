% Problema rezolvata de Laura.

:-op(100,xfy,plus).
:-op(100,xfy,este).

Mrez este M1 plus M2 :- sum_matrix(M1, M2, Mrez).

sum_matrix([],[],[]).
sum_matrix([H1|T1], [H2|T2], Mrez) :- sum_lists(H1, H2, Mrez1),
                                    sum_matrix(T1, T2, Mrez2),
                                    Mrez = [Mrez1|Mrez2].

% sum_lists(L1,L2,LR) 
% calculeaza L1+L2 si o pune in LR
sum_lists([],[],[]).
sum_lists([H|T], [H2|T2], LR) :- H1 is H+H2, sum_lists(T, T2, LR1), LR = [H1|LR1].
