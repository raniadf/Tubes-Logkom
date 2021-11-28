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
    findall(Qty, inventory(_, Qty, _, _, _, _, _, _), ListofQty),
    findall(Name, inventory(Name, _, _, _, _, _, _, _), ListofName), !.

/* Menampilkan seluruh item yang ada di inventory */
displayInventory([], [], []).
displayInventory([A|X], [B|Y], [C|Z]) :-
    A >= 1,
    write(B), write(' Level '), write(A), write(' '), printItemName(C), nl,
    displayInventory(X, Y, Z).
displayInventory([A|X], [B|Y], [C|Z]) :-
    A < 1,
    write(B), write(' '), printItemName(C), nl,
    displayInventory(X, Y, Z).


/* *** ADD ITEMS *** */
/* Case 1: Belum ada item 'itemName' di Inventory */
addItem(ItemName, Quantity) :-
    inventoryCapacity(Max),
    totalInventory(Length),
    Length + Quantity =< Max,
    \+ inventory(ItemName, _, _, _, _, _, _),
    item(ItemName, Qty, Price, Level, FarmLevel, FishLevel, RanchLevel),
    Qty2 is Qty + Quantity,
    asserta(inventory(ItemName, Qty2, Price, Level, FarmLevel, FishLevel, RanchLevel)),
    write('You got '), write(Quantity), write(' '), printItemName(ItemName), write('!'), nl, !.

/* Case 2: Sudah ada item 'itemName' di Inventory */
addItem(ItemName, Quantity) :-
    inventoryCapacity(Max),
    totalInventory(Length),
    Length + Quantity =< Max,
    inventory(ItemName, Qty, _, _, _, _, _),
    Qty2 is Qty + Quantity,
    retract(inventory(ItemName, Qty, Price, Level, FarmLevel, FishLevel, RanchLevel)),
    asserta(inventory(ItemName, Qty2, Price, Level, FarmLevel, FishLevel, RanchLevel)),
    write('You got '), write(Quantity), write(' '), printItemName(ItemName), write('!'), nl, !.

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
    write('Your inventory is full! Only '), write(QtyAvailable), write(' '), printItemName(ItemName), write(' can be added into your inventory!'), !.


/* *** REMOVE ITEMS *** */
/* Dengan catatan, item yang ingin di-remove harus mencukupi */
/* Case 1: Sudah ada item 'itemName' di inventory, jumlah mencukupi, dan jumlah item-nya tidak menjadi 0 setelah di-remove */
removeItem(ItemName, Quantity) :-
    inventory(ItemName, Qty, _, _, _, _, _),
    Qty2 is Qty - Quantity,
    Qty2 > 0,
    retract(inventory(ItemName, Qty, Price, Level, FarmLevel, FishLevel, RanchLevel)),
    asserta(inventory(ItemName, Qty2, Price, Level, FarmLevel, FishLevel, RanchLevel)), !.

/* Case 2: Sudah ada item 'itemName' di inventory, jumlah mencukupi, dan jumlah item-nya menjadi 0 setelah di-remove */
removeItem(ItemName, Quantity) :-
    inventory(ItemName, Qty, _, _, _, _, _),
    Qty2 is Qty - Quantity,
    Qty2 =:= 0,
    retract(inventory(ItemName, Qty, _, _, _, _, _)), !.


/* *** THROW ITEMS *** */
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
    write('You don\'t have '), printItemName(ItemName), write(' in your inventory! Cancelling...'), nl, !.
/* Case 2: Terdapat item yang ingin di-throw */
throwItemName(ItemName) :-
    inventory(ItemName, Qty, _, _, _, _, _),
    nl,
    write('You have '), write(Qty), write(' '), printItemName(ItemName), write('. How many '), printItemName(ItemName), write(' do you want to throw? (type \'0\' if u want to cancel)'), nl,
    read(Amount),
    throwAmount(ItemName, Amount).

/* throwAmount */
/* Case 1: Pemain membatalkan proses throw */
throwAmount(ItemName, Qty) :-
    Qty =:= 0,
    nl,
    write('You cancelled to throw '), printItemName(ItemName), write('! Cancelling...'), nl, !.
/* Case 2: Jumlah yang ingin di-throw melebihi stok di inventory */
throwAmount(ItemName, ItemQty) :-
    inventory(ItemName, Qty, _, _, _, _, _),
    ItemQty > Qty,
    nl,
    write('You don\'t have enough '), printItemName(ItemName), write(' to throw! Cancelling...'), nl, !.
