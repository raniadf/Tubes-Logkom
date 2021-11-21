/* FACTS */
:- dynamic(inMarket/0).

/* RULES */

/* Fail to enter the market */
market :- \+start, !, write('Please type "start" first to start the game and enter the marketplace!').
market :- /*isi posisi player dan posisi store di elemen peta*/, !, write('Please go to the marketplace first!').

/* Entering the market */
market :- write_ln('What do you want to do?'), write_ln('1. Buy'), write_ln('2.Sell').
