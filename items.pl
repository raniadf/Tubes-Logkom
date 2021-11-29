/*** FACTS ***/
:- dynamic(item/7).

/* Item terdiri atas data-data sebagai berikut:
    1. Name
    2. Quantity
    3. Price              
    4. Level                    
    5. Minimum Farming Level
    6. Minimum fishing Level
    7. Minimum ranching level
*/

/** Farming **/
/* Farm product */
item(carrot, 0, 200, 0, 0, 0, 0).
item(sweet_potato, 0, 300, 0, 0, 0, 0).
item(cassava, 0, 250, 0, 0, 0, 0).
item(corn, 0, 0, 400, 0, 0, 0).
item(tomato, 0, 300, 0, 0, 0, 0).
item(potato, 0, 350, 0, 0, 0, 0).
/* Item */
item(carrot_seed, 0, 50, 0, 1, 0, 0).
item(sweet_potato_seed, 0, 80, 0, 1, 0, 0).
item(cassava_seed, 0, 120, 0, 1, 0, 0).
item(corn_seed, 0, 140, 0, 2, 0, 0).
item(tomato_seed, 0, 130, 0, 3, 0, 0).
item(potato_seed, 0, 150, 0, 4, 0, 0).
/* Equipment */
item(shovel_1, 0, 250, 1, 3, 0, 0).
item(shovel_2, 0, 500, 2, 10, 0, 0).
item(hand_fork_1, 0, 150, 1, 1, 0, 0).
item(hand_fork_2, 0, 300, 2, 5, 0, 0).

/** Fishing **/
/* Fish product */
item(salmon, 0, 1000, 0, 0, 0, 0).
item(tuna, 0, 0, 500, 0, 0, 0).
item(mahi_mahi, 0, 600, 0, 0, 0, 0).
item(red_snapper, 0, 400, 0, 0, 0, 0).
item(catfish, 0, 100, 0, 0, 0, 0).
/* Item */
item(grade_a_food, 0, 300, 0, 0, 4, 0).
item(grade_b_food, 0, 200, 0, 0, 2, 0).
item(grade_c_food, 0, 100, 0, 0, 1, 0).
/* Equipment */
item(fishnet_1, 0, 250, 1, 0, 3, 0).
item(fishnet_2, 0, 500, 2, 0, 10, 0).
item(rod_1, 0, 100, 1, 0, 1, 0).
item(rod_2, 0, 200, 2, 0, 5, 0).

/** Ranching **/
/* Ranch product */
item(chicken_egg, 0, 100, 0, 0, 0, 0).
item(milk, 0, 0, 200, 0, 0, 0).
item(wool, 0, 0, 0, 0, 0, 0).
/* Item */
item(chicken, 0, 500, 0, 0, 0, 1).
item(cow, 0, 1000, 0, 0, 0, 1).
item(sheep, 0, 1500, 0, 0, 0, 1).
/* Equipment */
item(milk_pail_1, 0, 100, 1, 0, 0, 1).
item(milk_pail_2, 0, 200, 2, 0, 0, 5).
item(shears_1, 0, 150, 1, 0, 0, 1).
item(shears_2, 0, 300, 2, 0, 0, 5).

/*** Rules ***/
/* Print Item */
printItem(Item) :-
    ( Item == carrot -> write('Carrot') ;
    Item == sweet_potato -> write('Sweet Potato') ;
    Item == cassava -> write('Cassava') ; 
    Item == corn -> write('Corn') ;
    Item == tomato -> write('Tomato') ;
    Item == potato -> write('Potato') ;
    Item == carrot_seed -> write('Carrot Seed') ;
    Item == sweet_potato_seed -> write('Sweet Potato Seed') ;
    Item == cassava_seed -> write('Cassava Seed') ;
    Item == corn_seed -> write('Corn Seed') ;
    Item == tomato_seed -> write('Tomato Seed') ;
    Item == potato_seed -> write('Potato Seed') ;
    Item == shovel_1 -> write('Shovel');
    Item == shovel_2 -> write('Shovel');
    Item == hand_fork_1 -> write('Hand Fork');
    Item == hand_fork_2 -> write('Hand Fork');
    Item == salmon -> write('Salmon');
    Item == tuna -> write('Tuna');
    Item == mahi_mahi -> write('Mahi-Mahi');
    Item == red_snapper -> write('Red Snapper');
    Item == catfish -> write('Catfish');
    Item == grade_a_food -> write('Grade A Food');
    Item == grade_b_food -> write('Grade B Food');
    Item == grade_c_food -> write('Grade C Food'):
    Item == fishnet_1 -> write('Fishnet');
    Item == fishnet_2 -> write('Fishnet');
    Item == rod_1 -> write('Fishing Rod');
    Item == rod_2 -> write('Fishing Rod');
    Item == chicken_egg -> write('Chicken Egg');
    Item == milk -> write('Milk');
    Item == wool -> write('Wool');
    Item == chicken -> write('Chicken');
    Item == cow -> write('Cow');
    Item == sheep -> write('Sheep');
    Item == milk_pail_1 -> write('Milk Pail');
    Item == milk_pail_2 -> write('Milk Pail') :
    Item == shears_1 -> write('Shears') ;
    Item == shears_2 -> write('Shears')), !.