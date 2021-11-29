/*** FACTS ***/
:- include('items.pl').
:- include('player.pl').
:- include('map.pl').

:- dynamic(inMarket/0).
:- dynamic(market/0).
:- dynamic(buy/0).
:- dynamic(sell/1).
:- dynamic(exitMarket/0).

/*** RULES ***/

/* Fail to enter the market */
market :- \+gameStarted, !, write('Please type "start" first to start the game and enter the marketplace!').
/* market :- isOnMarket(Hasil), \+Hasil = 'true', !, write('Please go to the marketplace first!'). */

/* Entering the market */
/*assertz(inMarket), --> janlup tambahin ini pi klo dah ada posisi playernya*/
/*isOnMarket(Hasil), Hasil = 'true',*/
market :- objPeta(X,Y,'M'), objPeta(X,Y,'P'), assertz(inMarket),
        write('What do you want to do?'), nl,
        write('1. Buy'), nl,
        write('2. Sell'),nl,
        write('> '),read(Z), (Z =:= 1 -> buy; Z =:= 2 -> sell), nl, !.
market :- \+inMarket, !, write('Please go to the marketplace first!').

/* Buy */
buy :- 
    write('What do you want to buy?'), nl,
    write('1. Items'), nl,
    write('2. Equipment'), nl,
    write('> '),read(X), (X =:= 1 -> buyItems; X =:= 2 -> buyEquipment).

buyItems :- 
    write('Welcome to the market!'),nl,
    write('Choose an item!'),nl,
    write('1. Carrot Seed                    50 gold'),nl,
    write('2. Sweet Potato Seed              80 gold'),nl,
    write('3. Cassava Seed                   120 gold'),nl,
    write('4. Corn Seed                      140 gold'),nl,
    write('5. Tomato Seed                    130 gold'),nl,
    write('6. Potato Seed                    150 gold'),nl,
    write('7. Grade A Food                   300 gold'),nl,
    write('8. Grade B Food                   200 gold'),nl,
    write('9. Grade C Food                   100 gold'),nl,
    write('10. Chicken                       500 gold'),nl,
    write('11. Cow                           1000 gold'),nl,
    write('12. Sheep                         1500 gold'),nl,
    write('Write the item ID!'),nl, write('> '),read(X),
        ( X=:=1 -> buy_carrot_seed ;
          X=:=2 -> buy_sweet_potato_seed ;
          X=:=3 -> buy_cassava_seed ;
          X=:=4 -> buy_corn_seed ;
          X=:=5 -> buy_tomato_seed ;
          X=:=6 -> buy_potato_seed ;
          X=:=7 -> buy_grade_A_food ;
          X=:=8 -> buy_grade_B_food ;
          X=:=9 -> buy_grade_C_food ;
          X=:=10 -> buy_chicken ;
          X=:=11 -> buy_cow ;
          X=:=12 -> buy_sheep ).

/* Buy carrot seed */
buy_carrot_seed :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 50), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_carrot_seed :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold >= 50), addItem(carrot_seed, 1), reduceGold(50),
    write('Congratulations! Transaction completed. +1 Carrot seed in your inventory.'), nl.

/* Buy sweet potato seed */
buy_sweet_potato_seed :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 80), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_sweet_potato_seed :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold >= 80), addItem(sweet_potato_seed, 1), reduceGold(80),
    write('Congratulations! Transaction completed. +1 Sweet potato seed in your inventory.'), nl.

/* Buy cassava seed */
buy_cassava_seed :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 120), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_cassava_seed :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold >= 120), addItem(cassava_seed, 1), reduceGold(120),
    write('Congratulations! Transaction completed. +1 Cassava seed in your inventory.'), nl.

/* Buy corn seed */
buy_corn_seed :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 140), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_corn_seed :- 
    player(_, _,LvlFarm, _, _, _, _, _, _, _),
    (LvlFarm < 2), write('You need to upgrade your farming level to level 2 before purchasing this item.'), nl.
buy_corn_seed :- 
    player(_, _, LvlFarm, _, _, _, _, _, _, Gold),
    (Gold >= 140), LvlFarm >= 2, addItem(corn_seed, 1), reduceGold(140),
    write('Congratulations! Transaction completed. +1 Corn seed in your inventory.'), nl.

/* Buy tomato seed */
buy_tomato_seed :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 130), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_tomato_seed :- 
    player(_, _, LvlFarm, _, _, _, _, _, _, _),
    (LvlFarm < 3), write('You need to upgrade your farming level to level 3 before purchasing this item.'), nl.
buy_tomato_seed :- 
    player(_, _, LvlFarm, _, _, _, _, _, _, Gold),
    (Gold >= 130), LvlFarm >=3, addItem(tomato_seed, 1), reduceGold(130),
    write('Congratulations! Transaction completed. +1 Tomato seed in your inventory.'), nl.

