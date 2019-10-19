module(matrix).

case(X, Y, L, Couleur) :- 
    Z is X * 8 + Y,
    nth0(Z , L, Couleur).

estEgal(A,B):-
    A=B.

estPleine(A) :-
    A\=v.

reverseCouleur(A, B) :-
    (A = b -> B = n;
        A = n -> B = b;
    false).

caseVerticaleBasse(X, Y, Plateau, Couleur, XResultat) :-
    Xtemporaire is X + 1,
    case(Xtemporaire, Y, Plateau, CouleurTemporaire),
    estPleine(CouleurTemporaire),
    (estEgal(Couleur, CouleurTemporaire) -> caseVerticaleBasse(Xtemporaire, Y, Plateau, Couleur, XResultat);
    not(estEgal(Couleur, CouleurTemporaire)) -> XResultat is Xtemporaire).

caseVerticaleHaute(X, Y, Plateau, Couleur, XResultat) :-
    Xtemporaire is X - 1,
    case(Xtemporaire, Y, Plateau, CouleurTemporaire),
    estPleine(CouleurTemporaire),
    (estEgal(Couleur, CouleurTemporaire) -> caseVerticaleHaute(Xtemporaire, Y, Plateau, Couleur, XResultat);
    not(estEgal(Couleur, CouleurTemporaire)) -> XResultat is Xtemporaire).

caseHorizontaleGauche(X, Y, Plateau, Couleur, YResultat) :-
    Ytemporaire is Y - 1,
    case(X, Ytemporaire, Plateau, CouleurTemporaire),
    estPleine(CouleurTemporaire),
    (estEgal(Couleur, CouleurTemporaire) -> caseHorizontaleGauche(X, Ytemporaire, Plateau, Couleur, YResultat);
    not(estEgal(Couleur, CouleurTemporaire)) -> YResultat is Ytemporaire).

caseHorizontaleDroite(X, Y, Plateau, Couleur, YResultat) :-
    Ytemporaire is Y + 1,
    case(X, Ytemporaire, Plateau, CouleurTemporaire),
    estPleine(CouleurTemporaire),
    (estEgal(Couleur, CouleurTemporaire) -> caseHorizontaleDroite(X, Ytemporaire, Plateau, Couleur, YResultat);
    not(estEgal(Couleur, CouleurTemporaire)) -> YResultat is Ytemporaire).

horizontale(Plateau, X, Y, Couleur, YTrouve) :-
    case(X, Y, Plateau, Couleur),
    reverseCouleur(Couleur, CouleurContraire),
    (caseHorizontaleGauche(X, Y, Plateau, CouleurContraire, YTrouve);
    caseHorizontaleDroite(X, Y, Plateau, CouleurContraire, YTrouve)).

verticale(Plateau, X, Y, Couleur, XTrouve) :-
    case(X, Y, Plateau, Couleur),
    reverseCouleur(Couleur, CouleurContraire),
    (caseVerticaleHaute(X, Y, Plateau, CouleurContraire, XTrouve);
    caseVerticaleBasse(X, Y, Plateau, CouleurContraire, XTrouve)).

diagonale(Plateau, X, Y, Couleur, XTrouve, YTrouve) :-
    case(X, Y, Plateau, Couleur),
    reverseCouleur(Couleur, CouleurContraire),
    (caseDiagonaleNE(X, Y, Plateau, CouleurContraire, XTrouve, YTrouve);
    caseDiagonaleNO(X, Y, Plateau, CouleurContraire, XTrouve, YTrouve);
    caseDiagonaleSE(X, Y, Plateau, CouleurContraire, XTrouve, YTrouve);
    caseDiagonaleSO(X, Y, Plateau, CouleurContraire, XTrouve, YTrouve)).

caseDiagonaleNE(X, Y, Plateau, Couleur, XResultat, YResultat) :-
    Ytemporaire is Y + 1,
    Xtemporaire is X - 1,
    case(Xtemporaire, Ytemporaire, Plateau, CouleurTemporaire),
    estPleine(CouleurTemporaire),
    (estEgal(Couleur, CouleurTemporaire) -> caseDiagonaleNE(Xtemporaire, Ytemporaire, Plateau, Couleur, XResultat ,YResultat);
    not(estEgal(Couleur, CouleurTemporaire)) -> XResultat is Xtemporaire ,YResultat is Ytemporaire).

caseDiagonaleNO(X, Y, Plateau, Couleur, XResultat, YResultat) :-
    Ytemporaire is Y - 1,
    Xtemporaire is X - 1,
    case(Xtemporaire, Ytemporaire, Plateau, CouleurTemporaire),
    estPleine(CouleurTemporaire),
    (estEgal(Couleur, CouleurTemporaire) -> caseDiagonaleNO(Xtemporaire, Ytemporaire, Plateau, Couleur, XResultat ,YResultat);
    not(estEgal(Couleur, CouleurTemporaire)) -> XResultat is Xtemporaire ,YResultat is Ytemporaire).

caseDiagonaleSE(X, Y, Plateau, Couleur, XResultat, YResultat) :-
    Ytemporaire is Y + 1,
    Xtemporaire is X + 1,
    case(Xtemporaire, Ytemporaire, Plateau, CouleurTemporaire),
    estPleine(CouleurTemporaire),
    (estEgal(Couleur, CouleurTemporaire) -> caseDiagonaleSE(Xtemporaire, Ytemporaire, Plateau, Couleur, XResultat ,YResultat);
    not(estEgal(Couleur, CouleurTemporaire)) -> XResultat is Xtemporaire ,YResultat is Ytemporaire).

caseDiagonaleSO(X, Y, Plateau, Couleur, XResultat, YResultat) :-
    Ytemporaire is Y - 1,
    Xtemporaire is X + 1,
    case(Xtemporaire, Ytemporaire, Plateau, CouleurTemporaire),
    estPleine(CouleurTemporaire),
    (estEgal(Couleur, CouleurTemporaire) -> caseDiagonaleSO(Xtemporaire, Ytemporaire, Plateau, Couleur, XResultat ,YResultat);
    not(estEgal(Couleur, CouleurTemporaire)) -> XResultat is Xtemporaire ,YResultat is Ytemporaire).

croix(Plateau, X, Y, Couleur, [X1, Y1]) :-
    (horizontale(Plateau, X, Y, Couleur, YTrouve), X1 is X, Y1 is YTrouve);
    (verticale(Plateau, X, Y, Couleur, XTrouve), X1 is XTrouve, Y1 is Y);
    (diagonale(Plateau, X, Y, Couleur, XTrouve, YTrouve), X1 is XTrouve, Y1 is YTrouve).

flipCases(Plateau, X, Y, Couleur, Liste) :-
    bagof(Coords, croix(Plateau,X,Y,Couleur, Coords),Liste).

%[b, v, v, v, v, b, b, v, v, n, v, b, v, n, v, v, v, v, n, n, n, n, v, v, v, b, n, b, n, b, v, v, v, v, n, n, n, n, n, b, v, b, v, b, v, n, v, v, v, v, v, v, v, v, b, v, v, v, v, b, v, v, v, v]



