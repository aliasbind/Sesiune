% Problema rezolvata de Laura.

% inord(+A) unde A este de forma arb(Rad,As,Ad)
% afiseaza arborele cu radacina Rad in inordine

inord(null).
inord(arb(Rad,S,D)) :- inord(S), write(Rad), write(' '), inord(D).

/* Interogare:

| ?- inord(arb(8,arb(4,arb(3,null,null),arb(6,null,null)),arb(11,arb(9,null,null),arb(16,null,null)))).
3 4 6 8 9 11 16
yes
   */
