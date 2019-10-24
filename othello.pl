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
        write('\n')
        ; (PlayerType = o ->
            write('Choix de l\'heuristique : (1, 2, 3, 4)\n'),
            read(HeuristicIndex),
            write('Ordi vs Ordi : '), write(HeuristicIndex), 
            write('\n')
            ; fail)),
            
    print_matrice(Plateau),
    write('Before Round Loop\n'),
    roundLoop(Plateau, n, PlayerType, HeuristicIndex, true).
    
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
            ; PlayerType = o ->
                choixCoupPossible(Plateau, Color, CoupsPossible, HeuristicIndex, PlateauFinal)
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

passerJoueurSuivant(j,oj).
passerJoueurSuivant(oj,j).
passerJoueurSuivant(o,o).