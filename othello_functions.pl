:- consult(primitive).
:- consult(listeCoupsPossibles).
:- consult(Heuristique3).
:- consult(HeuristiqueDanger).
:- consult(HeuristiqueMaximiserPionsAlies).
:- consult(HeuristiqueMinimiserCoupAdverse).
:- consult(heuristiquesGrouperPions).

module(matrix).

% Initialise le plateau dans plateau
initPlateau(Plateau) :-
    Plateau = [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, b, n, v, v, v, v, v, v, n, b, v, v, v, v, v, v, v, v, v, v, v,v, v, v, v, v, v, v, v,v, v, v, v, v, v, v, v].

% Logique centrale : choisis un coup X,Y parmus coupsPossible
choixCoupPossible(Plateau, Couleur, CoupsPossibles, HeuristicIndex, PlateauResultant) :-
    evaluer_et_choisir(CoupsPossibles, Plateau, Couleur, 3, 1, (nil, -1000), (PlateauResultant, _), HeuristicIndex),
    write("Salut 2 !\n"),
    print_matrice(PlateauResultant).
    %recupererX(CoupResultant, X),
    %recupererY(CoupResultant, Y).
 
entrerCoup(X, Y) :-
	writeln('Entrer coord X puis Y (0 <= X Y <= 7,) :'),
	read(X),
	read(Y).

% placer un pion. Return false si autre statut que vide 
% X,Y => Coordonnée, LIST => plateau, COULEUR => n(noir) ou b(blanc) en fonction du joueur
placerPion(Plateau, Couleur, X, Y, PlateauFinal) :-
    remplace(X, Y, Couleur, Plateau, PlateauInte),
    tryFlipCases(PlateauInte, X, Y, Couleur, PlateauFinal).    

%%%%%%%%%%%%%%%%%%%%
%% TRY FLIP CASES %%
%%%%%%%%%%%%%%%%%%%%

caseVerticaleBasse(X, Y, Plateau, Couleur, XResultat) :-
    Xtemporaire is X + 1,
    case(Xtemporaire, Y, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseVerticaleBasse(Xtemporaire, Y, Plateau, Couleur, XResultat);
    (not(estEgal(Couleur,CouleurTemporaire)), estPleine(CouleurTemporaire)) -> XResultat is Xtemporaire).

caseVerticaleHaute(X, Y, Plateau, Couleur, XResultat) :-
    Xtemporaire is X - 1,
    case(Xtemporaire, Y, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseVerticaleHaute(Xtemporaire, Y, Plateau, Couleur, XResultat);
    (not(estEgal(Couleur,CouleurTemporaire)), estPleine(CouleurTemporaire)) -> XResultat is Xtemporaire).

caseHorizontaleGauche(X, Y, Plateau, Couleur, YResultat) :-
    Ytemporaire is Y - 1,
    case(X, Ytemporaire, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseHorizontaleGauche(X, Ytemporaire, Plateau, Couleur, YResultat);
    (not(estEgal(Couleur,CouleurTemporaire)), estPleine(CouleurTemporaire)) -> YResultat is Ytemporaire).

caseHorizontaleDroite(X, Y, Plateau, Couleur, YResultat) :-
    Ytemporaire is Y + 1,
    case(X, Ytemporaire, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseHorizontaleDroite(X, Ytemporaire, Plateau, Couleur, YResultat);
    (not(estEgal(Couleur,CouleurTemporaire)), estPleine(CouleurTemporaire)) -> YResultat is Ytemporaire).

horizontale(Plateau, X, Y, Couleur, YTrouve) :-
    case(X, Y, Plateau, Couleur),
    reverseCouleur(Couleur, CouleurContraire),
    (case(X, Y-1, Plateau, CouleurContraire),(caseHorizontaleGauche(X, Y, Plateau, CouleurContraire, YTrouve));
    (case(X, Y+1, Plateau, CouleurContraire),caseHorizontaleDroite(X, Y, Plateau, CouleurContraire, YTrouve))).

verticale(Plateau, X, Y, Couleur, XTrouve) :-
    case(X, Y, Plateau, Couleur),
    reverseCouleur(Couleur, CouleurContraire),
    (case(X-1, Y, Plateau, CouleurContraire),(caseVerticaleHaute(X, Y, Plateau, CouleurContraire, XTrouve));
    (case(X+1, Y, Plateau, CouleurContraire),caseVerticaleBasse(X, Y, Plateau, CouleurContraire, XTrouve))).

diagonale(Plateau, X, Y, Couleur, XTrouve, YTrouve) :-
    case(X, Y, Plateau, Couleur),
    reverseCouleur(Couleur, CouleurContraire),
    ((case(X-1, Y+1, Plateau, CouleurContraire),caseDiagonaleNE(X, Y, Plateau, CouleurContraire, XTrouve, YTrouve));
    (case(X-1, Y-1, Plateau, CouleurContraire),caseDiagonaleNO(X, Y, Plateau, CouleurContraire, XTrouve, YTrouve));
    (case(X+1, Y+1, Plateau, CouleurContraire),caseDiagonaleSE(X, Y, Plateau, CouleurContraire, XTrouve, YTrouve));
    (case(X+1, Y-1, Plateau, CouleurContraire),caseDiagonaleSO(X, Y, Plateau, CouleurContraire, XTrouve, YTrouve))).

