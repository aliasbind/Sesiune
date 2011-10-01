cap(ploua, umbrela).
cap(ninge, caciula).
cap(soare, palaria_de_soare).

haina(ger, paltonul).
haina(frig, jacheta).
haina(caldut, vesta).
haina(cald, nimic).

incalta(polei, cizme).
incalta(baltoace, ghete).
incaltatemp(uscat, frig, adidasii).
incaltatemp(uscat, cald, sandalele).

% vremea(+X, -COND) (primeste temperatura X si returneaza conditia COND)
vremea(X, COND) :- (X < 0, COND = ger) ;
                   (X >= 0, X =< 10, COND = frig) ;
                   (X > 10, X =< 20, COND = caldut) ;
                   (X > 20, COND = cald).

% azi(+TEMP, +COND1, +COND2, -C, -H, -I)
azi(TEMP, COND1, COND2, C, H, I) :- vremea(TEMP, VREME), cap(COND1, C),
    haina(VREME, H), ((COND2 == uscat, incaltatemp(uscat, VREME, I)) ;
    (incalta(COND2, I))).
