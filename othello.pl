:- consult(othello_functions).

play :-
    initPlateau(Plateau),
    print_matrice(Plateau),
    
    write('Before Repeat\n'),
    repeat,
    (
        write('Début Manche\n'),

        listeCoupsPossibles(Plateau, n, CoupsPossible),
        write('Coup Possible Noir : '),
        write(CoupsPossible),
        write('\n'),
        
        (listeNonVide(CoupsPossible) ->
            write('Joueur Noir Joue... \n'),
            
            choixCoupPossible(Plateau, n, CoupsPossible, X, Y),
            write('Choix Coup Possible.. \n'),
            write('X: '), write(X), write(' Y: '), write(Y), write('\n'),
            % OU entrerCoup(X, Y, CoupsPossible),
            
            placerPion(Plateau, n, X, Y),
            write('tryFlipCases\n'),
	        tryFlipCases(Plateau, n, X, Y),
            write('tryFlipCasesEnd\n')
        ),
        print_matrice(Plateau),

		
        listeCoupsPossibles(Plateau, b, CoupsPossible),
        write('Coup Possible Blanc '),
        write(CoupsPossible),
        write('\n'),
        
		(listeNonVide(CoupsPossible) ->
            write('Blanc\n'),
            choixCoupPossible(Plateau, b, CoupsPossible, X, Y),
            % OU entrerCoup(X, Y, CoupsPossible),
            placerPion(Plateau, b, X, Y),
	        tryFlipCases(Plateau, b, X, Y)
        ),
        
        print_matrice(Plateau),
        write('fin Manche\n')
    ), 
    testFinPartie(Plateau),
    !,
    afficheResultat(Plateau).
