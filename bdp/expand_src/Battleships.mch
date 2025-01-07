MACHINE
    Battleships

SETS
    PLAYER = { Player1 , Player2 } ;
    SHOT_RESULTS = { Hit , Miss , Invalid } ;
    GAME_STATUS = { Setup , Ongoing , Player1_wins , Player2_wins } ;
    REPORT_MESSAGES = { fleet_deployed , fleet_not_deployed , game_over , invalid_shot }

CONCRETE_CONSTANTS
    Grid , TotalShips

PROPERTIES
    Grid : POW ( NAT1 * NAT1 ) &
    Grid = { xx , yy | xx : 1 .. 3 & yy : 1 .. 3 } &
    TotalShips : NAT1 &
    TotalShips = 3

DEFINITIONS
    // Animation Functions for Battleships
    ANIMATION_FUNCTION == ( { row , col , img | col : 1 .. 10 &
            row : 1 .. 21 & img = 0 } ) ;
    ANIMATION_FUNCTION1 == ( { row , col , img | col : 1 .. 10 &
            row : 1 .. 10 & img = 1 & ( col , row ) : playerShips ( Player1 ) } ) ;
    ANIMATION_FUNCTION2 == ( { row , col , img | col : 1 .. 10 &
            row : 1 .. 21 & img = 2 & ( col , row - 11 ) : playerShips ( Player2 ) } ) ;


    ANIMATION_IMG0 == "images/empty_cell.gif" ;
    ANIMATION_IMG1 == "images/player1_ship.gif" ;
    ANIMATION_IMG2 == "images/player2_ship.gif" ;      // Cell where a shot is fired

ABSTRACT_VARIABLES
    playerShips ,
    shotsFired ,
    gameState ,
    turn ,
    shotResults

INVARIANT
    playerShips : PLAYER --> POW ( Grid ) &
    card ( playerShips ( Player1 ) ) <= TotalShips &
    card ( playerShips ( Player2 ) ) <= TotalShips &
    shotsFired : PLAYER --> NAT &
    gameState : GAME_STATUS &
    turn : PLAYER &
    shotResults : PLAYER --> seq ( SHOT_RESULTS )

INITIALISATION
    playerShips := { Player1 |-> {} , Player2 |-> {} } ||
    shotsFired := { Player1 |-> 0 , Player2 |-> 0 } ||
    gameState := Setup ||
    turn := Player1 ||
    shotResults := { Player1 |-> [] , Player2 |-> [] }

OPERATIONS
    report <-- deployFleet ( player , positions ) =
    PRE
        player : PLAYER &
        positions : POW ( Grid ) &
        card ( positions ) = 3 &
        gameState = Setup
    THEN
        IF ( playerShips ( player ) /\ positions = {} & card ( playerShips ( player ) ) = 0 ) THEN
            /* Deploy the fleet for the player */
            playerShips ( player ) := positions ||
            shotsFired ( player ) := 0 ||
            report := fleet_deployed ||
            IF ( player = Player1 & card ( playerShips ( Player2 ) ) = 3 ) THEN
                gameState := Ongoing
            ELSE
                IF ( player = Player2 & card ( playerShips ( Player1 ) ) = 3 ) THEN
                gameState := Ongoing
                END
            END
        ELSE
            report := fleet_not_deployed
        END
    END ;

    report <-- playerShoots ( target ) =
    PRE
        gameState = Ongoing &
        target : Grid
    THEN
        /* Determine opponent based on current turn */
        IF turn = Player1 THEN
            /* Targeting Player2's ships */
            IF target : playerShips ( Player2 ) THEN
                /* Simulate updated fleet after the hit */
                IF card ( playerShips ( Player2 ) - { target } ) = 0 THEN
                    gameState := Player1_wins ||
                    playerShips ( Player2 ) := playerShips ( Player2 ) - { target } ||
                    shotResults ( turn ) := shotResults ( turn ) ^ [ Hit ] ||
                    shotsFired ( turn ) := shotsFired ( turn ) + 1 ||
                    report := Hit
                ELSE
                    playerShips ( Player2 ) := playerShips ( Player2 ) - { target } ||
                    shotResults ( turn ) := shotResults ( turn ) ^ [ Hit ] ||
                    shotsFired ( turn ) := shotsFired ( turn ) + 1 ||
                    turn := Player2 ||
                    report := Hit
                END
            ELSE
                /* Miss: Switch turns */
                shotResults ( turn ) := shotResults ( turn ) ^ [ Miss ] ||
                shotsFired ( turn ) := shotsFired ( turn ) + 1 ||
                turn := Player2 ||
                report := Miss
            END
        ELSE
            /* Targeting Player1's ships */
            IF target : playerShips ( Player1 ) THEN
                /* Simulate updated fleet after the hit */
                IF card ( playerShips ( Player1 ) - { target } ) = 0 THEN
                    gameState := Player2_wins ||
                    playerShips ( Player1 ) := playerShips ( Player1 ) - { target } ||
                    shotResults ( turn ) := shotResults ( turn ) ^ [ Hit ] ||
                    shotsFired ( turn ) := shotsFired ( turn ) + 1 ||
                    report := Hit
                ELSE
                    playerShips ( Player1 ) := playerShips ( Player1 ) - { target } ||
                    shotResults ( turn ) := shotResults ( turn ) ^ [ Hit ] ||
                    shotsFired ( turn ) := shotsFired ( turn ) + 1 ||
                    turn := Player1 ||
                    report := Hit
                END
            ELSE
                /* Miss: Switch turns */
                shotResults ( turn ) := shotResults ( turn ) ^ [ Miss ] ||
                shotsFired ( turn ) := shotsFired ( turn ) + 1 ||
                turn := Player1 ||
                report := Miss
            END
        END
    END ;

    shipsquares <-- shipLocations ( player ) =
    PRE
        player : PLAYER
    THEN
        shipsquares := playerShips ( player )
    END ;

    shipCounts <-- shipsLeft =
    BEGIN
        shipCounts := { Player1 |-> card ( playerShips ( Player1 ) ) ,
                               Player2 |-> card ( playerShips ( Player2 ) ) }
    END ;

    shotCount <-- shotsTaken ( player ) =
    PRE
        player : PLAYER
    THEN
        shotCount := shotsFired ( player )
    END ;

    report <-- gameStatus =
    BEGIN
        report := gameState
    END
END
