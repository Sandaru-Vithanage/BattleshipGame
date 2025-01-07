/* Player Battlefield Machine
 * Implements core game mechanics and shooting logic
 */
MACHINE
    PlayerOperations
    
SEES
    GridMachine,
    Player,
    GameStates

VARIABLES
    playerShips,       // Ship positions for each player
    currentGameState,  // Current overall game state
    shotsFired,        // Number of shots fired by each player
    currentPlayer,     // Player whose turn it currently is
    hittedShots,       // Coordinates of successful shots for each player
    missedShots        // Coordinates of missed shots for each player

INVARIANT
    playerShips : PLAYER --> POW(Grid) &
    card(playerShips(Player1)) <= MaxShips &
    card(playerShips(Player2)) <= MaxShips &
    shotsFired : PLAYER --> NAT &
    currentGameState : GAME_STATUS &
    currentPlayer : PLAYER &
    hittedShots : PLAYER --> POW(Grid) &
    missedShots : PLAYER --> POW(Grid)

INITIALISATION
    playerShips := {Player1 |-> {}, Player2 |-> {}} ||
    shotsFired := {Player1 |-> 0, Player2 |-> 0} ||
    currentGameState := Game_Setup ||
    currentPlayer := Player1 ||
    hittedShots := {Player1 |-> {}, Player2 |-> {}} ||
    missedShots := {Player1 |-> {}, Player2 |-> {}}

OPERATIONS
    /* Fleet Deployment Operation */
    report <-- deployFleet(player, positions) =
    PRE
        player : PLAYER &
        positions : POW(Grid) &
        card(positions) = MaxShips &
        currentGameState = Game_Setup
    THEN
        IF (playerShips(player) /\ positions = {} & card(playerShips(player)) = 0) THEN
            playerShips(player) := positions ||
            shotsFired(player) := 0 ||
            report := Fleet_Deployed_Successfully ||
            
            IF (player = Player1 & card(playerShips(Player2)) = MaxShips) THEN
                currentGameState := Ongoing
            ELSE
                IF (player = Player2 & card(playerShips(Player1)) = MaxShips) THEN
                    currentGameState := Ongoing
                END
            END
        ELSE
            report := Waiting_OtherPlayer_To_Deploy
        END
    END;

    /* Player Shooting Mechanism */
    report <-- playerShoots(target) =
    PRE
        currentGameState = Ongoing &
        target : Grid
    THEN
        IF currentPlayer = Player1 THEN
            IF target : playerShips(Player2) THEN
                IF card(playerShips(Player2) - {target}) = 0 THEN
                    currentGameState := Player1_Wins ||
                    playerShips(Player2) := playerShips(Player2) - {target} ||
                    shotsFired(currentPlayer) := shotsFired(currentPlayer) + 1 ||
                    hittedShots(currentPlayer) := hittedShots(currentPlayer) \/ {target} ||
                    report := Hit
                ELSE
                    playerShips(Player2) := playerShips(Player2) - {target} ||
                    shotsFired(currentPlayer) := shotsFired(currentPlayer) + 1 ||
                    currentPlayer := Player2 ||
                    hittedShots(currentPlayer) := hittedShots(currentPlayer) \/ {target} ||
                    report := Hit
                END
            ELSE
                shotsFired(currentPlayer) := shotsFired(currentPlayer) + 1 ||
                missedShots(currentPlayer) := missedShots(currentPlayer) \/ {target} ||
                currentPlayer := Player2 ||
                report := Miss
            END
        ELSE
            // Similar logic for Player 2's turn
            IF target : playerShips(Player1) THEN
                IF card(playerShips(Player1) - {target}) = 0 THEN
                    currentGameState := Player2_Wins ||
                    playerShips(Player1) := playerShips(Player1) - {target} ||
                    hittedShots(currentPlayer) := hittedShots(currentPlayer) \/ {target} ||
                    shotsFired(currentPlayer) := shotsFired(currentPlayer) + 1 ||
                    report := Hit
                ELSE
                    playerShips(Player1) := playerShips(Player1) - {target} ||
                    shotsFired(currentPlayer) := shotsFired(currentPlayer) + 1 ||
                    currentPlayer := Player1 ||
                    hittedShots(currentPlayer) := hittedShots(currentPlayer) \/ {target} ||
                    report := Hit
                END
            ELSE
                shotsFired(currentPlayer) := shotsFired(currentPlayer) + 1 ||
                missedShots(currentPlayer) := missedShots(currentPlayer) \/ {target} ||
                currentPlayer := Player1 ||
                report := Miss
            END
        END
    END;

    /* Ship Location Retrieval */
    playerShipsquares <-- shipLocations(player) =
    PRE 
        player : PLAYER
    THEN
        playerShipsquares := playerShips(player)
    END;
    
    /* Ship Count Retrieval */
    shipCounts <-- playerShipsLeft =
    BEGIN
        shipCounts := {
            Player1 |-> card(playerShips(Player1)), 
            Player2 |-> card(playerShips(Player2))
        }
    END;
    
    /* Shot Count Retrieval */
    shotCount <-- shotsFiredTaken(player) =
    PRE 
        player : PLAYER
    THEN
        shotCount := shotsFired(player)
    END;
    
    /* Game Status Retrieval */
    report <-- gameStatus =
    BEGIN
        report := currentGameState
    END

END