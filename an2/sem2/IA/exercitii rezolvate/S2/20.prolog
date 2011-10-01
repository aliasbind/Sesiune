% Problema rezolvata de Laura.

% postord(+A) unde A este de forma arb(Rad,As,Ad)
% afiseaza arborele cu radacina Rad in postordine

postord(null).
postord(arb(Rad,S,D)) :- postord(S),  postord(D), write(Rad), write(' ').

/* Interogare:

| ?- postord(arb(8,arb(4,arb(3,null,null),arb(6,null,null)),arb(11,arb(9,null,null),arb(16,null,null)))).
3 6 4 9 16 11 8
yes
   */
