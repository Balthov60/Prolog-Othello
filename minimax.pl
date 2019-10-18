% change la couleur courante (enfin, is supposed to. aux erreurs près ¯\_(ツ)_/¯)
changerJoueur(Couleur) :- 
	(Couleur = b -> Couleur = n ; Couleur = n -> Couleur = b).

% MINIMAX Algorithm avec élagage alpha_beta
evaluer_et_choisir(Plateau, [[X|Y]|CoupsPossibles], Couleur, Profondeur, Alpha, Beta, MeilleurMouvementCourant, CoupResultant) :-
	placerPion(Plateau, X, Y, Couleur),
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
	Alpha < Valeur, Valeur < Beta,
	evaluer_et_choisir(CoupsPossibles, Plateau, Couleur, Valeur, Beta, Coup, CoupResultant).
	
cutoff(Coup, Valeur, Profondeur, Alpha, Beta, CoupsPossibles, Plateau, Couleur, MeilleurMouvementCourant, CoupResultant) :-
	Valeur <= Alpha,
	evaluer_et_choisir(CoupsPossibles, Plateau, Couleur, Profondeur, Alpha, Beta, MeilleurMouvementCourant, CoupResultant).