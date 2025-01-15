/*

ROS Heli repair v1.3 - by RickOShay

Supports all helis in Arma 3 / DLCs / RHS / SOG

LEGAL STUFF
Credit must be given in your mission and on the Steam Workshop if this script is used in any mission or
derivative works. There are three dependent scripts: ROS_HeliRepair.sqf, ROS_Welder.sqf, ROSWavein.sqf.
They must be kept together.

USAGE:
In the editor drop down a helipad where the helo will land and be repaired.
Place a Repair AI unit ~20m behind the helipad facing the helipad in the direction of incoming helos.
Repair unit must be in his own group and be a minimum of 20m from the helipad.

   👨 repair unit

        ↑ 20m

        □ helipad center  → 25m ⛟ (auto spawned fuel truck, refueler & fuel pipe - see options below)

        ↑
       🚁 inbound helis

Place the following line in the Repair units init field:
[this] execvm "scripts\ROS_HeliRepair.sqf";

Copy the ROS_HeliRepair folder to your mission root.
Add the sound classes from the provided description.ext to Cfg_Sound in your description.ext.

For added effect use the ROS_wavein.sqf script to have a unit wave in the helis.
See that included script's header for instructions.

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Auto add Refuel Truck, Fuel Pipes &  Refueler to the right hand side of the helipad. Default true = ON             */

_addRefuelItems = true;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////// DO NOT MAKE CHANGES BELOW THIS LINE //////////////////////////////////////////////// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params ["_repairer"];

if (!local _repairer) exitWith {};

// Supported helipads
//_helipads = ["Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadEmpty_F","Land_HelipadRescue_F","Land_HelipadSquare_F","HeliH","HeliHCivil","Heli_H_civil","HeliHEmpty","HeliHRescue","Heli_H_rescue"];

_nHeliPads = [];
_nHeliPad = objNull;
_ftruck = objNull;
_wlight = objNull;
_ctl = false;
ROS_hInbound = false;
ROSHeliRepaired = false;
ROSHeliRefueled = false;
_repaircase = objNull;
_initPos = getPosATL _repairer;
_initDir = getdir _repairer;
_nearestHeli = objNull;
_nHeliPads = [];
_heliDamage = 0;
_heliFuel = 0;
_vehType = "";
_firstpos = [0,0,0];
_reppos = [0,0,0];

// Disable damage on repairer
[_repairer, false] remoteExec ["allowDamage",0];

_nHeliPads = nearestObjects [_repairer, ["HeliH"], 30];
if (count _nHeliPads >0) then {_nHeliPad = _nHeliPads select 0};
if (isNull _nHeliPad) exitWith {hint "There is no nearby helipad within (~20m) of the repair unit";};
// Do not change the helipad orientation below it must point at the repairer
if (abs ((getdir _nHeliPad +180) - (getdir _repairer))>15) then {
	_nHeliPad setdir (getdir _repairer -180);
};

// If unit is too close to helipad move back 20m relative to helipad.
if (_repairer distance _nHeliPad <20) then {
	_dir = getDir _repairer;
	_pos = _nHeliPad getPos [-20, _dir-10];
	_repairer setPosATL _pos;
	_repairer setdir _dir;
	_initPos = getPosATL _repairer;
	_initDir = getdir _repairer;
};

// Orange light center helipad
_padlamp = "PortableHelipadLight_01_red_F" createVehicle [0,0,0];
_padlamp setpos (_nHeliPad modeltoworld [0,0,-0.1]);
_padlamp enableSimulation false;
_padlamp allowdamage false;
_padlamp setdir (getdir _repairer);
_olight = "Reflector_Cone_01_narrow_orange_F" createVehicle [0,0,0];
_olight setpos (_padlamp modelToWorld [0,0,0.12]);
_olight hideObject true;
[_olight] spawn { params ["_olight"]; while {true} do {_olight setdir (getdir _olight +2); sleep 0.001;}};

// Oil spill on helipad
_oil1 = "Oil_Spill_F" createVehicle [0,0,0];
_oil1 setpos (_padlamp modeltoworld [0,1.5,0]);

// Place red light on vest
_r1 = "Chemlight_red" createVehicle [0,0,0];
_r1 attachTo [_repairer, [0,0.1,0], "Spine3"];

