:- dynamic(objPeta/3). % objPeta(X, Y, Objek)

/* Deklarasi fakta */
objPeta(3, 3, 'o'). % tile air
objPeta(4, 3, 'o').
objPeta(5, 3, 'o').
objPeta(6, 3, 'o').
objPeta(4, 4, 'o').
objPeta(5, 4, 'o').
objPeta(5, 2, 'o').
objPeta(5, 2, 'o').
objPeta(4, 2, 'o').

ukuranPeta(10, 10).

/* Deklarasi rules */

/* Batas kiri */	
printObjPeta(X, Y) :- 
	ukuranPeta(_, H),
	X =:= 0,
	Y =< H+1,
	write('# '),
	NextX is X+1,
	printObjPeta(NextX, Y).

/* Batas atas */
printObjPeta(X, Y) :- 
	ukuranPeta(W, _),
	X > 0, X < W + 1,
	Y =:= 0,
	write('# '),
	NextX is X+1,
	printObjPeta(NextX, Y).

/* Batas kanan */
printObjPeta(X, Y) :- 
	ukuranPeta(W, H),
	X =:= W + 1,
	Y =< H + 1,
	write('# '), nl,
	NextY is Y+1,
	printObjPeta(0, NextY).

/* Batas bawah */				
printObjPeta(X, Y) :- 
	ukuranPeta(W, H),
	X > 0, X < W + 1,
	Y =:= H + 1,
	write('# '),
	NextX is X+1,
	printObjPeta(NextX, Y).					

/* Objek dalam peta */
printObjPeta(X, Y) :- 
	ukuranPeta(W, H),
	X > 0, X < W + 1,
	Y > 0, Y < H + 1,
	objPeta(X, Y, Obj), !,
	format('~w ', [Obj]),
	NextX is X+1,
	printObjPeta(NextX, Y).

/* Tile kosong */
printObjPeta(X, Y) :- 
	ukuranPeta(W, H),
	X > 0, X < W + 1,
	Y > 0, Y < H + 1,
	(\+ objPeta(X, Y, _)),
	write('- '),
	NextX is X+1,
	printObjPeta(NextX, Y).

randomizeLoc(X, Y) :- 	
	random(1, 10, X1), 
	random(1, 10, Y1),
	X0 is X1 - 1, X2 is X1 + 1,
	Y0 is Y1 - 1, Y2 is Y1 + 1,
	\+ (objPeta(X0, Y0, _) ; objPeta(X1, Y0, _) ; objPeta(X2, Y0, _) ; 
	objPeta(X0, Y1, _) ; objPeta(X1, Y1, _) ; objPeta(X2, Y1, _) ;
	objPeta(X0, Y2, _) ; objPeta(X1, Y2, _) ; objPeta(X2, Y2, _)), !,
	X is X1, 
	Y is Y1;
	randomizeLoc(X, Y).

createPlayer :- 	
	randomizeLoc(X, Y),
	assertz(objPeta(X, Y, 'P')).

createHouse :-
	randomizeLoc(X, Y),
	assertz(objPeta(X, Y, 'H')).

createRanch :-
	randomizeLoc(X, Y),
	assertz(objPeta(X, Y, 'R')).

createQuest :-
	randomizeLoc(X, Y),
	assertz(objPeta(X, Y, 'Q')).

createMarketplace :-
	randomizeLoc(X, Y),
	assertz(objPeta(X, Y, 'M')).

createMap :- /* inisialisasi peta */
	createPlayer,
	createHouse,
	createRanch,
	createQuest,
	createMarketplace.

map :- 	
	% startGame(false), !, 
	% write('Game belum dimulai! Ketik \'start.\' untuk memulai.');
	printObjPeta(0, 0).

