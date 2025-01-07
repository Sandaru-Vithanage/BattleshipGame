/* Modular Battleships Machine
 * Refined implementation using modular B method approach
 */
MACHINE
    MainMachine
    
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

VARIABLES
    playerShips,       // Ship positions for each player
    currentGameState,  // Current overall game state
    shotsFired,        // Number of shots fired by each player
    currentPlayer,     // Player whose turn it currently is
    hittedShots,       // Coordinates of successful shots for each player
    missedShots        // Coordinates of missed shots for each player

INVARIANT
    playerShips : PLAYER --> POW(Grid) &             // Ships mapped to players
    card(playerShips(Player1)) <= MaxShips &         // Max ships for Player 1
    card(playerShips(Player2)) <= MaxShips &         // Max ships for Player 2
    shotsFired : PLAYER --> NAT &                    // Shots are non-negative integers
    currentGameState : GAME_STATUS &                 // Validate game state
    currentPlayer : PLAYER &                         // Current player is valid
    hittedShots : PLAYER --> POW(Grid) &             // Hit shot coordinates
    missedShots : PLAYER --> POW(Grid)               // Missed shot coordinates

INITIALISATION
    playerShips := {Player1 |-> {}, Player2 |-> {}} ||
    shotsFired := {Player1 |-> 0, Player2 |-> 0} ||
    currentGameState := Game_Setup ||
    currentPlayer := Player1 ||
    hittedShots := {Player1 |-> {}, Player2 |-> {}} ||
    missedShots := {Player1 |-> {}, Player2 |-> {}}

END