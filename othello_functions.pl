:- consult(primitive).
:- consult(listeCoupsPossibles).

% Initialise le plateau dans plateau
initPlateau(Plateau) :-
    Plateau = [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, b, n, v, v, v, v, v, v, n, b, v, v, v, v, v, v, v, v, v, v, v,v, v, v, v, v, v, v, v,v, v, v, v, v, v, v, v].

% Logique centrale : choisis un coup X,Y parmus coupsPossible
choixCoupPossible(Plateau, Couleur, CoupsPossible, X, Y) :-
    % DOING
    Alpha = 1,
    write("temp Solution !\n"),
    recupererX(CoupsPossible, CoupResultant),
    recupererX(CoupResultant, X),
    recupererY(CoupResultant, Y).
%    evaluer_et_choisir(Plateau, CoupsPossible, Couleur, 3, Alpha, 2, Coup, CoupResultant).
%    write("Salut 2 !\n"),
%    write(CoupResultant),
%    recupererX(CoupResultant, X),
%    recupererY(CoupResultant, Y).
 
% Demande à l’utilisateur de choisir un x y parmis les coupsPossible
entrerCoup(CoupsPossible, X, Y) :-
    % TODO
    X is 0,
    Y is 0.

% placer un pion. Return false si autre statut que vide 
% X,Y => Coordonnée, LIST => plateau, COULEUR => n(noir) ou b(blanc) en fonction du joueur
placerPion(Plateau, Couleur, X, Y) :-
    ( case(X, Y, Plateau, V) ->
            remplace(X, Y, Couleur, Plateau, RESULT);
            Plateau is RESULT
    ; fail).
        
%%%%%%%%%%%%%%%%%%%%
%% TRY FLIP CASES %%
%%%%%%%%%%%%%%%%%%%%

estEgal(A,B):-
    A=B.

estPleine(A) :-
    A\=v.

estVide(A) :-
    A=v.

reverseCouleur(A, B) :-
    (A = b -> B = n;
        A = n -> B = b;
    false).

caseVerticaleBasse(X, Y, Plateau, Couleur, XResultat) :-
    Xtemporaire is X + 1,
    case(Xtemporaire, Y, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseVerticaleBasse(Xtemporaire, Y, Plateau, Couleur, XResultat);
    estVide(CouleurTemporaire) -> XResultat is Xtemporaire).

caseVerticaleHaute(X, Y, Plateau, Couleur, XResultat) :-
    Xtemporaire is X - 1,
    case(Xtemporaire, Y, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseVerticaleHaute(Xtemporaire, Y, Plateau, Couleur, XResultat);
    estVide(CouleurTemporaire) -> XResultat is Xtemporaire).

caseHorizontaleGauche(X, Y, Plateau, Couleur, YResultat) :-
    Ytemporaire is Y - 1,
    case(X, Ytemporaire, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseHorizontaleGauche(X, Ytemporaire, Plateau, Couleur, YResultat);
    estVide(CouleurTemporaire) -> YResultat is Ytemporaire).

caseHorizontaleDroite(X, Y, Plateau, Couleur, YResultat) :-
    Ytemporaire is Y + 1,
    case(X, Ytemporaire, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseHorizontaleDroite(X, Ytemporaire, Plateau, Couleur, YResultat);
    estVide(CouleurTemporaire) -> YResultat is Ytemporaire).

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
    estVide(CouleurTemporaire) -> XResultat is Xtemporaire ,YResultat is Ytemporaire).

caseDiagonaleNO(X, Y, Plateau, Couleur, XResultat, YResultat) :-
    Ytemporaire is Y - 1,
    Xtemporaire is X - 1,
    case(Xtemporaire, Ytemporaire, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseDiagonaleNO(Xtemporaire, Ytemporaire, Plateau, Couleur, XResultat ,YResultat);
    estVide(CouleurTemporaire) -> XResultat is Xtemporaire ,YResultat is Ytemporaire).

caseDiagonaleSE(X, Y, Plateau, Couleur, XResultat, YResultat) :-
    Ytemporaire is Y + 1,
    Xtemporaire is X + 1,
    case(Xtemporaire, Ytemporaire, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseDiagonaleSE(Xtemporaire, Ytemporaire, Plateau, Couleur, XResultat ,YResultat);
    estVide(CouleurTemporaire) -> XResultat is Xtemporaire ,YResultat is Ytemporaire).

caseDiagonaleSO(X, Y, Plateau, Couleur, XResultat, YResultat) :-
    Ytemporaire is Y - 1,
    Xtemporaire is X + 1,
    case(Xtemporaire, Ytemporaire, Plateau, CouleurTemporaire),    
    (estEgal(Couleur, CouleurTemporaire) -> caseDiagonaleSO(Xtemporaire, Ytemporaire, Plateau, Couleur, XResultat ,YResultat);
    estVide(CouleurTemporaire) -> XResultat is Xtemporaire ,YResultat is Ytemporaire).

% Pour chaque direction essaye de flip une case
tryFlipCases(Plateau, Couleur, X, Y) :-
    ((horizontale(Plateau, X, Y, Couleur, YTrouve), X1 is X, Y1 is YTrouve);
    (verticale(Plateau, X, Y, Couleur, XTrouve), X1 is XTrouve, Y1 is Y);
    (diagonale(Plateau, X, Y, Couleur, XTrouve, YTrouve), X1 is XTrouve, Y1 is YTrouve)),
    flipCases(Plateau, X, Y, X1, Y1).

