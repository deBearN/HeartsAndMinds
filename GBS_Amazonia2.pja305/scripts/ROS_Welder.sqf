/* Welder by RickOShay
This script is called by ROS_HeliRepair.sqf

LEGAL STUFF
Credit must be given in your mission and on the Steam Workshop if this script is used in any mission or
derivative works. There are three dependent scripts: ROS_HeliRepair.sqf, ROS_Welder.sqf, ROSWavein.sqf.
They must be kept together.

Average repair times (dependent on number of damaged hitpoints):
Min: ~60 secs (5 hitpoints) Max: ~2.50 mins (all hitpoints (~40 hp) - ie setdamage) exclusing refuel and walk time overhead ~40secs

*/

params ["_welder"];

if (!local _welder) exitWith {};

_weldingcart = objNull;

_welder setBehaviour "CARELESS";

// Create welding cart
_weldingcart = createVehicle ["Land_WeldingTrolley_01_F", (position _welder), [], 0, "CAN_COLLIDE"];
_weldingcart setposatl (_welder modelToWorld [-1,-0.2,0]);

_pweapon = primaryWeapon _welder;
_sweapon = secondaryWeapon _welder;
{_welder removeWeapon _x} foreach [_pweapon,_sweapon];

sleep 2;

// Create welding tool
_weldingRod = createVehicle ["Land_TorqueWrench_01_F", (position _welder), [], 0, "CAN_COLLIDE"];
_weldingRod attachto [_welder,[-0.05,0.15,-0.02],"RightHandMiddle1"];

_weldingRod setVectorDirAndUp [[0,-0.1,1],[1,0,0]];
_welder disableai "anim";
_welder switchmove "Acts_Examining_Device_Player";

sleep (1 + random 4);

_y = 0;
_dist = 0.65;

_light = "#lightpoint" createVehicleLocal (getpos _weldingRod);
_light setlightBrightness 0;
_light setlightColor [1.0, 1.0, 0.5];
_light attachto [_weldingRod, [_dist, _y, 0]];

ROS_weldingSparks_Fnc = {
	params ["_weldingRod"];

	_wSparks = "#particlesource" createVehicleLocal [0,0,0];
	_wSparks setParticleCircle [0, [0, 0, 0]];
	_wSparks setParticleRandom [
	6, //LifeTime
	[0,0,0], //Position
	[0,0,0], //MoveVelocity
	30, //rotationVel
	0.25, //Scale
	[1,0.8,0.5,1], //Color
	0.50, //randDirPeriod
	1, //randDirIntesity
	30 // Angle
	];

	_wSparks setParticleParams [
	["\A3\data_f\cl_water", 1, 0, 1], //animationName
	"",
	"Billboard", // particleType
	1, // Timer period
	3, // lifetime
	[0.65, 0, 0], // position
	[(random 0.50),(random 0.50),-0.5], //moveVelocity
	500, //rotationVelocity
	1050, // weight
	7.9, // Volume
	0.1, // rubbing
	[0.017,0.017], // size
	[[1,0.8,0.5, 1],[1,0.8,0.5,1]], // color
	[0.16], // animationSpeed
	0, // randomDirectionPeriod
	0, // randomDirectionIntensity
	"", // onTimerScript
	"", // beforeDestroyScript
	_weldingRod, // object
	0, // angle
	false, // surface
	0.25, // bounceOnSurface
	[[0,0,0,1]] // emissiveColor
	];

	_wSparks attachTo [_weldingRod,[0.65,0,0]];
	_wSparks setDropInterval 0.001;
}; // end ROS_weldingSparks_Fnc


while {!ROSHeliRepaired} do {
	sleep 0.5;
	_smoke = "#particlesource" createVehicleLocal getpos _weldingRod;
	_smoke attachto [_weldingRod, [_dist, _y, 0]];
	_smoke setParticleClass "AvionicsSmoke";
	_smokepos = getpos _smoke;
	_sparkpos = [(_smokepos select 0), _smokepos select 1, (_smokepos select 2)+0.03];

	_light setlightBrightness 1;

	[_weldingRod] spawn ROS_weldingSparks_Fnc;

	_sparks1 = "#particlesource" createVehicleLocal _sparkpos;
	_sparks1 setParticleClass "AvionicsSparks";
	sleep 0.2;
	_sparks1 attachTo [_weldingRod,[0.65,0,0]];

	[_light, _sparks1] spawn {
		params ["_light", "_sparks1"];
		// flicker
		while {alive _sparks1} do {
			_light setlightBrightness (0.75 + random 0.25);
			_light setlightColor[1.0, 1.0, (0.7 + random 0.3)];
			sleep 0.12 + random 0.2;
			_light setlightBrightness 0;
		};
	};

	_sfx = selectRandom ["welding1H", "welding2H"];
	[_weldingcart, vehicle player] say3d _sfx;

	if (ROSHeliRepaired) exitWith {
		deleteVehicle _light;
		deleteVehicle _weldingcart;
		{if (typeOf _x == "#particlesource") then {deleteVehicle _x}} forEach (_welder nearObjects 7);
	};

	sleep 10;

	_light setlightBrightness 0;
	{if (typeOf _x == "#particlesource") then {deleteVehicle _x}} forEach (_welder nearObjects 7);
	sleep (1 + random 2);
}; // end while

deleteVehicle _light;
deleteVehicle _weldingcart;
deleteVehicle _weldingRod;
{if (typeOf _x == "#particlesource") then {deleteVehicle _x}} forEach (_welder nearObjects 7);

