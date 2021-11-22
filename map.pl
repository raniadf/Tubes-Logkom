:- dynamic(elmtPeta/3).
:- dynamic(playerPos/2).

/* ukuranPeta(A,B) peta memiliki A baris dan B kolom */
ukuranPeta(15,20).

/*Inisialisasi Posisi Obj pada peta secara manual */
#BORDER
elmtPeta(0,_,'#'). elmtPeta(_,0,'#'). elmtPeta(_,19,'#'). elmtPeta(14,_,'#').
elmtPeta(5,1,'#'). elmtPeta(5,2,'#'). elmtPeta(5,3,'#'). elmtPeta(5,7,'#'). elmtPeta(5,8,'#'). elmtPeta(5,9,'#'). elmtPeta(5,10,'#').
elmtPeta(1,10,'#'). elmtPeta(2,10,'#'). elmtPeta(3,10,'#'). elmtPeta(4,10,'#').


/* printObjMap(A,B)*/
printObjMap(_,20) :-
    !,write('\n').
printObjMap(A,B) :-
    playerPos(A,B),!, write('P').
printObjMap(A,B) :-
    elmtPeta(A,B,C),!, write('M').
printObjMap(A,B) :-
    elmtPeta(A,B,C),!, write('Q').
printObjMap(A,B) :-
    elmtPeta(A,B,C),!, write('R').
printObjMap(A,B) :-
    elmtPeta(A,B,C),!, write('H').
printObjMap(A,B) :-
    \+elmtPeta(A,B,_),!, write('-').
/* Pond masih bikin fungsinya */

/* printPeta(A,B) memprint peta dari elemen awal hingga A,B*/
# printPeta(14,20):- !.
# printPeta(A,B):-
#     ukuranPeta(C,D), A < C, B =< D,
#     B =:= (D), printObjMap(A,B),
#     B1 is 0, A1 is (A+1), printPeta(A1,B1).
# printPeta(A,B):-
#     ukuranPeta(C,D), A < C, B =< D,
#     printObjMap(A,B),
#     B1 is (B+1), printPeta(A,B1).