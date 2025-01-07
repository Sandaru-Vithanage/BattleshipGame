/* Battleships
 * Author:- D. V. Sandaru Rashmika
 * UOW_ID :- w1867090
 * IIT ID :- 20210334
 * Creation date: 2024-11-29
 * 
 * Two-Player Battleship Game - B method Specification
 */
MACHINE
    Battleships

/* SETS: Define the fundamental enumeration types for the game
 * - PLAYER: Represents the two players in the game
 * - SHOT_REPORT_MESSAGES: Possible outcomes of a shot
 * - GAME_STATUS: Tracks the overall state of the game
 * - REPORT_MESSAGES: Deployment and game progression messages
 */
SETS
    PLAYER = {Player1, Player2};  // Explicitly define two players
    SHOT_REPORT_MESSAGES = {Hit, Miss, Invalid_Shot};  // Possible shot outcomes
    GAME_STATUS = {
        Game_Setup,  // Initial game configuration phase
        Ongoing,  // Game in active play
        Player1_Wins,  // Player 1 has won the game
        Player2_Wins   // Player 2 has won the game
    }; 
    REPORT_MESSAGES = {
        Fleet_Deployed_Successfully,  // Successful ship placement
        Waiting_OtherPlayer_To_Deploy // Waiting for opponent's fleet deployment
    }

/* CONSTANTS: Define game board and ship configuration
 * - Grid: Represents the game board's coordinate system
 * - TotalShips: Maximum number of ships per player
 */
CONSTANTS
    Grid,       // Game board coordinate space
    TotalShips  // Maximum ships allowed per player

/* PROPERTIES: Establish constraints and rules for the game
 * - Define grid as a set of coordinate pairs
 * - Set grid size to 10x10 
 * - Set total ships to exactly 3 per player
 */
PROPERTIES
    Grid: POW(NAT1 * NAT1) &           // Grid is a power set of natural number pairs
    Grid = {xx, yy | xx: 1..5 & yy: 1..5} &  // 10x10 Grid definition as per specification (But for testing purposes 5*5 grid is used with MAX_INT is 10 and Maximum Operations are 5000)
    TotalShips : NAT1 & 
    TotalShips = 3 

