
/* ----------------------------------------------------------------------------
Function: btc_veh_fnc_addRespawn

Description:
    Add a vehicle to the respawn system and save vehicle parameters.

Parameters:
    _vehicle - Vehicle to add inside the respawn system. [Object]
    _time - Time before respawn. [Number]

Returns:
    _handle - Value of the MPEventhandle. [Number]

Examples:
    (begin example)
        [cursorObject, 30] call btc_veh_fnc_addRespawn;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_vehicle", objNull, [objNull]],
    ["_time", 30, [0]]
];

if (isNil "btc_helo") then {
    btc_helo = [];
};

private _index = btc_helo pushBackUnique _vehicle;
if (_index isEqualTo -1) exitWith {
    if (btc_debug || btc_debug_log) then {
        ["Helo added more than once in btc_helo", __FILE__, [btc_debug, btc_debug_log, true]] call btc_debug_fnc_message;
    }; 
};

private _type = typeOf _vehicle;
private _pos = getPosASL _vehicle;
private _dir = getDir _vehicle;
private _vector = [vectorDir _vehicle, vectorUp _vehicle];
private _vehProperties = [_vehicle] call btc_fnc_getVehProperties;
_vehProperties set [5, false];

_vehicle setVariable ["data_respawn", [_type, _pos, _dir, _time, _vector] + _vehProperties];

if ((isNumber (configOf _vehicle >> "ace_fastroping_enabled")) && (typeOf _vehicle isNotEqualTo "RHS_UH1Y_d")) then {[_vehicle] call ace_fastroping_fnc_equipFRIES};
_vehicle addMPEventHandler ["MPKilled", {
    if (isServer) then {
        _this call btc_veh_fnc_respawn;
    };
}];
if (btc_p_respawn_location > 0) then {
    if (fullCrew [_vehicle, "cargo", true] isNotEqualTo []) then {
        [_vehicle, "Deleted", {_thisArgs call BIS_fnc_removeRespawnPosition}, [btc_player_side, _vehicle] call BIS_fnc_addRespawnPosition] call CBA_fnc_addBISEventHandler;
    };
};
