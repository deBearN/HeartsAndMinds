/*
profileNamespace setVariable ["var_kills",10000];
saveProfileNamespace;
_playerKills = profileNamespace getVariable "var_kills";*/

private ["_cities_status","_fobs"];

hint "saving...";
[[8],"btc_fnc_show_hint"] spawn BIS_fnc_MP;

btc_db_is_saving = true;

for "_i" from 0 to (count btc_city_all - 1) do {
	private "_s";
	_s = [_i] spawn btc_fnc_city_de_activate;
	waitUntil {scriptDone _s};
};
hint "saving...2";
//City status
_cities_status = [];
{
	_city_status = [];
	_city_status pushBack (_x getVariable "id");
	
	//_city_status pushBack (_x getVariable "name");
	
	_city_status pushBack (_x getVariable "initialized");

	_city_status pushBack (_x getVariable "spawn_more");
	_city_status pushBack (_x getVariable "occupied");
	
	_city_status pushBack (_x getVariable "data_units");
	
	_city_status pushBack (_x getVariable ["has_ho",false]);
	_city_status pushBack (_x getVariable ["ho_units_spawned",false]);
	_city_status pushBack (_x getVariable ["ieds",[]]);

	_cities_status pushBack _city_status;
	//diag_log format ["SAVE: %1 - %2",(_x getVariable "id"),(_x getVariable "occupied")];
} foreach btc_city_all;

profileNamespace setVariable ["btc_hm_cities",_cities_status];
//rep status
profileNamespace setVariable ["btc_hm_rep",btc_global_reputation];
//FOBS
_fobs = [];
{
	private "_pos";
	_pos = getMarkerPos _x;
	_fobs pushBack [_x,_pos];
} foreach btc_fobs;
profileNamespace setVariable ["btc_hm_fobs",_fobs];
//Vehicles status

//Objects status

//
profileNamespace setVariable ["btc_hm_db",true];
saveProfileNamespace;
hint "saving...3";
[[9],"btc_fnc_show_hint"] spawn BIS_fnc_MP;

btc_db_is_saving = false;