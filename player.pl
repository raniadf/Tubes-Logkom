/* FACTS */
:- dynamic(exp/3).
:- dynamic(expFarm/3).
:- dynamic(expFish/3).
:- dynamic(expRanch/3).
:- dynamic(player/10).

/* Job, levelUpFarming, levelUpFishing, levelUpRanching */ /* FarmingTime, FishRarity, RanchingTime */
growthRate(farmer, 2, 1, 0).
growthRate(fisherman, 0, 2, 1).
growthRate(rancher, 1, 0, 2).

/* (masih ga yakin, yang ngerti perlu/gak pake baseStat boleh kabarin hehe) */
/* Base Stats di Level 1 */ 
/* Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold */
baseStat(farmer, 1, 1, 0, 1, 0, 1, 0, 0, 0).
baseStat(fisherman, 1, 1, 0, 1, 0, 1, 0, 0, 0).
baseStat(rancher, 1, 1, 0, 1, 0, 1, 0, 0, 0).

/* Pas milih class, assert player dengan baseStat dari job-nya */
/* Di main.pl saat bagian inisialisasi */
/* assertz(player(......)) */


/* RULES */
/* Initial Exp */
initialExp :-
    /* Level, Exp Before, Exp Max */
	retractall(exp(_, _, _)),
	assertz(exp(1, 0, 1)),
	retractall(expFarm(_, _, _)),
	assertz(expFarm(1, 0, 1)),
	retractall(expFish(_, _, _)),
	assertz(expFish(1, 0, 1)),
	retractall(expRanch(_, _, _)),
	assertz(expRanch(1, 0, 1)).

/* Status */
/* exp(Lv, _, Total) :- Total is 3*Lv*Lv - 2*Lv. */
status :- player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),!,
		  write('Job            : '), write(Job), nl,
		  write('Level          : '), write(Lvl), nl,
		  write('Level farming  : '), write(LvlFarm), nl,
          write('Exp farming    : '), write(ExpFarm), nl,
		  write('Level fishing  : '), write(LvlFish), nl,
		  write('Exp fishing    : '), write(ExpFish), nl,
		  write('Level ranching : '), write(LvlRanch), nl,
		  write('Exp ranching   : '), write(ExpRanch), nl,
		  write('Exp            : '), write(Exp), write('/'), exp(_, _, Max), write(Max), nl,
		  write('Gold           : '), write(Gold), nl.

/* Level Up */
/* Setiap kenaikan level umum, level specialty akan naik sesuai growthRate */
levelUp(X) :- 
	growthRate(X, A, B, C),
	player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
	retract(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold)),
	NewLvl is Lvl + 1, NewLvlFarm is LvlFarm + A, NewLvlFish is LvlFish + B, NewLvlRanch is LvlRanch + C,
	assertz(player(Job, NewLvl, NewLvlFarm, ExpFarm, NewLvlFish, ExpFish, NewLvlRanch, ExpRanch, Exp, Gold)),
    write('Congratulations! Level up!'), nl.
levelUpFarming :-
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
	retract(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold)),
	NewLvlFarm is LvlFarm + 1,
	assertz(player(Job, Lvl, NewLvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold)),
    write('You\'re getting better and better at farming. Your farming level has just leveled up!'), nl.
levelUpFishing :-
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
	retract(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold)),
	NewLvlFish is LvlFish + 1, 
	assertz(player(Job, Lvl, LvlFarm, ExpFarm, NewLvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold)),
	increaseOpportunity,
    write('You\'re getting better and better at fishing. Your fishing level has just leveled up!'), nl.
levelUpRanching :-
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
	retract(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold)),
	NewLvlRanch is LvlRanch + 1,
	assertz(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, NewLvlRanch, ExpRanch, Exp, Gold)),
    write('You\'re getting better and better at ranching. Your ranching level has just leveled up!'), nl.

/* Add Exp */
/* Menambah exp player sambil level up  */
addExp(X) :-
	exp(Lvl, Xbefore, Max), 
    NewExp is Xbefore + X,
	(X =:= 0 -> 
		write('You level up again!'), nl
	; 
		format('You gain ~d exp. ~n', [X])
	),
	(NewExp >= Max ->
		NewExp2 is NewExp - Max, NewLvl is Lvl + 1, NewMax is 3*NewLvl*NewLvl - 2*NewLvl,
		retract(exp(Lvl, Xbefore, Max)),
        assertz(exp(NewLvl, NewExp2, NewMax)),
		player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
		retract(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold)),
        /* Pada saat assertz, Lvl tidak perlu diubah menjadi NewLvl karena sudah ditanganin oleh fungsi levelUp */
        assertz(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, NewExp2, Gold)),
		levelUp(Job),
		(NewExp2 >= NewMax ->
			addExp(0)
		;
			true
		)
	; 
		Xremain is Max - NewExp,
		format('You need ~d exp to level up. ~n', [Xremain]),
		retract(exp(Lvl, Xbefore, Max)), 
        assertz(exp(Lvl, NewExp, Max)),
		player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
		retract(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold)),
        assertz(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, NewExp, Gold))
	).