_hitpartType = ["#c svetlo","#cabin_light","#cabin_light1","#cabin_light2","#cabin_light3","#cam_gunner","#cargo_light_1","#cargo_light_2","#cargo_light_3","#cargo_light_4","#gear_1_light_1_hit","#gear_1_light_2_hit","#gear_2_light_1_hit","#gear_3_light_1_hit","#gear_3_light_2_hit","#gear_f_lights","#glass11","#hitlight1","#hitlight2","#hitlight3","#l svetlo","#l2 svetlo","#light_1","#light_1_hit","#light_1_hitpoint","#light_2","#light_2_hit","#light_2_hitpoint","#light_3_hit","#light_4_hit","#light_f","#light_fg125","#light_g","#light_hd_1","#light_hd_2","#light_hitpoint","#light_l","#light_l_flare","#light_l_hitpoint","#light_l2","#light_l2_flare","#light_r","#light_r_flare","#light_r_hitpoint","#light_r2","#light_r2_flare","#p svetlo","#p2 svetlo","#reverse_light_hit","#rl_nav_illum","#rl_op_red_illum","#rl_op_teal_illum","#rl_remspot_illum","#searchlight","#svetlo","#t svetlo","#wing_left_light","#wing_right_light","armor_composite_65","glass_pod_01_hitpoint","hit_ammo","hit_optic_crows_day","hit_optic_driver","hit_optic_sosnau","hitatgmsight","hitbody","hitduke1","hitengine","hitfuel","hitfuel_l","hitfueltank_left","hitglass1","hithrotor","hithull","hithull_structural","hitlfwheel","hitvrotor","hitwindshield_1","armor_composite_40","armor_composite_50","armor_composite_60","armor_composite_70","armor_composite_75","armor_composite_80","armor_composite_85","armor_composite_95","glass_1_hitpoint","glass_10_hitpoint","glass_11_hitpoint","glass_12_hitpoint","glass_13_hitpoint","glass_14_hitpoint","glass_15_hitpoint","glass_16_hitpoint","glass_17_hitpoint","glass_18_hitpoint","glass_19_hitpoint","glass_2_hitpoint","glass_20_hitpoint","glass_3_hitpoint","glass_4_hitpoint","glass_5_hitpoint","glass_6_hitpoint","glass_7_hitpoint","glass_8_hitpoint","glass_9_hitpoint","glass_pod_02_hitpoint","glass_pod_03_hitpoint","glass_pod_04_hitpoint","glass_pod_05_hitpoint","glass_pod_06_hitpoint","hit_ammo","hit_gps_headmirror","hit_gps_optical","hit_gps_tis","hit_light_l","hit_light_r","hit_lightl","hit_lightr","hit_longbow","hit_optic_1g46","hit_optic_1k13","hit_optic_1k13","hit_optic_9s475","hit_optic_citv","hit_optic_comcwss","hit_optic_comm2","hit_optic_comperiscope","hit_optic_comperiscope1","hit_optic_comperiscope2","hit_optic_comperiscope3","hit_optic_comperiscope4","hit_optic_comperiscope5","hit_optic_comperiscope6","hit_optic_comperiscope7","hit_optic_comsight","hit_optic_crows_day","hit_optic_crows_day","hit_optic_crows_lrf","hit_optic_crows_ti","hit_optic_driver","hit_optic_driver_rear","hit_optic_driver1","hit_optic_driver2","hit_optic_driver3","hit_optic_dvea","hit_optic_essa","hit_optic_gps","hit_optic_gps_ti","hit_optic_loaderperiscope","hit_optic_mainsight","hit_optic_nsvt","hit_optic_periscope","hit_optic_periscope1","hit_optic_periscope2","hit_optic_periscope3","hit_optic_periscope4","hit_optic_pnvs","hit_optic_sosnau","hit_optic_tads","hit_optic_tkn3","hit_optic_tkn3","hit_optic_tkn4s","hit_optic_tpd1k","hit_optic_tpn4","hit_optics_cdr_civ","hit_optics_cdr_peri","hit_optics_dvr_dve","hit_optics_dvr_peri","hit_optics_dvr_rearcam","hit_optics_gnr","hitaasight","hitammo","hitammohull","hitavionics","hitbattery_l","hitbattery_r","hitbody","hitcomgun","hitcomsight","hitcomturret","hitcontrolrear","hitdoor_1_1","hitdoor_1_2","hitdoor_2_1","hitdoor_2_2","hitduke1","hitduke2","hitengine","hitengine_1","hitengine_2","hitengine_3","hitengine_4","hitengine_c","hitengine_l1","hitengine_l2","hitengine_r1","hitengine_r2","hitengine1","hitengine2","hitengine3","hitengine4","hitfuel","hitfuel_l","hitfuel_lead_left","hitfuel_lead_right","hitfuel_left","hitfuel_left_wing","hitfuel_r","hitfuel_right","hitfuel_right_wing","hitfuel2","hitfuell","hitfuelr","hitfueltank","hitfueltank_left","hitfueltank_right","hitgear","hitglass1","hitglass10","hitglass11","hitglass12","hitglass13","hitglass14","hitglass15","hitglass16","hitglass17","hitglass18","hitglass19","hitglass1a","hitglass1b","hitglass2","hitglass20","hitglass21","hitglass3","hitglass4","hitglass5","hitglass6","hitglass7","hitglass8","hitglass9","hitgun","hitgun1","hitgun2","hitgun3","hitgun4","hitguncom","hitguncomm2","hitgunlauncher","hitgunloader","hitgunnsvt","hithood","hithrotor","hithstabilizerl1","hithull","hithull_structural","hithydraulics","hitlaileron","hitlaileron_link","hitlauncher","hitlbwheel","hitlcelevator","hitlcrudder","hitlf2wheel","hitlfwheel","hitlglass","hitlight","hitlightback","hitlightfront","hitlightl","hitlightr","hitlmwheel","hitlrf2wheel","hitltrack","hitmainsight","hitmissiles","hitperiscope1","hitperiscope10","hitperiscope11","hitperiscope12","hitperiscope13","hitperiscope14","hitperiscope2","hitperiscope3","hitperiscope4","hitperiscope5","hitperiscope6","hitperiscope7","hitperiscope8","hitperiscope9","hitperiscopecom1","hitperiscopecom2","hitperiscopegun1","hitperiscopegun2","hitperiscopegun3","hitperiscopegun4","hitpylon1","hitpylon10","hitpylon11","hitpylon2","hitpylon3","hitpylon4","hitpylon5","hitpylon6","hitpylon7","hitpylon8","hitpylon9","hitraileron","hitraileron_link","hitrbwheel","hitrelevator","hitreservewheel","hitrf2wheel","hitrfwheel","hitrglass","hitrightrudder","hitrmwheel","hitrotor","hitrotor1","hitrotor2","hitrotor3","hitrotor4","hitrotor5","hitrotor6","hitrotorvirtual","hitrrudder","hitrtrack","hitsearchlight","hitspare","hitstarter1","hitstarter2","hitstarter3","hittail","hittransmission","hitturret","hitturret1","hitturret2","hitturret3","hitturret4","hitturretcom","hitturretcomm2","hitturretlauncher","hitturretloader","hitturretnsvt","hitvrotor","hitvstabilizer1","hitwinch","hitwindshield_2","ind_hydr_l","ind_hydr_r","indicatoreng1","indicatoreng2","indicatoroil1","indicatoroil2","usespare","warningaileron","warningelevator"];

