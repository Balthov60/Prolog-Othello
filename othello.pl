:- consult(othello_functions).

play :-
    initPlateau(Plateau),
    
    write('Joueur vs Ordi (entrer : j) ou Ordi vs Ordi (entrer : o)\n'),
    read(PlayerType),
    
    (PlayerType = j -> 
        write('Joueur vs Ordi \n')
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
            ; (PlayerType = o ->
                choixCoupPossible(Plateau, Color, CoupsPossible, HeuristicIndex, PlateauFinal)
                ; fail)
        ),      
        write('Fin Manche - Joué.\n'),
        print_matrice(PlateauFinal),
        
        roundLoop(PlateauFinal, NewColor, PlayerType, HeuristicIndex, true)
    
    ; PreviousPlayed = true -> 
        write('Fin Manche - Non Joué.\n'),
        roundLoop(Plateau, NewColor, PlayerType, HeuristicIndex, false)        
        ; afficherResultat(Plateau)
    ).
