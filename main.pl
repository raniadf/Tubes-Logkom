/* FACTS */
:- dynamic(role/1).
:- dynamic(exp/2).
:- dynamic(level/2).
:- dynamic(gold/1).

level(player,1).
level(farming,1).
level(fishing,1).
level(ranching,1).

exp(farming,0).
exp(ranching,0).
exp(fishing,0).
exp(player,0).

gold(0).

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
    write('Welcome to Harvest Star. Choose your job.'),nl,
    write('1. Fisherman'),nl,
    write('2. Farmer'),nl,
    write('3. Rancher'),nl,
    write('> '),read(X),
    write('You chose '),writeRole(X),write(', Let\'s start farming'),nl.

/* writeRole buat nulis di start dan update role user */
writeRole(1) :- 
    write('Fisherman'),asserta(role('Fisherman')),!.
writeRole(2) :- 
    write('Farmer'),asserta(role('Farmer')),!.
writeRole(3) :- 
    write('Rancher'),asserta(role('Rancher')),!.

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