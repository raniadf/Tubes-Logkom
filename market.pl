/*** FACTS ***/
:- include('items.pl').
:- include('player.pl').

:- dynamic(inMarket/0).

/*** RULES ***/

/* Fail to enter the market */
market :- \+gameStarted, !, write('Please type "start" first to start the game and enter the marketplace!').
market :- 
    /*isi posisi player dan posisi store di elemen peta*/
    !, write('Please go to the marketplace first!').

/* Entering the market */
/*assertz(inMarket), --> janlup tambahin ini pi klo dah ada posisi playernya*/
market :- write_ln('What do you want to do?'), 
        write_ln('1. Buy'), 
        write_ln('2.Sell'),
        read(X), (X =:= 1 -> buy; X =:= 2 -> sell), nl, !.

/* Buy */
buy :- inMarket(_),
    write_ln('What do you want to buy?'),
    write_ln('1. Items'),
    write_ln('2. Equipment'),
    read(X), (X =:= 1 -> buyItems; X =:= 2 -> buyEquipment).

buyItems :- inMarket(_),
    write_ln('Welcome to the market!'),
    write_ln('Choose an item!'),
    write_ln('1. Carrot Seed                    50 gold'),
    write_ln('2. Sweet Potato Seed              80 gold'),
    write_ln('3. Cassava Seed                   120 gold'),
    write_ln('4. Corn Seed                      140 gold'),
    write_ln('5. Tomato Seed                    130 gold'),
    write_ln('6. Potato Seed                    150 gold'),
    write_ln('7. Grade A Food                   300 gold'),
    write_ln('8. Grade B Food                   200 gold'),
    write_ln('9. Grade C Food                   100 gold'),
    write_ln('10. Chicken Food                  100 gold'),
    write_ln('11. Cow Food                      125 gold'),
    write_ln('12. Sheep Food                    170 gold'),
    write_ln('Write the item ID!'), read(X),
        ( X=:=1 -> buy_carrot_seed ;
          X=:=2 -> buy_sweet_potato_seed ;
          X=:=3 -> buy_cassava_seed ;
          X=:=4 -> buy_corn_seed ;
          X=:=5 -> buy_tomato_seed ;
          X=:=6 -> buy_potato_seed ;
          X=:=7 -> buy_grade_A_food ;
          X=:=8 -> buy_grade_B_food ;
          X=:=9 -> buy_grade_C_food ;
          X=:=10 -> buy_chicken_food ;
          X=:=11 -> buy_cow_food ;
          X=:=12 -> buy_sheep_food ).

/* Buy carrot seed */
buy_carrot_seed :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold < 50), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_carrot_seed :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold >= 50), addItem(carrot_seed, 1), reduceGold(50),
    write('Congratulations! Transaction completed. +1 Carrot seed in your inventory.'), nl.

/* Buy sweet potato seed */
buy_sweet_potato_seed :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold < 80), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_sweet_potato_seed :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold >= 80), addItem(sweet_potato_seed, 1), reduceGold(80),
    write('Congratulations! Transaction completed. +1 Sweet potato seed in your inventory.'), nl.

/* Buy cassava seed */
buy_cassava_seed :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold < 120), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_cassava_seed :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold >= 120), addItem(cassava_seed, 1), reduceGold(120),
    write('Congratulations! Transaction completed. +1 Cassava seed in your inventory.'), nl.

/* Buy corn seed */
buy_corn_seed :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold < 140), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_corn_seed :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (LvlFarm < 2), write('You need to upgrade your farming level to level 2 before purchasing this item.'), nl.
buy_corn_seed :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold >= 140), LvlFarm >= 2, addItem(corn_seed, 1), reduceGold(140),
    write('Congratulations! Transaction completed. +1 Corn seed in your inventory.'), nl.

/* Buy tomato seed */
buy_tomato_seed :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold < 130), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_tomato_seed :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (LvlFarm < 3), write('You need to upgrade your farming level to level 3 before purchasing this item.'), nl.
buy_tomato_seed :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold >= 130), LvlFarm >=3, addItem(tomato_seed, 1), reduceGold(130),
    write('Congratulations! Transaction completed. +1 Tomato seed in your inventory.'), nl.

/* Buy potato seed */
buy_potato_seed :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold < 150), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_potato_seed :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (LvlFarm < 4), write('You need to upgrade your farming level to level 4 before purchasing this item.'), nl.
buy_potato_seed :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold >= 150), LvlFarm >= 4, addItem(potato_seed, 1), reduceGold(150),
    write('Congratulations! Transaction completed. +1 Potato seed in your inventory.'), nl.

/* Buy Grade A food */
buy_grade_A_food :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold < 300), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_grade_A_food :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (LvlFish < 4), write('You need to upgrade your fishing level to level 4 before purchasing this item.'), nl.
buy_grade_A_food :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold >= 300), LvlFish >= 4, addItem(grade_a_food, 1), reduceGold(300),
    write('Congratulations! Transaction completed. +1 Grade A food in your inventory.'), nl.

/* Buy Grade B food */
buy_grade_B_food :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold < 200), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_grade_B_food :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (LvlFish < 2), write('You need to upgrade your fishing level to level 2 before purchasing this item.'), nl.
buy_grade_B_food :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold >= 200), addItem(grade_b_food, 1), reduceGold(200),
    write('Congratulations! Transaction completed. +1 Grade B food in your inventory.'), nl.

