:- include('player.pl').
:- include('inventory.pl').
:- dynamic(telur/2).
:- dynamic(susu/2).
:- dynamic(wool/2).

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
    (
        \+ haveAnimal -> write('You don\'t have any animals in your ranch'),nl;
        write('Welcome to the ranch! You have: '),nl,
        writeAnimal(chicken),!,
        writeAnimal(cow),!,
        writeAnimal(sheep),!
    ).

/* menambahkan hasil ternak setiap day tertentu */
addHasil :-
    \+ haveAnimal,!.
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
        1 =:= mod(DAY,W) -> addEgg,addMilk,addWool;

        1 =:= mod(DAY,V) -> addWool,addMilk;

        1 =:= mod(DAY,U) -> addEgg,addMilk;

        1 =:= mod(DAY,T) -> addEgg,addWool;

        1 =:= mod(DAY,X) ->addEgg;

        1 =:= mod(DAY,Y) -> addWool;

        1 =:= mod(DAY,Z) -> addMilk;
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
    \+ haveMilkCattle,!,
    write('You have to own a Milk Cattle to milk your cows'),nl.
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
    \+ haveShears,!,
    write('You have to own shears to get your wool'),nl.

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

haveShears :-
    amountItem(shears_1,A),!,
    amountItem(shears_2,B),!,
    (A > 0; B > 0).
    
haveMilkCattle :-
    amountItem(milk_pail_1,A),!,
    amountItem(milk_pail_2,B),!,
    (A > 0; B > 0).

haveAnimal :-
    amountItem(chicken,A),!,
    amountItem(sheep,B),!,
    amountItem(cow,C),!,
    (A>0;B>0;C>0).

writeAnimal(Animal) :-
    amountItem(Animal,Q),!,
    (
        Q > 0 -> format('- ~d ~w ~n',[Q,Animal]);
        !
    ).

addMilk :-
    susu(JUMLAH_SUSU,Z),
    amountItem(cow,A),!,
    DIF is 1 * A,
    JUMLAH_BARU_SUSU is JUMLAH_SUSU+ DIF,retract(susu(JUMLAH_SUSU,Z)),
    asserta(susu(JUMLAH_BARU_SUSU,Z)).
addWool :-
    wool(JUMLAH_WOOl,Y),
    amountItem(sheep,A),!,
    DIF is 1 * A,
    JUMLAH_BARU_WOOL is JUMLAH_WOOl + DIF,retract(wool(JUMLAH_WOOl,Y)),
    asserta(wool(JUMLAH_BARU_WOOL,Y)).
addEgg :-
    telur(JUMLAH_TELUR,X),
    amountItem(chicken,A),
    DIF is 1 * A,
    JUMLAH_BARU_TELUR is JUMLAH_TELUR + 1,retract(telur(JUMLAH_TELUR,X)),
    asserta(telur(JUMLAH_BARU_TELUR,X)).