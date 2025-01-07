Normalised(
THEORY MagicNumberX IS
  MagicNumber(Machine(Battleships))==(3.5)
END
&
THEORY UpperLevelX IS
  First_Level(Machine(Battleships))==(Machine(Battleships));
  Level(Machine(Battleships))==(0)
END
&
THEORY LoadedStructureX IS
  Machine(Battleships)
END
&
THEORY ListSeesX IS
  List_Sees(Machine(Battleships))==(?)
END
&
THEORY ListUsesX IS
  List_Uses(Machine(Battleships))==(?)
END
&
THEORY ListIncludesX IS
  Inherited_List_Includes(Machine(Battleships))==(?);
  List_Includes(Machine(Battleships))==(?)
END
&
THEORY ListPromotesX IS
  List_Promotes(Machine(Battleships))==(?)
END
&
THEORY ListExtendsX IS
  List_Extends(Machine(Battleships))==(?)
END
&
THEORY ListVariablesX IS
  External_Context_List_Variables(Machine(Battleships))==(?);
  Context_List_Variables(Machine(Battleships))==(?);
  Abstract_List_Variables(Machine(Battleships))==(?);
  Local_List_Variables(Machine(Battleships))==(shotResults,turn,gameState,shotsFired,playerShips);
  List_Variables(Machine(Battleships))==(shotResults,turn,gameState,shotsFired,playerShips);
  External_List_Variables(Machine(Battleships))==(shotResults,turn,gameState,shotsFired,playerShips)
END
&
THEORY ListVisibleVariablesX IS
  Inherited_List_VisibleVariables(Machine(Battleships))==(?);
  Abstract_List_VisibleVariables(Machine(Battleships))==(?);
  External_List_VisibleVariables(Machine(Battleships))==(?);
  Expanded_List_VisibleVariables(Machine(Battleships))==(?);
  List_VisibleVariables(Machine(Battleships))==(?);
  Internal_List_VisibleVariables(Machine(Battleships))==(?)
END
&
THEORY ListInvariantX IS
  Gluing_Seen_List_Invariant(Machine(Battleships))==(btrue);
  Gluing_List_Invariant(Machine(Battleships))==(btrue);
  Expanded_List_Invariant(Machine(Battleships))==(btrue);
  Abstract_List_Invariant(Machine(Battleships))==(btrue);
  Context_List_Invariant(Machine(Battleships))==(btrue);
  List_Invariant(Machine(Battleships))==(playerShips: PLAYER --> POW(Grid) & card(playerShips(Player1))<=TotalShips & card(playerShips(Player2))<=TotalShips & shotsFired: PLAYER --> NAT & gameState: GAME_STATUS & turn: PLAYER & shotResults: PLAYER --> seq(SHOT_RESULTS))
END
&
THEORY ListAssertionsX IS
  Expanded_List_Assertions(Machine(Battleships))==(btrue);
  Abstract_List_Assertions(Machine(Battleships))==(btrue);
  Context_List_Assertions(Machine(Battleships))==(btrue);
  List_Assertions(Machine(Battleships))==(btrue)
END
&
THEORY ListCoverageX IS
  List_Coverage(Machine(Battleships))==(btrue)
END
&
THEORY ListExclusivityX IS
  List_Exclusivity(Machine(Battleships))==(btrue)
END
&
THEORY ListInitialisationX IS
  Expanded_List_Initialisation(Machine(Battleships))==(playerShips,shotsFired,gameState,turn,shotResults:={Player1|->{},Player2|->{}},{Player1|->0,Player2|->0},Setup,Player1,{Player1|-><>,Player2|-><>});
  Context_List_Initialisation(Machine(Battleships))==(skip);
  List_Initialisation(Machine(Battleships))==(playerShips:={Player1|->{},Player2|->{}} || shotsFired:={Player1|->0,Player2|->0} || gameState:=Setup || turn:=Player1 || shotResults:={Player1|-><>,Player2|-><>})
END
&
THEORY ListParametersX IS
  List_Parameters(Machine(Battleships))==(?)
END
&
THEORY ListInstanciatedParametersX END
&
THEORY ListConstraintsX IS
  List_Context_Constraints(Machine(Battleships))==(btrue);
  List_Constraints(Machine(Battleships))==(btrue)
END
&
THEORY ListOperationsX IS
  Internal_List_Operations(Machine(Battleships))==(deployFleet,playerShoots,shipLocations,shipsLeft,shotsTaken,gameStatus);
  List_Operations(Machine(Battleships))==(deployFleet,playerShoots,shipLocations,shipsLeft,shotsTaken,gameStatus)
END
&
THEORY ListInputX IS
  List_Input(Machine(Battleships),deployFleet)==(player,positions);
  List_Input(Machine(Battleships),playerShoots)==(target);
  List_Input(Machine(Battleships),shipLocations)==(player);
  List_Input(Machine(Battleships),shipsLeft)==(?);
  List_Input(Machine(Battleships),shotsTaken)==(player);
  List_Input(Machine(Battleships),gameStatus)==(?)
END
&
THEORY ListOutputX IS
  List_Output(Machine(Battleships),deployFleet)==(report);
  List_Output(Machine(Battleships),playerShoots)==(report);
  List_Output(Machine(Battleships),shipLocations)==(shipsquares);
  List_Output(Machine(Battleships),shipsLeft)==(shipCounts);
  List_Output(Machine(Battleships),shotsTaken)==(shotCount);
  List_Output(Machine(Battleships),gameStatus)==(report)
END
&
THEORY ListHeaderX IS
  List_Header(Machine(Battleships),deployFleet)==(report <-- deployFleet(player,positions));
  List_Header(Machine(Battleships),playerShoots)==(report <-- playerShoots(target));
  List_Header(Machine(Battleships),shipLocations)==(shipsquares <-- shipLocations(player));
  List_Header(Machine(Battleships),shipsLeft)==(shipCounts <-- shipsLeft);
  List_Header(Machine(Battleships),shotsTaken)==(shotCount <-- shotsTaken(player));
  List_Header(Machine(Battleships),gameStatus)==(report <-- gameStatus)
END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX IS
  List_Precondition(Machine(Battleships),deployFleet)==(player: PLAYER & positions: POW(Grid) & card(positions) = 3 & gameState = Setup);
  List_Precondition(Machine(Battleships),playerShoots)==(gameState = Ongoing & target: Grid);
  List_Precondition(Machine(Battleships),shipLocations)==(player: PLAYER);
  List_Precondition(Machine(Battleships),shipsLeft)==(btrue);
  List_Precondition(Machine(Battleships),shotsTaken)==(player: PLAYER);
  List_Precondition(Machine(Battleships),gameStatus)==(btrue)
END
&
THEORY ListSubstitutionX IS
  Expanded_List_Substitution(Machine(Battleships),gameStatus)==(btrue | report:=gameState);
  Expanded_List_Substitution(Machine(Battleships),shotsTaken)==(player: PLAYER | shotCount:=shotsFired(player));
  Expanded_List_Substitution(Machine(Battleships),shipsLeft)==(btrue | shipCounts:={Player1|->card(playerShips(Player1)),Player2|->card(playerShips(Player2))});
  Expanded_List_Substitution(Machine(Battleships),shipLocations)==(player: PLAYER | shipsquares:=playerShips(player));
  Expanded_List_Substitution(Machine(Battleships),playerShoots)==(gameState = Ongoing & target: Grid | turn = Player1 ==> (target: playerShips(Player2) ==> (card(playerShips(Player2)-{target}) = 0 ==> gameState,playerShips,shotResults,shotsFired,report:=Player1_wins,playerShips<+{Player2|->playerShips(Player2)-{target}},shotResults<+{turn|->(shotResults(turn)^[Hit])},shotsFired<+{turn|->shotsFired(turn)+1},Hit [] not(card(playerShips(Player2)-{target}) = 0) ==> playerShips,shotResults,shotsFired,turn,report:=playerShips<+{Player2|->playerShips(Player2)-{target}},shotResults<+{turn|->(shotResults(turn)^[Hit])},shotsFired<+{turn|->shotsFired(turn)+1},Player2,Hit) [] not(target: playerShips(Player2)) ==> shotResults,shotsFired,turn,report:=shotResults<+{turn|->(shotResults(turn)^[Miss])},shotsFired<+{turn|->shotsFired(turn)+1},Player2,Miss) [] not(turn = Player1) ==> (target: playerShips(Player1) ==> (card(playerShips(Player1)-{target}) = 0 ==> gameState,playerShips,shotResults,shotsFired,report:=Player2_wins,playerShips<+{Player1|->playerShips(Player1)-{target}},shotResults<+{turn|->(shotResults(turn)^[Hit])},shotsFired<+{turn|->shotsFired(turn)+1},Hit [] not(card(playerShips(Player1)-{target}) = 0) ==> playerShips,shotResults,shotsFired,turn,report:=playerShips<+{Player1|->playerShips(Player1)-{target}},shotResults<+{turn|->(shotResults(turn)^[Hit])},shotsFired<+{turn|->shotsFired(turn)+1},Player1,Hit) [] not(target: playerShips(Player1)) ==> shotResults,shotsFired,turn,report:=shotResults<+{turn|->(shotResults(turn)^[Miss])},shotsFired<+{turn|->shotsFired(turn)+1},Player1,Miss));
  Expanded_List_Substitution(Machine(Battleships),deployFleet)==(player: PLAYER & positions: POW(Grid) & card(positions) = 3 & gameState = Setup | playerShips(player)/\positions = {} & card(playerShips(player)) = 0 ==> (playerShips,shotsFired,report:=playerShips<+{player|->positions},shotsFired<+{player|->0},fleet_deployed || (player = Player1 & card(playerShips(Player2)) = 3 ==> gameState:=Ongoing [] not(player = Player1 & card(playerShips(Player2)) = 3) ==> (player = Player2 & card(playerShips(Player1)) = 3 ==> gameState:=Ongoing [] not(player = Player2 & card(playerShips(Player1)) = 3) ==> skip))) [] not(playerShips(player)/\positions = {} & card(playerShips(player)) = 0) ==> report:=fleet_not_deployed);
  List_Substitution(Machine(Battleships),deployFleet)==(IF playerShips(player)/\positions = {} & card(playerShips(player)) = 0 THEN playerShips(player):=positions || shotsFired(player):=0 || report:=fleet_deployed || IF player = Player1 & card(playerShips(Player2)) = 3 THEN gameState:=Ongoing ELSE IF player = Player2 & card(playerShips(Player1)) = 3 THEN gameState:=Ongoing END END ELSE report:=fleet_not_deployed END);
  List_Substitution(Machine(Battleships),playerShoots)==(IF turn = Player1 THEN IF target: playerShips(Player2) THEN IF card(playerShips(Player2)-{target}) = 0 THEN gameState:=Player1_wins || playerShips(Player2):=playerShips(Player2)-{target} || shotResults(turn):=shotResults(turn)^[Hit] || shotsFired(turn):=shotsFired(turn)+1 || report:=Hit ELSE playerShips(Player2):=playerShips(Player2)-{target} || shotResults(turn):=shotResults(turn)^[Hit] || shotsFired(turn):=shotsFired(turn)+1 || turn:=Player2 || report:=Hit END ELSE shotResults(turn):=shotResults(turn)^[Miss] || shotsFired(turn):=shotsFired(turn)+1 || turn:=Player2 || report:=Miss END ELSE IF target: playerShips(Player1) THEN IF card(playerShips(Player1)-{target}) = 0 THEN gameState:=Player2_wins || playerShips(Player1):=playerShips(Player1)-{target} || shotResults(turn):=shotResults(turn)^[Hit] || shotsFired(turn):=shotsFired(turn)+1 || report:=Hit ELSE playerShips(Player1):=playerShips(Player1)-{target} || shotResults(turn):=shotResults(turn)^[Hit] || shotsFired(turn):=shotsFired(turn)+1 || turn:=Player1 || report:=Hit END ELSE shotResults(turn):=shotResults(turn)^[Miss] || shotsFired(turn):=shotsFired(turn)+1 || turn:=Player1 || report:=Miss END END);
  List_Substitution(Machine(Battleships),shipLocations)==(shipsquares:=playerShips(player));
  List_Substitution(Machine(Battleships),shipsLeft)==(shipCounts:={Player1|->card(playerShips(Player1)),Player2|->card(playerShips(Player2))});
  List_Substitution(Machine(Battleships),shotsTaken)==(shotCount:=shotsFired(player));
  List_Substitution(Machine(Battleships),gameStatus)==(report:=gameState)
END
&
THEORY ListConstantsX IS
  List_Valuable_Constants(Machine(Battleships))==(Grid,TotalShips);
  Inherited_List_Constants(Machine(Battleships))==(?);
  List_Constants(Machine(Battleships))==(Grid,TotalShips)
END
&
THEORY ListSetsX IS
  Set_Definition(Machine(Battleships),PLAYER)==({Player1,Player2});
  Context_List_Enumerated(Machine(Battleships))==(?);
  Context_List_Defered(Machine(Battleships))==(?);
  Context_List_Sets(Machine(Battleships))==(?);
  List_Valuable_Sets(Machine(Battleships))==(?);
  Inherited_List_Enumerated(Machine(Battleships))==(?);
  Inherited_List_Defered(Machine(Battleships))==(?);
  Inherited_List_Sets(Machine(Battleships))==(?);
  List_Enumerated(Machine(Battleships))==(PLAYER,SHOT_RESULTS,GAME_STATUS,REPORT_MESSAGES);
  List_Defered(Machine(Battleships))==(?);
  List_Sets(Machine(Battleships))==(PLAYER,SHOT_RESULTS,GAME_STATUS,REPORT_MESSAGES);
  Set_Definition(Machine(Battleships),SHOT_RESULTS)==({Hit,Miss,Invalid});
  Set_Definition(Machine(Battleships),GAME_STATUS)==({Setup,Ongoing,Player1_wins,Player2_wins});
  Set_Definition(Machine(Battleships),REPORT_MESSAGES)==({fleet_deployed,fleet_not_deployed,game_over,invalid_shot})
END
&
THEORY ListHiddenConstantsX IS
  Abstract_List_HiddenConstants(Machine(Battleships))==(?);
  Expanded_List_HiddenConstants(Machine(Battleships))==(?);
  List_HiddenConstants(Machine(Battleships))==(?);
  External_List_HiddenConstants(Machine(Battleships))==(?)
END
&
THEORY ListPropertiesX IS
  Abstract_List_Properties(Machine(Battleships))==(btrue);
  Context_List_Properties(Machine(Battleships))==(btrue);
  Inherited_List_Properties(Machine(Battleships))==(btrue);
  List_Properties(Machine(Battleships))==(Grid: POW(NAT1*NAT1) & Grid = {xx,yy | xx: 1..3 & yy: 1..3} & TotalShips: NAT1 & TotalShips = 3 & PLAYER: FIN(INTEGER) & not(PLAYER = {}) & SHOT_RESULTS: FIN(INTEGER) & not(SHOT_RESULTS = {}) & GAME_STATUS: FIN(INTEGER) & not(GAME_STATUS = {}) & REPORT_MESSAGES: FIN(INTEGER) & not(REPORT_MESSAGES = {}))
END
&
THEORY ListSeenInfoX END
&
THEORY ListANYVarX IS
  List_ANY_Var(Machine(Battleships),deployFleet)==(?);
  List_ANY_Var(Machine(Battleships),playerShoots)==(?);
  List_ANY_Var(Machine(Battleships),shipLocations)==(?);
  List_ANY_Var(Machine(Battleships),shipsLeft)==(?);
  List_ANY_Var(Machine(Battleships),shotsTaken)==(?);
  List_ANY_Var(Machine(Battleships),gameStatus)==(?)
END
&
THEORY ListOfIdsX IS
  List_Of_Ids(Machine(Battleships)) == (Grid,TotalShips,PLAYER,SHOT_RESULTS,GAME_STATUS,REPORT_MESSAGES,Player1,Player2,Hit,Miss,Invalid,Setup,Ongoing,Player1_wins,Player2_wins,fleet_deployed,fleet_not_deployed,game_over,invalid_shot | ? | shotResults,turn,gameState,shotsFired,playerShips | ? | deployFleet,playerShoots,shipLocations,shipsLeft,shotsTaken,gameStatus | ? | ? | ? | Battleships);
  List_Of_HiddenCst_Ids(Machine(Battleships)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(Battleships)) == (Grid,TotalShips);
  List_Of_VisibleVar_Ids(Machine(Battleships)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(Battleships)) == (?: ?)
END
&
THEORY SetsEnvX IS
  Sets(Machine(Battleships)) == (Type(PLAYER) == Cst(SetOf(etype(PLAYER,0,1)));Type(SHOT_RESULTS) == Cst(SetOf(etype(SHOT_RESULTS,0,2)));Type(GAME_STATUS) == Cst(SetOf(etype(GAME_STATUS,0,3)));Type(REPORT_MESSAGES) == Cst(SetOf(etype(REPORT_MESSAGES,0,3))))
END
&
THEORY ConstantsEnvX IS
  Constants(Machine(Battleships)) == (Type(Player1) == Cst(etype(PLAYER,0,1));Type(Player2) == Cst(etype(PLAYER,0,1));Type(Hit) == Cst(etype(SHOT_RESULTS,0,2));Type(Miss) == Cst(etype(SHOT_RESULTS,0,2));Type(Invalid) == Cst(etype(SHOT_RESULTS,0,2));Type(Setup) == Cst(etype(GAME_STATUS,0,3));Type(Ongoing) == Cst(etype(GAME_STATUS,0,3));Type(Player1_wins) == Cst(etype(GAME_STATUS,0,3));Type(Player2_wins) == Cst(etype(GAME_STATUS,0,3));Type(fleet_deployed) == Cst(etype(REPORT_MESSAGES,0,3));Type(fleet_not_deployed) == Cst(etype(REPORT_MESSAGES,0,3));Type(game_over) == Cst(etype(REPORT_MESSAGES,0,3));Type(invalid_shot) == Cst(etype(REPORT_MESSAGES,0,3));Type(Grid) == Cst(SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?)));Type(TotalShips) == Cst(btype(INTEGER,?,?)))
