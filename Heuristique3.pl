:- consult(primitive).
:- consult(listeCoupsPossibles).

entoureParDeuxPionsAdversaires(X, Y, Couleur, Plateau):-
    reverseCouleur(Couleur, CouleurAdversaire),
    case(X-1, Y-1, Plateau, CouleurAdversaire),
    case(X+1, Y+1, Plateau, CouleurAdversaire).

entoureParDeuxPionsAdversaires(X, Y, Couleur, Plateau):-
    reverseCouleur(Couleur, CouleurAdversaire),
    case(X-1, Y, Plateau, CouleurAdversaire),
    case(X+1, Y, Plateau, CouleurAdversaire).

entoureParDeuxPionsAdversaires(X, Y, Couleur, Plateau):-
    reverseCouleur(Couleur, CouleurAdversaire),
    case(X-1, Y+1, Plateau, CouleurAdversaire),
    case(X+1, Y-1, Plateau, CouleurAdversaire).

entoureParDeuxPionsAdversaires(X, Y, Couleur, Plateau):-
    reverseCouleur(Couleur, CouleurAdversaire),
    case(X, Y-1, Plateau, CouleurAdversaire),
    case(X, Y+1, Plateau, CouleurAdversaire).

calculerScore(_, _, [], _).
    
calculerScore(Plateau, Score, [[X|Y]|T], ScoreResultat) :-
    case(X, Y, Plateau, Couleur),
    Danger is 0,
    (entoureParDeuxPionsAdversaires(X, Y, Couleur, Plateau) -> Danger is Danger +100),
    ScoreTemp is Score - Danger,   
    calculerScore(Plateau ,ScoreTemp, T, ScoreResultat).