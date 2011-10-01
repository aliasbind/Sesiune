% intersectie(:dreapta1 :dreapta2, :pt)
% afla punctul de intersectie dintre dreapta1 si dreapta2
% si il pune in pt.

intersectie(dreapta(dr1, pt(X1,Y1), pt(X2,Y2)),
            dreapta(dr2, pt(X3,Y3), pt(X4,Y4)),
            pt(XF, YF)) :-
  XFtop is ((X1*Y2 - Y1*X2) * (X3 - X4)) - ((X1 - X2) * (X3*Y4 - Y3*X4)),
  XFbot is ((X1 - X2) * (Y3 - Y4)) - ((Y1 - Y2) * (X3 - X4)),
  YFtop is ((X1*Y2 - Y1*X2) * (Y3 - Y4)) - ((Y1 - Y2) * (X3*Y4 - Y3*X4)),
  YFbot is ((X1 - X2) * (Y3 - Y4)) - ((Y1 - Y2) * (X3 - X4)),
  XFbot \== 0,
  XF is XFtop / XFbot,
  YF is YFtop / YFbot.
