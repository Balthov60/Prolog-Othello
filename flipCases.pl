flipCases(X1,Y1,X2,Y2):-
     ((X1 is X2) -> flipPionsSurLigne(X1, Y1, Y2);
     (Y1 is Y2) -> flipPionsSurLigne(Y1, X1, X2);
     flipsPionsDiag(X1,Y1,X2,Y2)).  
         
     
flipPionsSurLigne(Dir, Borne1, Borne2) :- 
    ((Borne2>Borne1) -> Borne_inf is Borne1+1, Borne_sup is Borne2-1, flipPionsVersDir(Dir, Borne_inf, Borne_sup);
     Borne_inf is Borne2+1, Borne_sup is Borne1-1,flipPionsVersDir(Dir, Borne_inf, Borne_sup)).
     
flipPionsVersDir(Dir, Borne_inf, Borne_sup) :- between(Borne_inf, Borne_sup, I),
         									flipUneCase(Dir,I),
                    						false.
     
flipsPionsDiag(X1,Y1,X2,Y2):- ((X2>X1,Y2>Y1) ->  flipsPionsDiagDir(X1,Y1,X2,Y2);
                              (X2<X1,Y2<Y1) ->  flipsPionsDiagDir(X2,Y2,X1,Y1);
                              (X2>X1,Y2<Y1) ->  flipsPionsDiagDir(X1,Y2,X2,X1);
                              flipsPionsDiagDir(X2,Y1,X1,Y2)).
                              
flipsPionsDiagDir(Borne_inf_x,Borne_inf_y,Borne_sup_x,Borne_sup_y):-
    between(Borne_inf_x, Borne_sup_x, X),  
    between(Borne_inf_y, Borne_sup_y, Y),
    flipUneCase(X,Y),
    false,
    false.
                
