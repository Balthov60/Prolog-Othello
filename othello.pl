:- consult(othello_functions).

play :-
    initPlateau(Plateau),
    print_matrice(Plateau),
    
    write('Before Repeat\n'),
    repeat,
    (
        write('Début Manche Noir\n'),

        listeCoupsPossibles(Plateau, n, CoupsPossibleNoir),
        write('Coup Possible Noir : '),
        write(CoupsPossibleNoir),
        write('\n'),
        read(A),
        
        (listeNonVide(CoupsPossibleNoir) ->
            write('Joueur Noir Joue... \n'),
            
            choixCoupPossible(Plateau, n, CoupsPossibleNoir, X, Y),
            write('Choix Coup Possible.. \n'),
            write('X: '), write(X), write(' Y: '), write(Y), write('\n'),
            % OU entrerCoup(X, Y, CoupsPossibleNoir),
            
            % placerPion(Plateau, n, X, Y), %% BACK HERE TODO ERROR
            
            write('tryFlipCases\n'),
	        % tryFlipCases(Plateau, n, X, Y),
            write('tryFlipCasesEnd\n')
        ),
        print_matrice(Plateau),
		
        write('Début Manche Blanc\n'),

        listeCoupsPossibles(Plateau, b, CoupsPossibleBlanc),
        write('Coup Possible Blanc : '),
        write(CoupsPossibleBlanc),
        write('\n'),
        read(A),
        
		(listeNonVide(CoupsPossibleBlanc) ->
            write('Joueur Blanc Joue... \n'),
            
            choixCoupPossible(Plateau, b, CoupsPossibleBlanc, X, Y),
            write('Choix Coup Possible.. \n'),
            write('X: '), write(X), write(' Y: '), write(Y), write('\n'),
            % OU entrerCoup(X, Y, CoupsPossibleBlanc),
            
            placerPion(Plateau, b, X, Y),
            write('tryFlipCases\n'),
            % tryFlipCases(Plateau, b, X, Y),
            write('tryFlipCasesEnd\n')
        ),
        print_matrice(Plateau),
    
        write('fin Manche\n')
    ), 
    testFinPartie(Plateau),
    !,
    afficheResultat(Plateau).