%%%%%%%%%%%%%%%%
%% FLIP CASES %%
%%%%%%%%%%%%%%%%

% Retourne les pions entre x1,y1 et x2,y2 nob inclus
flipCases(Plateau, X1, Y1, Y2, Y2) :-
     ((X1 is X2) -> flipPionsSurLigne(Plateau, X1, Y1, Y2);
     (Y1 is Y2) -> flipPionsSurLigne(Plateau, Y1, X1, X2);
     flipsPionsDiag(Plateau,X1,Y1,X2,Y2)).

flipPionsSurLigne(Plateau, Dir, Borne1, Borne2) :- 
    ((Borne2>Borne1) -> Borne_inf is Borne1+1, Borne_sup is Borne2-1, flipPionsVersDir(Plateau,Dir, Borne_inf, Borne_sup);
     Borne_inf is Borne2+1, Borne_sup is Borne1-1,flipPionsVersDir(Plateau,Dir, Borne_inf, Borne_sup)).
     
flipPionsVersDir(Plateau,Dir, Borne_inf, Borne_sup) :- 
    between(Borne_inf, Borne_sup, I),
    flipPion(Plateau,Dir,I),
    false.
     
flipsPionsDiag(Plateau,X1,Y1,X2,Y2) :- 
    ((X2>X1,Y2>Y1) ->  
        flipsPionsDiagDir(Plateau,X1,Y1,X2,Y2);
    (X2<X1,Y2<Y1) ->  
        flipsPionsDiagDir(Plateau,X2,Y2,X1,Y1);
    (X2>X1,Y2<Y1) ->  
        flipsPionsDiagDir(Plateau,X1,Y2,X2,X1);
        flipsPionsDiagDir(Plateau,X2,Y1,X1,Y2)).
                              
flipsPionsDiagDir(Plateau, Borne_inf_x, Borne_inf_y, Borne_sup_x, Borne_sup_y) :-
    between(Borne_inf_x, Borne_sup_x, X),  
    between(Borne_inf_y, Borne_sup_y, Y),
    flipPion(Plateau,X,Y),
    false,
    false.
       
% Retourne le pion au coordonnée X, Y
flipPion(Plateau, X, Y) :-
   case(X, Y, Plateau, Z),
   (Z = 'n' -> replace(X, Y, 'b', Plateau, r);
   Z = 'b' -> replace(X, Y, 'n', Plateau, r);
   fail),
   Plateau is r.
   
%%%%%%%%%%%%%
%% Minimax %%
%%%%%%%%%%%%%
   
% change la couleur courante (enfin, is supposed to. aux erreurs près ¯\_(ツ)_/¯)
changerJoueur(Couleur) :- 
	(Couleur = b -> Couleur = n ; Couleur = n -> Couleur = b).

% MINIMAX Algorithm avec élagage alpha_beta
evaluer_et_choisir(Plateau, [[X|Y]|CoupsPossibles], Couleur, Profondeur, Alpha, Beta, MeilleurMouvementCourant, CoupResultant) :-
	placerPion(Plateau, Couleur, X, Y),
	alpha_beta(Profondeur, Plateau, Couleur, Alpha, Beta, MoveA, Valeur),
	ValeurCourante = -Valeur,
	cutoff(MoveX, MoveY, ValeurCourante, Alpha, Beta, CoupsPossibles, Plateau, MeilleurMouvementCourant, CoupResultant).

evaluer_et_choisir(Plateau, [], Couleur, Profondeur, Alpha, Beta, Coup, (Coup,Alpha)).	

alpha_beta(0, Plateau, Couleur, Alpha, Beta, Coup, Valeur) :-
	heuristique(Plateau, Valeur).
	
alpha_beta(Profondeur, Plateau, Couleur, Alpha, Beta, [X|Y], Valeur) :-
	listeCoupsPossibles(Plateau, Couleur, CoupsPossibles),
	Alpha1 = -Beta,
	Beta1 = -Alpha,
	newProfondeur = Profondeur-1,
	changerJoueur(Couleur), 
	evaluer_et_choisir(CoupsPossibles, Plateau, Couleur, newProfondeur, Alpha1, Beta1, nil, ([X|Y], Valeur)).
	
cutoff(Coup, Valeur, Profondeur, Alpha, Beta, CoupsPossibles, Plateau, Couleur, MeilleurMouvementCourant, (Coup, Valeur)) :-
	Value >= Beta.
	
cutoff(Coup, Valeur, Profondeur, Alpha, Beta, Plateau, Couleur, MeilleurMouvementCourant, CoupResultant) :-
	Alpha < Valeur, 
    Valeur < Beta,
	evaluer_et_choisir(CoupsPossibles, Plateau, Couleur, Valeur, Beta, Coup, CoupResultant).
	
cutoff(Coup, Valeur, Profondeur, Alpha, Beta, CoupsPossibles, Plateau, Couleur, MeilleurMouvementCourant, CoupResultant) :-
	Valeur =< Alpha,
	evaluer_et_choisir(CoupsPossibles, Plateau, Couleur, Profondeur, Alpha, Beta, MeilleurMouvementCourant, CoupResultant).
      
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
    (N > B -> write('Les noirs ont gagné! '),write(N),write(' à '),write(B);
   	B > N -> write('Les blancs ont gagné! '),write(B),write(' à '),write(N);
   	B = N ->  write('Match nul! '),write(N),write(' partout.');
   	fail).
