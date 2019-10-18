case(X, Y, LIST, RESULT) :-
    Z is X * 8 + Y,
    nth0(Z , LIST, RESULT).
 
replace(X, Y, N, L, R) :-
    Z is X * 8 + Y,
    nth0(Z, L, _, RR),
    nth0(Z, R, N, RR).

% placer un pion. Return false si autre statut que vide 
% X,Y => Coordonnée, LIST => plateau, COULEUR => n(noir) ou b(blanc) en fonction du joueur

placer(X, Y, LIST, COULEUR, RESULT):-
    ( case(X,Y, LIST, v)->
            replace(X, Y, COULEUR, LIST, RESULT)
    ; fail).


flipPion(Plateau, X, Y, R):-
   case(X, Y, Plateau, Z),
   (Z = 'n' -> replace(X, Y, 'b', Plateau, R);
   Z = 'b' -> replace(X, Y, 'n', Plateau, R);
   fail).

listeNonVide([_|_]).

% lit les coordonnées du coup du joueur
lire_coord_joueur(X, Y):-
	writeln('Entrer coord X puis Y (0 <= X,Y <= 7,) :'),
	read(X),
	read(Y),
	(X > 7 -> lire_coord_joueur(X,Y);
	 X < 0 -> lire_coord_joueur(X,Y);
	 Y > 7 -> lire_coord_joueur(X,Y);
	 Y < 0 -> lire_coord_joueur(X,Y);
	 !
 	 ).