/* Buy potato seed */
buy_potato_seed :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 150), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_potato_seed :- 
    player(_, _, LvlFarm, _, _, _, _, _, _, _),
    (LvlFarm < 4), write('You need to upgrade your farming level to level 4 before purchasing this item.'), nl.
buy_potato_seed :- 
    player(_, _, LvlFarm, _, _, _, _, _, _, Gold),
    (Gold >= 150), LvlFarm >= 4, addItem(potato_seed, 1), reduceGold(150),
    write('Congratulations! Transaction completed. +1 Potato seed in your inventory.'), nl.

/* Buy Grade A food */
buy_grade_A_food :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 300), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_grade_A_food :- 
    player(_, _, _, _, LvlFish, _, _, _, _, _),
    (LvlFish < 4), write('You need to upgrade your fishing level to level 4 before purchasing this item.'), nl.
buy_grade_A_food :- 
    player(_, _, _, _, LvlFish, _, _, _, _, Gold),
    (Gold >= 300), LvlFish >= 4, addItem(grade_a_food, 1), reduceGold(300),
    write('Congratulations! Transaction completed. +1 Grade A food in your inventory.'), nl.

/* Buy Grade B food */
buy_grade_B_food :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 200), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_grade_B_food :- 
    player(_, _, _, _, LvlFish, _, _, _, _, _),
    (LvlFish < 2), write('You need to upgrade your fishing level to level 2 before purchasing this item.'), nl.
buy_grade_B_food :- 
    player(_, _, _, _, LvlFish, _, _, _, _, Gold),
    (Gold >= 200), LvlFish >= 2, addItem(grade_b_food, 1), reduceGold(200),
    write('Congratulations! Transaction completed. +1 Grade B food in your inventory.'), nl.

/* Buy Grade C food */
buy_grade_C_food :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 100), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_grade_C_food :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold >= 100), addItem(grade_c_food, 1), reduceGold(100),
    write('Congratulations! Transaction completed. +1 Grade C food in your inventory.'), nl.

/* Buy chicken */
buy_chicken :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 500), write('It seems like your money is not enough to buy this cute little chicken.'), nl.
buy_chicken :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold >= 500), addItem(chicken, 1), reduceGold(500),
    write('Congratulations! Transaction completed. Please raise your chicken wisely.'), nl.

/* Buy cow */
buy_cow :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 1000), write('It seems like your money is not enough to buy this cute little cow.'), nl.
buy_cow :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold >= 1000), addItem(cow, 1), reduceGold(1000),
    write('Congratulations! Transaction completed. Please raise your cow wisely.'), nl.

/* Buy sheep */
buy_sheep :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 1500), write('It seems like your money is not enough to buy this cute little sheep.'), nl.
buy_sheep :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold >= 1500), addItem(sheep, 1), reduceGold(1500),
    write('Congratulations! Transaction completed. Please raise your sheep wisely.'), nl.

/* Buy Equipment */
buyEquipment :- 
    write('Welcome to the market!'),nl,
    write('Choose an equipment!'),nl,
    write('1. Shovel Level 1                 250 gold'), nl,
    write('2. Shovel Level 2                 500 gold'), nl,
    write('3. Hand Fork Level 1              150 gold'), nl,
    write('4. Hand Fork Level 2              300 gold'), nl,
    write('5. Fish Net Level 1               250 gold'), nl,
    write('6. Fish Net Level 2               500 gold'), nl,
    write('7. Rod Level 1                    100 gold'), nl,
    write('8. Rod Level 2                    200 gold'), nl,
    write('9. Milk Pail Level 1              100 gold'), nl,
    write('10. Milk Pail Level 2              200 gold'), nl,
    write('11. Shears Level 1                 150 gold'), nl,
    write('12. Shears Level 2                 300 gold'), nl,
    write('Write the equipment ID!'), nl, write('> '),read(X),
        ( X=:=1 -> buy_shovel_1 ;
        X=:=2 -> buy_shovel_2 ;
        X=:=3 -> buy_hand_fork_1 ;
        X=:=4 -> buy_hand_fork_2 ;
        X=:=5 -> buy_fishnet_1 ;
        X=:=6 -> buy_fishnet_2 ;
        X=:=7 -> buy_rod_1 ;
        X=:=8 -> buy_rod_2 ;
        X=:=9 -> buy_milk_pail_1 ;
        X=:=10 -> buy_milk_pail_2 ;
        X=:=11 -> buy_shears_1 ;
        X=:=12 -> buy_shears_2 ;! ).

