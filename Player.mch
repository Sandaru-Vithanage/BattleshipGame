/* Players Machine
 * Defines player-related constants and sets
 */
MACHINE
    Player

SETS
    PLAYER = {Player1, Player2}  // Explicitly define two players

CONSTANTS
    MaxShips  // Maximum number of ships per player

PROPERTIES
    MaxShips : NAT1 &
    MaxShips = 3  // 3 ships per player as in original specification

END