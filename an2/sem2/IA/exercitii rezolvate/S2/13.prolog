% Problema rezolvata de Laura.

% operator care face produsul scalar a doua liste si returneaza rezultatul
% R este L1 produsscalar L2.

:-op(100,xfy,produsscalar).
:-op(100,xfy,este).

R este L1 produsscalar L2 :- length(L1,Lung1), length(L2,Lung2), Lung1 =:= Lung2,
                        produs_scalar(L1,L2,R).

% produs_scalar(+L1,+L2,-R)
% calculeaza produsul scalar dintre elementele din
% vectorul L1 si L2 si il pune in R
produs_scalar([],[], 0).
produs_scalar([H1|T1],[H2|T2], R):- produs_scalar(T1,T2,R1), R is ((H1 * H2) + R1).