caseDiagonaleNE(X, Y, Plateau, Couleur, XResultat, YResultat) :-
    Ytemporaire is Y + 1,
    Xtemporaire is X - 1,
    case(Xtemporaire, Ytemporaire, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseDiagonaleNE(Xtemporaire, Ytemporaire, Plateau, Couleur, XResultat ,YResultat);
    (not(estEgal(Couleur,CouleurTemporaire)), estPleine(CouleurTemporaire)) -> XResultat is Xtemporaire ,YResultat is Ytemporaire).

caseDiagonaleNO(X, Y, Plateau, Couleur, XResultat, YResultat) :-
    Ytemporaire is Y - 1,
    Xtemporaire is X - 1,
    case(Xtemporaire, Ytemporaire, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseDiagonaleNO(Xtemporaire, Ytemporaire, Plateau, Couleur, XResultat ,YResultat);
    (not(estEgal(Couleur,CouleurTemporaire)), estPleine(CouleurTemporaire)) -> XResultat is Xtemporaire ,YResultat is Ytemporaire).

caseDiagonaleSE(X, Y, Plateau, Couleur, XResultat, YResultat) :-
    Ytemporaire is Y + 1,
    Xtemporaire is X + 1,
    case(Xtemporaire, Ytemporaire, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseDiagonaleSE(Xtemporaire, Ytemporaire, Plateau, Couleur, XResultat ,YResultat);
    (not(estEgal(Couleur,CouleurTemporaire)), estPleine(CouleurTemporaire)) -> XResultat is Xtemporaire ,YResultat is Ytemporaire).

caseDiagonaleSO(X, Y, Plateau, Couleur, XResultat, YResultat) :-
    Ytemporaire is Y - 1,
    Xtemporaire is X + 1,
    case(Xtemporaire, Ytemporaire, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseDiagonaleSO(Xtemporaire, Ytemporaire, Plateau, Couleur, XResultat ,YResultat);
    (not(estEgal(Couleur,CouleurTemporaire)), estPleine(CouleurTemporaire)) -> XResultat is Xtemporaire ,YResultat is Ytemporaire).

croix(Plateau, X, Y, Couleur, [X1|Y1]) :-
    ((horizontale(Plateau, X, Y, Couleur, YTrouve), X1 is X, Y1 is YTrouve);
    (verticale(Plateau, X, Y, Couleur, XTrouve), X1 is XTrouve, Y1 is Y);
    (diagonale(Plateau, X, Y, Couleur, XTrouve, YTrouve), X1 is XTrouve, Y1 is YTrouve);
    true).
    
tryFlipCases(Plateau, X, Y, Couleur, PlateauResult) :-
    bagof(Coords, croix(Plateau, X, Y, Couleur, Coords), Liste),
    listButLast(Liste, ListeButLast),
    writeln(ListeButLast),
    recurFlipCases(Plateau, X, Y, ListeButLast, PlateauResult).

%%%%%%%%%%%%%%%%
%% FLIP CASES %%
%%%%%%%%%%%%%%%%

flipPion(Plateau, X, Y, R):-
     case(X, Y, Plateau, Z),
     (Z = 'n' -> remplace(X, Y, 'b', Plateau, R);
     Z = 'b' -> remplace(X, Y, 'n', Plateau, R);
     fail).        
     
flipPionsSurLigne(Plateau, Axe, Dir, Borne1, Borne2, R) :- 
    ((Borne2>Borne1) -> Borne_inf is Borne1, Borne_sup is Borne2-1, flipPionsVersDir(Plateau,Axe,Dir, Borne_inf, Borne_sup, R);
     Borne_inf is Borne2, Borne_sup is Borne1-1,flipPionsVersDir(Plateau,Axe,Dir, Borne_inf, Borne_sup, R)).
    
flipPionsVersDir(Plateau, Axe, Dir, Borne_sup, Borne_sup, Plateau).
flipPionsVersDir(Plateau,Axe,Dir, Borne_inf, Borne_sup, R) :-
    I is Borne_inf + 1,
    (   Axe = x ->  flipPion(Plateau, Dir, I, R2);
    flipPion(Plateau, I, Dir, R2)),
    flipPionsVersDir(R2, Axe ,Dir, I, Borne_sup, R).
    
     
