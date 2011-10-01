% Problema rezolvata de Laura.

% preord(+A) unde A este de forma arb(Rad, As, Ad)
% Afiseaza arborele cu radacina Rad, in preordine.

preord(null).
preord(arb(Rad,S,D)) :- write(Rad), write(' '), preord(S),preord(D).
