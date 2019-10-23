% Primitive gestion board

% Met dans RESULT la valeur LIST[X][Y]
case(X, Y, LIST, RESULT) :-
    X < 8, X >= 0,
    Y < 8, Y >= 0,
    Z is X * 8 + Y,
    nth0(Z, LIST, RESULT).
    
% Remplace ma valeur MAT[X][Y] par NEW et renvoi RESULT_MAT la nouvelle MAT
remplace(X, Y, NEW, MAT, RESULT_MAT) :-
    Z is X * 8 + Y,
    nth0(Z, MAT, _, TEMP),
    nth0(Z, RESULT_MAT, NEW, TEMP).

% Print board
print_matrice([]).
print_matrice([H1,H2,H3,H4,H5,H6,H7,H8|Matrice]) :-
    format('~w ~w ~w ~w ~w ~w ~w ~w~n', [H1,H2,H3,H4,H5,H6,H7,H8]),
    print_matrice(Matrice).

% Renvoi true si liste non vide
listeNonVide([_|_]).

% Primitive Afficher resultat

count([],_,0).
count([C|R],C,X) :- count(R,C,Y), X is 1+Y.
count([_|R],C,X) :- count(R,C,X).

% Var Primitive

estEgal(A,B):-
    A=B.

estPleine(A) :-
    A\=v.

estVide(A) :-
    A=v.
    
affectation(A, A).

recupererX([X|_], X).
recupererY([_|A], Y) :-
    unlist(A, Y).

unlist([A], A).

% Color Primitive

reverseCouleur(A, B) :-
    (A = b -> B = n;
        A = n -> B = b;
    false).
    
% List Primitive

listButLast([X|Y], RList) :-                 
   listButLastPrev(Y, RList, X).

listButLastPrev([], [], _).
listButLastPrev([X1|Y], [X0|RList], X0) :-  
   listButLastPrev(Y, RList, X1).