% lungime(+L, -Lg). (afla lungimea listei L)

lungime([], 0).
lungime([_|T], N) :- lungime(T, N1), N is N1+1, !.
