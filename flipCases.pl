
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
     
flipPionsSurLigne(Plateau,Dir, Borne1, Borne2, R) :- 
    ((Borne2>Borne1) -> Borne_inf is Borne1+1, Borne_sup is Borne2-1, flipPionsVersDir(Plateau,Dir, Borne_inf, Borne_sup, R);
     Borne_inf is Borne2+1, Borne_sup is Borne1-1,flipPionsVersDir(Plateau,Dir, Borne_inf, Borne_sup, R)).
     
flipPionsVersDir(Plateau,Dir, Borne_inf, Borne_sup, R) :- between(Borne_inf, Borne_sup, I),
                          flipPion(Plateau,Dir,I, R),
                                I=Borne_sup.
     
flipsPionsDiag(Plateau,X1,Y1,X2,Y2, R):- ((X2>X1,Y2>Y1) ->  A1 is X1+1, B1 is Y1+1, NbCases is X2-1-A1, flipsPionsDiagDir(Plateau,A1,B1,NbCases,R);
                              (X2<X1,Y2<Y1) -> A1 is X2+1, B1 is Y2+1, NbCases is A1-X2-1, flipsPionsDiagDir(Plateau,A1,B1,NbCases,R);
                              (X2>X1,Y2<Y1) -> A1 is X1+1, B1 is Y2+1, NbCases is X2-1-A1, flipsPionsDiagDir(Plateau,A1,B1,NbCases,R);
                              A1 is X2+1, B1 is Y1+1, NbCases is A1-X2-1, flipsPionsDiagDir(Plateau,A1,B1,NbCases,R)).
                              
flipsPionsDiagDir(Plateau,Borne_inf_x,Borne_inf_y, NbCases, R):-    
    between(0, NbCases, I),  
    (   X is Borne_inf_x + I, Y is Borne_inf_y + I, 
    flipPion(Plateau,X,Y, R), Plateau is R),
    I=NbCases.

flipCases(Plateau,X1,Y1,X2,Y2, R):-
     ((X1 = X2) -> flipPionsSurLigne(Plateau, X1, Y1, Y2, R);
     (Y1 = Y2) -> flipPionsSurLigne(Plateau, Y1, X1, X2, R);
     flipsPionsDiag(Plateau,X1,Y1,X2,Y2, R)).  
     
 flipCases([v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, b, n, v, v, v, v, v, v, n, b, v, v, v, v, v, v, v, v, v, v, v,v, v, v, v, v, v, v, v,v, v, v, v, v, v, v, v], 3, 2, 3, 5, R). 


