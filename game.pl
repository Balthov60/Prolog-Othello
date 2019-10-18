case(X, Y, LIST, RESULT) :-
    Z is X * 8 + Y,
    nth0(Z , LIST, RESULT).
 
 

% placer un pion. Return false si autre statut que vide 
% X,Y => Coordonnée, LIST => plateau, COULEUR => n(noir) ou b(blanc) en fonction du joueur

placer(X, Y, LIST, COULEUR, RESULT):-
    ( case(X,Y, LIST, v)->
            replace(X, Y, COULEUR, LIST, RESULT)
    ; fail).

