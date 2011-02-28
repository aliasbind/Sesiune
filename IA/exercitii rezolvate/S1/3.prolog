% max(+A, +B, -X). (determina maximul intre A si B si il pune in X).
max(A, B, X) :- (A =< B, X is B, !) ; (A > B, X is A).
