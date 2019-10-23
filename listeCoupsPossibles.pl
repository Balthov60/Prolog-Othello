:- consult(primitive).

% est vrai si la case est vide
estVide(Plateau,X,Y):- case(X,Y,Plateau,v).

% est vrai si la case est vide
estNonVide(Plateau,X,Y):- case(X,Y,Plateau,R), R\==v.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% vrai si une case avec un pion noir a au moins un voisin blanc
aVoisinCouleurOpposee(Plateau,X,Y,n):- coordEnHaut(X,Y,XNew,YNew), case(XNew,YNew,Plateau,b). % au dessus
aVoisinCouleurOpposee(Plateau,X,Y,n):- coordEnHautDroite(X,Y,XNew,YNew), case(XNew,YNew,Plateau,b). % en haut à droite
aVoisinCouleurOpposee(Plateau,X,Y,n):- coordDroite(X,Y,XNew,YNew), case(XNew,YNew,Plateau,b). % a droite
aVoisinCouleurOpposee(Plateau,X,Y,n):- coordEnBasDroite(X,Y,XNew,YNew), case(XNew,YNew,Plateau,b). % en bas a droite
aVoisinCouleurOpposee(Plateau,X,Y,n):- coordEnBas(X,Y,XNew,YNew), case(XNew,YNew,Plateau,b). % en dessous
aVoisinCouleurOpposee(Plateau,X,Y,n):- coordEnBasGauche(X,Y,XNew,YNew), case(XNew,YNew,Plateau,b). % en bas a gauche
aVoisinCouleurOpposee(Plateau,X,Y,n):- coordGauche(X,Y,XNew,YNew), case(XNew,YNew,Plateau,b). % a gauche
aVoisinCouleurOpposee(Plateau,X,Y,n):- coordEnHautGauche(X,Y,XNew,YNew), case(XNew,YNew,Plateau,b). % en haut a gauche

% vrai si une case avec un pion blanc a au moins un voisin noir
aVoisinCouleurOpposee(Plateau,X,Y,b):- coordEnHaut(X,Y,XNew,YNew), case(XNew,YNew,Plateau,n). % au dessus
aVoisinCouleurOpposee(Plateau,X,Y,b):- coordEnHautDroite(X,Y,XNew,YNew), case(XNew,YNew,Plateau,n). % en haut à droite
aVoisinCouleurOpposee(Plateau,X,Y,b):- coordDroite(X,Y,XNew,YNew), case(XNew,YNew,Plateau,n). % a droite
aVoisinCouleurOpposee(Plateau,X,Y,b):- coordEnBasDroite(X,Y,XNew,YNew), case(XNew,YNew,Plateau,n). % en bas a droite
aVoisinCouleurOpposee(Plateau,X,Y,b):- coordEnBas(X,Y,XNew,YNew), case(XNew,YNew,Plateau,n). % en dessous
aVoisinCouleurOpposee(Plateau,X,Y,b):- coordEnBasGauche(X,Y,XNew,YNew), case(XNew,YNew,Plateau,n). % en bas a gauche
aVoisinCouleurOpposee(Plateau,X,Y,b):- coordGauche(X,Y,XNew,YNew), case(XNew,YNew,Plateau,n). % a gauche
aVoisinCouleurOpposee(Plateau,X,Y,b):- coordEnHautGauche(X,Y,XNew,YNew), case(XNew,YNew,Plateau,n). % en haut a gauche

% calcule les coordonnees X2 et Y2
% permet d avancer dans une direction
coordEnHaut(X,Y,X2,Y2):- X2 is X-1, Y2 is Y.
coordEnHautDroite(X,Y,X2,Y2):- X2 is X-1, Y2 is Y+1.
coordDroite(X,Y,X2,Y2):- X2 is X, Y2 is Y+1.
coordEnBasDroite(X,Y,X2,Y2):- X2 is X+1, Y2 is Y+1.
coordEnBas(X,Y,X2,Y2):- X2 is X+1, Y2 is Y.
coordEnBasGauche(X,Y,X2,Y2):- X2 is X+1, Y2 is Y-1.
coordGauche(X,Y,X2,Y2):- X2 is X, Y2 is Y-1.
coordEnHautGauche(X,Y,X2,Y2):- X2 is X-1, Y2 is Y-1.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



