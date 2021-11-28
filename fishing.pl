:- include('player.pl').
:- include('inventory.pl').

:- dynamic(range/2).

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
    isNearWater('true'),!,
    range(MIN,MAX),!,
    random(MIN,MAX,VALUE),
    (
        between(45,50,VALUE) -> addItem(salmon,1),write('You got salmon!'),nl,write('You gained 50 fishing exp!'),addExpFishing(50);
        between(36,45,VALUE) -> addItem(tuna,1),write('You got tuna!'),nl,write('You gained 40 fishing exp!'),addExpFishing(40);
        between(26,35,VALUE) -> addItem(mahi_mahi,1),write('You got mahi-mahi!'),nl,write('You gained 30 fishing exp!'),addExpFishing(30);
        between(16,25,VALUE) -> addItem(red_snapper,1),write('You got red_snapper!'),nl,write('You gained 20 fishing exp!'),addExpFishing(20);
        between(6,15,VALUE) -> addItem(catfish,1),write('You got catfish!'),nl,write('You gained 10 fishing exp!'),addExpFishing(10);
        write('You didn\'t get anything! '),nl,write('You gained 5 fishing exp!'),addExpFishing(5)
    ).

/* tambahin tiap naik level */
increaseOpportunity :-
    range(MIN,MAX),!,
    NEW_MAX is MAX + 7,
    retract(range(MIN,MAX)),
    asserta(range(MIN,NEW_MAX)).