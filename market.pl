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
          X=:=4 -> buy_fish_net ;
          X=:=5 -> buy_rod ;
          X=:=6 -> buy_milk_pail ;
          X=:=7 -> buy_shears ).

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
        ( X=:=1 -> buy_shovel ;
          X=:=2 -> buy_hand_fork ;
          X=:=3 -> buy_watering_can ;
          X=:=4 -> buy_fish_net ;
          X=:=5 -> buy_rod ;
          X=:=6 -> buy_milk_pail ;
          X=:=7 -> buy_shears ).

/* Exit market */
exitMarket :- \+inMarket, nl, write_ln('Anda belum berada di market.').
exitMarket :- inMarket, nl, write_ln('Terima kasih sudah berkunjung ke market! Sampai jumpa kembali!').
