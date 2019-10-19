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