_hitpartText = ["Light","Cabin Light","Cabin Light","Cabin Light","Cabin Light","Cam Gunner","Cargo Light","Cargo Light","Cargo Light","Cargo Light","Gear Light","Gear Light","Gear Light","Gear Light","Gear Light","Gear Light","Glass","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Light","Searchlight","Light","Light","Light","Light","Armor","Glass","Ammo","Optics","Optics","Optics","Sight","Body","Duke","Engine Part","Fuel","Fuel","Fuel","Glass","Rotor","Hull","Hull","Wheel","Rotor","Windshield","Armor","Armor","Armor","Armor","Armor","Armor","Armor","Armor","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Ammo","Mirror","GPS","GPS","Light","Light","Light","Light","Longbow","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Optics","Sight","Ammo","Ammo","Avionics","Battery","Battery","Body","Gun","Sight","Turret","Control","Door","Door","Door","Door","Duke","Duke","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Engine Part","Fuel System","Fuel System","Fuel System","Fuel System","Fuel System","Fuel System","Fuel System","Fuel System","Fuel System","Fuel System","Fuel System","Fuel System","Fuel Tank","Fuel Tank","Fuel Tank","Gear","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Glass","Gun","Gun","Gun","Gun","Gun","Gun","Gun","Gun","Gun","Gun","Hood","Rotor","Stabilizer","Hull","Hull","Hydraulics","Aileron","Aileron","Launcher","Wheel","Elevator","Rudder","Wheel","Wheel","Glass","Light","Light","Light","Light","Light","Wheel","Wheel","Track","Sight","Missiles","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Periscope","Pylon","Pylon","Pylon","Pylon","Pylon","Pylon","Pylon","Pylon","Pylon","Pylon","Pylon","Aileron","Aileron","Wheel","Elevator","Wheel","Wheel","Wheel","Glass","Rudder","Wheel","Rotor","Rotor","Rotor","Rotor","Rotor","Rotor","Rotor","Rotor","Rudder","Track","Searchlight","Spare","Starter","Starter","Starter","Tail","Transmission","Turret","Turret","Turret","Turret","Turret","Turret","Turret","Turret","Turret","Turret","Rotor","Stabilizer","Winch","Windshield","Hydraulics","Hydraulics","Indicator Engine","Indicator Engine","Indicator Oil","Indicator Oil","Spare","Aileron","Elevator"];