caseVerticaleBasse_coupPossible(X, Y, Plateau, Couleur, XResultat) :-
    Xtemporaire is X + 1,
    case(Xtemporaire, Y, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseVerticaleBasse_coupPossible(Xtemporaire, Y, Plateau, Couleur, XResultat);
    estVide(CouleurTemporaire) -> false;
    not(estEgal(Couleur,CouleurTemporaire)) -> XResultat is Xtemporaire).

caseVerticaleHaute_coupPossible(X, Y, Plateau, Couleur, XResultat) :-
    Xtemporaire is X - 1,
    case(Xtemporaire, Y, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseVerticaleHaute_coupPossible(Xtemporaire, Y, Plateau, Couleur, XResultat);
    estVide(CouleurTemporaire) -> false;
    not(estEgal(Couleur,CouleurTemporaire)) -> XResultat is Xtemporaire).

caseHorizontaleGauche_coupPossible(X, Y, Plateau, Couleur, YResultat) :-
    Ytemporaire is Y - 1,
    case(X, Ytemporaire, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseHorizontaleGauche_coupPossible(X, Ytemporaire, Plateau, Couleur, YResultat);
    estVide(CouleurTemporaire) -> false;
    not(estEgal(Couleur,CouleurTemporaire)) -> YResultat is Ytemporaire).

caseHorizontaleDroite_coupPossible(X, Y, Plateau, Couleur, YResultat) :-
    Ytemporaire is Y + 1,
    case(X, Ytemporaire, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseHorizontaleDroite_coupPossible(X, Ytemporaire, Plateau, Couleur, YResultat);
    estVide(CouleurTemporaire) -> false;
    not(estEgal(Couleur,CouleurTemporaire)) -> YResultat is Ytemporaire).

horizontale_coupPossible(Plateau, X, Y, Couleur, YTrouve) :-
    reverseCouleur(Couleur, CouleurContraire),
    (case(X, Y-1, Plateau, CouleurContraire),(caseHorizontaleGauche_coupPossible(X, Y, Plateau, CouleurContraire, YTrouve));
    (case(X, Y+1, Plateau, CouleurContraire),caseHorizontaleDroite_coupPossible(X, Y, Plateau, CouleurContraire, YTrouve))).

verticale_coupPossible(Plateau, X, Y, Couleur, XTrouve) :-
    reverseCouleur(Couleur, CouleurContraire),
    (case(X-1, Y, Plateau, CouleurContraire),(caseVerticaleHaute_coupPossible(X, Y, Plateau, CouleurContraire, XTrouve));
    (case(X+1, Y, Plateau, CouleurContraire),caseVerticaleBasse_coupPossible(X, Y, Plateau, CouleurContraire, XTrouve))).

diagonale_coupPossible(Plateau, X, Y, Couleur, XTrouve, YTrouve) :-
    reverseCouleur(Couleur, CouleurContraire),
    ((case(X-1, Y+1, Plateau, CouleurContraire),caseDiagonaleNE_coupPossible(X, Y, Plateau, CouleurContraire, XTrouve, YTrouve));
    (case(X-1, Y-1, Plateau, CouleurContraire),caseDiagonaleNO_coupPossible(X, Y, Plateau, CouleurContraire, XTrouve, YTrouve));
    (case(X+1, Y+1, Plateau, CouleurContraire),caseDiagonaleSE_coupPossible(X, Y, Plateau, CouleurContraire, XTrouve, YTrouve));
    (case(X+1, Y-1, Plateau, CouleurContraire),caseDiagonaleSO_coupPossible(X, Y, Plateau, CouleurContraire, XTrouve, YTrouve))).

caseDiagonaleNE_coupPossible(X, Y, Plateau, Couleur, XResultat, YResultat) :-
    Ytemporaire is Y + 1,
    Xtemporaire is X - 1,
    case(Xtemporaire, Ytemporaire, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseDiagonaleNE_coupPossible(Xtemporaire, Ytemporaire, Plateau, Couleur, XResultat ,YResultat);
    estVide(CouleurTemporaire) -> false;
    not(estEgal(Couleur,CouleurTemporaire)) -> XResultat is Xtemporaire ,YResultat is Ytemporaire).

