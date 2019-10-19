:- consult(primitive).

% Initialise le plateau dans plateau
initPlateau(Plateau) :-
    Plateau = [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, b, n, v, v, v, v, v, v, n, b, v, v, v, v, v, v, v, v, v, v, v,v, v, v, v, v, v, v, v,v, v, v, v, v, v, v, v].

% Liste les coups possible pour couleur dans coupsPossibles
listeCoupsPossible(Plateau, Couleur, CoupsPossible) :-
	% TODO
    CoupsPossible = [[1,2],[2,3]].

% Logique centrale : choisis un coup X,Y parmus coupsPossible
choixCoupPossible(Plateau, Couleur, CoupsPossible, X, Y) :-
    % TODO
    X = 0,
    Y = 0.
 
% Demande à l’utilisateur de choisir un x y parmis les coupsPossible
entrerCoup(CoupsPossible, X, Y) :-
    % TODO
    X is 0,
    Y is 0.

% placer un pion. Return false si autre statut que vide 
% X,Y => Coordonnée, LIST => plateau, COULEUR => n(noir) ou b(blanc) en fonction du joueur
placerPion(Plateaun, Couleur, X, Y) :-
    ( case(X, Y, Plateau, V) ->
            remplace(X, Y, Couleur, Plateau, RESULT);
            Plateau is RESULT
    ; fail).

%%%%%%%%%%%%%%%%
%% FLIP CASES %%
%%%%%%%%%%%%%%%%

% Pour chaque direction essaye de flip une case
tryFlipCases(Plateau, Couleur, X, Y) :-
    % TODO
    % Parcourir les 8 directions et trouver un pion x2, y2
    % Pour chaque direction, si un pion x2, y2 trouvé, appeler:
    % ListePionAFlip(plateau, x1, y1, x2, y2);
    print('tryFlipCases').

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
