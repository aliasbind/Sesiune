% sublist(+SL, +L). (verifica daca SL este sublista a lui L)

sublist([], _).
sublist(_, []) :- fail.
sublist([H|TS], [H|T])  :- sublist(TS,T).
sublist([HS|TS], [H|T]) :- HS \== H, sublist([HS|TS], T).
