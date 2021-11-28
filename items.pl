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

/* item(name, qty, price, level, farmLevel, fishLevel, ranchLevel) */

/** Farming **/
/* Farm product */
item(carrot, 0, 0, 0, 0, 0, 0).
item(sweet_potato, 0, 0, 0, 0, 0, 0).
item(cassava, 0, 0, 0, 0, 0, 0).
item(corn, 0, 0, 0, 0, 0, 0).
item(tomato, 0, 0, 0, 0, 0, 0).
item(potato, 0, 0, 0, 0, 0, 0).
/* Item */
item(carrot_seed, 0, 50, 0, 1, 0, 0).
item(sweet_potato_seed, 0, 80, 0, 1, 0, 0).
item(cassava_seed, 0, 120, 0, 1, 0, 0).
item(corn_seed, 0, 140, 0, 2, 0, 0).
item(tomato_seed, 0, 130, 0, 3, 0, 0).
item(potato_seed, 0, 150, 0, 4, 0, 0).
/* Equipment */
item(shovel_1, 0, 250, 1, 3, 0, 0).
item(shovel_2, 0, 250, 2, 3, 0, 0).
item(hand_fork_1, 0, 150, 1, 1, 0, 0).
item(hand_fork_2, 0, 150, 2, 1, 0, 0).
item(watering_can_1, 0, 300, 1, 1, 0, 0).
item(watering_can_2, 0, 300, 2, 1, 0, 0).

/** Fishing **/
/* Fish product */
item(salmon, 0, 0, 0, 0, 0, 0).
item(tuna, 0, 0, 0, 0, 0, 0).
item(mahi_mahi, 0, 0, 0, 0, 0, 0).
item(red_snapper, 0, 0, 0, 0, 0, 0).
item(catfish, 0, 0, 0, 0, 0, 0).
/* Item */
item(grade_a_food, 0, 300, 0, 0, 4, 0).
item(grade_b_food, 0, 200, 0, 0, 2, 0).
item(grade_c_food, 0, 100, 0, 0, 1, 0).
/* Equipment */
item(fishnet_1, 0, 250, 1, 0, 3, 0).
item(fishnet_2, 0, 250, 2, 0, 3, 0).
item(rod_1, 0, 100, 1, 0, 1, 0).
item(rod_2, 0, 100, 2, 0, 1, 0).

/** Farming **/
/* Farm product */
item(chicken_egg, 0, 0, 0, 0, 0).
item(milk, 0, 0, 0, 0, 0, 0).
item(wool, 0, 0, 0, 0, 0, 0).
/* Item */
item(chicken, 0, 500, 0, 0, 0, 1).
item(cow, 0, 1000, 0, 0, 0, 1).
item(sheep, 0, 1500, 0, 0, 0, 1).
/* Equipment */
item(milk_pail_1, 0, 100, 1, 0, 0, 1).
item(milk_pail_2, 0, 100, 2, 0, 0, 1).
item(shears_1, 0, 150, 1, 0, 0, 1).
item(shears_2, 0, 150, 2, 0, 0, 1).