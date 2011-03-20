% peek(+C, -EL)
% pune in EL varful cozii C
peek([H|_], H).

% empty(+C)
% verifica daca S e vida
empty([]).

% push(+C, +EL, -CF)
% pune EL in coada
push(C, EL, [EL|C]).

% pop(+C, -EL, -CF).
% scoate un element din coada si il pune in EL
pop([X], X, []) :- !.
pop([H|T], EL, CF) :- pop(T, EL, CF1), CF = [H|CF1].
