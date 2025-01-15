// create the logic (alternative to placing a synchronized module named Convoy_01)
logicCenter_01 = createCenter sideLogic;
logicGroup_01 = createGroup logicCenter_01;
Convoy_01 = logicGroup_01 createUnit ["Logic", [0,0,0], [], 0, "NONE"];
Convoy_01 setVariable ["maxSpeed", 40];
Convoy_01 setVariable ["convSeparation", 20];
Convoy_01 setVariable ["stiffnessCoeff", 0.2];
Convoy_01 setVariable ["dampingCoeff", 0.6];
Convoy_01 setVariable ["curvatureCoeff", 0.3];
Convoy_01 setVariable ["stiffnessLinkCoeff", 0.1];
Convoy_01 setVariable ["pathFrequecy", 0.05];
Convoy_01 setVariable ["speedFrequecy", 0.2];
Convoy_01 setVariable ["speedModeConv", "NORMAL"];
Convoy_01 setVariable ["behaviourConv", "pushThroughContact"];
Convoy_01 setVariable ["debug", false];

// create the convoy
call{ 0 = [Convoy_01,[vehicleLead,vehicle2,vehicle3]] execVM "\nagas_Convoy\functions\fn_initConvoy.sqf" };

// stop the convoy without erasing its waypoints
Convoy_01 setVariable ["maxSpeed", 0];
sleep 5; // wait for all vehicles to stop

// disband the convoy
vehicleLead setVariable ["convoy_terminate", true];
sleep .5; // wait for script to finish

// create a new convoy with only the first two vehicles
call{ 0 = [Convoy_01,[vehicleLead,vehicle2]] execVM "\nagas_Convoy\functions\fn_initConvoy.sqf" };

// resume
Convoy_01 setVariable ["maxSpeed", 40];