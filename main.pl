:- include('player.pl').
:- include('quest.pl').
:- include('market.pl').

/* FACTS */
:- dynamic(role/1).
:- dynamic(exp/2).
:- dynamic(level/2).
/* Idenya waktu dihitung per 1 move = 1 hari, tp bisa diganti juga */ 
/* Goal kalo gold >= 20000 pas waktu <=365 */
:- dynamic(time/1). 
:- dynamic(gameStarted/0).



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
    write('You chose '),writeRole(X),write(', Let\'s start farming'),nl.

start :-
    !, write('Game sudah dimulai, ketik "help." untuk melihat aksi yang bisa dilakukan').

/* writeRole buat nulis di start dan update role user */
writeRole(1) :- 
    write('Fisherman'),
    baseStat('fisherman',A,B,C,D,E,F,G,H,I),!,
    asserta(player('fisherman',A,B,C,D,E,F,G,H,I)),!,
    assertz(gameStarted),!.
writeRole(2) :- 
    write('Farmer'),
    baseStat('farmer',A,B,C,D,E,F,G,H,I),!,
    asserta(player('farmer',A,B,C,D,E,F,G,H,I)),!,
    assertz(gameStarted),!.
writeRole(3) :- 
    write('Rancher'),
    baseStat('rancher',A,B,C,D,E,F,G,H,I),!,
    asserta(player('rancher',A,B,C,D,E,F,G,H,I)),!,
    assertz(gameStarted),!.

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

