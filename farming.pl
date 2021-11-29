/*** Facts ***/
:- dynamic(isPlant/4).

isPlant(0,0,0,0).
/*** Rules ***/

/* itemCount(shovel, 1) */ 
dig :- objPeta(X,Y,'P'), \+isFarmable('true'),
    write('Pick your digging tools!'), nl,
    write('1. Shovel Level 1'), nl,
    write('2. Shovel Level 2'), nl,
    write('3. Hand Fork Level 1'), nl,
    write('4. Hand Fork Level 2'), nl,
    write('> '), read(Z),
    (Z==1 -> digShovel1 ;
    Z==2 -> digShovel2 ;
    Z==3 -> digHandFork1 ;
    Z==4 -> digHandFork2 ), !.

/** perdig2an ini harus nyetak - jadi = */
/* dig Once -> add day 1x*/
digShovel1 :- amountItem(shovel_1, Amount), Amount == 0, 
    write('Please buy this item first!'), !.
digShovel1 :- amountItem(shovel_1, Amount), Amount > 0, addDay, 
    write('Land has been digged!'), digTile, !.

digShovel2 :- amountItem(shovel_2, Amount), Amount == 0, 
    write('Please buy this item first!'), !.
digShovel2 :- amountItem(shovel_2, Amount), Amount > 0,
    write('Land has been digged!'), digTile, !.

/* dig Twice -> add day 2x */
digHandFork1 :- amountItem(hand_fork_1, Amount), Amount == 0, 
    write('Please buy this item first!'), !.
digHandFork1 :- amountItem(hand_fork_1, Amount), Amount > 0,
    addDay, addDay, addDay,
    write('Land has been digged!'), digTile, !.

digHandFork2 :- amountItem(hand_fork_2, Amount), Amount == 0, 
    write('Please buy this item first!'), !.
digHandFork2 :- amountItem(hand_fork_2, Amount), Amount > 0,
    addDay, addDay,
    write('Land has been digged!'), digTile, !.

plant :- objPeta(X,Y,'P'), isFarmable('true'), \+isPlant(X,Y, _, _), 
    write('What do you want to plant?'), nl,
    write('Seeds you have : '), nl,
    (amountItem(carrot_seed,Acs), 
        write('1. Carrot : '), write(Acs), write(' Seeds.'), nl),
    (amountItem(sweet_potato_seed,Asp), 
        write('2. Sweet Potato : '), write(Asp), write(' Seeds.'), nl),
    (amountItem(cassava_seed,Acsv), 
        write('3. Cassava : '), write(Acsv), write(' Seeds.'), nl),
    (amountItem(corn_seed,Acr), 
        write('4. Corn : '), write(Acr), write(' Seeds.'), nl),
    (amountItem(tomato_seed,At), 
        write('5. Tomato : '), write(At), write(' Seeds.'), nl),
    (amountItem(potato_seed,Ap), 
        write('6. Potato : '), write(Ap), write(' Seeds.'), nl),
    write('Write the seeds ID!'), nl,
    write('> '), read(Z),
    (Z==1 -> plant_carrot ;
    Z==2 -> plant_sweet_potato ;
    Z==3 -> plant_cassava ;
    Z==4 -> plant_corn ;
    Z==5 -> plant_tomato ;
    Z==6 -> plant_potato ), !.

/* Tilenya diganti dari = jadi c/sp/cs/cr/t/p */
/* kalo fungsinya udah bener baru nanti copas */
/* addExp(X) :
    X = 100 carrot
    X = 150 sweet potato
    X = 125 cassava
    X = 200 corn
    X = 150 tomato
    X = 175 potato */
/* HarvestDay :
    Level < 10 :
    carrot = 3 hari
    sweet potato = 4 hari
    cassava = 2 hari
    corn = 4 hari
    tomato = 3 hari
    potato = 3 hari

    Level >= 10 :
    carrot = 2 hari
    sweet potato = 3 hari
    cassava = 1 hari
    corn = 3 hari
    tomato = 2 hari
    potato = 2 hari
    */
plant_carrot :- objPeta(X,Y,'P'), plantCropC,
    player(_, _, LvlFarm, _, _, _, _, _, _, _),
    day(Day),
    addExp(100),
    dropItems(carrot_seed, 1),
    (LvlFarm < 10 -> HarvestDay is Day + 3, assertz(isPlant(X,Y,'carrot', HarvestDay)) ;
    LvlFarm >= 10 -> HarvestDay is Day + 2, assertz(isPlant(X,Y,'carrot', HarvestDay))),
    write('You planted a carrot seed'), nl, !.

