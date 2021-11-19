/* FACTS */
:- dynamic(role/2).


/*  RULES */
/* startGame */
startGame:-
    write(' _   _                           _'),nl,   
    write('| | | | __ _ _ ____   _____  ___| |_ '),nl,
    write('| |_| |/ _` | \''),write('__\\ \\ / / _ \\/ __| __|'),nl,
    write('|  _  | (_| | |  \\ V /  __/\\__ \\ |_ '),nl,
    write('|_| |_|\\__,_|_|   \\_/ \\___||___/\\__|'),nl,nl,
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
    write('Fisherman '),retractall(role(_,_)),assertz(role(user,_Fisherman)).
writeRole(2) :- 
    write('Farmer'),retractall(role(_,_)),assertz(role(user,_Farmer)).
writeRole(3) :- 
    write('Rancher'),retractall(role(_,_)),assertz(role(user,_Rancher)).

/* status */
/* belom bener harus masukin variabelnya bingung*/
status :-
    write('Your status: '),nl,
    write('Job: '),writeRole(1),nl,
    write('Level: '),nl,
    write('Level farming; '),nl,
    write('Exp farming: '),nl,
    write('Level fishing; '),nl,
    write('Exp fishing: '),nl,
    write('Level ranching; '),nl,
    write('Exp ranching: '),nl,
    write('Exp: '),nl,
    write('Gold: '),nl.