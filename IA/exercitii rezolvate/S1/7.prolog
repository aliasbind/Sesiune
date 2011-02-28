% multime(+L, -M) (transforma L intr-o multime)
multime([], []) :- !.
multime([H|T], M) :- not(member(H, T)), multime(T, M1), M = [H|M1], !.
multime([H|T], M) :- member(H, T), multime(T, M1), M = M1, !.

% reuniune(+M1, +M2, -MF) (reuneste multimile M1 si M2)
reuniune(M1, M2, MF) :- append(M1, M2, MF1), multime(MF1, MF2), MF = MF2.

% intersectie(+M1, +M2, -MF) (intersecteaza multimile M1 si M2)
intersectie([], _, []).
intersectie(_, [], []).
intersectie([H1|T1], M2, MF) :- 
  not(member(H1, M2)), intersectie(T1, M2, MF1), MF = MF1.
intersectie([H1|T1], M2, MF) :- 
  member(H1, M2), intersectie(T1, M2, MF1), MF = [H1|MF1].

% diferenta(+M1, +M2, -MF) (diferenta intre M1 si M2)
diferenta([], _, []).
diferenta(A, [], A).
diferenta([H|M1], M2, MF) :-
  member(H, M2), diferenta(M1, M2, MF1), MF = MF1, !.
diferenta([H|M1], M2, MF) :-
  not(member(H, M2)), diferenta(M1, M2, MF1), MF = [H|MF1], !.

% dsim(+M1, +M2, -MF) (diferenta simetrica intre M1 si M2)
dsim(M1, M2, MF) :- diferenta(M1, M2, MX), diferenta(M2, M1, MY),
                    reuniune(MX, MY, MF1), MF = MF1.

% subm(+M1, +M2) (verifica daca M1 e submultime a lui M2)
subm([], _).
subm([H|M1], M2) :- member(H, M2), subm(M1, M2), !.
