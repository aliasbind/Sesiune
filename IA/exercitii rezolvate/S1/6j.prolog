% add(+Element, +Lista, -Lista_fin) (adauga un element la inceputul listei)

add(E, L, LF) :- LF = [E|L].
