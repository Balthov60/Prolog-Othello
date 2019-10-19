count([],_,0).
count([C|R],C,X) :- count(R,C,Y), X is 1+Y.
count([_|R],C,X) :- count(R,C,X).  


% Vérifie si le jeu est terminé
testFinPartie(Plateau) :-
    listeCoupsPossible(Plateau, b, CoupsBlancs),
    listeCoupsPossible(Plateau, n, CoupsNoirs),
    \listeNonVide(CoupsBlancs),
    \listeNonVide(CoupsNoirs).

% Affiche les résultat sur la partie
afficherResultat(Plateau) :-
    print_matrice(Plateau),
   	count(Plateau, b, B),
	count(Plateau, n, N),
    (N > B -> write('Les noirs ont gagné! '),write(N),write(' à '),write(B);
   	B > N -> write('Les blancs ont gagné! '),write(B),write(' à '),write(N);
   	B = N ->  write('Match nul! '),write(N),write(' partout.');
   	fail).