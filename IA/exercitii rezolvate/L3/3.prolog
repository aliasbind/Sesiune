% isoscel(:pt1, :pt2, :pt3)
% verifica daca punctele p1, p2 si p3
% formeaza un triunghi isoscel

isoscel(pt(X1, Y1), pt(X2, Y2), pt(X3, Y3)) :-
  (sqrt( (X2-X1)^2 + (Y2-Y1)^2) =:= sqrt( (X3-X2)^2 + (Y3-Y2)^2 )) ;
  (sqrt( (X2-X1)^2 + (Y2-Y1)^2) =:= sqrt( (X3-X1)^2 + (Y3-Y1)^2 )) ;
  (sqrt( (X3-X1)^2 + (Y3-Y1)^2) =:= sqrt( (X3-X2)^2 + (Y3-Y2)^2 )), !.
