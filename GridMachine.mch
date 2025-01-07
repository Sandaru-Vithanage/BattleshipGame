/* Grid Machine
 * Defines the coordinate system for the Battleships game
 */
MACHINE
    GridMachine

CONSTANTS
    Grid,       // Game board coordinate space
    GridSize    // Size of the grid

PROPERTIES
    GridSize : NAT1 &
    GridSize = 3 &  // 10x10 grid as specified
    Grid : POW(NAT1 * NAT1) &
    Grid = {xx, yy | xx: 1..GridSize & yy: 1..GridSize}

END