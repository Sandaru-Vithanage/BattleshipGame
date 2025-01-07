/* Battleships
* Author:- D. V. Sandaru Rashmika
* UOW_ID :- w1867090
* IIT ID :- 20210334
* Creation date: 2024-11-29
*
* Two-Player Battleship Game - B method Specification
*
* Animation Machine
 * Defines visualization and animation functions for Battleships game
 */
MACHINE
    Animations
    
SEES
    GridMachine,
    Player,
    GameStates

DEFINITIONS
    // Empty grid cell visualization
    ANIMATION_FUNCTION == ({ row, col, img | 
        col: 1..10 & 
        row: 1..21 & 
        img=0 
    });

    // Separator row visualization
    ANIMATION_FUNCTION1 == ({ row, col, img | 
        col: 1..10 & 
        row: {11} & 
        img=4 
    });

    // Player 1's ship visualization
    ANIMATION_FUNCTION2(playerShips) == ({ row, col, img | 
        col: 1..10 & 
        row: 1..10 & 
        img=1 & 
        (11-col, row) : playerShips(Player1) 
    });

    // Player 2's ship visualization
    ANIMATION_FUNCTION3(playerShips) == ({ row, col, img | 
        col: 1..10 & 
        row: 1..21 & 
        img=2 & 
        (col, 21-row) : playerShips(Player2) 
    });
    
    // Visualization of hit shots on Player 2's grid
    ANIMATION_FUNCTION4(hittedShots) == ({ row, col, img | 
        col: 1..10 & 
        row: 1..10 & 
        img=3 & 
        (11-col, row) : hittedShots(Player2) 
    });

    // Visualization of hit shots on Player 1's grid
    ANIMATION_FUNCTION5(hittedShots) == ({ row, col, img | 
        col: 1..10 & 
        row: 1..21 & 
        img=3 & 
        (col, 21-row) : hittedShots(Player1) 
    });
    
    // Visualization of missed shots on Player 1's grid
    ANIMATION_FUNCTION6(missedShots) == ({ row, col, img | 
        col: 1..10 & 
        row: 1..10 & 
        img=5 & 
        (11-col, row) : missedShots(Player2) 
    });

    // Visualization of missed shots on Player 2's grid
    ANIMATION_FUNCTION7(missedShots) == ({ row, col, img | 
        col: 1..10 & 
        row: 1..21 & 
        img=5 & 
        (col, 21-row) : missedShots(Player1) 
    });
                         
    // Image path definitions for different game states
    ANIMATION_IMG0 == "images/empty_cell.gif";     // Empty grid cell
    ANIMATION_IMG1 == "images/player1_ship.gif";   // Player 1's ships
    ANIMATION_IMG2 == "images/player2_ship.gif";   // Player 2's ships
    ANIMATION_IMG3 == "images/target.gif";         // Targeted cell
    ANIMATION_IMG4 == "images/seperator.gif";      // Separator row
    ANIMATION_IMG5 == "images/wrong_target.gif";   // Missed shot marker

END