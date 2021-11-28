/* Facts */
dynamic(isDig/2).
dynamic(isDigHandFork/2).
dynamic(isPlant/4).
dynamic(digLand/0).

/*** Rules ***/
checkLand :- isDigable(Hasil), Hasil == 'true', assertz(digLand).

/* Tambahin fungsi apakah bisa digali apa ga */
/* itemCount(shovel, 1) */ 
dig :- checkLand, write('Pick your digging tools!'), nl,
    write('- Shovel'), nl,
    write('- Hand Fork'), nl.
    write('> '), read(X),
    (X=:=1 -> digShovel ;
    X=:=2 -> digHandFork).

/** perdig2an ini harus nyetak - jadi = */
/* dig Once -> add day 1x*/
digShovel :- /+isDig(X,Y), objPeta(X,Y,'P'), assertz(isDig(X,Y)), 
    write('Land has been digged!'), !.

/* dig Twice -> add day 2x */
digHandFork :- objPeta(X,Y,'P'), 
    (\+isDig(X,Y), isDigHandFork(X, Y, 1), 
    retract(isDigHandFork(X,Y,1)), 
    assertz(isDigHandFork(X, Y, 2)), assertz(isDig(X,Y))), !.

plant :- objPeta(X,Y,'P'), isDig(X,Y), \+isPlant(X,Y, _, _), 
    write('What do you want to plant?'), nl,
    (isItemAvailable(carrot_seed) -> write('- Carrot (Type Cr)'), nl),
    (isItemAvailable(sweet_potato_seed) -> write('- Sweet Potato (Type Sp)'), nl),
    (isItemAvailable(cassava_seed) -> write('- Cassava (Type Cs)'), nl),
    (isItemAvailable(corn_seed) -> write('- Corn (Type Crn)'), nl),
    (isItemAvailable(tomato_seed) -> write('- Tomato (Type Tm)'), nl),
    (isItemAvailable(potato_seed) -> write('- Potato (Type Pt)'), nl),
    write('> '), read(Z),
    (Z=:='Cr' -> plant_carrot ;
    Z=:='Sp' -> plant_sweet_potato ;
    Z=:='Cs' -> plant_cassava ;
    Z=:='Crn' -> plant_corn ;
    Z=:='Tm' -> plant_tomato ;
    Z=:='Pt' -> plant_potato ).

/* Inventory seednya kurangin 1 */
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
plant_carrot :- objPeta(X,Y,'P'), 
    player(_, _, LvlFarm, _, _, _, _, _, _, _),
    day(Day),
    (LvlFarm < 10 -> HarvestDay is Day + 3, assertz(isPlant(X,Y,carrot, HarvestDay)) ;
    LvlFarm >= 10 -> HarvestDay is Day + 2, assertz(isPlant(X,Y,carrot, HarvestDay))),
    write('You planted a carrot seed'), nl, !.

harvest :- objPeta(X,Y,'P'), \+isDig(X,Y), \+isPlant(X,Y, _, _),
    write('No plants and not a dig site....... hmm...'), nl, !.
harvest :- objPeta(X,Y,'P'), isDig(X,Y), \+isPlant(X,Y, _, _),
    write('Please plant something first!'), nl, !.
harvest :- objPeta(X,Y,'P'), isDig(X,Y), day(Day),
    isPlant(X,Y, _, HarvestDay), HarvestDay < Day, !.
/* tilenya diganti dari huruf jadi - */
harvest :- objPeta(X,Y,'P'), isDig(X,Y), day(Day),
    isPlant(X,Y, _, HarvestDay), HarvestDay >= Day,
    (isPlant(X,Y, carrot, _) -> harvest_carrot ;
    isPlant(X,Y, sweet_potato, _) -> harvest_sweet_potato ;
    isPlant(X,Y, cassava, _) -> harvest_cassava ;
    isPlant(X,Y, corn, _) -> harvest_corn ;
    isPlant(X,Y, tomato, _) -> harvest_tomato ;
    isPlant(X,Y, potato, _) -> harvest_potato ),
    retract(isPlant(X,Y, _, _)), retract(isDig(X,Y)),
    levelUpFarming !.

/* add item ke inventory */
/* Kalo udh bisa nanti tinggal copas */
harvest_carrot :- write('You harvested carrot.'), nl, !.
