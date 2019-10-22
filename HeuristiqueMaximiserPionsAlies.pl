%case(X, Y, LIST, RESULT) :-
%    Z is X * 8 + Y,
%    nth0(Z , LIST, RESULT).

%flipPion(Plateau, X, Y, Ymax, R, N):-
%     case(X, Y, Plateau, Z),
%     (Z = 'n' -> replace(X, Y, 'b', Plateau, R2);
%     Z = 'b' -> replace(X, Y, 'n', Plateau, R2);
%     fail),
%        Y2 is Y + 1, N is N + 1,
%        flipPion(R2, X, Y2, Ymax, R, N).        
     
%flipPionsSurLigne(Plateau,Dir, Borne1, Borne2, R, N) :- 
%    ((Borne2>Borne1) -> Borne_inf is Borne1+1, Borne_sup is Borne2, flipPionsVersDir(Plateau,Dir, Borne_inf, Borne_sup, R, N);
%     Borne_inf is Borne2+1, Borne_sup is Borne1-1,flipPionsVersDir(Plateau,Dir, Borne_inf, Borne_sup, R)).
     
%flipPionsVersDir(Plateau,Dir, Borne_inf, Borne_sup, R, N) :-
%    	flipPion(Plateau,Dir, Borne_inf, Borne_sup, R, N).
%%%%%%%%%%%%%%%%QUESAKO?????   
%between(Borne_inf, Borne_sup, I),
    %                      flipPion(R,Dir,I, R),
    %                           I=Borne_sup.
%%%%%%%%%%%%%%%%
     
%flipsPionsDiag(Plateau,X1,Y1,X2,Y2, R, N):- ((X2>X1,Y2>Y1) ->  A1 is X1+1, B1 is Y1+1, NbCases is X2-1-A1, flipsPionsDiagDir(Plateau,A1,B1,NbCases,R,N);
%                              (X2<X1,Y2<Y1) -> A1 is X2+1, B1 is Y2+1, NbCases is A1-X2-1, flipsPionsDiagDir(Plateau,A1,B1,NbCases,R,N);
%                              (X2>X1,Y2<Y1) -> A1 is X1+1, B1 is Y2+1, NbCases is X2-1-A1, flipsPionsDiagDir(Plateau,A1,B1,NbCases,R,N);
%                              A1 is X2+1, B1 is Y1+1, NbCases is A1-X2-1, flipsPionsDiagDir(Plateau,A1,B1,NbCases,R,N)).
                              
%flipsPionsDiagDir(Plateau,Borne_inf_x,Borne_inf_y, NbCases, R, N):-    
%    between(0, NbCases, I),  
%   (   X is Borne_inf_x + I, Y is Borne_inf_y + I, 

%    I=NbCases).

%nbFlipCases(Plateau,X1,Y1,X2,Y2, R, N):-
%     ((X1 = X2) -> flipPionsSurLigne(Plateau, X1, Y1, Y2, R, N);
%     (Y1 = Y2) -> flipPionsSurLigne(Plateau, Y1, X1, X2, R,N);
%     flipsPionsDiag(Plateau,X1,Y1,X2,Y2, R,N)).


%S'inspirer de tryFlipCases
%croix(Plateau, X, Y, Couleur, [X1, Y1], NB) :-
      %((horizontale(Plateau, X, Y, Couleur, YTrouve), X1 is X, Y1 is YTrouve);
      %(verticale(Plateau, X, Y, Couleur, XTrouve), X1 is XTrouve, Y1 is Y);
      %(diagonale(Plateau, X, Y, Couleur, XTrouve, YTrouve), X1 is XTrouve, Y1 is YTrouve);),
      %nbFlipCases(Plateaun X, Y, X1, Y1, N),
      %NB is NB + N.
% n est le nouveau paramètre qui retourne le nombre de cases retournées

%HeuristiqueMaximiserPionsAlies(plateau, couleur, listeCoup,case) :-
    %for each case de listeCoup
    %croix(Plateau,X,Y,Couleur, [X1, Y1],N).
