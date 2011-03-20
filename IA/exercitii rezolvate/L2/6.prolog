% split(+L, -LF1, -LF2)
% (desparte lista L in functie de paritatea pozitiei)
split(L, LF1, LF2) :- split1(L, LF1, LF2).

split1([], [], []).
split1([H|L], [H|LF1], LF2) :- split2(L, LF1, LF2).

split2([], [], []).
split2([H|L], LF1, [H|LF2]) :- split1(L, LF1, LF2).
