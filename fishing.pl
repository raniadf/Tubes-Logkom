:- include('player.pl').
:- include('inventory.pl').

:- dynamic(range/2).
:- dynamic(fishAmount/1).

fishAmount(1).

range(1,15).
maxRange(55).

/* IDENYA */
% 1-5 gadapet ikan
% 6-15 dapet catfish
% 16-25 dapet red_snapper
% 26-35 dapet mahi_mahi
% 36-45 dapet tuna
% 46-50 dapet salmon

fish :-
    \+ isNearWater('true'),!,
    write('You have to be near a water tile to fish!'),nl.

fish :-
    \+ haveFishingRod,!,
    write('You have own a fishing rod to fish'),nl.

fish :-
    isNearWater('true'),!,
    write('Choose your fishing tool: '),nl,
    write('1. Fishnet level 1'),nl,
    write('2. Fishnet level 2'),nl,
    write('3. Fishing rod level 1'),nl,
    write('4. Fishing rod level 2'),nl,
    write('>'),read(A),
    (
        chooseEquipment(A) -> range(MIN,MAX),!,
        random(MIN,MAX,VALUE),fishAmount(Amount),
        (
        between(45,50,VALUE) -> addItem(salmon,Amount),write('You got salmon!'),nl,addExpFishing(50);
        between(36,45,VALUE) -> addItem(tuna,Amount),write('You got tuna!'),nl,addExpFishing(40);
        between(26,35,VALUE) -> addItem(mahi_mahi,Amount),write('You got mahi-mahi!'),nl,addExpFishing(30);
        between(16,25,VALUE) -> addItem(red_snapper,Amount),write('You got red_snapper!'),nl,addExpFishing(20);
        between(6,15,VALUE) -> addItem(catfish,Amount),write('You got catfish!'),nl,addExpFishing(10);
        write('You didn\'t get anything! '),nl,addExpFishing(5)
        ),addDay;
        write('You don\'t have the equipment, you have to buy it first'),nl
    ).
    

/* tambahin tiap naik level */
increaseOpportunity :-
    range(MIN,MAX),!,
    (
        MAX < 50 -> NEW_MAX is MAX + 7,retract(range(MIN,MAX)),asserta(range(MIN,NEW_MAX));
       !
    )
    .

haveFishingRod :-
    amountItem(fishnet_1,A),!,
    amountItem(fishnet_2,B),!,
    amountItem(rod_1,C),!,
    amountItem(rod_2,D),!,
    (
        A >0;B >0;C>0;D>0
    ).

haveEquipment(Equipment) :-
    amountItem(Equipment,A),
    A > 0.

chooseEquipment(A) :-
    (
        A =:= 1 -> 
        (
            haveEquipment(fishnet_1)-> resetFishAmount,addFishAmount(1);
            fail
        );
        A =:= 2 -> 
        (
            haveEquipment(fishnet_2)-> resetFishAmount,addFishAmount(2);
            fail
        );
        A =:= 3 -> 
        (
            haveEquipment(rod_1)-> resetFishAmount;
            fail
        );

        A =:= 4 -> 
        (
            haveEquipment(rod_2) -> resetFishAmount, increaseOpportunity;
            fail
        );
        !
    ).

addFishAmount(X) :-
    fishAmount(Amount),!,
    NEW_Amount is Amount + X,
    retract(fishAmount(Amount)),
    asserta(fishAmount(NEW_Amount)).

resetFishAmount :-
    fishAmount(Amount),!,
    NEW_Amount is 1,
    retract(fishAmount(Amount)),
    asserta(fishAmount(NEW_Amount)).