digTile :- %convert '-' ke '=', ada restriksi tile atasnya harus bukan object.
	objPeta(X, Y, 'P'),
	UpperY is Y - 1,
	(Y > 1, \+objPeta(X,UpperY,'o'),\+objPeta(X,UpperY,'H'),\+objPeta(X,UpperY,'R'),\+objPeta(X,UpperY,'Q'),\+objPeta(X,UpperY,'M') ), !,
	asserta(objPeta(X, UpperY, 'P')),
	asserta(objPeta(X,Y,'=')),
	retract(objPeta(X, Y, 'P')),!.

digTile :-
	write('Pastikan tiles di atas bisa diakses !').

plantCropC :-
	objPeta(X, Y, '='),
	UpperY is Y - 1,
	(Y > 1, \+objPeta(X,UpperY,'o'),\+objPeta(X,UpperY,'H'),\+objPeta(X,UpperY,'R'),\+objPeta(X,UpperY,'Q'),\+objPeta(X,UpperY,'M') ), !,
	asserta(objPeta(X, UpperY, 'P')),
	asserta(objPeta(X,Y,'c')),
	retract(objPeta(X, Y, 'P')),!.
	
plantCropC :-
	write('Pastikan tiles di atas bisa diakses !').

plantCropSp :-
	objPeta(X, Y, '='),
	UpperY is Y - 1,
	(Y > 1, \+objPeta(X,UpperY,'o'),\+objPeta(X,UpperY,'H'),\+objPeta(X,UpperY,'R'),\+objPeta(X,UpperY,'Q'),\+objPeta(X,UpperY,'M') ), !,
	asserta(objPeta(X, UpperY, 'P')),
	asserta(objPeta(X,Y,'sp')),
	retract(objPeta(X, Y, 'P')),!.
plantCropSp :-
	write('Pastikan tiles di atas bisa diakses !').

plantCropCs :-
	objPeta(X, Y, '='),
	UpperY is Y - 1,
	(Y > 1, \+objPeta(X,UpperY,'o'),\+objPeta(X,UpperY,'H'),\+objPeta(X,UpperY,'R'),\+objPeta(X,UpperY,'Q'),\+objPeta(X,UpperY,'M') ), !,
	asserta(objPeta(X, UpperY, 'P')),
	asserta(objPeta(X,Y,'cs')),
	retract(objPeta(X, Y, 'P')),!.

plantCropCs :-
	write('Pastikan tiles di atas bisa diakses !').

plantCropCr :-
	objPeta(X, Y, '='),
	UpperY is Y - 1,
	(Y > 1, \+objPeta(X,UpperY,'o'),\+objPeta(X,UpperY,'H'),\+objPeta(X,UpperY,'R'),\+objPeta(X,UpperY,'Q'),\+objPeta(X,UpperY,'M') ), !,
	asserta(objPeta(X, UpperY, 'P')),
	asserta(objPeta(X,Y,'cr')),
	retract(objPeta(X, Y, 'P')),!.

plantCropCr :-
	write('Pastikan tiles di atas bisa diakses !').

plantCropT :-
	objPeta(X, Y, '='),
	UpperY is Y - 1,
	(Y > 1, \+objPeta(X,UpperY,'o'),\+objPeta(X,UpperY,'H'),\+objPeta(X,UpperY,'R'),\+objPeta(X,UpperY,'Q'),\+objPeta(X,UpperY,'M') ), !,
	asserta(objPeta(X, UpperY, 'P')),
	asserta(objPeta(X,Y,'t')),
	retract(objPeta(X, Y, 'P')),!.

plantCropT :-
	write('Pastikan tiles di atas bisa diakses !').

plantCropP :-
	objPeta(X, Y, '='),
	UpperY is Y - 1,
	(Y > 1, \+objPeta(X,UpperY,'o'),\+objPeta(X,UpperY,'H'),\+objPeta(X,UpperY,'R'),\+objPeta(X,UpperY,'Q'),\+objPeta(X,UpperY,'M') ), !,
	asserta(objPeta(X, UpperY, 'P')),
	asserta(objPeta(X,Y,'p')),
	retract(objPeta(X, Y, 'P')),!.

