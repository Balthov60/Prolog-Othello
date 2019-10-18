:- consult(othello_functions).

play :-
    initPlateau(Plateau),
    print_matrice(Plateau),
    repeat,
    (
        listeCoupsPossible(Plateau, n, CoupsPossible),
		(listeNonVide(CoupsPossible) ->
            choixCoupPlateau(Plateau, n, CoupsPossible, X, Y),
            % OU entrerCoup(X, Y, CoupsPossible),
            placerPion(Plateau, n, X, Y),
	        flipCases(Plateau, n, X, Y)
        ),
		
        listeCoupsPossible(Plateau, b, CoupsPossible),
		(listeNonVide(CoupsPossible) ->
            choixCoupPlateau(Plateau, b, CoupsPossible, X, Y),
            % OU entrerCoup(X, Y, CoupsPossible),
            placerPion(Plateau, b, X, Y),
	        flipCases(Plateau, b, X, Y)
        )
    ), 
    testFinPartie(PLATEAU),
    !,
    afficheResultat(plateau).