END
&
THEORY VariablesEnvX IS
  Variables(Machine(Battleships)) == (Type(shotResults) == Mvl(SetOf(etype(PLAYER,0,1)*SetOf(btype(INTEGER,?,?)*etype(SHOT_RESULTS,?,?))));Type(turn) == Mvl(etype(PLAYER,?,?));Type(gameState) == Mvl(etype(GAME_STATUS,?,?));Type(shotsFired) == Mvl(SetOf(etype(PLAYER,0,1)*btype(INTEGER,0,MAXINT)));Type(playerShips) == Mvl(SetOf(etype(PLAYER,0,1)*SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?)))))
END
&
THEORY OperationsEnvX IS
  Operations(Machine(Battleships)) == (Type(gameStatus) == Cst(etype(GAME_STATUS,?,?),No_type);Type(shotsTaken) == Cst(btype(INTEGER,?,?),etype(PLAYER,?,?));Type(shipsLeft) == Cst(SetOf(etype(PLAYER,?,?)*btype(INTEGER,?,?)),No_type);Type(shipLocations) == Cst(SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?)),etype(PLAYER,?,?));Type(playerShoots) == Cst(etype(SHOT_RESULTS,?,?),btype(INTEGER,?,?)*btype(INTEGER,?,?));Type(deployFleet) == Cst(etype(REPORT_MESSAGES,?,?),etype(PLAYER,?,?)*SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?))));
  Observers(Machine(Battleships)) == (Type(gameStatus) == Cst(etype(GAME_STATUS,?,?),No_type);Type(shotsTaken) == Cst(btype(INTEGER,?,?),etype(PLAYER,?,?));Type(shipsLeft) == Cst(SetOf(etype(PLAYER,?,?)*btype(INTEGER,?,?)),No_type);Type(shipLocations) == Cst(SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?)),etype(PLAYER,?,?)))
END
&
THEORY TCIntRdX IS
  predB0 == OK;
  extended_sees == KO;
  B0check_tab == KO;
  local_op == OK;
  abstract_constants_visible_in_values == KO;
  project_type == SOFTWARE_TYPE;
  event_b_deadlockfreeness == KO;
  variant_clause_mandatory == KO;
  event_b_coverage == KO;
  event_b_exclusivity == KO;
  genFeasibilityPO == KO
END
)