// Remove repairer NVGoggles
_repairer unassignitem "nvgoggles";
_repairer removeitem "nvgoggles";

if (_addRefuelItems) then {
	_dir = getDir _repairer;
	_ftruckpos = _nHeliPad modeltoworld [21.8721,-1.82813,0];
	_ftruck = createvehicle ["Braf_Worker_Fuel", _ftruckpos, [], 0, "CAN_COLLIDE"];
	_ftruck setpos _ftruckpos;
	_ftruck setdir (_ftruck getdir _nHeliPad)-180;
	//ftruck = _ftruck;

	// White spotlight rear of Ftruck
	_wlight = "Reflector_Cone_01_narrow_white_F" createVehicle [0,0,0];
	_wlight setpos (_ftruck modelToWorld [-0.1,-3.48,0.855]);
	_wlight setdir (_wlight getdir _nHeliPad);
	_wlight hideObject true;

	sleep 1;
	_refueler = "B_engineer_F" createvehicle [0,0,0];
	_refueler setpos (_ftruck modeltoworld [2.5,-2.5,-1.7]);
	_refueler setdir (_refueler getdir _nHeliPad);
	_refueler switchmove "Acts_CivilIdle_1";

	// Place white light in front or refueler
	_lightp = "#lightpoint" createVehicleLocal [0,0,0];
	_lightp setLightBrightness 0.1;
	_lightp setLightColor[1, 1, 1];
	_lightp lightAttachObject [_refueler, [0,0.7,0.7]];

	removeAllWeapons _refueler;
	removeAllItems _refueler;
	removeAllAssignedItems _refueler;
	removeVest _refueler;
	removeBackpack _refueler;
	removeHeadgear _refueler;
	_refueler addVest "V_DeckCrew_violet_F";
	_refueler addHeadgear "H_MilCap_gry";
	_refueler disableAI "move";
	_refueler setBehaviour "careless";
};

/////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