/* Case 3: Jumlah yang ingin di-throw mencukupi */
throwAmount(ItemName, ItemQty) :-
    inventory(ItemName, Qty, _, _, _, _, _),
    ItemQty =< Qty,
    removeItem(ItemName, ItemQty),
    nl,
    write('You threw '), write(Qty), write(' '), printItemName(ItemName), write(' away!') nl, !.


/* *** PRINT ITEMS *** */
printItemName(ItemName) :-
    ItemName == carrot,
    write('Carrot'), !
.
printItemName(ItemName) :-
    ItemName == sweet_potato,
    write('Sweet Potato'), !
.
printItemName(ItemName) :-
    ItemName == cassava,
    write('Cassava'), !
.
printItemName(ItemName) :-
    ItemName == corn,
    write('Corn'), !
.
printItemName(ItemName) :-
    ItemName == tomato,
    write('Tomato'), !
.
printItemName(ItemName) :-
    ItemName == potato,
    write('Potato'), !
.
printItemName(ItemName) :-
    ItemName == carrot_seed,
    write('Carrot Seed'), !
.
printItemName(ItemName) :-
    ItemName == sweet_potato_seed,
    write('Sweet Potato Seed'), !
.
printItemName(ItemName) :-
    ItemName == cassava_seed,
    write('Cassava Seed'), !
.
printItemName(ItemName) :-
    ItemName == corn_seed,
    write('Corn Seed'), !
.
printItemName(ItemName) :-
    ItemName == tomato_seed,
    write('Tomato Seed'), !
.
printItemName(ItemName) :-
    ItemName == potato_seed,
    write('Potato Seed'), !
.
printItemName(ItemName) :-
    ItemName == shovel_1,
    write('Shovel'), !
.
printItemName(ItemName) :-
    ItemName == shovel_2,
    write('Shovel'), !
.
printItemName(ItemName) :-
    ItemName == hand_fork_1,
    write('Hand Fork'), !
.
printItemName(ItemName) :-
    ItemName == hand_fork_2,
    write('Hand Fork'), !
.
printItemName(ItemName) :-
    ItemName == watering_can_1,
    write('Watering Can'), !
.
printItemName(ItemName) :-
    ItemName == watering_can_2,
    write('Watering Can'), !
.
printItemName(ItemName) :-
    ItemName == salmon,
    write('Salmon'), !
.
printItemName(ItemName) :-
    ItemName == tuna,
    write('Tuna'), !
.
printItemName(ItemName) :-
    ItemName == mahi_mahi,
    write('Mahi-Mahi'), !
.
printItemName(ItemName) :-
    ItemName == red_snapper,
    write('Red Snapper'), !
.
printItemName(ItemName) :-
    ItemName == catfish,
    write('Catfish'), !
.
printItemName(ItemName) :-
    ItemName == grade_a_food,
    write('Grade A Food'), !
.
printItemName(ItemName) :-
    ItemName == grade_b_food,
    write('Grade B Food'), !
.
printItemName(ItemName) :-
    ItemName == grade_c_food,
    write('Grade C Food'), !
.
printItemName(ItemName) :-
    ItemName == fishnet_1,
    write('Fishnet'), !
.
printItemName(ItemName) :-
    ItemName == fishnet_2,
    write('Fishnet'), !
.
printItemName(ItemName) :-
    ItemName == rod_1,
    write('Fishing Rod'), !
.
printItemName(ItemName) :-
    ItemName == rod_2,
    write('Fishing Rod'), !
.
printItemName(ItemName) :-
    ItemName == chicken_egg,
    write('Chicken Egg'), !
.
printItemName(ItemName) :-
    ItemName == milk,
    write('Milk'), !
.
printItemName(ItemName) :-
    ItemName == wool,
    write('Wool'), !
.
printItemName(ItemName) :-
    ItemName == chicken,
    write('Chicken'), !
.
printItemName(ItemName) :-
    ItemName == cow,
    write('Cow'), !
.
printItemName(ItemName) :-
    ItemName == sheep,
    write('Sheep'), !
.
printItemName(ItemName) :-
    ItemName == milk_pail_1,
    write('Milk Pail'), !
.
printItemName(ItemName) :-
    ItemName == milk_pail_2,
    write('Milk Pail'), !
.
printItemName(ItemName) :-
    ItemName == shears_1,
    write('Shears'), !
.
printItemName(ItemName) :-
    ItemName == shears_2,
    write('Shears'), !
.