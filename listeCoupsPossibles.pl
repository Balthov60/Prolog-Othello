
coupPossible(Plateau,X,Y,Couleur):- 
	estVide(Plateau,X,Y), 
	aVoisinCouleurOpposee(Plateau,X,Y,Couleur).
%	encadreCouleurOpposee(Plateau,X,Y,Couleur,X2,Y2).

case(X, Y, LIST, RESULT) :-
    Z is X * 8 + Y,
    nth0(Z, LIST, RESULT).

% est vrai si la case est vide
estVide(Plateau,X,Y):- case(X,Y,Plateau,v).
estNonVide(Plateau,X,Y):- case(X,Y,Plateau,R), R\==v.

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


listeCoupsPossibles(Plateau,Couleur,ListeCoupsPossibles):-
    listeCoupsPossiblesSousMethode(Plateau,Plateau,Couleur,ListeCoupsPossibles,_).

listeCoupsPossiblesSousMethode(_,[],_,[],-1).

listeCoupsPossiblesSousMethode(Plateau,[_|Reste],Couleur,ListeCoupsPossibles,N):-
	listeCoupsPossiblesSousMethode(Plateau,Reste,Couleur,L2,NN),
    N is NN+1,
    mod(N,8,Y),
    div(N,8,X),
    majCoups(Plateau,X,Y,Couleur,L2,ListeCoupsPossibles).

majCoups(Plateau,X,Y,Couleur,ListeCoupsPossibles,[[X,Y]|ListeCoupsPossibles]):-
    coupPossible(Plateau,X,Y,Couleur).

majCoups(_,_,_,_,ListeCoupsPossibles,ListeCoupsPossibles).


% Z correspond à Y
mod(A,B,Z):- Z is A mod B.
% Z correspond à X
div(A,B,Z):- Z is A//B.
