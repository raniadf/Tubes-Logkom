:- include('market.pl').

/* FACTS */
:- dynamic(role/1).
:- dynamic(exp/2).
:- dynamic(level/2).
:- dynamic(gold/1).
/* Idenya waktu dihitung per 1 move = 1 hari, tp bisa diganti juga */ 
/* Goal kalo gold >= 20000 pas waktu <=365 */
:- dynamic(time/1). 
:- dynamic(gameStarted/0).


level(player,1).
level(farming,1).
level(fishing,1).
level(ranching,1).

exp(farming,0).
exp(ranching,0).
exp(fishing,0).
exp(player,0).

gold(0).
time(0).

/*  RULES */
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
    write('% 9. Status : menampilkan status pemain                                        %'),nl,
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
    write('Fisherman'),asserta(role('Fisherman')),!,assertz(gameStarted),!.
writeRole(2) :- 
    write('Farmer'),asserta(role('Farmer')),!,assertz(gameStarted),!.
writeRole(3) :- 
    write('Rancher'),asserta(role('Rancher')),!,assertz(gameStarted),!.

/* status */
status :-
    write('Your status: '),nl,
    role(Y),!,
    write('Job: '),write(Y),nl,
    level(player,Player_Level),!,
    write('Level: '),write(Player_Level),nl,
    level(farming,Farming_Level),
    write('Level farming: '),write(Farming_Level),nl,
    exp(farming,Farming_EXP),!,
    write('Exp farming: '),write(Farming_EXP),nl,
    level(fishing,Fishing_Level),
    write('Level fishing; '),write(Fishing_Level),nl,
    exp(fishing,Fishing_EXP),!,
    write('Exp fishing: '),write(Fishing_EXP),nl,
    level(ranching,Ranching_Level),
    write('Level ranching; '),write(Ranching_Level),nl,
    exp(ranching,Ranching_EXP),!,
    write('Exp ranching: '),write(Ranching_EXP),nl,
    exp(player,Player_EXP),!,
    write('Exp: '),write(Player_EXP),nl,
    gold(GOLD),!,
    write('Gold: '),write(GOLD),nl.

/* goal state*/
goalState :-
    gold(GOLD),!,time(WAKTU),!,
    GOLD >= 20000, WAKTU =< 365,
    write('Congratulations! You have finally collected 20000 golds!'),nl.

/* fail state */
failState :-
    gold(GOLD),!,time(WAKTU),!,
    GOLD =< 20000, WAKTU >= 365,
    write('You have worked hard, but in the end result is all that matters.May God bless you in the future with kind people'),nl.

/* levelUp */
levelUp(LEVEL_Category) :-
    level(LEVEL_Category,Y),!,
    Z is Y + 1,
    retract(level(LEVEL_Category,_)),
    asserta(level(LEVEL_Category,Z)).

/* addExp */
addExp(EXP_Category,Amount) :-
    exp(EXP_Category,Y),!,
    NEW_EXP is Y + Amount,
    retract(exp(EXP_Category,Y)),
    asserta(exp(EXP_Category,NEW_EXP)).

/* addGold */
addGold(Amount) :-
    gold(GOLD),!,
    NEW_GOLD is GOLD + Amount,
    retract(gold(GOLD)),
    asserta(gold(NEW_GOLD)).

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