ROS_Repair_heli_fnc = {
	params ["_repairer", "_veh", "_initPos", "_initDir", "_hitpartType", "_hitpartText", "_nHeliPad", "_addRefuelItems", "_ftruck"];

	_rdist = 0;
	_hitpartDesc = "";
	ROSHeliRepaired = false;
	ROSHeliRefueled = false;
	_pilot = assignedDriver _veh;

	// switch on rotating orange pad light
	_olight hideObject false;

	_hose0 = objNull;
	_hose1 = objNull;
	_hose2 = objNull;
	_hose3 = objNull;
	_hose4 = objNull;
	_hose5 = objNull;

	// Repair the Heli
	hint "";

	// Create Repaircase
	_repaircase = "Land_PlasticCase_01_small_F" createVehicle (position _repairer);
	[_repaircase, false] remoteExec ["enableSimulationGlobal", 2];
	_repaircase setposatl (_repairer modelToWorld [0.5,-0.2,-0.5]);
	_repaircase setdir (getdir _repairer +10);

	//Switch engine off
	_timer = time +6;

	if (isEngineOn _veh && isTouchingGround _veh && _veh distance _nHeliPad <5) then {
		if (isplayer _pilot) then {
			_repairer sidechat "Switch the engine and lights off and Exit the vehicle.";
			hint "Please switch the engine and lights off and Exit the vehicle.";
		};
	};

	waitUntil {!isEngineOn _veh or time >_timer};

	// Align heli with pad
	_nearestHeli setPos (getpos _nHeliPad);

	// Force engine off and player out
	if (isEngineOn _veh) then {
		[_veh, false] remoteExec ["engineOn", _veh];
	};

	[_veh, false] remoteExec ["setPilotLight", _veh];

	hint "";

	// Kick player
	if (isplayer _pilot && vehicle player == _veh) then {
		_repairer sidechat "You must exit the vehicle.";
		hint "You must exit the vehicle.";
		player action ["EJECT", _veh];
		waitUntil {vehicle player == player};
	};

	// Lock Vehicle
	if (isPlayer _pilot && !(vehicle player == _veh)) then {_veh lock true};

	_repairer setBehaviour "careless";
	_repairer setspeedMode "limited";
	_repairer allowFleeing 0;
	[_repairer, false] remoteExec ["allowDamage",0];
	[_veh, false] remoteExec ["allowDamage",0];

	// [hitpointsNamesArray, selectionsNamesArray, damageValuesArray]
	_allHPnames = ((getAllHitPointsDamage _veh) select 0);
	_allHPvalues = ((getAllHitPointsDamage _veh) select 2);
	_numDamHP = {_x >0} count _allHPvalues;

	/*// Play repair sounds
	[_veh, _repairer] spawn {
		params ["_veh", "_repairer"];
		waitUntil {animationState _repairer == "acts_carfixingwheel"};
		sleep 0.3;
		_sounds = ["repair","repair1","repair2","repair3","repair4","repair5","repair6"];
		while {!ROSHeliRepaired && alive _veh && alive _repairer} do {
			_selSound = selectRandom _sounds;
			// sound, maxDistance, pitch, isSpeech
			[[_repairer, player], [_selSound, 100]] remoteExec ["say3D", 0];
			sleep 5.5;
		};
	};*/

	sleep 1;

	// Attach repair case to repairer's hand
	_repaircase setdir (getdir _repairer -5);
	_repaircase attachto [_repairer,[0.01,-0.06,-0.21],"RightHandMiddle1"];

	// Get approx size of hull
	_bbr = 0 boundingBoxReal _veh;
	_ba1 = _bbr select 0;
	_ba2 = _bbr select 1;
	_bsd = _bbr select 2; // sphere diameter
	_maxW = abs ((_ba2 select 0) - (_ba1 select 0));
	_maxL = abs ((_ba2 select 1) - (_ba1 select 1));

	if (_maxL > _maxW) then {_maxW = _maxL};

	_reppos = [0,0,0];
	_xoffSet = 0;

	// Create moveto positions
	_firstpos = _veh getPos [_maxW+1, (getdir _veh)+90];

	// A3 / RHS
	if ("RHS_MELB" in typeof _veh) then {_xoffSet =2.2;};
	if ("BRAF_Fennec_SAR" in typeof _veh) then {_xoffSet =2.5;};
	if ("RHS_AH64D" in typeof _veh or "Apache_AH1" in typeOf _veh) then {_xoffSet =3;};
	if ("RHS_UH60M" in typeof _veh) then {_xoffSet =3;};
	if ("B_Heli_Light" in typeof _veh) then {_xoffSet =2.05;};
	if ("C_Heli_Light" in typeof _veh) then {_xoffSet =2;};
	if ("I_C_Heli_Light" in typeof _veh) then {_xoffSet =2;};
	if ("O_Heli_Light_02" in typeof _veh or "rhs_ka60" in typeOf _veh) then {_xoffSet =2.55;};
	if ("B_Heli_Attack" in typeof _veh) then {_xoffSet =2.6;};
	if ("B_Heli_Transport_03" in typeof _veh) then {_xoffSet =3.85;};
	if ("Heli_Transport_01" in typeof _veh) then {_xoffSet =2.8;};
	if ("O_Heli_Attack" in typeof _veh) then {_xoffSet =4.3;};
	if ("O_Heli_Transport" in typeof _veh) then {_xoffSet =4.8;};
	if ("I_Heli_light_03" in typeof _veh or "Wildcat_AH1" in typeOf _veh) then {_xoffSet =2.1;};
	if ("I_E_Heli_light_03" in typeof _veh) then {_xoffSet =2.1;};
	if ("RHS_AH1Z" in typeof _veh) then {_xoffSet =3.5;};
	if ("RHS_UH1Y" in typeof _veh) then {_xoffSet =2.4;};
	if ("C_IDAP_Heli_Transport" in typeof _veh) then {_xoffSet =3.9;};
	if ("RHS_Ka52" in typeOf _veh) then {_xoffSet = 6.1;};
	if ("rhs_mi28" in typeOf _veh) then {
		_xoffSet =3.1;
		_firstpos = _veh getPos [_maxW-6, (getdir _veh)+90];
	};
	if ("RHS_Mi8" in typeOf _veh) then {
		_xoffSet =2.95;
		_firstpos = _veh getPos [_maxW-6, (getdir _veh)+90];
	};
	if ("RHS_Mi24" in typeOf _veh) then {
		_xoffSet =2.7;
		_firstpos = _veh getPos [_maxW-4.5, (getdir _veh)+90];
	};
	if ("I_Heli_Transport_02" in typeof _veh or "Merlin_HC3" in typeOf _veh) then {
		_xoffSet = 3.9;
		_firstpos = _veh getPos [_maxW-4, (getdir _veh)+90];
	};
	if ("rhsusf_CH53E_USMC" in typeof _veh) then {
		_xoffSet = 4.8;
		_firstpos = _veh getPos [_maxW+7.1, (getdir _veh)+90];
	};
	if ("RHS_CH_47F" in typeof _veh) then {
		_xoffSet = 3.3;
		_firstpos = _veh getPos [_maxW-4, (getdir _veh)+90];
	};

	// SOG
	if ("vn_b_air_uh1c" in typeOf _veh) then {_xoffSet =2.25;};
	if ("vn_i_air_uh1c" in typeOf _veh) then {_xoffSet =2.25;};
	if ("vn_b_air_uh1d" in typeOf _veh) then {_xoffSet =2.65;};
	if ("vn_i_air_uh1d" in typeOf _veh) then {_xoffSet =2.65;};
	if ("vn_b_air_oh6a" in typeOf _veh) then {_xoffSet =2.0;};
	if ("vn_b_air_ah1g" in typeOf _veh) then {_xoffSet =2.2;};
	if ("vn_b_air_ch34" in typeOf _veh) then {_xoffSet =2.4;};
	if ("vn_i_air_ch34" in typeOf _veh) then {_xoffSet =2.4;};
	if ("vn_o_air_mi2" in typeof _veh) then {_xoffSet =2.4;};

	if (_xoffSet >=0) then {
		_reppos = _veh getPos [_xoffSet, (getDir _veh)+90];
	} else {
		_reppos = _veh getPos [(_maxW/3.6), (getDir _veh)+90];
	};

	// Move to first pos
	_repairer enableai "move";
	_repairer domove _firstPos;

	waitUntil {sleep 0.01; _repairer distance _firstpos <3.5};

	_repairer setdir (getdir _veh)-90;
	_repairer disableAI "anim";
	_repairer setDir (_repairer getDir _reppos);

	// Forced walk to reppos
	_maxD = (_firstpos distance _reppos);
	while {_repairer distance _reppos >0.1 && alive _veh && !(_repairer distance _firstpos > _maxD)} do {
		_repairer playMoveNow "amovpercmwlksnonwnondf";
		sleep 0.0001;
	};

	_repairer switchmove "";

	// Place Toolbox
	_repairer playactionnow "takeflag";
	sleep 0.5;
	detach _repaircase;
	_repairer playMoveNow "amovpercmstpsnonwnondnon";
	_repaircase setposatl (_repairer modelToWorld [0.5,-0.2,0]);
	_repaircase setdir (getdir _repairer +10);
	[_repaircase, false] remoteExec ["enableSimulationGlobal", 2];

	sleep 1;

	// Start REPAIR AND OR REFUEL
	if (selectMax _allHPvalues >=0.1) then {

		// Repair day - manual / Repair night - welding
		[_repairer, _veh] spawn {
			params ["_repairer", "_veh"];
			[_repairer] execvm "scripts\ROS_welder.sqf";
		};

		sleep 8;

		// Delay for repairing HP type
		_aveSecPerHP = 1.5;
		_secEngine = 4;
		_secFuel = 2;
		_secRotor = 3;
		_secHull = 5;
		_secGlass = 2;
		_delay = _aveSecPerHP;

		// Repair HPs
		for "_i" from 0 to (_numDamHP-1) do {
			_hp = _allHPnames select _i;
			if ("engine" in _hp) then {_delay = _secEngine};
			if ("fuel" in _hp) then {_delay = _secFuel};
			if ("rotor" in _hp) then {_delay = _secRotor};
			if ("hull" in _hp) then {_delay = _secHull};
			if ("glass" in _hp) then {_delay = _secGlass};
			if (!("engine" in _hp) && !("fuel" in _hp) && !("rotor" in _hp) && !("hull" in _hp) && !("glass" in _hp)) then {_delay = _aveSecPerHP};

			_hpdamage = _allHPvalues select _i;
			{if (_hpdamage>0 && _hp find _x>-1) then {_hitpartDesc = toUpper (_hitpartText select _foreachindex)}} foreach _hitpartType;

			if (_hpdamage >0) then {
				if (isplayer _pilot) then {hint format ["Repairing: %1", _hitpartDesc]};
			};

			[_veh, _hp, 0, true] call BIS_fnc_setHitPointDamage;
			if (_i == _numDamHP-1) exitWith {
				_veh setdamage 0;
				sleep 0.2;
				// Kill sound obj
				deleteVehicle (allMissionObjects "#soundonvehicle" select 0);
				{if (typeOf _x == "#particlesource") then {deleteVehicle _x}} forEach (_veh nearObjects 7);
				ROSHeliRepaired = true;
			};
			sleep _delay;
		};

		waitUntil {damage _veh ==0 && ROSHeliRepaired};
		if (isplayer _pilot) then {Hint "Repair completed"};
	}; // end Repair

	sleep 3;

	//Refuel
	_fInc = 0;
	_fveh = fuel _veh;

	_repairer switchmove "amovpercmstpsnonwnondnon";

	if (fuel _veh <=0.8) then {
		if (_addRefuelItems) then {
			_hose0 = "LayFlatHose_01_CurveShort_F" createVehicle [0,0,0];
			_hose1 = "LayFlatHose_01_CurveLong_F" createvehicle [0,0,0];
			_hose2 = "LayFlatHose_01_SBend_F" createvehicle [0,0,0];
			_hose3 = "LayFlatHose_01_SBend_F" createvehicle [0,0,0];
			_hose4 = "LayFlatHose_01_SBend_F" createvehicle [0,0,0];
			_hose5 = "LayFlatHose_01_CurveShort_F" createVehicle [0,0,0];
			{[_x, _veh] remoteExecCall ["disableCollisionWith", 0, _x]} forEach [_hose0,_hose1];
			_hose2 attachto [_hose1,[-0.55,-5,0]];
			_hose3 attachto [_hose2,[0.86,-5,0]];
			_hose4 attachto [_hose3,[0.86,-5,0]];
			_hose1 setdir (getdir _ftruck +180);
			_hose5 attachto [_hose4,[0.43,-3.1,0.47]];
			_hose5 setdir (getdir _hose4-140);
			_hose5 setvectorup [1,0,0];
			_hose0 attachto [_hose1,[1.4,2.9,0.47]];
			_hose0 setvectorUp [-0.5,0.5,0];
			_hose0 setvectorDir [0.149259,0.988798,0];
			sleep 0.2; //hose1 = _hose1;
			_hose1 setpos (_ftruck modelToWorld [2.9,-16.2,-1.74]);
		};

		sleep 1.5;

		if (isplayer _pilot) then {hint "Vehicle is being refueled"};
		[[_hose1, player], ["refuel_startH",100]] remoteExec ["say3D", 0];
		sleep 2;
		for "_i" from _fveh to 1 step 0.1 do {
			[[_hose1, player], ["refuel_loopH",100]] remoteExec ["say3D", 0];
			sleep 5;
			if (isplayer _pilot) then {hint format ["Refueling: %1 %2", ((fuel _veh)*100) toFixed 1, '%']};
			if (_i<0.95) then {[_veh, ((fuel _veh)+0.1)] remoteExec ["setfuel", _veh]};
		};
		[[_hose1, player], ["refuel_endH",100]] remoteExec ["say3D", 0];
		if (isplayer _pilot) then {hint "Refueled: 100.0"};
	} else {
		// Top up
		[_veh, 1] remoteExec ["setfuel", _veh];
	};

	sleep 0.5;

	waitUntil {fuel _veh > 0.8 && damage _veh ==0};

	// Clean up
	deleteVehicle _repaircase;
	if (_addRefuelItems && !isNull _hose1) then {
		{deleteVehicle _x; sleep 0.1;} forEach [_hose0,_hose1,_hose2,_hose3,_hose4,_hose5];
	};

	_repairer switchMove "amovpercmstpsnonwnondnon";

	[[_repairer, player], ["RepairedSirH", 50]] remoteExec ["say3D", 0];
	_vehType = getText(configFile>>"CfgVehicles">>typeOf (_veh)>>"DisplayName");
	if (isplayer _pilot) then {
		_veh sidechat format ["%1 has been repaired and refueled Sir", _vehType];
		hint format ["%1 has been\nrepaired and refueled Sir", _vehType];
	};

	// Unlock Vehicle
	if (isPlayer _pilot) then {_veh lock false};

	_repairer enableai "anim";
	_repairer enableai "move";

	_wp0 = (group _repairer) addWaypoint [_initPos, 0];
	_wp0 setWaypointType "MOVE";
	_repairer setspeedMode "limited";
	[_veh, true] remoteExec ["allowDamage",0];
	waitUntil {_repairer distance _initPos <2};
	sleep 1;
	// Switch off orange repair light
	_olight hideObject true;

	_repairer setdir (_repairer getdir _nHeliPad);
	_repairer disableAI "MOVE";

	ROSHeliRefueled = true;
	ROSHeliRepaired = true;

	true

}; // End REPAIR / REFUEL heli fnc


