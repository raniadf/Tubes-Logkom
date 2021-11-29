/* Facts */
dynamic(isPlant/4).
dynamic(digLand/0).

isPlant(0,0,0,0).
/*** Rules ***/
/*checkLand :- isDigable('true'), assertz(digLand). */

/* Tambahin fungsi apakah bisa digali apa ga */
/* itemCount(shovel, 1) */ 
dig :- objPeta(X,Y,'P'), \+isFarmable('true'),
    write('Pick your digging tools!'), nl,
    write('1. Shovel Level 1'), nl,
    write('2. Shovel Level 2'), nl,
    write('3. Hand Fork Level 1'), nl,
    write('4. Hand Fork Level 2'), nl,
    write('> '), read(X),
    (X==1 -> digShovel1 ;
    X==2 -> digShovel2 ;
    X==3 -> digHandFork1 ;
    X==4 -> digHandFork2 ), 
    digTile, !.

/** perdig2an ini harus nyetak - jadi = */
/* dig Once -> add day 1x*/
digShovel1 :- amountItem(shovel_1, Amount), Amount == 0, 
    write('Please buy this item first!'), !.
digShovel1 :- amountItem(shovel_1, Amount), Amount > 0, addDay, 
    write('Land has been digged!'), !.

digShovel2 :- amountItem(shovel_2, Amount), Amount == 0, 
    write('Please buy this item first!'), !.
digShovel2 :- amountItem(shovel_2, Amount), Amount > 0,
    write('Land has been digged!'), !.

/* dig Twice -> add day 2x */
digHandFork1 :- amountItem(hand_fork_1, Amount), Amount == 0, 
    write('Please buy this item first!'), !.
digHandFork1 :- amountItem(hand_fork_1, Amount), Amount > 0,
    addDay, addDay, addDay,
    write('Land has been digged!'), !.

digHandFork2 :- amountItem(hand_fork_2, Amount), Amount == 0, 
    write('Please buy this item first!'), !.
digHandFork2 :- amountItem(hand_fork_2, Amount), Amount > 0,
    addDay, addDay,
    write('Land has been digged!'), !.

plant :- objPeta(X,Y,'P'), isFarmable('true'), \+isPlant(X,Y, _, _), 
    write('What do you want to plant?'), nl,
    (\+amountItem(carrot_seed,0) -> write('- Carrot (Type Cr)'), nl),
    (\+amountItem(sweet_potato_seed,0) -> write('- Sweet Potato (Type Sp)'), nl),
    (\+amountItem(cassava_seed,0) -> write('- Cassava (Type Cs)'), nl),
    (\+amountItem(corn_seed,0) -> write('- Corn (Type Crn)'), nl),
    (\+amountItem(tomato_seed,0) -> write('- Tomato (Type Tm)'), nl),
    (\+amountItem(potato_seed,0) -> write('- Potato (Type Pt)'), nl),
    write('> '), read(Z),
    (Z==Cr -> plant_carrot ;
    Z==Sp -> plant_sweet_potato ;
    Z==Cs -> plant_cassava ;
    Z==Crn -> plant_corn ;
    Z==Tm -> plant_tomato ;
    Z==Pt -> plant_potato ), !.

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
    dropItems(carrot_seed, 1),
    (LvlFarm < 10 -> HarvestDay is Day + 3, assertz(isPlant(X,Y,'carrot', HarvestDay)) ;
    LvlFarm >= 10 -> HarvestDay is Day + 2, assertz(isPlant(X,Y,'carrot', HarvestDay))),
    write('You planted a carrot seed'), nl, !.

harvest :- objPeta(X,Y,'P'), \+isFarmable('true'), \+isPlant(X,Y, _, _),
    write('No plants and not a dig site....... hmm...'), nl, !.
harvest :- objPeta(X,Y,'P'), isFarmable('true'), \+isPlant(X,Y, _, _),
    write('Please plant something first!'), nl, !.
harvest :- objPeta(X,Y,'P'), isFarmable('true'), day(Day),
    isPlant(X,Y, _, HarvestDay), HarvestDay < Day, !.
/* tilenya diganti dari huruf jadi - */
harvest :- objPeta(X,Y,'P'), isFarmable('true'), day(Day),
    isPlant(X,Y, _, HarvestDay), HarvestDay >= Day,
    (isPlant(X,Y, carrot, _) -> harvest_carrot ;
    isPlant(X,Y, sweet_potato, _) -> harvest_sweet_potato ;
    isPlant(X,Y, cassava, _) -> harvest_cassava ;
    isPlant(X,Y, corn, _) -> harvest_corn ;
    isPlant(X,Y, tomato, _) -> harvest_tomato ;
    isPlant(X,Y, potato, _) -> harvest_potato ),
    retract(isPlant(X,Y, _, _)), retract(isDig(X,Y)),
    levelUpFarming, !.

/* Kalo udh bisa nanti tinggal copas */
harvest_carrot :- addItem(carrot,1),
    write('You harvested carrot.'), nl, !.