/* Buy Grade C food */
buy_grade_C_food :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold < 100), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_grade_C_food :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold >= 100), addItem(grade_c_food, 1), reduceGold(100),
    write('Congratulations! Transaction completed. +1 Grade C food in your inventory.'), nl.

/* Buy chicken food */
buy_chicken_food :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold < 100), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_chicken_food :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold >= 100), addItem(chicken_food, 1), reduceGold(100),
    write('Congratulations! Transaction completed. +1 Chicken food in your inventory.'), nl.

/* Buy cow food */
buy_cow_food :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold < 125), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_cow_food :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold >= 125), addItem(cow_food, 1), reduceGold(125),
    write('Congratulations! Transaction completed. +1 Cow food in your inventory.'), nl.

/* Buy sheep food */
buy_sheep_food :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold < 170), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_sheep_food :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold >= 170), addItem(sheep_food, 1), reduceGold(170),
    write('Congratulations! Transaction completed. +1 Sheep food in your inventory.'), nl.

/* Buy Equipment */
buyEquipment :- inMarket(_),
    write_ln('Welcome to the market!'),
    write_ln('Choose an equipment!'),
    write_ln('1. Shovel                         250 gold'),
    write_ln('2. Hand Fork                      150 gold'),
    write_ln('3. Watering Can                   300 gold'),
    write_ln('4. Fish Net                       200 gold'),
    write_ln('5. Rod                            100 gold'),
    write_ln('6. Milk Pail                      100 gold'),
    write_ln('7. Shears                         150 gold'),
    write_ln('Write the equipment ID!'), read(X),
        ( X=:=1 -> buy_shovel ;
          X=:=2 -> buy_hand_fork ;
          X=:=3 -> buy_watering_can ;
          X=:=4 -> buy_fishnet ;
          X=:=5 -> buy_rod ;
          X=:=6 -> buy_milk_pail ;
          X=:=7 -> buy_shears ).

/* Buy shovel */
buy_shovel :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold < 250), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_shovel :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (LvlFarm < 3), write('You need to upgrade your farming level to level 3 before purchasing this item.'), nl.
buy_shovel :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold >= 250), LvlFarm >= 3, addItem(shovel, 1), reduceGold(250),
    write('Congratulations! Transaction completed. +1 Shovel in your inventory.'), nl.

/* Buy hand fork */
buy_hand_fork :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold < 150), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_hand_fork :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold >= 150), addItem(hand_fork, 1), reduceGold(150),
    write('Congratulations! Transaction completed. +1 Hand fork in your inventory.'), nl.

/* Buy watering can */
buy_watering_can :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold < 300), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_watering_can :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold >= 300), addItem(watering_can, 1), reduceGold(300),
    write('Congratulations! Transaction completed. +1 Watering can in your inventory.'), nl.

/* Buy fish net */
buy_fishnet :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold < 200), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_fishnet :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (LvlFish < 3), write('You need to upgrade your fishing level to level 3 before purchasing this item.'), nl.
buy_fishnet :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold >= 200), LvlFish >= 3, addItem(fishnet, 1), reduceGold(200),
    write('Congratulations! Transaction completed. +1 Fishnet in your inventory.'), nl.

/* Buy rod */
buy_rod :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold < 100), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_rod :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold >= 100), addItem(rod, 1), reduceGold(100),
    write('Congratulations! Transaction completed. +1 Rod in your inventory.'), nl.

/* Buy milk pail */
buy_milk_pail :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold < 100), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_milk_pail :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold >= 100), addItem(milk_pail, 1), reduceGold(100),
    write('Congratulations! Transaction completed. +1 Milk pail in your inventory.'), nl.

/* Buy shears */
buy_shears :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold < 150), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_shears :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold),
    (Gold >= 150), addItem(shears, 1), reduceGold(150),
    write('Congratulations! Transaction completed. +1 Shears in your inventory.'), nl.

/* Sell items */
sell :- inMarket(_),
    write_ln('Welcome to the market!'),
    write_ln('What do you want to sell?'),
    write_ln('1. Shovel                         250 gold'),
    write_ln('2. Hand Fork                      150 gold'),
    write_ln('3. Watering Can                   300 gold'),
    write_ln('4. Fish Net                       200 gold'),
    write_ln('5. Rod                            100 gold'),
    write_ln('6. Milk Pail                      100 gold'),
    write_ln('7. Shears                         150 gold'),
    write_ln('Write the equipment ID!'), read(X),
        ( X=:=1 -> sell_ ;
          X=:=2 -> sell_ ;
          X=:=3 -> sell_ ;
          X=:=4 -> sell_ ;
          X=:=5 -> sell_ ;
          X=:=6 -> sell_ ;
          X=:=7 -> sell_ ).

sell_ :- 
    player(Job, Lvl, LvlFarm, ExpFarm, LvlFish, ExpFish, LvlRanch, ExpRanch, Exp, Gold).

/* Exit market */
exitMarket :- \+inMarket, nl, write_ln('Anda belum berada di market.').
exitMarket :- inMarket, nl, write_ln('Terima kasih sudah berkunjung ke market! Sampai jumpa kembali!').
