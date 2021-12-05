:- include('player.pl').
:- include('quest.pl').
:- include('market.pl').
:- include('items.pl').
:- include('house.pl').
:- include('ranching.pl').
:- include('inventory.pl').
:- include('map.pl').
:- include('fishing.pl').
:- include('farming.pl').

/* FACTS */
/* Idenya waktu dihitung per 1 move = 1 hari, tp bisa diganti juga */ 
/* Goal kalo gold >= 20000 pas day <=365 */
:- dynamic(day/1). 
:- dynamic(gameStarted/0).

day(1).



/* RULES */
/* startGame */
startGame:-
    write(' _   _                           _'),nl,   
    write('| | | | __ _ _ ____   _____  ___| |_ '),nl,
    write('| |_| |/ _` | \'__\\ \\ / / _ \\/ __| __|'),nl,
    write('|  _  | (_| | |   \\ V /  __/\\__ \\ |_ '),nl,
    write('|_| |_|\\__,_|_|    \\_/ \\___||___/\\__|'),nl,nl,
    write('Harvest Star!!!'),nl,nl,
    write('Let\'s play and pay our debts together!'),nl,nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl,
    write('%                              ~Harvest Star~                                  %'),nl,
    write('% 1. start  : untuk memulai petualanganmu                                      %'),nl,
    write('% 2. map    : menampilkan peta                                                 %'),nl,
    write('% 3. status : menampilkan kondisimu terkini                                    %'),nl,
    write('% 4. w      : gerak ke utara 1 langkah                                         %'),nl,
    write('% 5. s      : gerak ke selatan 1 langkah                                       %'),nl,
    write('% 6. d      : gerak ke timur 1 langkah                                         %'),nl,
    write('% 7. a      : gerak ke barat 1 langkah                                         %'),nl,
    write('% 8. help   : menampilkan segala bantuan                                       %'),nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl.

/* start*/
start:-
    \+ gameStarted,!,
    write('Welcome to Harvest Star. Choose your job.'),nl,
    write('1. Fisherman'),nl,
    write('2. Farmer'),nl,
    write('3. Rancher'),nl,
    write('> '),read(X),
    write('You chose '),writeRole(X),write(', Let\'s start farming!'),nl.

start :-
    !, write('Game has already been started, use \'help\' to show commands').

/* writeRole buat nulis di start dan update role user */
writeRole(1) :- 
    write('Fisherman'),
    baseStat('fisherman',A,B,C,D,E,F,G,H,I),!,
    asserta(player('fisherman',A,B,C,D,E,F,G,H,I)),!,
    initialExp,
    assertz(gameStarted), createMap, !.
writeRole(2) :- 
    write('Farmer'),
    baseStat('farmer',A,B,C,D,E,F,G,H,I),!,
    asserta(player('farmer',A,B,C,D,E,F,G,H,I)),!,
    initialExp,
    assertz(gameStarted),createMap,!.
writeRole(3) :- 
    write('Rancher'),
    baseStat('rancher',A,B,C,D,E,F,G,H,I),!,
    asserta(player('rancher',A,B,C,D,E,F,G,H,I)),!,
    initialExp,
    assertz(gameStarted),createMap, !.

/* status */
help :-
    \+ gameStarted,!,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl,
    write('%                              ~Harvest Star~                                  %'),nl,
    write('%    1. startGame -> lihat info command dasar pada game                        %'),nl,
    write('%    2. start     -> memulai game                                              %'),nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl.

help :-
    inMarket,!,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl,
    write('%                              ~Harvest Star~                                  %'),nl,
    write('%    1. buy       -> membeli item                                              %'),nl,
    write('%    2. sell      -> menjual item                                              %'),nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl.

help :-
    inHouse,!,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl,
    write('%                              ~Harvest Star~                                  %'),nl,
    write('%    1. sleep       -> tidur, lanjut ke hari selanjutnya                       %'),nl,
    write('%    2. writeDiary  -> menulis diary untuk hari ini                            %'),nl,
    write('%    3. readDiary   -> membaca diary yang sudah pernah ditulis                 %'),nl,
    write('%    4. exitHouse   -> keluar dari house                                       %'),nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl.

help :-
    gameStarted,!,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl,
    write('%                              ~Harvest Star~                                  %'),nl,
    write('%    1. map       -> menampilkan map                                           %'),nl,
    write('%    2. inventory -> menampilkan inventory                                     %'),nl,
    write('%    3. w         -> bergerak ke atas                                          %'),nl,
    write('%    4. a         -> bergerak ke kiri                                          %'),nl,
    write('%    5. s         -> bergerak ke bawah                                         %'),nl,
    write('%    6. d         -> bergerak ke kanan                                         %'),nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl.


addDay :-
    day(DAY),!,
    NEW_DAY is DAY + 1,
    retract(day(DAY)),
    asserta(day(NEW_DAY)),
    (
        \+ failState -> addHasil;
        !
    ).

goalState :-
    player(_,_,_,_,_,_,_,_,_,GOLD),!,
    day(DAY),!,
    DAY =< 365,GOLD >= 20000,
    write('Congratulations! You have finally collected 20000 golds!'),nl,
    write('You have finished the game!'),nl,
    retract(gameStarted).

failState :-
    player(_,_,_,_,_,_,_,_,_,GOLD),!,
    day(DAY),!,
    DAY > 365,GOLD < 20000,
    write('You have worked hard, but in the end result is all that matters. May God bless you in the future with kind people!'),retract(gameStarted),nl.