plant_sweet_potato :- objPeta(X,Y,'P'), plantCropSp,
    player(_, _, LvlFarm, _, _, _, _, _, _, _),
    day(Day),
    addExp(150),
    dropItems(sweet_potato_seed, 1),
    (LvlFarm < 10 -> HarvestDay is Day + 4, assertz(isPlant(X,Y,'sweet_potato', HarvestDay)) ;
    LvlFarm >= 10 -> HarvestDay is Day + 3, assertz(isPlant(X,Y,'sweet_potato', HarvestDay))),
    write('You planted a sweet potato seed'), nl, !.

plant_cassava :- objPeta(X,Y,'P'), plantCropCs,
    player(_, _, LvlFarm, _, _, _, _, _, _, _),
    day(Day),
    addExp(125),
    dropItems(cassava_seed, 1),
    (LvlFarm < 10 -> HarvestDay is Day + 2, assertz(isPlant(X,Y,'cassava', HarvestDay)) ;
    LvlFarm >= 10 -> HarvestDay is Day + 1, assertz(isPlant(X,Y,'cassava', HarvestDay))),
    write('You planted a cassava seed'), nl, !.

plant_corn :- objPeta(X,Y,'P'), plantCropCr,
    player(_, _, LvlFarm, _, _, _, _, _, _, _),
    day(Day),
    addExp(200),
    dropItems(corn_seed, 1),
    (LvlFarm < 10 -> HarvestDay is Day + 4, assertz(isPlant(X,Y,'corn', HarvestDay)) ;
    LvlFarm >= 10 -> HarvestDay is Day + 3, assertz(isPlant(X,Y,'corn', HarvestDay))),
    write('You planted a corn seed'), nl, !.

plant_tomato :- objPeta(X,Y,'P'), plantCropT,
    player(_, _, LvlFarm, _, _, _, _, _, _, _),
    day(Day),
    addExp(150),
    dropItems(tomato_seed, 1),
    (LvlFarm < 10 -> HarvestDay is Day + 3, assertz(isPlant(X,Y,'tomato', HarvestDay)) ;
    LvlFarm >= 10 -> HarvestDay is Day + 2, assertz(isPlant(X,Y,'tomato', HarvestDay))),
    write('You planted a tomato seed'), nl, !.

plant_potato :- objPeta(X,Y,'P'), plantCropP,
    player(_, _, LvlFarm, _, _, _, _, _, _, _),
    day(Day),
    addExp(175),
    dropItems(potato_seed, 1),
    (LvlFarm < 10 -> HarvestDay is Day + 3, assertz(isPlant(X,Y,'potato', HarvestDay)) ;
    LvlFarm >= 10 -> HarvestDay is Day + 2, assertz(isPlant(X,Y,'potato', HarvestDay))),
    write('You planted a potato seed'), nl, !.

/** Harvest **/
harvest :- objPeta(X,Y,'P'), \+isFarmable('true'), \+isPlant(X,Y, _, _),
    write('No plants and not a dig site....... hmm...'), nl, !.
harvest :- objPeta(X,Y,'P'), isFarmable('true'), \+isPlant(X,Y, _, _),
    write('Please plant something first!'), nl, !.
harvest :- objPeta(X,Y,'P'), isFarmable('true'), day(Day),
    isPlant(X,Y, _, HarvestDay), HarvestDay < Day, 
    write('It\'s not harvest time yet! Please come back at day '), write(HarvestDay), write('.'), !.
/* tilenya diganti dari huruf jadi - */
harvest :- objPeta(X,Y,'P'), isFarmable('true'), day(Day),
    isPlant(X,Y, _, HarvestDay), HarvestDay >= Day,
    (isPlant(X,Y, carrot, _) -> harvest_carrot ;
    isPlant(X,Y, sweet_potato, _) -> harvest_sweet_potato ;
    isPlant(X,Y, cassava, _) -> harvest_cassava ;
    isPlant(X,Y, corn, _) -> harvest_corn ;
    isPlant(X,Y, tomato, _) -> harvest_tomato ;
    isPlant(X,Y, potato, _) -> harvest_potato ),
    retract(isPlant(X,Y, _, _)),
    levelUpFarming, !.

/* Kalo udh bisa nanti tinggal copas */
harvest_carrot :- addItem(carrot,1),
    write('You harvested carrot.'), nl, !.
harvest_sweet_potato :- addItem(sweet_potato,1),
    write('You harvested sweet potato.'), nl, !.
harvest_cassava :- addItem(cassava,1),
    write('You harvested cassava.'), nl, !.
harvest_corn :- addItem(corn,1),
    write('You harvested corn.'), nl, !.
harvest_tomato :- addItem(tomato,1),
    write('You harvested tomato.'), nl, !.
harvest_potato :- addItem(potato,1),
    write('You harvested potato.'), nl, !.