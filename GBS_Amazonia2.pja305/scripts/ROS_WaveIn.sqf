/*
This script is part of ROS_HeliRepair - by RickOshay

LEGAL STUFF
Credit must be given in your mission and on the Steam Workshop if this script is used in any mission or
derivative works. There are three dependent scripts: ROS_HeliRepair.sqf, ROS_Welder.sqf, ROSWavein.sqf.
They must be kept together.

Place a unit 20m behind a helipad (center) facing the direction the heli will approach from.

👨 Repairer  👨 wave in unit

        	  ↑ 20m

       		  □ helipad

       		  ↑
       		 🚁 inbound heli

There must be a heli pad (all classes are supported) placed >=20m in front of the 'wavein' unit.
Helipad should be the largest one available to make easier for the pilot to land on the center.
Copy the ROS_HeliRepair folder to your mission root.
Place the following line in the wavein units init field:
[this] execvm "ROS_HeliRepair\scripts\ROS_wavein.sqf";

*/

params ["_unit"];

if !(local _unit) exitWith {};

// Suported helipads
//_helipads = ["Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadEmpty_F","Land_HelipadRescue_F","Land_HelipadSquare_F","HeliH","HeliHCivil","Heli_H_civil","HeliHEmpty","HeliHRescue","Heli_H_rescue"];

_nHeliPads = [];
_nHeliPad = objNull;
_maxHPvalue = 0;
clLH = objNull;
clRH = objNull;
ROS_WiLightsAdded = false;

if (count units group _unit >1) then {_unit join grpNull};

_nHeliPads = nearestObjects [_unit, ["HeliH"], 30];
if (count _nHeliPads >0) then {_nHeliPad = _nHeliPads select 0};
if (isNull _nHeliPad) exitWith {hint "There is no nearby helipad within (~20m) of the repair unit";};

// If unit is too close to helipad move to 20m relative to helipad.
if (_unit distance _nHeliPad <20) then {
	_dir = getDir _unit;
	_pos = _nHeliPad getPos [-20, _dir];
	_unit setPosATL _pos;
	_unit setdir (_unit getDir _nHeliPad);
};

_nHeli = objNull;
_nHelis = [];

_unit setUnitPos "up";
_pwep = primaryWeapon _unit;
_unit removeWeapon _pwep;
_unit setBehaviour "careless";
_unit disableaI "move";
_unit disableAI "anim";
_unit switchMove "amovpercmstpsnonwnondnon";
[_unit, false] remoteExec ["allowDamage",0];

// Place red light on vest
_c1 = "Chemlight_red" createVehicle [0,0,0];
_c1 attachTo [_unit, [0,0,1]];

// Place white light in front
_lightw = "#lightpoint" createVehicleLocal [0,0,0];
_lightw setLightBrightness 0.1;
_lightw setLightColor[1, 1, 1];
_lightw lightAttachObject [_unit, [0,0.7,0.7]];

ROS_addlights_Fnc = {
	params ["_unit"];
	if (!ROS_WiLightsAdded) then {
		// Add red lights to hands
		clLH = "Chemlight_red" createVehicle [0,0,0];
		clRH = "Chemlight_red" createVehicle [0,0,0];
		clLH attachTo [_unit, [0,-0.01,0.08], "Lefthand"];
		clRH attachTo [_unit, [-0.03,-0.01,0.04], "Righthand"];
		clLH setVectorDirAndUp [[0,0,-1],[0,1,0]];
		clRH setVectorDirAndUp [[0,0,-1],[0,1,0]];
		ROS_WiLightsAdded = true;
	};
	true
};

if (isnil "ROS_WaveOut") then {ROS_WaveOut = false;};

while {true} do {
	// Look for helis nearby and wave them in them
	_nHelis = nearestObjects [_unit,["helicopter"],100];
	if (count _nHelis >0) then {
		_nHeli = _nHelis select 0;
	} else {
		_nHeli == objNull;
	};

	if (!isnull _nHeli) then {
		_vehDamage = selectMax ((getAllHitPointsDamage _nHeli) select 2);
		_vehFuel = fuel _nHeli;

		// Wave In
		if (!isTouchingGround _nHeli && _nHeli distance _unit <= 100 && (_vehDamage >=0.1 or _vehFuel <0.9)) then {
			if (ROS_WaveOut) then {ROS_WaveOut = false ;};
			[_unit] call ROS_addlights_Fnc;
			_unit setdir (_unit getdir _nHeli);
			_unit switchmove "Acts_JetsMarshallingStraight_loop";
			sleep 2;
		};
		// Wave Out
		if (isTouchingGround _nHeli && _nHeli distance _nHeliPad <= 5 && (_vehDamage >=0.1 or _vehFuel <0.9)) then {
			if !(ROS_WaveOut) then {
				_unit switchmove "Acts_JetsMarshallingStraight_out";
				sleep 5;
				_unit doWatch _nHeli;
				// Remove red lights
				{deleteVehicle _x} foreach [clLH, clRH];
				ROS_WiLightsAdded = false;
				_unit switchmove "";
				ROS_WaveOut = true;
			};
		};
	};
	sleep 2;
};

