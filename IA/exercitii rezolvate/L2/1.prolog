% divizori(+N, -L) returneaza lista divizorilor lui N
divizori(N, L) :- divizori1(N, 1, L).

divizori1(N, N, [N]).
divizori1(N, I, L) :- N mod I =:= 0, J is I+1, L = [I|L1], 
                      divizori1(N, J, L1), !.
divizori1(N, I, L) :- N mod I \== 0, J is I+1, divizori1(N, J, L), !.
