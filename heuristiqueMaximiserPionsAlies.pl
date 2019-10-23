count([],_,0).
count([C|R],C,X) :- count(R,C,Y), X is 1+Y.
count([_|R],C,X) :- count(R,C,X).

heuristiqueMaximiserNombrePionsAlies(Plateau, Couleur, Score) :-
    count(Plateau, Couleur, Score).