caseDiagonaleNO_coupPossible(X, Y, Plateau, Couleur, XResultat, YResultat) :-
    Ytemporaire is Y - 1,
    Xtemporaire is X - 1,
    case(Xtemporaire, Ytemporaire, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseDiagonaleNO_coupPossible(Xtemporaire, Ytemporaire, Plateau, Couleur, XResultat ,YResultat);
    estVide(CouleurTemporaire) -> false;
    not(estEgal(Couleur,CouleurTemporaire)) -> XResultat is Xtemporaire ,YResultat is Ytemporaire).

caseDiagonaleSE_coupPossible(X, Y, Plateau, Couleur, XResultat, YResultat) :-
    Ytemporaire is Y + 1,
    Xtemporaire is X + 1,
    case(Xtemporaire, Ytemporaire, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseDiagonaleSE_coupPossible(Xtemporaire, Ytemporaire, Plateau, Couleur, XResultat ,YResultat);
    estVide(CouleurTemporaire) -> false;
    not(estEgal(Couleur,CouleurTemporaire)) -> XResultat is Xtemporaire ,YResultat is Ytemporaire).

caseDiagonaleSO_coupPossible(X, Y, Plateau, Couleur, XResultat, YResultat) :-
    Ytemporaire is Y - 1,
    Xtemporaire is X + 1,
    case(Xtemporaire, Ytemporaire, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseDiagonaleSO_coupPossible(Xtemporaire, Ytemporaire, Plateau, Couleur, XResultat ,YResultat);
    estVide(CouleurTemporaire) -> false;
    not(estEgal(Couleur,CouleurTemporaire)) -> XResultat is Xtemporaire ,YResultat is Ytemporaire).

croix_coupPossible(Plateau, X, Y, Couleur, [X1, Y1]) :-
    (horizontale_coupPossible(Plateau, X, Y, Couleur, YTrouve), X1 is X, Y1 is YTrouve);
    (verticale_coupPossible(Plateau, X, Y, Couleur, XTrouve), X1 is XTrouve, Y1 is Y);
    (diagonale_coupPossible(Plateau, X, Y, Couleur, XTrouve, YTrouve), X1 is XTrouve, Y1 is YTrouve).

findCoupPossible(Plateau, X, Y, Couleur, Liste) :-
    bagof(Coords, croix_coupPossible(Plateau,X,Y,Couleur, Coords),Liste).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% coupPossible prend en parametre le plateau, les coordonnées et la couleur du pion qu'on souhaite poser sur cette case
% il renvoie true si le coup est possible, false sinon

coupPossible(Plateau,X,Y,Couleur):- 
	estVide(Plateau,X,Y), 
	aVoisinCouleurOpposee(Plateau,X,Y,Couleur),
	findCoupPossible(Plateau, X, Y, Couleur, _).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% unifie dans ListeCoupsPossibles la liste des coordonnées [X,Y] où il est possible de poser des pions de couleur Couleur

listeCoupsPossibles(Plateau,Couleur,ListeCoupsPossibles):-
    listeCoupsPossiblesSousMethode(Plateau,Plateau,Couleur,ListeCoupsPossibles,_),!.


listeCoupsPossiblesSousMethode(_,[],_,[],-1).

listeCoupsPossiblesSousMethode(Plateau,[_|Reste],Couleur,ListeCoupsPossibles,N):-
    listeCoupsPossiblesSousMethode(Plateau,Reste,Couleur,L2,NN),
    N is NN+1,
    mod(N,8,Y),
    div(N,8,X),
    majCoups(Plateau,X,Y,Couleur,L2,ListeCoupsPossibles).

% Z correspond à Y
mod(A,B,Z):- Z is A mod B.

% Z correspond à X
div(A,B,Z):- Z is A//B.


% majCoups ajoute les coordonnées de la case à la liste des coups possibles si un coup est possible sur cette case

majCoups(Plateau,X,Y,Couleur,ListeCoupsPossibles,[[X,Y]|ListeCoupsPossibles]):-
    coupPossible(Plateau,X,Y,Couleur).

majCoups(_,_,_,_,ListeCoupsPossibles,ListeCoupsPossibles).


