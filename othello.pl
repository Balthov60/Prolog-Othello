initialize(Game, Position, Player).

play(Game) :- 
	initialize(Game, Position, Player),
	display(Position, Player),
	play(Position, Player, Result).
	
play(Position, Player, Result) :- 
	game_over(Position, Player, Result), !, announce(Result).

play(Position, Player, Result) :-
	choose_move(Position, Player, Move),
	move(Move, Position, Position1),
	display_game(Position1, Player),
	next_player(Player, Player1),
	!, play(Position1, Player1, Result).% S'il y a un moyen de jouer alors on joue
	
evaluate_and_choose([Move|Moves], Position, Record, BestMove) :-
	% choisir le BestMove dans l'ensemble des Moves à partir de la position courante ; 
	% Record enregistre le meilleur mouvement courant
	move(Move, Position, Position1),
	value(Position1, Value),
	update(Move, Value, Record, Record1),
	evaluate_and_choose(Moves, Position, Record1, BestMove).
	
evaluate_and_choose([], Position, (Move, Value), Move).

update(Move, Value, (Move1, Value1), (Move1,Value1)) :-
	Value := Value1.
	
update(Move, Value, (Move1,Value1), (Move,Value)) :-
	Value > Value1.
	
choose_move(Position, Computer, Move) :-
	set_of(M, move(Position, M), Moves),
	evaluate_and_choose(Moves, Position, (nil, -1000), Move).
	
% move(Position, Move) <-
% TODO ce prédicat doit être vrai si Move est un mouvement possible à partir de la position courante


% evaluate_and_choose(Moves, Position, Depth, Flag, Record, BestMove) <-
%	choisir le BestMove parmi l'ensemble des Moves à partir de la Position courante en utilisant l'algorithme minimax,
%	anticipant de Depth strates Flag, indique si l'on minimise ou si l'on maximise couramment.
%	Record enregistre le meilleur mouvement courant

evaluate_and_choose([Move|Moves], Position, D, MaxMin, Record, Best) :- 
	move(Move, Position, Position1),
	minimax(D, Position1, MaxMin, MoveX, Value),
	update(Move, Value, Record, Record1),
	evaluate_and_choose(Moves, Position, D, MaxMin, Record1, Best).
	
evaluate_and_choose([], Position, D, MaxMin, Record, Record).

minimax(0, Position, MaxMin, Move, Value) :-
	value(Position, V),
	Value := V * MaxMin.
	
minimax(D, Position, MaxMin, Move, Value) :-
	D > 0,
	set_of(M, move(Position, M), Moves),
	D1 := D - 1,
	MinMax := -MaxMin,
	evaluate_and_choose(Moves, Position, D1, MinMax, (nil, -1000), (Move, Value)).
	
%update(Move, Value, Record, Record1)
% cf au dessus 