plantCropP :-
	write('Pastikan tiles di atas bisa diakses !').


/* Command Move */
/* Move ke atas */
w :-
  	\+ gameStarted, !,
	write('Game belum dimulai! Ketik \'start.\' untuk memulai.').

w :-
	objPeta(X, Y, 'P'),
	UpperY is Y - 1,
	(Y > 1, \+objPeta(X,UpperY,'o')), !,
	asserta(objPeta(X, UpperY, 'P')),
	retract(objPeta(X, Y, 'P')),addDay,!.

w :-
	write('Ada tembok atau air di atas. Ketik \'map.\' untuk melihat map.').

/* Move ke kiri */
a :-
  	\+ gameStarted, !,
 	write('Game belum dimulai! Ketik \'start.\' untuk memulai.').

a :-
	objPeta(X, Y, 'P'),
	WesterX is X - 1,
	(X > 1, \+objPeta(WesterX,Y,'o')), !,
	asserta(objPeta(WesterX, Y, 'P')),
	retract(objPeta(X, Y, 'P')), addDay,!.

a :-
	write('Ada tembok atau air di kiri. Ketik \'map.\' untuk melihat map.').

/* Move ke bawah */
s :-
  	\+gameStarted, !,
 	write('Game belum dimulai! Ketik \'start.\' untuk memulai.').

s :- objPeta(X,Y,'P'), NewY is Y + 1, objPeta(X,NewY,'o'), write('Ada air di bawah. Ketik \'map.\' untuk melihat map.').
s :-
	objPeta(X, Y, 'P'),
	LowerY is Y + 1,
	ukuranPeta(_,Lowest),
	(Y < Lowest, \+objPeta(X,LowerY,'o')), !,
	asserta(objPeta(X, LowerY, 'P')),
	retract(objPeta(X, Y, 'P')), addDay,!.

s :-
	write('Ada tembok atau air di bawah. Ketik \'map.\' untuk melihat map.').

/* Move ke kanan */
d :-
  	\+gameStarted, !,
 	write('Game belum dimulai! Ketik \'start.\' untuk memulai.').

d :-
	objPeta(X, Y, 'P'),
	ukuranPeta(Eastest,_),
	EasterX is X + 1,
	(X < Eastest, \+objPeta(EasterX,Y,'o')), !,
	asserta(objPeta(EasterX, Y, 'P')),
	retract(objPeta(X, Y, 'P')), addDay,!.

d :-
	write('Ada tembok atau air di kanan. Ketik \'map.\' untuk melihat map.').

isNearWater(Hasil) :-
    objPeta(X,Y,'P'),
    (UpperY is Y - 1, objPeta(X,UpperY,'o') -> Hasil = 'true';
    LowerY is Y + 1, objPeta(X,LowerY,'o') -> Hasil = 'true';
    WesterX is X - 1, objPeta(WesterX,Y,'o') -> Hasil = 'true';
    EasterX is X + 1, objPeta(EasterX,Y,'o') -> Hasil = 'true';
    Hasil = 'false').

isOnRanch(Hasil) :-
    objPeta(X,Y,'P'), objPeta(X,Y,'R'), Hasil = 'true'.

isOnHouse(Hasil) :-
    objPeta(X,Y,'H'), objPeta(X,Y,'P'), Hasil = 'true'.

isOnMarket(Hasil) :-
    objPeta(X,Y,'M'), objPeta(X,Y,'P'), Hasil = 'true', assertz(inMarket).

isDigable(Hasil) :-
    +isOnMarket('true'), +isOnRanch('true'), + (objPeta(X,Y,'P'), objPeta(X,Y,'o')), Hasil = 'true'.

isFarmable(Hasil) :-
    objPeta(X,Y,'P'), objPeta(X,Y,'='), Hasil = 'true'.

checkLocation :-
    (isOnMarket('true') -> market;
    isOnRanch('true') -> ranching;
    !).