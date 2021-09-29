
/* ----------------------------------------------------------------------------
Function: btc_db_fnc_add_veh

Description:
    Add vehicle to the wreck system.

Parameters:
    _veh - Vehicle to add in wreck system. [Object]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_db_fnc_add_veh;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_veh", objNull, [objNull]]
];

if !(isServer) exitWith {
    _veh remoteExecCall ["btc_db_fnc_add_veh", 2];
};

if (isNil "btc_vehicles") then {
    btc_vehicles = [];
};
private _index = btc_vehicles pushBackUnique _veh;
if (_index isEqualTo -1) exitWith {
    if (btc_debug || btc_debug_log) then {
        ["Vehicle added more than once in btc_vehicles", __FILE__, [btc_debug, btc_debug_log, true]] call btc_debug_fnc_message;
    }; 
};

_veh setVariable ["btc_dont_delete", true];

_veh addMPEventHandler ["MPKilled", {
    if (isServer) then {
        _this call btc_veh_fnc_killed;
    };
}];
if ((isNumber (configOf _veh >> "ace_fastroping_enabled")) && (typeOf _veh isNotEqualTo "RHS_UH1Y_d")) then {
    [_veh] call ace_fastroping_fnc_equipFRIES
};
if (btc_p_respawn_location > 1) then {
    if (fullCrew [_veh, "cargo", true] isNotEqualTo []) then {
        if (
            (btc_p_respawn_location isEqualTo 2) && (_veh isKindOf "Air") ||
            btc_p_respawn_location > 2
        ) then {
            [_veh, "Deleted", {_thisArgs call BIS_fnc_removeRespawnPosition}, [btc_player_side, _veh] call BIS_fnc_addRespawnPosition] call CBA_fnc_addBISEventHandler;
        };
    };
};
