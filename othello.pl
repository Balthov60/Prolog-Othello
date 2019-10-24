:- consult(othello_functions).

play :-
    initPlateau(Plateau),
    
    write('Joueur vs Ordi (entrer : j) ou Ordi vs Ordi (entrer : o)\n'),
    read(PlayerType),
    
    (PlayerType = j -> 
        write('Joueur vs Ordi \n'),
	write('Choix de l\'heuristique : (1, 2, 3, 4)\n'),
        read(HeuristicIndex),
        write('Type de l\'heuristique de l\'ordinateur : '), write(HeuristicIndex), 
        write('\n'),
	print_matrice(Plateau),
	write('Before Round Loop\n'),
	roundLoop(Plateau, n, PlayerType, HeuristicIndex, true)
        
	; (PlayerType = o ->
            write('Choix de l\'heuristique des noirs : (1, 2, 3, 4)\n'),
            read(HeuristicIndex1),
	    write('Choix de l\'heuristique des blancs : (1, 2, 3, 4)\n'),
            read(HeuristicIndex2),
            write('Ordi (noir) vs Ordi (blanc) : '), 
	    write(HeuristicIndex1),write(' vs '), write(HeuristicIndex2),
            write('\n'),
	    print_matrice(Plateau),
    	    write('Before Round Loop\n'),
	    roundLoop(Plateau, n, PlayerType, HeuristicIndex1, HeuristicIndex2, true)
		; fail)).

% appelé pour joueur vs joueur (1 IA = 1 heuristique)
roundLoop(Plateau, Color, PlayerType, HeuristicIndex, PreviousPlayed) :-
    write('Début Manche : '), write(PlayerType), write(" "), writeln(Color),

    reverseCouleur(Color, NewColor),
    listeCoupsPossibles(Plateau, Color, CoupsPossible),
    write('Coup Possible : '),
    writeln(CoupsPossible),

    (listeNonVide(CoupsPossible) ->        
        (PlayerType = j -> 
            entrerCoup(X, Y),
            placerPion(Plateau, Color, X, Y, PlateauFinal)
            ; PlayerType = oj ->
		    choixCoupPossible(Plateau, Color, CoupsPossible, HeuristicIndex, PlateauFinal)
			; fail
        ),      
        writeln('Fin Manche - Joué.'),
        print_matrice(PlateauFinal),
	passerJoueurSuivant(PlayerType, NextPlayerType),
        roundLoop(PlateauFinal, NewColor, NextPlayerType, HeuristicIndex, true)
    
    ; PreviousPlayed = true -> 
        write('Fin Manche - Non Joué.\n'),
	passerJoueurSuivant(PlayerType, NextPlayerType),
        roundLoop(Plateau, NewColor, NextPlayerType, HeuristicIndex, false)        
        
	; afficherResultat(Plateau)
    ).

% appelé pour pc vs pc (2 IA = 2 heuristiques)
roundLoop(Plateau, Color, PlayerType, HeuristicIndexCurrent, HeuristicIndex2, PreviousPlayed) :-
    write('Début Manche : '), write(PlayerType), write(" "), writeln(Color),
    write('Heuristique appliquée :'), writeln(HeuristicIndexCurrent),

    reverseCouleur(Color, NewColor),
    listeCoupsPossibles(Plateau, Color, CoupsPossible),
    write('Coup Possible : '),
    writeln(CoupsPossible),

    (listeNonVide(CoupsPossible) ->        
        choixCoupPossible(Plateau, Color, CoupsPossible, HeuristicIndexCurrent, PlateauFinal),
        writeln('Fin Manche - Joué.'),
        print_matrice(PlateauFinal),
        roundLoop(PlateauFinal, NewColor, NextPlayerType, HeuristicIndex2, HeuristicIndexCurrent, true)
    
    ; PreviousPlayed = true -> 
        write('Fin Manche - Non Joué.\n'),
        roundLoop(Plateau, NewColor, NextPlayerType, HeuristicIndex2, HeuristicIndexCurrent, false)        
        
	; afficherResultat(Plateau)
    ).


passerJoueurSuivant(j,oj).
passerJoueurSuivant(oj,j).