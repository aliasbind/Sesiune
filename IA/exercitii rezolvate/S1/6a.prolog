obiect(a).
obiect(b).
obiect(c).

% perm(-X, -Y, -Z) (genereaza permutarile)
perm(X, Y, Z) :- obiect(X), obiect(Y), obiect(Z),
                 X \== Y, Y \== Z, Z \== X.

% perml(-L) (genereaza permutarile si le pune in lista)
perml(L) :- perm(X, Y, Z), L = [X, Y, Z].
