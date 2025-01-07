/* Battleships
* Author:- D. V. Sandaru Rashmika
* UOW_ID :- w1867090
* IIT ID :- 20210334
* Creation date: 2024-11-29
*
* Two-Player Battleship Game - B method Specification
*
* Modular Battleships Machine
 * Refined implementation using modular B method approach
 */
MACHINE
    MainBattleship
    
SEES
    GridMachine,
    Player,
    GameStates,
    Animations

INCLUDES
    PlayerOperations

PROMOTES
    deployFleet,
    playerShoots,
    shipLocations,
    playerShipsLeft,
    shotsFiredTaken,
    gameStatus
END