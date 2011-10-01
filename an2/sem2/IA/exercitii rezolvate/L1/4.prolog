% nr_zile(+LUNA, -ZILE)
nr_zile(2, 28).
nr_zile(2, 29).
nr_zile(L, Z) :- L >= 0, L \== 2, L =< 7, ((L mod 2 =:= 0, Z = 30); 
                                  (L mod 2 =:= 1, Z = 31)), !.
nr_zile(L, Z) :- L >= 8, L =< 12,((L mod 2 =:= 0, Z = 31);
                                  (L mod 2 =:= 1, Z = 30)), !.

% an_bisect(+X) (verifica daca X e an bisect).
an_bisect(X) :- ((X mod 100 =:= 0, X mod 400 =:= 0), !) ; X mod 4 =:= 0.

% data_corecta(+Z, +L, +A) (verifica daca data este corecta)
data_corecta(Z, L, A) :- L =< 12, L \== 2, L >= 1, nr_zile(L, NR), 
                         Z =< NR, Z >= 0, A >= 0, !.

% cazul cand luna este februarie
data_corecta(Z, L, A) :- A >= 0, L = 2, Z >= 0,
                         (an_bisect(A), Z =< 29, !) ;
                         (\+ an_bisect(A), Z =< 28, !).
