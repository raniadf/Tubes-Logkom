/* FACTS */
:- include('items.pl').
:- dynamic(inMarket/0).


/* RULES */

/* Fail to enter the market */
market :- \+gameStarted, !, write('Please type "start" first to start the game and enter the marketplace!').
market :- 
    /*isi posisi player dan posisi store di elemen peta*/
    !, write('Please go to the marketplace first!').

/* Entering the market */
/*assertz(inMarket), --> janlup tambahin ini pi klo dah ada posisi playernya*/
market :- write_ln('What do you want to do?'), 
        write_ln('1. Buy'), 
        write_ln('2.Sell'),
        read(X), (X =:= 1 -> buy; X =:= 2 -> sell), nl, !.
market :- 

/* Buy items */


/* Exit market */
exitMarket :- \+inMarket, nl, write_ln('Anda belum berada di market.').
exitMarket :- inMarket, nl, write_ln('Terima kasih sudah berkunjung ke market! Sampai jumpa kembali!').
