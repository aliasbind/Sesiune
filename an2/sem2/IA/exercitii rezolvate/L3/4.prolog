% Author:  Roman Laura grupa 242
% Date: 4/17/2011

% distanta(+pt1,+pt2,-R)
% returneaza in R distanta dintre cele doua puncte
distanta(pt(X1,Y1),pt(X2,Y2), R) :- sqrt((X2-X1)*(X2-X1) + (Y2-Y1)*(Y2-Y1),R).

% echilateral(+pt1,+pt2,+pt3)
% verifica daca punctele formeaza un triunghi echilateral

echilateral(pt(X1,Y1),pt(X2,Y2),pt(X3,Y3)):- %calculeaza lungimile celor 3 laturi
                                         distanta(pt(X1,Y1),pt(X2,Y2), R1),
                                         distanta(pt(X1,Y1),pt(X3,Y3), R2),
                                         distanta(pt(X2,Y2),pt(X3,Y3), R3),
                                         %aici verifica daca punctele formeaza un triunghi
                                         (R1 < R2+R3 ; R2 < R1+R3 ; R3 < R1+R2),
                                         %aici verifica daca toate laturile sunt egale
                                         %caz in care este echilateral
                                         (R1 =:= R2 , R1 =:= R3 , R2 =:= R3).