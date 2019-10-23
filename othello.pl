:- consult(othello_functions).

play :-
    initPlateau(Plateau),
    
    write('Joueur vs Ordi (entrer : j) ou Ordi vs Ordi (entrer : o)\n'),
    read(PlayerType),
    
    (PlayerType = j -> 
        write('Joueur vs Ordi \n')
        ; (PlayerType = o ->
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

    (listeNonVide(CoupsPossible) ->
        write('Joueur Joue... \n'),

        write('Player Type : '),
        write(PlayerType),
        (PlayerType = j -> 
            entrerCoup(X, Y),
            placerPion(Plateau, Color, X, Y, PlateauFinal)
            ; (PlayerType = o ->
                choixCoupPossible(Plateau, Color, CoupsPossible, PlateauFinal)
                ; fail)
        ),
        
        write('Choix Coup Possible.. \n'),
        write('X: '), write(X), write(' Y: '), write(Y), write('\n'),        
        print_matrice(PlateauFinal),
        
        write('Fin Manche - Joué.\n'),
        roundLoop(PlateauFinal, NewColor, PlayerType, true)
    
    ; PreviousPlayed = true -> 
        write('Fin Manche - Non Joué.\n'),
        roundLoop(Plateau, NewColor, PlayerType, false)        
        ; afficherResultat(Plateau)
    ).
