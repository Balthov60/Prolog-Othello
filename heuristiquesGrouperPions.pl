case(X, Y, LIST, RESULT) :-
    Z is X * 8 + Y,
    nth0(Z , LIST, RESULT).
 
hGroupePions(Plateau, Couleur, ScoreFin):-
    parcourtPion(0, 0, Plateau, Couleur, 0, ScoreFin).

parcourtPion(0, 8, Plateau, Couleur, Score, Score):-!.

parcourtPion(X, Y, Plateau, Couleur, Score, ScoreFin):-
    case(X, Y, Plateau, Pion),
    (   Pion = Couleur -> compteVoisins(X, Y, Plateau, Couleur, Nb), Score2 is Score + Nb;
    Score2 is Score),
    X2 is X + 1,
    (   X2 > 7 -> X3 is 0, Y3 is Y + 1;
    X3 is X2, Y3 is Y),
    parcourtPion(X3, Y3, Plateau, Couleur, Score2, ScoreFin).
    
compteVoisins(X, Y, Plateau, Couleur, Nb):-
    %Récupere les voisins de x et y
    Xhaut is X - 1, 
    XBas is X + 1,
    YGauche is Y - 1, 
    Ydroite is Y + 1,
    %Regarde les voisins un par un
    ( Xhaut \= -1 ->  case(Xhaut, Y, Plateau, PionH);
    PionH is 0),
    ( PionH = Couleur ->  H is 1;
    H is 0),
    ( Xhaut \= -1, YGauche \= -1 ->  case(Xhaut, YGauche, Plateau, PionHG);
    PionHG is 0),
    ( PionHG = Couleur ->  HG is 1;
    HG is 0),
    ( YGauche \= -1 ->  case(X, YGauche, Plateau, PionG);
    PionG is 0),
    ( PionG = Couleur ->  G is 1;
    G is 0),
    ( XBas \= 8, YGauche \= -1 ->  case(XBas, YGauche, Plateau, PionBG);
    PionBG is 0),
    ( PionBG = Couleur ->  BG is 1;
    BG is 0),
    ( XBas \= 8 ->  case(XBas, Y, Plateau, PionB);
    PionB is 0),
    ( PionB = Couleur ->  B is 1;
    B is 0),
    ( XBas \= 8, Ydroite \= 8 ->  case(XBas, Ydroite, Plateau, PionBD);
    PionBD is 0),
    ( PionBD = Couleur ->  BD is 1;
    BD is 0),
    ( Ydroite \= 8->  case(X, Ydroite, Plateau, PionD);
    PionD is 0),
    ( PionD = Couleur ->  D is 1;
    D is 0),
    ( Xhaut \= -1, Ydroite \= 8 ->  case(Xhaut, Ydroite, Plateau, PionHD);
    PionHD is 0),
    ( PionHD = Couleur ->  HD is 1;
    HD is 0),
    Nb is H + HG + G + BG + B + BD + D + HD.
    

    
    
    
