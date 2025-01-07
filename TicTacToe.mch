/* TicTacToe
 * Author: 
 * Creation date: 2024-10-16
 */
MACHINE
    TicTacToe
    
SETS
    Players = {Noughts, Crosses}
    
CONSTANTS
    grid

PROPERTIES
    grid ={(1..3)*(1..3)}
    
VARIABLES
    noughts, crosses
    
INVARIANT
    noughts <: grid &
    crosses <: grid &
    noughts /\ crosses = {}
    
INITIALISATION
    noughts := {} ||
    crosses := {}
    
OPERATIONS
    placetoken(xx,yy,player) =
    
    PRE
        xx:(1..3) &
        yy:(1..3) &
        player:Players

    THEN
        IF
            (xx,yy) : noughts \/ crosses
        THEN
            res := Failure
            
        ELSE
           if player = noughts
       THEN
           noughts := nought \/ {{xx ->YY}} ||
           res := Sucesss
       ELSE
           crosses := crosees \/ {xx ->YY}} ||
       res := Sucess
   END;
END
END