/* Buy shovel level 1 */
buy_shovel_1 :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 250), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_shovel_1 :- 
    player(_, _, LvlFarm, _, _, _, _, _, _, _),
    (LvlFarm < 3), write('You need to upgrade your farming level to level 3 before purchasing this item.'), nl.
buy_shovel_1 :- 
    player(_, _, LvlFarm, _, _, _, _, _, _, Gold),
    (Gold >= 250), LvlFarm >= 3, addItem(shovel_1, 1), reduceGold(250),
    write('Congratulations! Transaction completed. +1 Shovel Level 1 in your inventory.'), nl.

/* Buy shovel level 2 */
buy_shovel_2 :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 500), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_shovel_2 :- 
    player(_, _, LvlFarm, _, _, _, _, _, _, _),
    (LvlFarm < 10), write('You need to upgrade your farming level to level 10 before purchasing this item.'), nl.
buy_shovel_2 :- 
    player(_, _, LvlFarm, _, _, _, _, _, _, Gold),
    (Gold >= 500), LvlFarm >= 10, addItem(shovel_2, 1), reduceGold(500),
    write('Congratulations! Transaction completed. +1 Shovel Level 2 in your inventory.'), nl.

/* Buy hand fork level 1 */
buy_hand_fork_1 :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 150), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_hand_fork_1 :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold >= 150), addItem(hand_fork_1, 1), reduceGold(150),
    write('Congratulations! Transaction completed. +1 Hand fork Level 1 in your inventory.'), nl.

/* Buy hand fork level 2 */
buy_hand_fork_2 :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 300), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_hand_fork_2 :- 
    player(_, _, LvlFarm, _, _, _, _, _, _, _),
    (LvlFarm < 5), write('You need to upgrade your farming level to level 5 before purchasing this item.'), nl.
buy_hand_fork_2 :- 
    player(_, _, LvlFarm, _, _, _, _, _, _, Gold),
    (Gold >= 300), LvlFarm >= 5, addItem(hand_fork_2, 1), reduceGold(300),
    write('Congratulations! Transaction completed. +1 Hand fork Level 2 in your inventory.'), nl.

/* Buy fish net level 1*/
buy_fishnet_1 :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 250), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_fishnet_1 :- 
    player(_, _, _, _, LvlFish, _, _, _, _, _),
    (LvlFish < 3), write('You need to upgrade your fishing level to level 3 before purchasing this item.'), nl.
buy_fishnet_1 :- 
    player(_, _, _, _, LvlFish, _, _, _, _, Gold),
    (Gold >= 250), LvlFish >= 3, addItem(fishnet_1, 1), reduceGold(250),
    write('Congratulations! Transaction completed. +1 Fishnet Level 1 in your inventory.'), nl.

/* Buy fish net level 2*/
buy_fishnet_2 :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 500), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_fishnet_1 :- 
    player(_, _, _, _, LvlFish, _, _, _, _, _),
    (LvlFish < 10), write('You need to upgrade your fishing level to level 10 before purchasing this item.'), nl.
buy_fishnet_1 :- 
    player(_, _, _, _, LvlFish, _, _, _, _, Gold),
    (Gold >= 500), LvlFish >= 10, addItem(fishnet_2, 1), reduceGold(500),
    write('Congratulations! Transaction completed. +1 Fishnet Level 2 in your inventory.'), nl.

/* Buy rod level 1 */
buy_rod_1 :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 100), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_rod_1 :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold >= 100), addItem(rod_2, 1), reduceGold(100),
    write('Congratulations! Transaction completed. +1 Rod Level 1 in your inventory.'), nl.

/* Buy rod level 2 */
buy_rod_2 :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 200), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_rod_2 :- 
    player(_, _, _, _, LvlFish, _, _, _, _, _),
    (LvlFish < 5), write('You need to upgrade your fishing level to level 10 before purchasing this item.'), nl.
buy_rod_2 :- 
    player(_, _, _, _, LvlFish, _, _, _, _, Gold),
    (Gold >= 200), LvlFish >= 5, addItem(rod_2, 1), reduceGold(200),
    write('Congratulations! Transaction completed. +1 Rod Level 2 in your inventory.'), nl.

/* Buy milk pail level 1*/
buy_milk_pail_1 :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 100), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_milk_pail_1 :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold >= 100), addItem(milk_pail_1, 1), reduceGold(100),
    write('Congratulations! Transaction completed. +1 Milk pail Level 1 in your inventory.'), nl.

/* Buy milk pail level 2*/
buy_milk_pail_2 :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 200), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_milk_pail_2 :- 
    player(_, _, _, _, _, _, LvlRanch, _, _, _),
    (LvlRanch < 5), write('You need to upgrade your ranching level to level 10 before purchasing this item.'), nl.
