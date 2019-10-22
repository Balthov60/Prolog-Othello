:- consult(othello_functions).

play :-
    initPlateau(Plateau),
    print_matrice(Plateau),
    repeat,
    (
        print('Début Manche'),
        listeCoupsPossibles(Plateau, n, CoupsPossible),
		(listeNonVide(CoupsPossible) ->
            print('Noir'),
            choixCoupPossible(Plateau, n, CoupsPossible, X, Y),
            % OU entrerCoup(X, Y, CoupsPossible),
            placerPion(Plateau, n, X, Y),
	        tryFlipCases(Plateau, n, X, Y)
        ),
		
        listeCoupsPossibles(Plateau, b, CoupsPossible),
		(listeNonVide(CoupsPossible) ->
            print('Blanc'),
            choixCoupPossible(Plateau, b, CoupsPossible, X, Y),
            % OU entrerCoup(X, Y, CoupsPossible),
            placerPion(Plateau, b, X, Y),
	        tryFlipCases(Plateau, b, X, Y)
        ),
        
        print('fin Manche')
    ), 
    testFinPartie(Plateau),
    !,
    afficheResultat(Plateau).
