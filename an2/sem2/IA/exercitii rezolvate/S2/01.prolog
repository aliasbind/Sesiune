% peek(+S, -EL)
% pune in EL varful stivei S
peek([H|_], H).

% empty(+S)
% verifica daca S e vida
empty([]).

% push(+S, +EL, -SF)
% pune EL in stiva
push(S, EL, [EL|S]).

% pop(+S, -EL, -SF).
% scoate un element din stiva si il pune in EL
pop([H|T], H, T).
