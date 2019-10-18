JeuTermine(Plateau) :-
	ListeCoupsPossibles(Plateau, b, CoupsBlancs),
    ListeCoupsPossibles(Plateau, n, CoupsNoirs),
    \ListeNonVide(CoupsBlancs),
    \ListeNonVide(CoupsNoirs).