/////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////


// Find nearest damaged Heli
while {true} do {

	// Is pad clear - if not remove debris
	_neardead = allDead select {_x distance _nHeliPad <15};
	if (count _neardead>0) then {
		hint "Please hold while we clear the debris";
		sleep 5;
		{deletevehicle _x; sleep 1;} foreach _neardead;
	};

	// Look for helis nearby and repair them
	_nearestHeli = nearestObject [_nHeliPad, "Helicopter"];

	if (!isNull _nearestHeli && alive _nearestHeli) then {
		//Switch on spotlight on rear of fuel truck
		if (isObjectHidden _wlight && _addRefuelItems) then {_wlight hideObject false;};

		_heliDamage = selectMax ((getAllHitPointsDamage _nearestHeli) select 2);
		_heliFuel = fuel _nearestHeli;

		// Max allowed distance from helipad center (cannot be too large - allow for repairer pathing)
		_pDist = 6.5;

		if (!isTouchingGround _nearestHeli && _heliFuel <0.9 or _heliDamage >=0.1) then {
			if (isplayer (driver _nearestHeli)) then {hint format ["Distance to repair bay: %1\nCurrent damage: %2\nCurrent Fuel: %3%4", round (_nearestHeli distance _nHeliPad), (_heliDamage*100) toFixed 1, (_heliFuel *100) toFixed 1, '%']};
			if !(_ctl) then {
				if (isplayer (driver _nearestHeli)) then {
					[[_nearestheli, player], ["ClearToLandH", 40]] remoteExec ["say3D", player];
					sleep 0.2;
					_ctl =true;
				};
			};
		};

		if (isTouchingGround _nearestHeli) then {

			if (_heliFuel <0.9 or _heliDamage >=0.1) then {
				if (_nearestHeli distance _nHeliPad >_pDist) then {
					if (isplayer (assignedDriver _nearestHeli)) then {hint format ["You should be <%1m from the center of the pad.\nYou need to move closer to the center.", _pDist]};
				};
			};

			if (_heliFuel >=0.9 && _heliDamage <0.1) then {
				if (isplayer (assignedDriver _nearestHeli)) then {hint "This vehicle does not need\nto be repaired or refueled.\nPlease vacate the repair bay.\nThank you!"};
				sleep 5;
				hint "";
			};

			// Start repair if fuel (<0.9) or vehicle damage (any hp>0.1)
			_initDir = _repairer getdir _nearestHeli;
			if (_nearestHeli distance _nHeliPad <= _pDist && (_heliFuel <0.9 or _heliDamage >=0.1)) then {
				if (isplayer (assignedDriver _nearestHeli)) then {
					hint "Aligning with repair bay";
					_nearestHeli setPos (getpos _nHeliPad);
					sleep 1;
					[_repairer, _nearestHeli, _initPos, _initDir, _hitpartType, _hitpartText, _nHeliPad, _addRefuelItems, _ftruck] call ROS_Repair_heli_fnc;
					_ctl = false;
				};
			};
		};
	}; // !isnull nearestheli

	// Switch off Fuel truck spotlight when no near heli
	if (!isObjectHidden _wlight && isnull _nearestheli) then {_wlight hideObject true;};
	sleep 2;

}; // end while
