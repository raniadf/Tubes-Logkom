/* FACTS */
/* questInfo(X, Y, Z): mengumpulkan X item hasil panen, Y ikan, dan Z item hasil ranching */
:- dynamic(questInfo/3).
/* questRemaining(A, B, C, D): A, B, C, D menggambarkan 4 quest yang ada di map, bernilai satu jika quest nya masih ada */
:- dynamic(questRemaining/4).
:- dynamic(inQuest/0).

/* contoh questInfo */

questInfo(4,3,2).

/* RULES */

quest :-
    \+ gameStarted,!,
    write('You need to start the game first by entering \'start.\' before you can take any quests '),nl.

quest :-
    /* cek posisi player udah di Q ato belom*/
    !,write('Please go to tile \'Q\' first'),nl.

quest :- 
    /* game udah dimulai dan player udah di Q */
    assertz(inQuest),!,
    /* kayaknya harus ada id quest gitu sen biar tau ngambil quest yang mana
    soalnya klo gini jadinya jumlah angkanya ga sesuai gitu*/
    questInfo(A,B,C),!,
    write('You got a new quest!'),nl,
    format('- ~d Harvest Item',[A]),nl,
    format('- ~d Fish Item',[A]),nl,
    format('- ~d Ranch Item',[A]),nl.