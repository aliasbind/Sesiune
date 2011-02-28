% rem(+Lista, -ListaF) (sterge un element de la sfarsitul listei)

rem([_], []).
rem([H|LI], LF) :- rem(LI, LF1), LF = [H|LF1].
