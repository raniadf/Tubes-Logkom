/* Include modul lain */
:- include('items.pl').

/* FACTS */
/* Deklarasi predikat inventory() sebagai dynamic */
:- dynamic(inventory/7).    
/* inventory(name, qty, price, level, farmLevel, fishLevel, ranchLevel) */

/* Maximum Inventory Slots: 100 */
inventoryCapacity(100).



/* RULES */
/* *** SELEKTOR *** */
/* Mengembalikan total items pada inventory */
totalInventory(Length) :-
    findall(Qty, inventory(_, Qty, _, _, _, _, _), ListofQty),
    sumList(ListofQty, Length).

/* Mengembalikan total elemen pada List of Qty */
/* sumList(List, Sum) */
sumList([], 0).
sumList([Head|Tail], Sum) :-
   sumList(Tail, Sum1),
   Sum is Head + Sum1.

/* Mengembalikan jumlah item 'itemName' pada inventory */
amountItem(ItemName, Amount) :-
    inventory(ItemName, Qty, _, _, _, _, _),
    Amount is Qty, !.
amountItem(ItemName, Amount) :-
    \+ inventory(ItemName, _, _, _, _, _, _),
    Amount is 0, !.


/* *** INPUT/OUTPUT *** */
/* inventory */
/* Menampilkan informasi inventory */
inventory :-
    totalInventory(Length),
    /* Mencetak slot inventory */
    write('Your inventory ('), write(Length), write('/100)'), nl,
    /* Menampilkan seluruh item yang ada di inventory */
    makeListItems(ListofLevel, ListofQty, ListofName),
    displayInventory(ListofLevel, ListofQty, ListofName), !.

/* Mengembalikan list level, quantity, dan name dari item yang ada di inventory */
makeListItems(ListofLevel, ListofQty, ListofName) :-
    findall(Level, inventory(_, _, _, Level, _, _, _), ListofLevel),
    findall(Qty, inventory(_, Qty, _, _, _, _, _), ListofQty),
    findall(Name, inventory(Name, _, _, _, _, _, _), ListofName), !.

/* Menampilkan seluruh item yang ada di inventory */
displayInventory([], [], []).
displayInventory([A|X], [B|Y], [C|Z]) :-
    A >= 1,
    write(B), write(' Level '), write(A), write(' '), printItem(C), nl,
    displayInventory(X, Y, Z).
displayInventory([A|X], [B|Y], [C|Z]) :-
    A < 1,
    write(B), write(' '), printItem(C), nl,
    displayInventory(X, Y, Z).


/* *** ADD ITEM *** */
/* Case 1: Belum ada item 'itemName' di Inventory */
addItem(ItemName, Quantity) :-
    inventoryCapacity(Max),
    totalInventory(Length),
    Length + Quantity =< Max,
    \+ inventory(ItemName, _, _, _, _, _, _),
    item(ItemName, Qty, Price, Level, FarmLevel, FishLevel, RanchLevel),
    Qty2 is Qty + Quantity,
    asserta(inventory(ItemName, Qty2, Price, Level, FarmLevel, FishLevel, RanchLevel)),
    write('You got '), write(Quantity), write(' '), printItem(ItemName), write('!'), nl, !.

/* Case 2: Sudah ada item 'itemName' di Inventory */
addItem(ItemName, Quantity) :-
    inventoryCapacity(Max),
    totalInventory(Length),
    Length + Quantity =< Max,
    inventory(ItemName, Qty, _, _, _, _, _),
    Qty2 is Qty + Quantity,
    retract(inventory(ItemName, Qty, Price, Level, FarmLevel, FishLevel, RanchLevel)),
    asserta(inventory(ItemName, Qty2, Price, Level, FarmLevel, FishLevel, RanchLevel)),
    write('You got '), write(Quantity), write(' '), printItem(ItemName), write('!'), nl, !.

/* Case 3: Inventory penuh sebelum melakukan addItem */
addItem(_, _) :-
    inventoryCapacity(Max),
    totalInventory(Length),
    Length = Max,
    write('Your can\'t add item into your inventory. Your inventory is full! Cancelling...'), !, fail.

