
[compileScript ["core\init.sqf"]] call CBA_fnc_directCall;
showGps false;
setTerrainGrid 3.125;
CHVD_allowNoGrass = false;
[] execVM "Scripts\fn_disableGps.sqf";
[] execVM "Scripts\fn_VehicleInit.sqf";
//[] execVM "Scripts\fn_convertToSimpleObjects.sqf";
[] execVM "Scripts\fn_fixACEAX.sqf";