:- consult(primitive).
:- consult(listeCoupsPossibles).

valeurCase(X, Y, Val) :-
    valeurCases(P),
    (X > 3 -> TrueX is 7 - X; TrueX is X),
    (Y > 3 -> TrueY is 7 - Y; TrueY is Y),
    TrueX >= 0, TrueX < 8,
    TrueY >= 0, TrueY < 8,
    Z is TrueX * 4 + TrueY,
    nth0(Z, P, Val).

valeurCases(Plateau) :-
    Plateau = [100, 0, 75, 30,
                0, 75, 0, 0,
                75, 0, 0, 0,
                30, 0, 0, -1].

dangerCase(X, Y, Val) :-
    dangerCases(P),
    (X > 3 -> TrueX is 7 - X; TrueX is X),
    (Y > 3 -> TrueY is 7 - Y; TrueY is Y),
    TrueX >= 0, TrueX < 8,
    TrueY >= 0, TrueY < 8,
    Z is TrueX * 4 + TrueY,
    nth0(Z, P, Val).

dangerCases(Plateau) :-
    Plateau = [0, 100, 40, 20,
            100, 40, 25, 0,
            40, 25, 0, 0,
            20, 0, 0, -1].

heuristiqueDanger(Plateau, Couleur, Score) :-
    listeCoupsPossibles(Plateau, Couleur, CoupsPossible),
    calculerScore(Plateau, 0, CoupsPossible, Score).

calculerScore(_, _, [], _).
    
calculerScore(Plateau, Score, [[X|Y]|T], gScoreResultat) :-
    valeurCase(X, Y, Valeur),
    dangerCase(X, Y, Danger),
    ScoreTemp is Score + Valeur - Danger,   
    calculerScore(Plateau ,ScoreTemp, T, ScoreResultat).