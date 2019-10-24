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
    Plateau = [9999, 4, 3, 2,
               4, 3, 2, 0,
               3, 2, 0, 0,
               2, 0, 0, -1].

dangerCase(X, Y, Val) :-
    dangerCases(P),
    (X > 3 -> TrueX is 7 - X; TrueX is X),
    (Y > 3 -> TrueY is 7 - Y; TrueY is Y),
    TrueX >= 0, TrueX < 8,
    TrueY >= 0, TrueY < 8,
    Z is TrueX * 4 + TrueY,
    nth0(Z, P, Val).

dangerCases(Plateau) :-
    Plateau = [0, 5, 3, 0,
              5, 3, 0, 0,
              3, 0, 0, 0,
              0, 0, 0, -1].

heuristiqueDanger(Plateau, Couleur, Score) :-
    listeCoupsPossibles(Plateau, Couleur, CoupsPossible),
    calculerScore(Plateau, 0, CoupsPossible, Score).

calculerScore(_, ScoreTemp, [], ScoreResultat) :-
    ScoreResultat is ScoreTemp.
    
calculerScore(Plateau, Score, [[X|Y]|T], ScoreResultat) :-
    valeurCase(X, Y, Valeur),
    dangerCase(X, Y, Danger),
    ScoreTemp is Score + Valeur - Danger,   
    calculerScore(Plateau ,ScoreTemp, T, ScoreResultat).