buy_milk_pail_2 :- 
    player(_, _, _, _, _, _, LvlRanch, _, _, Gold),
    (Gold >= 200), LvlRanch >=5, addItem(milk_pail_2, 1), reduceGold(200),
    write('Congratulations! Transaction completed. +1 Milk pail Level 2 in your inventory.'), nl.

/* Buy shears level 1*/
buy_shears_1 :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 150), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_shears_1 :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold >= 150), addItem(shears_1, 1), reduceGold(150),
    write('Congratulations! Transaction completed. +1 Shears Level 1 in your inventory.'), nl.

/* Buy shears level 2*/
buy_shears_2 :- 
    player(_, _, _, _, _, _, _, _, _, Gold),
    (Gold < 300), write('It seems like your money is not enough to buy this item T__T'), nl.
buy_shears_2 :- 
    player(_, _, _, _, _, _, LvlRanch, _, _, _),
    (LvlRanch < 5), write('You need to upgrade your ranching level to level 10 before purchasing this item.'), nl.
buy_shears_2 :- 
    player(_, _, _, _, _, _, LvlRanch, _, _, Gold),
    (Gold >= 300), LvlRanch >=5, addItem(milk_pail_2, 1), reduceGold(300),
    write('Congratulations! Transaction completed. +1 Shears Level 2 in your inventory.'), nl.

/* Sell items */
sell :- 
    write('Welcome to the market!'), nl,
    write('What do you want to sell?'), nl,
    amountItem(salmon, Sa),
    write('1. Salmon (1000 gold) -> '), write(Sa), nl,
    amountItem(tuna, Ta),
    write('2. Tuna (500 gold) -> '), write(Ta), nl,
    amountItem(mahi_mahi, Mma),
    write('3. Mahi-mahi (600 gold) -> '), write(Mma), nl,
    amountItem(red_snapper, Rsa),
    write('4. Red Snapper (400 gold) -> '), write(Rsa), nl,
    amountItem(catfish, Ca),
    write('5. Catfish (100 gold) -> '), write(Ca), nl,
    amountItem(milk, Ma),
    write('6. Milk (200 gold) -> '), write(Ma), nl,
    amountItem(chicken_egg, Cea),
    write('7. Chicken Egg (100 gold) -> '), write(Cea), nl,
    amountItem(wool, Wa),
    write('8. Wool (500 gold) -> '), write(Wa), nl,
    amountItem(carrot, Cra),
    write('9. Carrot (200 gold) -> '), write(Cra), nl,
    amountItem(sweet_potato, Spa),
    write('10. Sweet Potato (300 gold) -> '), write(Spa), nl,
    amountItem(cassava, Csa),
    write('11. Cassava (250 gold) -> '), write(Csa), nl,
    amountItem(corn, Crna),
    write('12. Corn (400 gold) -> '), write(Crna), nl,
    amountItem(tomato, Tma),
    write('13. Tomato (300 gold) -> '), write(Tma), nl,
    amountItem(potato, Pa),
    write('14. Potato (350 gold) -> '), write(Pa), nl,
    write('Write the item ID!'), nl,write('> '),read(X),
        ( X=:=1 -> sell(salmon) ;
          X=:=2 -> sell(tuna) ;
          X=:=3 -> sell(mahi_mahi) ;
          X=:=4 -> sell(red_snapper) ;
          X=:=5 -> sell(catfish) ;
          X=:=6 -> sell(milk) ;
          X=:=7 -> sell(chicken_egg) ;
          X=:=8 -> sell(wool) ;
          X=:=9 -> sell(carrot) ;
          X=:=10 -> sell(sweet_potato) ;
          X=:=11 -> sell(cassava) ; 
          X=:=12 -> sell(corn) ;
          X=:=13 -> sell(tomato) ;
          X=:=14 -> sell(potato) ).

/* Sell failed template */
sell(Item) :-  
    amountItem(Item, X), (X==0),
    write('You dont have this item in your inventory. Sorry....'), nl.
/* Sell succeed template */
sell(Item) :- 
    amountItem(Item, X), (X>0), item(Item, _, Price, _, _, _, _),
    write('How many do you want to sell?'), nl, write('> '),read(Amount),
    ((Amount < X ; Amount == X), dropItems(Item, Amount), 
    Earn is Price * Amount, addGold(Earn),
    write('Transaction completed!'), nl) ;
    (Amount > X, write('Hmm... you dont have that much.. sorry..'), nl ).

/* Exit market */
exitMarket :- \+inMarket, nl, write('You\'re not in the market.'), nl.
exitMarket :- inMarket, retract(inMarket), nl, write('Thanks for visiting the market! Please come back soon!'), nl.
