:- consult(primitive).

% Initialise le plateau dans plateau
initPlateau(Plateau) :-
    Plateau = [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, b, n, v, v, v, v, v, v, n, b, v, v, v, v, v, v, v, v, v, v, v,v, v, v, v, v, v, v, v,v, v, v, v, v, v, v, v].
  
% Vérifie si le jeu est terminé
testFinPartie(Plateau) :-
    listeCoupsPossible(Plateau, b, CoupsBlancs),
    listeCoupsPossible(Plateau, n, CoupsNoirs),
    \listeNonVide(CoupsBlancs),
    \listeNonVide(CoupsNoirs).

% Liste les coups possible pour couleur dans coupsPossibles
listeCoupsPossible(Plateau, Couleur, CoupsPossible) :-
	% TODO
    CoupsPossible is [[1, 2], [2,3]].

% Logique centrale : choisis un coup X,Y parmus coupsPossible
choixCoupPossible(Plateau, Couleur, CoupsPossible, X, Y) :-
    % TODO
    X is 0,
    Y is 0.
 
% Demande à l’utilisateur de choisir un x y parmis les coupsPossible
entrerCoup(CoupsPossible, X, Y) :-
    % TODO
    X is 0,
    Y is 0.

% placer un pion. Return false si autre statut que vide 
% X,Y => Coordonnée, LIST => plateau, COULEUR => n(noir) ou b(blanc) en fonction du joueur
placerPion(X, Y, LIST, COULEUR, RESULT):-
    ( case(X,Y, LIST, v)->
            replace(X, Y, COULEUR, LIST, RESULT)
    ; fail).

% Pour chaque direction essaye de flip une case
tryFlipCases(Plateau, Couleur, X, Y) :-
    % TODO
    % Parcourir les 8 directions et trouver un pion x2, y2
    % Pour chaque direction, si un pion x2, y2 trouvé, appeler:
    % ListePionAFlip(plateau, x1, y1, x2, y2);
    print('tryFlipCases').

% Retourne les pions entre x1,y1 et x2,y2 nob inclus
flipCases(Plateau, X1, Y1, Y2, Y2) :-
    % Parcours les cases entre x1, y1 et x2, y2 exclus
    % Pour chaque : flipPion(plateau, x, y);
    print('flipCases').

% Retourne le pion au coordonnée X, Y
flipPion(Plateau, X, Y) :-
   case(X, Y, Plateau, Z),
   (Z = 'n' -> replace(X, Y, 'b', Plateau, r);
   Z = 'b' -> replace(X, Y, 'n', Plateau, r);
   fail),
   Plateau is r.

% Affiche les résultat sur la partie
afficheResultat(Plateau) :-
    % TODO
    print_matrice(Plateau).