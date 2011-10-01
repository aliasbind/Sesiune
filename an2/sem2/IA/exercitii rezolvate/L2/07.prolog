% add(+EL, +POZ, +L, -LF)
% (pune EL in lista L pe pozitia POZ)
add(EL, 1, L, [EL|L]) :- !.
add(EL, POZ, [H|L], [H|LF]) :- POZ1 is POZ-1, add(EL, POZ1, L, LF), !.
