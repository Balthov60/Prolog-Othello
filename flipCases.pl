case(X, Y, LIST, RESULT) :-
    Z is X * 8 + Y,
    nth0(Z , LIST, RESULT).
 
replace(X, Y, N, L, R) :-
    Z is X * 8 + Y,
    nth0(Z, L, _, RR),
    nth0(Z, R, N, RR).

flipPion(Plateau, X, Y, R):-
     case(X, Y, Plateau, Z),
     (Z = 'n' -> replace(X, Y, 'b', Plateau, R);
     Z = 'b' -> replace(X, Y, 'n', Plateau, R);
     fail).        
     
flipPionsSurLigne(Plateau, Axe, Dir, Borne1, Borne2, R) :- 
    ((Borne2>Borne1) -> Borne_inf is Borne1, Borne_sup is Borne2-1, flipPionsVersDir(Plateau,Axe,Dir, Borne_inf, Borne_sup, R);
     Borne_inf is Borne2, Borne_sup is Borne1-1,flipPionsVersDir(Plateau,Axe,Dir, Borne_inf, Borne_sup, R)).
    
flipPionsVersDir(Plateau, Axe, Dir, Borne_sup, Borne_sup, Plateau).
flipPionsVersDir(Plateau,Axe,Dir, Borne_inf, Borne_sup, R) :-
    I is Borne_inf + 1,
    (   Axe = x ->  flipPion(Plateau, Dir, I, R2);
    flipPion(Plateau, I, Dir, R2)),
    flipPionsVersDir(R2, Axe ,Dir, I, Borne_sup, R).
    
     
flipsPionsDiag(Plateau,X1,Y1,X2,Y2, R):- ((X2>X1,Y2>Y1) ->  NbCases is X2-X1-1, flipsPionsDiagDir(Plateau,X1,Y1, xp, yp, NbCases,R);
                              (X2<X1,Y2<Y1) -> NbCases is X1-X2-1, flipsPionsDiagDir(Plateau,X2,Y2,xp,yp,NbCases,R);
                              (X2>X1,Y2<Y1) -> NbCases is X2-X1-1, flipsPionsDiagDir(Plateau,X1,Y1,xp, yn, NbCases,R);
                              NbCases is X1-X2-1, flipsPionsDiagDir(Plateau,X1,Y1, xn, yp, NbCases,R)).
     
flipsPionsDiagDir(Plateau,Borne_inf_x,Borne_inf_y, Sens_X, Sens_Y, 0, Plateau). 
    
flipsPionsDiagDir(Plateau,Borne_inf_x,Borne_inf_y, Sens_X, Sens_Y, NbCases, R):- 
    (   Sens_X = xp ->  I is Borne_inf_x + 1;
    I is Borne_inf_x - 1),
    (    Sens_Y = yp ->  J is Borne_inf_y + 1;
    J is Borne_inf_y-1),
    NbCasesNew is NbCases - 1,
    flipPion(Plateau, I, J, R2),
    flipsPionsDiagDir(R2,I,J, Sens_X, Sens_Y,NbCasesNew, R).
    

flipCases(Plateau,X1,Y1,X2,Y2, R):-
     ((X1 = X2) -> flipPionsSurLigne(Plateau, x,  X1, Y1, Y2, R);
     (Y1 = Y2) -> flipPionsSurLigne(Plateau, y, Y1, X1, X2, R);
     flipsPionsDiag(Plateau,X1,Y1,X2,Y2, R)).
 
 % ?- flipCases([v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, b, n, v, v, v, v, v, v, n, b, v, v, v, v, v, v, v, v, v, v, v,v, v, v, v, v, v, v, v,v, v, v, v, v, v, v, v], 3, 2, 3, 5, R). 