/* Menambah exp farming sambil level up  */
addExpFarming(X) :-
	expFarm(LvlFarm, Xbefore, Max), 
    NewExpFarm is Xbefore + X,
	(X =:= 0 -> 
		write('Your farming skill levels up again!'), nl
	; 
		format('You gain ~d exp farming. ~n', [X])
	),
	(NewExpFarm >= Max ->
		NewExpFarm2 is NewExpFarm - Max, NewLvlFarm is LvlFarm + 1, NewMax is 3*NewLvlFarm*NewLvlFarm - 2*NewLvlFarm,
		retract(expFarm(LvlFarm, Xbefore, Max)),
        assertz(expFarm(NewLvlFarm, NewExpFarm2, NewMax)),
		player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
		retract(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold)),
        /* Pada saat assertz, LvlFarm tidak perlu diubah menjadi NewLvlFarm karena sudah ditanganin oleh fungsi levelUpFarming */
        assertz(player(Job, Lvl, LvlFarm, NewExpFarm2, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold)),
		levelUpFarming,
		(NewExpFarm2 >= NewMax ->
			addExpFarming(0)
		;
			true
		)
	; 
		Xremain is Max - NewExpFarm,
		format('You need ~d exp farming to level up. ~n', [Xremain]),
		retract(expFarm(LvlFarm, Xbefore, Max)), 
        assertz(expFarm(LvlFarm, NewExpFarm, Max)),
		player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
		retract(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold)),
        assertz(player(Job, Lvl, LvlFarm, NewExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold))
	).
/* Menambah exp fishing sambil level up  */
addExpFishing(X) :-
	expFarm(LvlFish, Xbefore, Max), 
    NewExpFish is Xbefore + X,
	(X =:= 0 -> 
		write('Your fishing skill levels up again!'), nl
	; 
		format('You gain ~d exp fishing. ~n', [X])
	),
	(NewExpFish >= Max ->
		NewExpFish2 is NewExpFish - Max, NewLvlFish is LvlFish + 1, NewMax is 3*NewLvlFish*NewLvlFish - 2*NewLvlFish,
		retract(expFish(LvlFish, Xbefore, Max)),
        assertz(expFish(NewLvlFish, NewExpFish2, NewMax)),
		player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
		retract(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold)),
        /* Pada saat assertz, LvlFish tidak perlu diubah menjadi NewLvlFish karena sudah ditanganin oleh fungsi levelUpFishing */
        assertz(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, NewExpFish2, LvlRanch, ExpRanch, Exp, Gold)),
		levelUpFishing,
		(NewExpFish2 >= NewMax ->
			addExpFishing(0)
		;
			true
		)
	; 
		Xremain is Max - NewExpFish,
		format('You need ~d exp fishing to level up. ~n', [Xremain]),
		retract(expFish(LvlFish, Xbefore, Max)), 
        assertz(expFish(LvlFish, NewExpFish, Max)),
		player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
		retract(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold)),
        assertz(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, NewExpFish, LvlRanch, ExpRanch, Exp, Gold))
	).
/* Menambah exp ranching sambil level up  */
addExpRanching(X) :-
	expRanch(LvlRanch, Xbefore, Max), 
    NewExpRanch is Xbefore + X,
	(X =:= 0 -> 
		write('Your ranching skill levels up again!'), nl
	; 
		format('You gain ~d exp ranching. ~n', [X])
	),
	(NewExpRanch >= Max ->
		NewExpRanch2 is NewExpRanch - Max, NewLvlRanch is LvlRanch + 1, NewMax is 3*NewLvlRanch*NewLvlRanch - 2*NewLvlRanch,
		retract(expRanch(LvlRanch, Xbefore, Max)),
        assertz(expRanch(NewLvlRanch, NewExpRanch2, NewMax)),
		player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
		retract(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold)),
        /* Pada saat assertz, LvlRanch tidak perlu diubah menjadi NewLvlRanch karena sudah ditanganin oleh fungsi levelUpRanching */
        assertz(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, NewExpRanch2, Exp, Gold)),
		levelUpRanching,
		(NewExpRanch2 >= NewMax ->
			addExpRanching(0)
		;
			true
		)
	; 
		Xremain is Max - NewExpRanch,
		format('You need ~d exp ranching to level up. ~n', [Xremain]),
		retract(expRanch(LvlRanch, Xbefore, Max)), 
        assertz(expRanch(LvlRanch, NewExpRanch, Max)),
		player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
		retract(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold)),
        assertz(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, NewExpRanch, Exp, Gold))
	).

/* Add Gold */
/* Menambah gold player */
addGold(X) :-
	player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    NewGold is Gold + X,
	retract(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold)), 
	assertz(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, NewGold)),
	format('You gain ~d gold. ~n', [X]).

reduceGold(X) :-
	player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    NewGold is Gold - X,
	retract(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold)), 
	assertz(player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, NewGold)).