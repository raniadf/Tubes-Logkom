/* Diary bakal ke overwrite kalo filenya sama */

:- include('diary.pl').
:- dynamic(inHouse/0).
:- dynamic(diaryExist/1).

/* fakta diary*/ 

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
    \+inHouse,!,
    write('Anda belum masuk ke dalam Rumah').

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

writeDiary :-
    \+inHouse,!,
    write('Anda belum masuk ke dalam Rumah').

writeDiary :-
    inHouse,!,
    day(DAY),!,
    write('Note: Untuk menuliskan diary gunakan tanda \'\''),nl,
    format('Write your diary for Day ~d ~n',[DAY]),
    diaryFile(DAY,File),!,
    (
        \+ diaryExist(DAY) -> assertz(diaryExist(DAY))
    ),
    write('Input isi diary: ' ),read(X),
    write_on_file(File,X).

readDiary :-
    \+inHouse,!,
    write('Anda belum masuk ke dalam Rumah').

readDiary :-
    forall(diaryExist(DAY), format('- Day ~d~n',[DAY])),
    read(X),nl,
    diaryFile(X,File),
    format('Berikut adalah isi diary day ke ~d',[X]),nl,
    read_from_file(File).

write_on_file(File,Text) :-
    open(File,append,Stream),
    write(Stream,Text),nl,
    close(Stream).

read_from_file(File) :-
    open(File,read,Stream),
    /* get char from file*/
    get_char(Stream,Char1),
    process_stream(Char1,Stream),
    close(Stream).

process_stream(end_of_file,_) :- !.

process_stream(Char,Stream) :-
    write(Char),
    get_char(Stream,Char2),
    process_stream(Char2,Stream).