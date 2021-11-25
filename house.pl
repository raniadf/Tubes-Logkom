:- dynamic(inHouse/0).

posisi(house).

house :-
    \+ gameStarted,!,
    write('Mohon mulai game terlebih dahulu dengan input start.'),nl.

house :-
    inHouse,!,
    write('Anda sudah berada di dalam house'),nl.

house :-
    /* nanti tambahin posisi udah sama ato belom*/
    gameStarted,!,
    write('- sleep'),nl,
    write('- writeDiary'),nl,
    write('- readDiary'),nl,
    write('- exit'),nl,
    assertz(inHouse).

sleep :-
    \+ gameStarted,!,
    write('Mohon mulai game terlebih dahulu dengan input start.'),nl.

sleep :-
    failState,!.

sleep :-
    \+failState,!,
    gameStarted,!,
    day(X),!,
    NEW_DAY is X + 1,
    retract(day(X)),
    asserta(day(NEW_DAY)),
    write('Anda sudah tertidur'),nl,
    format('Day ~d ~n',[NEW_DAY]).

exitHouse :-
    \+ inHouse,!,
    write('Anda sedang tidak berada di dalam rumah'),nl.

exitHouse :-
    inHouse,!,
    retract(inHouse),
    write('Anda sudah keluar dari rumah anda'),nl.


