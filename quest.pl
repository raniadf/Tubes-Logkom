/* Include modul lain */
:- include('map.pl').
:- include('inventory.pl').

/* FACTS */
/* questInfo(X, Y, Z): mengumpulkan X item hasil panen, Y ikan, dan Z item hasil ranching */
:- dynamic(questInfo/3).


/* RULES */
quest :-
    \+ gameStarted, !,
    write('You need to start the game first by entering \'start.\' before you can take any quests '), nl.

quest :-
    \+ isOnQuest('true'), !,
    write('Please go to the tile \'Q\' first'), nl.

quest:-
    isOnQuest('true'),

    /* Mengacak jumlah item quest yang harus dikumpulkan */
    questInfo(X, Y, Z),
    random(2, 6, X),
    random(2, 6, Y),
    random(2, 6, Z),
    write('Find '), write(X), write(' Tunas, '), write(Y), write(' Potato Seeds, and '), write(Z), (' Cows!'), nl,
    write('Rewards: 1000 exp and 5000 golds'), nl,
    write('You can go back here once you\'ve found them all to collect the reward!'), nl,

    /* Mengecek jumlah item quest pada inventory */
    amountItem(tuna, A),
    amountItem(potato_seeds, B),
    amountItem(cow, C),
    write('Right now you have: '), nl,
    write(A), write('Tuna'), nl,
    write(B), write('Potato Seed'), nl,
    write(C), write('Cow'), nl,

    /* Memproses redeem item dan collect reward */
    write('Do you want to redeem the reward? (y/n)'), 
    read(Choice),
    (
        Choice == 'y' ->
        (
            A >= X, B >= Y, C >= Z ->
            addExp(1000),
            addGold(5000),
            dropItems(tuna, X),
            dropItems(potato, Y),
            dropItems(large_egg, Z),
            write('Congratulations! You have completed the quest!'), nl,
            (write('You got 1000 exp and 5000 golds'), nl);

            (write('You don\'t have enough items to redeem! Try again next time!'), nl)
        );
        (
        Choice == 'n' ->
        write('You chose to not redeem your quest items with the rewards! Thank you for coming, see you!'),nl
        )
    ), !.