% reverse(+L, -R) (genereaza inversa listei L)

reverse([], []).
reverse([], _).
reverse([HL|TL], TR) :- reverse(TL, TR1), append(TR1,[HL],TR), !.
