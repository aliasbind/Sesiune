% nr_zile(+LUNA, -ZILE)
nr_zile(2, 28).
nr_zile(2, 29).
nr_zile(L, Z) :- L >= 0, L =< 7, ((L mod 2 =:= 0, Z = 30); 
                                  (L mod 2 =:= 1, Z = 31)), !.
nr_zile(L, Z) :- L >= 8, L =< 12,((L mod 2 =:= 0, Z = 31);
                                  (L mod 2 =:= 1, Z = 30)), !.
