% cmmdc(+X, +Y, -D) (calculeaza cmmdc intre X si Y)
cmmdc(X, 0, X).
cmmdc(X, Y, D) :- Z is X mod Y, cmmdc(Y, Z, D), !.
