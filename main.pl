% Primitive gestion board

% Met dans RESULT la valeur LIST[X][Y]
case(X, Y, LIST, RESULT) :-
    Z is X * 8 + Y,
    nth0(Z, LIST, RESULT).

% Remplace ma valeur LIST[X][Y] par NEW et renvoi RESULT_LIST la nouvelle LIST
replace(X, Y, NEW, LIST, RESULT_LIST) :-
    Z is X * 8 + Y,
    nth0(Z, LIST, _, TEMP),
    nth0(Z, RESULT_LIST, NEW, TEMP).

% Print board
print_matrice([]).
print_matrice([H1,H2,H3,H4,H5,H6,H7,H8|Matrice]) :-
    format('~w ~w ~w ~w ~w ~w ~w ~w~n', [H1,H2,H3,H4,H5,H6,H7,H8]),
    print_matrice(Matrice).

% Init board
init_board(MAT) :-
    MAT = [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, b, n, v, v, v, v, v, v, n, b, v, v, v, v, v, v, v, v, v, v, v,v, v, v, v, v, v, v, v,v, v, v, v, v, v, v, v].

main :-
    init_board(MAT),
    print_matrice(MAT),
    replace(0, 0, b, MAT, RESULT_MAT),
    print_matrice(RESULT_MAT).
