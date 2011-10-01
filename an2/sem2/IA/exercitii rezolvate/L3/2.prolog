% coliniare(:pt1, :pt2, :pt3)
% afla daca punctele p1, p2 si p3 sunt coliniare
coliniare(pt(X1, Y1), pt(X2, Y2), pt(X3, Y3)) :-
  X1 * (Y2 - Y3) + X2 * (Y3 - Y1) + X3 * (Y1 - Y2) =:= 0.
