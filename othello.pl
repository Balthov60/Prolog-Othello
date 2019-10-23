:- consult(othello_functions).

play :-
    initPlateau(Plateau),
    
    write('Joueur vs Ordi (entrer : j) ou Ordi vs Ordi (entrer : o)\n'),
    read(Player),
    
    (Player = j -> 
        write('Joueur vs Ordi \n')
        ; (Player = o ->
            write('Ordi vs Ordi \n')
            ; fail)),
            
    print_matrice(Plateau),
    write('Before Round Loop\n'),
    roundLoop(Plateau, n, PlayerType, true).
    
roundLoop(Plateau, Color, PlayerType, PreviousPlayed) :-
    write('Début Manche : '),
    write(Color),
    write('\n'),

    reverseCouleur(Color, NewColor),
    listeCoupsPossibles(Plateau, Color, CoupsPossible),
    write('Coup Possible : '),
    write(CoupsPossible),
    write('\n'),
    read(_),

    (listeNonVide(CoupsPossible) ->
        write('Joueur Joue... \n'),

        %(PlayerType = j -> 
        %    entrerCoup(X, Y),
        %    ; (PlayerType = o ->
        %        choixCoupPossible(Plateau, Color, CoupsPossible, X, Y),
        %        ; fail)
        %),
        choixCoupPossible(Plateau, Color, CoupsPossible, X, Y),
        
        write('Choix Coup Possible.. \n'),
        write('X: '), write(X), write(' Y: '), write(Y), write('\n'),
        
        placerPion(Plateau, Color, X, Y, PlateauInte),
        write('tryFlipCases \n'),
        print_matrice(PlateauInte),
        tryFlipCases(PlateauInte, X, Y, Color, PlateauFinal),
        write('tryFlipCasesEnd \n')
    ; PreviousPlayed = true -> 
        write('Fin Manche - Non Joué.\n'),
        roundLoop(Plateau, NewColor, PlayerType, false)
        ; afficherResultat(PlateauFinal)
    ),
    print_matrice(PlateauFinal),
    write('Fin Manche - Joué.\n'),
    roundLoop(PlateauFinal, NewColor, PlayerType, true).
    
play_old :-
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
            
            placerPion(Plateau, n, X, Y), %% BACK HERE TODO ERROR
            
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