/* Case 4: Penambahan item melebihi kapasitas inventory */
addItem(ItemName, Quantity) :-
    inventoryCapacity(Max),
    totalInventory(Length),
    Length + Quantity > Max,
    QtyAvailable is Max - Length,
    inventory(ItemName, Qty, _, _, _, _, _),
    Qty2 is Qty + QtyAvailable,
    retract(inventory(ItemName, Qty, Price, Level, FarmLevel, FishLevel, RanchLevel)),
    asserta(inventory(ItemName, Qty2, Price, Level, FarmLevel, FishLevel, RanchLevel)),
    write('Your inventory is full! Only '), write(QtyAvailable), write(' '), printItem(ItemName), write(' can be added into your inventory!'), !.


/* *** DROP ITEMS *** */
/* Case 1: Jumlah yang ingin di-drop melebihi stok di inventory */
dropItems(ItemName, ItemQty) :-
    inventory(ItemName, Qty, _, _, _, _, _),
    ItemQty > Qty,
    nl,
    write('You don\'t have enough '), printItem(ItemName), write('... Sorry...'), nl, !.
/* Case 2: Jumlah yang ingin di drop = jumlah quantity */
dropItems(ItemName, ItemQty) :-
    inventory(ItemName, Qty, _, _, _, _, _),
    Qty2 is Qty - ItemQty,
    Qty2 =:= 0,
    retract(inventory(ItemName, Qty, _, _, _, _, _)), !.
/* Case 3: Jumlah yang ingin di-drop mencukupi */
dropItems(ItemName, ItemQty) :-
    inventory(ItemName, Qty, _, _, _, _, _),
    ItemQty =< Qty,
    Qty2 is Qty - ItemQty,
    retract(inventory(ItemName, Qty, Price, Level, FarmLevel, FishLevel, RanchLevel)),
    asserta(inventory(ItemName, Qty2, Price, Level, FarmLevel, FishLevel, RanchLevel)), !.


/* *** THROW ITEM *** */
/* throwItem */
throwItem :-
    write('Your inventory'), nl,
    makeListItems(ListofLevel, ListofQty, ListofName),
    displayInventory(ListofLevel, ListofQty, ListofName),
    nl,
    write('What do you want to throw?'), nl,
    read(ItemName),
    throwItemName(ItemName), !.

/* throwItemName */
/* Case 1: Tidak ada item yang ingin di-throw */
throwItemName(ItemName) :-
    \+ inventory(ItemName, _, _, _, _, _, _),
    nl,
    write('You don\'t have '), printItem(ItemName), write(' in your inventory! Cancelling...'), nl, !.
/* Case 2: Terdapat item yang ingin di-throw */
throwItemName(ItemName) :-
    inventory(ItemName, Qty, _, _, _, _, _),
    nl,
    write('You have '), write(Qty), write(' '), printItem(ItemName), write('. How many '), printItem(ItemName), write(' do you want to throw? (type \'0\' if u want to cancel)'), nl,
    read(Amount),
    throwAmount(ItemName, Amount).

/* throwAmount */
/* Case 1: Pemain membatalkan proses throw */
throwAmount(ItemName, Qty) :-
    Qty =:= 0,
    nl,
    write('You cancelled to throw '), printItem(ItemName), write('! Cancelling...'), nl, !.
/* Case 2: Jumlah yang ingin di-throw melebihi stok di inventory */
throwAmount(ItemName, ItemQty) :-
    inventory(ItemName, Qty, _, _, _, _, _),
    ItemQty > Qty,
    nl,
    write('You don\'t have enough '), printItem(ItemName), write(' to throw! Cancelling...'), nl, !.
/* Case 3: Jumlah yang ingin di-throw mencukupi */
throwAmount(ItemName, ItemQty) :-
    inventory(ItemName, Qty, _, _, _, _, _),
    ItemQty =< Qty,
    dropItems(ItemName, ItemQty),
    nl,
    write('You threw '), write(ItemQty), write(' '), printItem(ItemName), write(' away!'), nl, !.