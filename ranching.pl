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
    /* cocokin posisi player sama ranch */
    write('Selamat datang di ranch! anda memiliki:'),nl,
    forall(animal(Y,X), format('- ~d ~w ~n',[X,Y])).

/* menambahkan hasil ternak setiap day tertentu */
addHasil :-
    day(DAY),!,
    telur(JUMLAH_TELUR,X),
    wool(JUMLAH_WOOl,Y),
    susu(JUMLAH_SUSU,Z),
    (
        0 =:= mod(DAY,X) ->JUMLAH_BARU is JUMLAH_TELUR + 1,retract(telur(JUMLAH_TELUR,X)),
        asserta(telur(JUMLAH_BARU,X));

        0 =:= mod(DAY,Y) -> JUMLAH_BARU is JUMLAH_WOOl + 1,retract(wool(JUMLAH_WOOl,Y)),
        asserta(wool(JUMLAH_BARU,X));

        0 =:= mod(DAY,Z) -> JUMLAH_BARU is JUMLAH_SUSU+ 1,retract(susu(JUMLAH_SUSU,Z)),
        asserta(susu(JUMLAH_BARU,X))
    ).

/* hasilnya belum di insert ke inventory */
chicken :-
    telur(JUMLAH_TELUR,X),
    (
        0 =:= JUMLAH_TELUR -> write('Ayam anda belum menghasilkan telur'),nl,
        write('Periksa lagi di lain waktu'),nl;

        0 < JUMLAH_TELUR -> format('Ayam anda menghasilkantelur! ~n',[JUMLAH_TELUR]),
        format('Anda memperoleh ~d telur!~n',[JUMLAH_TELUR]),
        EXP is JUMLAH_TELUR * 2,
        addExpRanching(EXP),
        retract(telur(JUMLAH_TELUR,X)),
        asserta(telur(0,X))
    ).

cow :-
    susu(JUMLAH_SUSU,X),
    (
        0 =:= JUMLAH_SUSU -> write('Sapi anda belum menghasilkan susu'),nl,
        write('Periksa lagi di lain waktu'),nl;

        0 < JUMLAH_SUSU -> format('Sapi anda menghasilkan ~d susu! ~n',[JUMLAH_SUSU]),
        format('Anda memperoleh ~d susu!~n',[JUMLAH_SUSU]),
        EXP is JUMLAH_SUSU * 5,
        addExpRanching(EXP),
        retract(susu(JUMLAH_SUSU,X)),
        asserta(susu(0,X))
    ).

sheep :-
    wool(JUMLAH_WOOl,X),
    (
        0 =:= JUMLAH_WOOl -> write('Domba anda belum menghasilkan wool'),nl,
        write('Periksa lagi di lain waktu');
        0 < JUMLAH_WOOl -> format('Domba anda menghasilkan ~d wool! ~n',[JUMLAH_WOOl]),
        format('Anda memperoleh ~d wool!~n',[JUMLAH_WOOl]),
        EXP is JUMLAH_WOOl * 3,
        addExpRanching(EXP),
        retract(wool(JUMLAH_WOOl,X)),
        asserta(wool(0,X))
    ). 