/* DEFINITIONS: Animation and Visualization Mappings
 * These functions map game state to visual representations
 * Each function defines how different game elements are displayed
 *  Includes mappings for ships, hit/miss shots, grid cells
 */
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
    ANIMATION_FUNCTION2 == ({ row, col, img | 
        col: 1..10 & 
        row: 1..10 & 
        img=1 & 
        (11-col, row) : playerShips(Player1) 
    });

    // Player 2's ship visualization
    ANIMATION_FUNCTION3 == ({ row, col, img | 
        col: 1..10 & 
        row: 1..21 & 
        img=2 & 
        (col, 21-row) : playerShips(Player2) 
    });
    
    // Visualization of hit shots on Player 2's grid
    ANIMATION_FUNCTION4 == ({ row, col, img | 
        col: 1..10 & 
        row: 1..10 & 
        img=3 & 
        (11-col, row) : hittedShots(Player2) 
    });

    // Visualization of hit shots on Player 1's grid
    ANIMATION_FUNCTION5 == ({ row, col, img | 
        col: 1..10 & 
        row: 1..21 & 
        img=3 & 
        (col, 21-row) : hittedShots(Player1) 
    });
    
    // Visualization of missed shots on Player 1's grid
    ANIMATION_FUNCTION6 == ({ row, col, img | 
        col: 1..10 & 
        row: 1..10 & 
        img=5 & 
        (11-col, row) : missedShots(Player2) 
    });

    // Visualization of missed shots on Player 2's grid
    ANIMATION_FUNCTION7 == ({ row, col, img | 
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

/* VARIABLES: Track dynamic game state
 * Each variable represents a key aspect of the game's current condition
 */
VARIABLES
    playerShips,       // Ship positions for each player
    currentGameState,  // Current overall game state
    shotsFired,        // Number of shots fired by each player
    currentPlayer,     // Player whose turn it currently is
    hittedShots,       // Coordinates of successful shots for each player
    missedShots        // Coordinates of missed shots for each player

/* INVARIANT: Establish and maintain game state constraints
 * - Ensure ship count doesn't exceed maximum
 * - Validate game state variables
 * - Maintain type and cardinality restrictions
 */
INVARIANT
    playerShips : PLAYER --> POW(Grid) &             // Ships mapped to players
    card(playerShips(Player1)) <= TotalShips &       // Max 3 ships for Player 1
    card(playerShips(Player2)) <= TotalShips &       // Max 3 ships for Player 2
    shotsFired : PLAYER --> NAT &                    // Shots are non-negative integers
    currentGameState : GAME_STATUS &                 // Validate game state
    currentPlayer : PLAYER &                         // Current player is valid
    hittedShots : PLAYER --> POW(Grid) &             // Hit shot coordinates
    missedShots : PLAYER --> POW(Grid)               // Missed shot coordinates
            
/* INITIALISATION: Set up initial game state
 * - Empty ship positions
 * - Reset shot counters
 * - Set initial game state to setup
 * - Start with Player 1
 * - Clear hit and missed shot records
 */
INITIALISATION
    playerShips := {Player1 |-> {}, Player2 |-> {}} ||       // No ships initially
    shotsFired := {Player1 |-> 0, Player2 |-> 0} ||          // No shots fired
    currentGameState := Game_Setup ||                        // Initial game state
    currentPlayer := Player1 ||                              // Player 1 starts
    hittedShots := {Player1 |-> {}, Player2 |-> {}} ||       // No hit shots initially
    missedShots := {Player1 |-> {}, Player2 |-> {}}          // No missed shots initially

/* OPERATIONS: Define core game mechanics
 * Comprehensive set of operations to manage game flow
 */
OPERATIONS
    /* Fleet Deployment Operation
     * Allows players to place their ships on the grid
     * 
     * Preconditions:
     * - Valid player
     * - Valid ship positions
     * - Exactly 3 ship positions
     * - Game in setup state
     * 
     * Actions:
     * - Validate and set ship positions
     * - Update game state
     * - Check if both players have deployed
     */
    report <-- deployFleet(player, positions) =
    PRE
        player : PLAYER &                     // Validate player
        positions : POW(Grid) &               // Validate position set
        card(positions) = 3 &                 // Exactly 3 ship positions
        currentGameState = Game_Setup         // Only during fleet deployment
    THEN
        IF (playerShips(player) /\ positions = {} & card(playerShips(player)) = 0) THEN
            // Successful deployment: no ship overlap
            playerShips(player) := positions ||     // Set ship positions
            shotsFired(player) := 0 ||             // Reset shot count
            report := Fleet_Deployed_Successfully ||
            
            // Check if both players have deployed
            IF (player = Player1 & card(playerShips(Player2)) = 3 ) THEN
                currentGameState := Ongoing          // Start game if Player 2 deployed
            ELSE
                IF (player = Player2 & card(playerShips(Player1)) = 3) THEN
                    currentGameState := Ongoing      // Start game if Player 1 deployed
                END
            END
        ELSE
            report := Waiting_OtherPlayer_To_Deploy  // Deployment failed
        END
    END;

    /* Player Shooting Mechanism
     * Core game logic for players taking shots
     * 
     * Preconditions:
     * - Game must be in ongoing state
     * - Target must be a valid coordinate
     * 
     * Actions:
     * - Validate shot
     * - Determine hit or miss
     * - Update game state
     * - Switch players
     * - Check for win condition
     */
    report <-- playerShoots(target) =
    PRE
        currentGameState = Ongoing &   // Game must be in progress
        target : NAT1 * NAT1  // Valid coordinate
    THEN
        IF target: Grid THEN  // Validate target is on grid
            IF currentPlayer = Player1 THEN
                // Player 1 shooting at Player 2's ships
                IF target : playerShips(Player2) THEN
                    // Hit on Player 2's ship
                    IF card(playerShips(Player2) - {target}) = 0 THEN
                        // Last ship destroyed - Player 1 wins
                        currentGameState := Player1_Wins ||
                        playerShips(Player2) := playerShips(Player2) - {target} ||
                        shotsFired(currentPlayer) := shotsFired(currentPlayer) + 1 ||
                        hittedShots(currentPlayer) := hittedShots(currentPlayer) \/ {target} ||
                        report := Hit
                    ELSE
                        // Ship hit but not last ship
                        playerShips(Player2) := playerShips(Player2) - {target} ||
                        shotsFired(currentPlayer) := shotsFired(currentPlayer) + 1 ||
                        hittedShots(currentPlayer) := hittedShots(currentPlayer) \/ {target} ||
                        currentPlayer := Player2 ||     // Switch players
                        report := Hit
                    END
                ELSE
                    // Miss on Player 2's ships
                    shotsFired(currentPlayer) := shotsFired(currentPlayer) + 1 ||
                    missedShots(currentPlayer) := missedShots(currentPlayer) \/ {target} ||
                    currentPlayer := Player2 ||         // Switch players
                    report := Miss
                END
            ELSE
                // Player 2 shooting at Player 1's ships
                IF target : playerShips(Player1) THEN
                    // Hit on Player 1's ship
                    IF card(playerShips(Player1) - {target}) = 0 THEN
                        // Last ship destroyed - Player 2 wins
                        currentGameState := Player2_Wins ||
                        playerShips(Player1) := playerShips(Player1) - {target} ||
                        hittedShots(currentPlayer) := hittedShots(currentPlayer) \/ {target} ||
                        shotsFired(currentPlayer) := shotsFired(currentPlayer) + 1 ||
                        report := Hit
                    ELSE
                        // Ship hit but not last ship
                        playerShips(Player1) := playerShips(Player1) - {target} ||
                        shotsFired(currentPlayer) := shotsFired(currentPlayer) + 1 ||
                        currentPlayer := Player1 ||  // Switch players
                        hittedShots(currentPlayer) := hittedShots(currentPlayer) \/ {target} ||
                        report := Hit
                    END
                ELSE
                    // Miss on Player 1's ships
                    shotsFired(currentPlayer) := shotsFired(currentPlayer) + 1 ||
                    missedShots(currentPlayer) := missedShots(currentPlayer) \/ {target} ||
                    currentPlayer := Player1 || // Switch players
                    report := Miss
                END
            END
        ELSE 
            report := Invalid_Shot // Invalid grid target
        END
    END;

    /* Ship Location Retrieval
     * Allows retrieving ship positions for a specific player
     */
    playerShipsquares <-- shipLocations(player) =
    PRE 
        player : PLAYER
    THEN
        playerShipsquares := playerShips(player)
    END ;
    
    /* Ship Count Retrieval
     * Returns the number of remaining ships for both players
     */
    shipCounts <-- shipsLeft =
    BEGIN
        shipCounts := {
            Player1 |-> card(playerShips(Player1)), 
            Player2 |-> card(playerShips(Player2))
        }
    END;
    
    /* Shot Count Retrieval
     * Returns the number of shots fired by a specific player
     */
    shotCount <-- shotsTaken(player) =
    PRE 
        player : PLAYER
    THEN
        shotCount := shotsFired(player)
    END;
    
    /* Game Status Retrieval
     * Returns the current state of the game
     */
    report <-- gameStatus =
    BEGIN
        report := currentGameState
    END;
    
    /* Reset Game 
     * Returns the initialisation state of the game
     */
    resetGame =
    BEGIN
        currentGameState := Game_Setup ||
        currentPlayer := Player1 ||
        playerShips := {Player1 |-> {}, Player2 |-> {}} ||
        hittedShots := {Player1 |-> {}, Player2 |-> {}} ||
        missedShots := {Player1 |-> {}, Player2 |-> {}} ||
        shotsFired := {Player1 |-> 0, Player2 |-> 0}   
    END
END