:- consult(othello_functions).

play :-
    initPlateau(Plateau),
    
    writeln('Joueur vs Ordi (entrer : j) ou Ordi vs Ordi (entrer : o)'),
    read(PlayerType),
    
    (PlayerType = j -> 
        writeln('Joueur vs Ordi'),
        writeln('Choix de l\'heuristique : (1, 2, 3, 4)'),
        
        read(HeuristicIndex),
        write('Type de l\'heuristique de l\'ordinateur : '), writeln(HeuristicIndex)
    
    ; PlayerType = o ->
        writeln('Choix de l\'heuristique Ordi 1 : (1, 2, 3, 4)'),
        read(HeuristicIndex1),
        
        writeln('Choix de l\'heuristique Ordi 2 : (1, 2, 3, 4)'),
        read(HeuristicIndex2),
        
        write('Ordi 1 vs Ordi 2 : '), write(HeuristicIndex1), write(' vs '), writeln(HeuristicIndex2)
    ; fail),
            
    print_matrice(Plateau),
    roundLoop(Plateau, n, PlayerType, HeuristicIndex1, HeuristicIndex2, true).
    
roundLoop(Plateau, Color, PlayerType, HeuristicIndex1, HeuristicIndex2, PreviousPlayed) :-
    write('Début Manche : '), write(PlayerType), write(" "), writeln(Color),

    reverseCouleur(Color, NewColor),
    listeCoupsPossibles(Plateau, Color, CoupsPossible),
    
    write('Coup Possible : '), writeln(CoupsPossible),

    (listeNonVide(CoupsPossible) ->        
        (PlayerType = j -> 
            entrerCoup(X, Y),
            placerPion(Plateau, Color, X, Y, PlateauFinal)
        ; PlayerType = o ->
            choixCoupPossible(Plateau, Color, CoupsPossible, HeuristicIndex1, PlateauFinal)       
        ; PlayerType = o2 ->
            choixCoupPossible(Plateau, Color, CoupsPossible, HeuristicIndex2, PlateauFinal)
        ; PlayerType = oj ->
		    choixCoupPossible(Plateau, Color, CoupsPossible, HeuristicIndex1, PlateauFinal)
        ; fail),      
    
        writeln('Fin Manche - Joué.'),
        print_matrice(PlateauFinal),

        passerJoueurSuivant(PlayerType, NextPlayerType),
        roundLoop(PlateauFinal, NewColor, NextPlayerType, HeuristicIndex1, HeuristicIndex2, true)
    
    ; PreviousPlayed = true -> 
        writeln('Fin Manche - Non Joué.'),
        passerJoueurSuivant(PlayerType, NextPlayerType),
        roundLoop(Plateau, NewColor, NextPlayerType, HeuristicIndex1, HeuristicIndex2, false)        
        
	; afficherResultat(Plateau)).