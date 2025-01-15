
[compileScript ["core\init.sqf"]] call CBA_fnc_directCall;
if ((!isServer) && (player != player)) then {
  waitUntil {player == player};
};
waitUntil {time > 10};
showGps false;
[] execVM "scripts\ROS_snakebite.sqf";