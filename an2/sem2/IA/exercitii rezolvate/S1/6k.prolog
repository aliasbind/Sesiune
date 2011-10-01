% add(+Element, +Lista, -Lista_fin) (adauga un element la sfarsitul listei)

add(E, [], [E]).
add(E, [H|T], LF) :- add(E, T, LF1), LF = [H|LF1], !.
