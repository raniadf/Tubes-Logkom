/* Include modul lain */
:- include('map.pl').
:- include('inventory.pl').
:- include('items.pl').


/* FACTS */
/* questInfo(ItemA, X, ItemB, Y, ItemC, Z, Exp, Gold): mengumpulkan X item hasil panen A, Y ikan B, dan Z item hasil ranching C untuk mendapatkan Exp dan Gold */
:- dynamic(questInfo/8).
/* questAvail: menandakan state quest sedang aktif */
:- dynamic(questAvail/0).


/* RULES */
quest :-
    \+gameStarted, !,
    write('You need to start the game first by entering \'start.\' before you can take any quests '), nl.

quest :-
    \+isOnQuest('true'), !,
    write('Please go to the tile \'Q\' first'), nl.

/* Mengambil quest pada saat tidak ada quest yang sedang aktif */
quest:-
    isOnQuest('true'), \+questAvail,
    /* Mengacak jumlah item quest yang harus dikumpulkan */
    random(2, 6, X),
    random(2, 6, Y),
    random(2, 6, Z),
    /* Mengacak jenis item quest yang harus dikumpulkan */
    random(1, 6, H),
    ( H==1 -> ItemA = carrot ;
    H==2 -> ItemA = sweet_potato ;
    H==3 -> ItemA = cassava ;
    H==4 -> ItemA = corn ;
    H==5 -> ItemA = tomato ;
    H==6 -> ItemA = potato ), 
    random(1, 5, I),
    ( I==1 -> ItemB = salmon ;
    I==2 -> ItemB = tuna ;
    I==3 -> ItemB = mahi_mahi ;
    I==4 -> ItemB = red_snapper ;
    I==5 -> ItemB = catfish ),
    random(1, 3, J),
    ( J==1 -> ItemC = chicken_egg ;
    J==2 -> ItemC = milk ;
    J==3 -> ItemC = wool ),
    /* Mengacak reward exp dan gold yang bisa didapatkan */
    random(100, 500, M),
    random(1000, 5000, N),
    assertz(questInfo(ItemA, X, ItemB, Y, ItemC, Z, M, N)),
    /* Quest aktif */
    assertz(questAvail),
    write('Find :'), nl,
    write('- '), write(X), write(' '), printItem(ItemA), nl, 
    write('- '), write(Y), write(' '), printItem(ItemB), nl, 
    write('- '), write(Z), write(' '), printItem(ItemC), nl,
    write('Rewards: '), write(M), write(' exp and '), write(N), write(' golds'), nl,
    write('You can go back here once you\'ve found them all to collect the reward!'), nl, !.

/* Mengambil quest pada saat sudah ada quest yang sedang aktif */
quest :- 
    questAvail, 
    questInfo(ItemA, X, ItemB, Y, ItemC, Z, M, N),
    write('Current quest : '),nl,
    write('- '), write(X), write(' '), printItem(ItemA), nl, 
    write('- '), write(Y), write(' '), printItem(ItemB), nl, 
    write('- '), write(Z), write(' '), printItem(ItemC), nl,
    write('Rewards: '), write(M), write(' exp and '), write(N), write(' golds'), nl,
    amountItem(ItemA, A),
    amountItem(ItemB, B),
    amountItem(ItemC, C),
    write('Right now you have: '), nl,
    write(A), write(' '), printItem(ItemA), nl,
    write(B), write(' '), printItem(ItemB), nl,
    write(C), write(' '), printItem(ItemC), nl,

    /* Memproses redeem item dan collect reward */
    write('Do you want to redeem the reward? (y/n)'), nl,
    write('> '), read(Choice),
    (
        Choice == 'y' ->
        (
            (A >= X, B >= Y, C >= Z ->
            addExp(M),
            addGold(N),
            dropItems(ItemA, X),
            dropItems(ItemB, Y),
            dropItems(ItemC, Z),
            retract(questInfo(ItemA, X, ItemB, Y, ItemC, Z, M, N)),
            write('Congratulations! You have completed the quest!'), nl,
            write('You got '), write(M), write(' exp and '), write(N), write(' golds'), nl,
            retract(questAvail));
            (write('You don\'t have enough items to redeem! Try again next time!'), nl)
        );
        (
        Choice == 'n' ->
        write('You chose to not redeem your quest items with the rewards! Thank you for coming, see you!'),nl
        )
    ), !.