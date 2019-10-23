:- consult(listeCoupsPossibles.pl).

% Heuristique pour minimiser le nombre de coup possible de l'adversaire

heuristiqueMinimiserCoupAdversaire(Plateau, Couleur, Score) :- 
	listeCoupsPossibles(Plateau, Couleur, ListeCoupPossibles),
        length(ListeCoupPossibles, Score).
   