flipsPionsDiag(Plateau,X1,Y1,X2,Y2, R):- ((X2>X1,Y2>Y1) ->  NbCases is X2-X1-1, flipsPionsDiagDir(Plateau,X1,Y1, xp, yp, NbCases,R);
                                          (X2<X1,Y2<Y1) -> NbCases is X1-X2-1, flipsPionsDiagDir(Plateau,X2,Y2,xp,yp,NbCases,R);
                                          (X2>X1,Y2<Y1) -> NbCases is X2-X1-1, flipsPionsDiagDir(Plateau,X1,Y1,xp, yn, NbCases,R);
                                          NbCases is X1-X2-1, flipsPionsDiagDir(Plateau,X1,Y1, xn, yp, NbCases,R)).
     
flipsPionsDiagDir(Plateau,Borne_inf_x,Borne_inf_y, Sens_X, Sens_Y, 0, Plateau). 
    
flipsPionsDiagDir(Plateau,Borne_inf_x,Borne_inf_y, Sens_X, Sens_Y, NbCases, R) :- 
    (Sens_X = xp -> I is Borne_inf_x + 1;
    I is Borne_inf_x - 1),
    (Sens_Y = yp -> J is Borne_inf_y + 1;
    J is Borne_inf_y-1),
    NbCasesNew is NbCases - 1,
    flipPion(Plateau, I, J, R2),
    flipsPionsDiagDir(R2,I,J, Sens_X, Sens_Y,NbCasesNew, R).
    
flipCases(Plateau,X1, Y1, X2, Y2, R) :-
     ((X1 = X2) -> flipPionsSurLigne(Plateau, x,  X1, Y1, Y2, R);
     (Y1 = Y2) -> flipPionsSurLigne(Plateau, y, Y1, X1, X2, R);
     flipsPionsDiag(Plateau,X1,Y1,X2,Y2, R)).

recurFlipCases(Plateau, X1, Y1, [], Plateau).

recurFlipCases(Plateau, X1, Y1, [[X2|Y2]|T], Result) :-
    flipCases(Plateau, X1, Y1, X2, Y2, TempR),
    recurFlipCases(TempR, X1, Y1, T, Result).

%%%%%%%%%%%%%
%% Minimax %%
%%%%%%%%%%%%% 

% Simple MINIMAX Algorithm
evaluer_et_choisir([[X,Y]|CoupsPossibles], Plateau, Couleur, Profondeur, Drapeau, Record, Result, HeuristicIndex) :-
    placerPion(Plateau, Couleur, X, Y, NewPlateau),
    minimax(Profondeur, NewPlateau, Couleur, Drapeau, PlateauX, Value, HeuristicIndex),
    update(NewPlateau, Value, Record, Record1),
    evaluer_et_choisir(CoupsPossibles, Plateau, Couleur, Profondeur, Drapeau, Record1, Result, HeuristicIndex).

evaluer_et_choisir([], Plateau, Couleur, Profondeur, Drapeau, Record, Record, _).


minimax(0, Plateau, Couleur, Drapeau, NewPlateau, Value, HeuristicIndex) :-
    (HeuristicIndex = 1 -> heuristiqueDanger(Plateau, Couleur, V);
    HeuristicIndex = 2 -> heuristiqueMaximiserNombrePionsAlies(Plateau, Couleur, V);
    HeuristicIndex = 3 -> heuristiqueMinimiserCoupAdversaire(Plateau, Couleur, V);
    HeuristicIndex = 4 -> hGroupePions(Plateau, Couleur, ScoreFin);
    false),
    Value is V*Drapeau.

minimax(Profondeur, Plateau, Couleur, Drapeau, NewPlateau, Value, HeuristicIndex) :-
    Profondeur > 0,
    reverseCouleur(Couleur, NewCouleur),
    listeCoupsPossibles(Plateau, NewCouleur, CoupsPossibles),
    NewProfondeur is Profondeur - 1,
    NewDrapeau is -Drapeau,
    evaluer_et_choisir(CoupsPossibles, Plateau, NewCouleur, NewProfondeur, NewDrapeau, (nil, -1000), (NewPlateau, Value), HeuristicIndex).

update(NewPlateau, Value, (NewPlateau1, Value1), (NewPlateau1, Value1)) :-
    	Value =< Value1.

update(NewPlateau, Value, (NewPlateau1, Value1), (NewPlateau, Value)) :-
    Value > Value1.
      
%%%%%%%%%%%%%%
%% END GAME %%
%%%%%%%%%%%%%%

% Vérifie si le jeu est terminé
testFinPartie(Plateau) :-
    listeCoupsPossible(Plateau, b, CoupsBlancs),
    listeCoupsPossible(Plateau, n, CoupsNoirs),
    not(listeNonVide(CoupsBlancs)),
    not(listeNonVide(CoupsNoirs)).

% Affiche les résultat sur la partie
afficherResultat(Plateau) :-
    print_matrice(Plateau),
   	count(Plateau, b, B),
	count(Plateau, n, N),
    (N > B -> write('Les noirs ont gagné! '),write(N),write(' à '),write(B), write('\n');
   	B > N -> write('Les blancs ont gagné! '),write(B),write(' à '),write(N), write('\n');
   	B = N -> write('Match nul! '),write(N), write(' partout.'), write('\n');
   	fail).
