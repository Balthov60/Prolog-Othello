:- consult(othello_functions).

play :-
    initPlateau(Plateau),
    
    writeln('Joueur vs Ordi (entrer : j) ou Ordi vs Ordi (entrer : o)'),
    read(PlayerType),
    
    (PlayerType = j -> 
        writeln('Joueur vs Ordi'),
        writeChoixHeuristiques('Choix de l\'heuristique :'),
        
        read(HeuristicIndex),
        write('Type de l\'heuristique de l\'ordinateur : '), writeln(HeuristicIndex)
    
    ; PlayerType = o ->
        writeChoixHeuristiques('Choix de l\'heuristique Ordi 1 : (1, 2, 3, 4)'),
        read(HeuristicIndex1),
        
        writeChoixHeuristiques('Choix de l\'heuristique Ordi 2 : (1, 2, 3, 4)'),
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
        ; PlayerType = oj ->
            write('Heuristique Appliquée : '), writeHeuristicDescription(HeuristicIndex1),
		    choixCoupPossible(Plateau, Color, CoupsPossible, HeuristicIndex1, PlateauFinal)
        ; PlayerType = o ->
            write('Heuristique Appliquée : '), writeHeuristicDescription(HeuristicIndex1),
            choixCoupPossible(Plateau, Color, CoupsPossible, HeuristicIndex1, PlateauFinal)       
        ; PlayerType = o2 ->
            write('Heuristique Appliquée : '), writeHeuristicDescription(HeuristicIndex2),
            choixCoupPossible(Plateau, Color, CoupsPossible, HeuristicIndex2, PlateauFinal)
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

writeChoixHeuristiques(PhraseIntro) :-
    writeln(PhraseIntro),
    writeHeuristicDescription(1),
    writeHeuristicDescription(2),
    writeHeuristicDescription(3),
    writeHeuristicDescription(4).

writeHeuristicDescription(1) :- writeln("1: Danger").
writeHeuristicDescription(2) :- writeln("2: Maximiser Nombre de pions").
writeHeuristicDescription(3) :- writeln("3: Minimiser Coups Adverses").
writeHeuristicDescription(4) :- writeln("4: Grouper Pions").