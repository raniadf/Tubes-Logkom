:- include('player.pl').
:- include('inventory.pl').
:- dynamic(telur/2).
:- dynamic(susu/2).
:- dynamic(wool/2).

animal(ayam,3).
animal(sapi,2).
animal(domba,3).

/* barang(jumlah,waktu yang diperlukan) */
telur(0,2).
susu(0,5).
wool(0,3).


ranching :-
    \+ gameStarted,!,
    write('Mohon mulai game terlebih dahulu dengan input start.'),nl.

ranching :-
   \+ isOnRanch('true'),!,
   write('You have to go to the ranch first'),nl.

ranching :-
    isOnRanch('true'),!,
    /* cocokin posisi player sama ranch */
    write('Selamat datang di ranch! anda memiliki:'),nl,
    forall(animal(Y,X), format('- ~d ~w ~n',[X,Y])).

/* menambahkan hasil ternak setiap day tertentu */
addHasil :-
    day(DAY),!,
    telur(JUMLAH_TELUR,X),
    wool(JUMLAH_WOOl,Y),
    susu(JUMLAH_SUSU,Z),
    W is X * Y * Z,
    V is Y * Z,
    U is X * Z,
    T is X * Y,

    (
        1 =:= mod(DAY,W) -> JUMLAH_BARU_TELUR is JUMLAH_TELUR + 1,retract(telur(JUMLAH_TELUR,X)),
        asserta(telur(JUMLAH_BARU_TELUR,X)),JUMLAH_BARU_WOOL is JUMLAH_WOOl + 1,retract(wool(JUMLAH_WOOl,Y)),
        asserta(wool(JUMLAH_BARU_WOOL,Y)),JUMLAH_BARU_SUSU is JUMLAH_SUSU+ 1,retract(susu(JUMLAH_SUSU,Z)),
        asserta(susu(JUMLAH_BARU_SUSU,Z));

        1 =:= mod(DAY,V) -> JUMLAH_BARU_WOOL is JUMLAH_WOOl + 1,retract(wool(JUMLAH_WOOl,Y)),
        asserta(wool(JUMLAH_BARU_WOOL,Y)),JUMLAH_BARU_SUSU is JUMLAH_SUSU+ 1,retract(susu(JUMLAH_SUSU,Z)),
        asserta(susu(JUMLAH_BARU_SUSU,Z));

        1 =:= mod(DAY,U) -> JUMLAH_BARU_TELUR is JUMLAH_TELUR + 1,retract(telur(JUMLAH_TELUR,X)),
        asserta(telur(JUMLAH_BARU_TELUR,X)),JUMLAH_BARU_SUSU is JUMLAH_SUSU+ 1,retract(susu(JUMLAH_SUSU,Z)),
        asserta(susu(JUMLAH_BARU_SUSU,Z));

        1 =:= mod(DAY,T) -> JUMLAH_BARU_TELUR is JUMLAH_TELUR + 1,retract(telur(JUMLAH_TELUR,X)),
        asserta(telur(JUMLAH_BARU_TELUR,X)),JUMLAH_BARU_WOOL is JUMLAH_WOOl + 1,retract(wool(JUMLAH_WOOl,Y)),
        asserta(wool(JUMLAH_BARU_WOOL,Y));

        1 =:= mod(DAY,X) ->JUMLAH_BARU is JUMLAH_TELUR + 1,retract(telur(JUMLAH_TELUR,X)),
        asserta(telur(JUMLAH_BARU,X));

        1 =:= mod(DAY,Y) -> JUMLAH_BARU is JUMLAH_WOOl + 1,retract(wool(JUMLAH_WOOl,Y)),
        asserta(wool(JUMLAH_BARU,Y));

        1 =:= mod(DAY,Z) -> JUMLAH_BARU is JUMLAH_SUSU+ 1,retract(susu(JUMLAH_SUSU,Z)),
        asserta(susu(JUMLAH_BARU,Z));
        !
    ).

/* hasilnya belum di insert ke inventory */
chicken :-
    telur(JUMLAH_TELUR,X),
    (
        0 =:= JUMLAH_TELUR -> write('Your chicken has not layed any eggs.'),nl,
        write('Please check again later.'),nl;

        0 < JUMLAH_TELUR -> format('Your chicken layed ~d eggs! ~n',[JUMLAH_TELUR]),
        format('You got ~d eggs!~n',[JUMLAH_TELUR]),
        EXP is JUMLAH_TELUR * 2,
        addExpRanching(EXP),
        retract(telur(JUMLAH_TELUR,X)),
        asserta(telur(0,X)),
        addItem(chicken_egg,JUMLAH_TELUR)
    ).

cow :-
    susu(JUMLAH_SUSU,X),
    (
        0 =:= JUMLAH_SUSU -> write('Your cow hasn’t produced any milk.'),nl,
        write('Please check again later.'),nl;

        0 < JUMLAH_SUSU -> format('Your cow produced ~d milk! ~n',[JUMLAH_SUSU]),
        format('You fot ~d milk!~n',[JUMLAH_SUSU]),
        EXP is JUMLAH_SUSU * 5,
        addExpRanching(EXP),
        retract(susu(JUMLAH_SUSU,X)),
        asserta(susu(0,X)),
        addItem(susu,JUMLAH_SUSU)
    ).

sheep :-
    wool(JUMLAH_WOOl,X),
    (
        0 =:= JUMLAH_WOOl -> write('Your sheep hasn’t produced any wool.'),nl,
        write('Please check again later.');
        0 < JUMLAH_WOOl -> format('Your sheep produced ~d wool! ~n',[JUMLAH_WOOl]),
        format('You got ~d wool!~n',[JUMLAH_WOOl]),
        EXP is JUMLAH_WOOl * 3,
        addExpRanching(EXP),
        retract(wool(JUMLAH_WOOl,X)),
        asserta(wool(0,X)),
        addItem(wool,JUMLAH_WOOl)
    ). 

/* ini belom selesai nanti tambahin di addExpRanching */
reduceRanchTime :-
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),!,
    (
        LvlRanch =:= 3 -> telur(X,TIME),NEW_TIME is TIME-1, retract(telur(X,TIME)), asserta(telur(X,NEW_TIME));
        LvlRanch =:= 5 -> wool(X,TIME_WOOL),NEW_TIME_WOOL is TIME_WOOL-1, retract(wool(X,TIME_WOOL)), asserta(wool(X,NEW_TIME_WOOL)),
        susu(X,TIME_SUSU),NEW_TIME_SUSU is TIME_SUSU-1, retract(susu(X,TIME_SUSU)), asserta(susu(X,NEW_TIME_SUSU));
        LvlRanch =:= 7 -> susu(X,TIME_SUSU),NEW_TIME_SUSU is TIME_SUSU-1, retract(susu(X,TIME_SUSU)), asserta(susu(X,NEW_TIME_SUSU));
        !
    ).