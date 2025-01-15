// Usage:
// this addAction ["Name Of Destination Here","teleporter.sqf",["destination"]];

// because we are running this from addaction we need to use the following to get the params
// _host = _this select 0;
// _caller = _this select 1;
// _id = _this select 2;
_params = _this select 3;

// because params are in an array we need to select the first entry even if there is only one entry
_destination = _params select 0;


_camera = "camera" camCreate (getpos player);
_camera cameraeffect ["terminate", "back"];
camDestroy _camera;


if (_destination == "base") then {player setPos getMarkerPos "tele_base";};
if (_destination == "cerimonial") then {player setPos getMarkerPos "tele_cerimonial";};
if (_destination == "final") then {player setPos getMarkerPos "tele_final";};

["Resolution", 1, [400]] spawn
{
	params ["_name", "_priority", "_effect", "_handle"];
	while {
		_handle = ppEffectCreate [_name, _priority];
		_handle < 0;
	} do {
		_priority = _priority + 1;
	};
	_handle ppEffectEnable true;
	_handle ppEffectAdjust _effect;
	_handle ppEffectCommit 3;
	waitUntil { ppEffectCommitted _handle };
	_handle ppEffectEnable false;
	ppEffectDestroy _handle;
};

/* // DynamicBlur Effect muito bom para o teleporte...
["DynamicBlur", 400, [10]] spawn
{
	params ["_name", "_priority", "_effect", "_handle"];
	while {
		_handle = ppEffectCreate [_name, _priority];
		_handle < 0
	} do {
		_priority = _priority + 1;
	};
	_handle ppEffectEnable true;
	_handle ppEffectAdjust _effect;
	_handle ppEffectCommit 3;
	waitUntil { ppEffectCommitted _handle };
	_handle ppEffectEnable false;
	ppEffectDestroy _handle;
};
*/