main :- 
	Othelier=[v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,b,n,v,v,v,v,v,v,n,b,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
	writeln('Bienvenue sur Prothello'),
	display(Othelier).


display([]).
display([H1,H2,H3,H4,H5,H6,H7,H8|Matrice]) :-
	format('~w ~w ~w ~w ~w ~w ~w ~w~n', [H1,H2,H3,H4,H5,H6,H7,H8]), display(Matrice).



