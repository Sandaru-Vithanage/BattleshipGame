/* Game States Machine
 * Defines possible game states and messages
 */
MACHINE
    GameStates

SETS
    GAME_STATUS = {
        Game_Setup,        // Initial game configuration phase
        Ongoing,           // Game in active play
        Player1_Wins,      // Player 1 has won the game
        Player2_Wins       // Player 2 has won the game
    }; 
    SHOT_REPORT_MESSAGES = {Hit, Miss, Invalid_Shot};
    REPORT_MESSAGES = {
        Fleet_Deployed_Successfully,  // Successful ship placement
        Waiting_OtherPlayer_To_Deploy // Waiting for opponent's fleet deployment
    }

END