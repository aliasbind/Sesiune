% cmmdc(+X, +Y, -D) (calculeaza cmmdc intre X si Y)
cmmdc(X, 0, X).
cmmdc(X, Y, D) :- Z is X mod Y, cmmdc(Y, Z, D), !.

% cmmmc(+X, +Y, -D) (calculeaza cmmmc intre X si Y)
cmmmc(X, Y, D) :- cmmdc(X, Y, Z), D is (X * Y) / Z.
