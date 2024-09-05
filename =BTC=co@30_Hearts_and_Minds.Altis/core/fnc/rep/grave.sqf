
/* ----------------------------------------------------------------------------
Function: btc_rep_fnc_grave

Description:
    Add reputation when a player put dead civil in grave.

Parameters:
    _patient - _patient [Object]
    _restingPlace - [Object]

Returns:

Examples:
    (begin example)
        [cursorObject, player] call btc_rep_fnc_grave;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params ["_patient", "_restingPlace"];

if (
    isNil {_city getVariable "btc_rep_playerKiller"}
) exitWith {};

private _church = nearestTerrainObjects [_patient, ["CHURCH", "CHAPEL"], 50];
if (_church isEqualTo []) exitWith {};

[btc_rep_bonus_grave, _city getVariable "btc_rep_playerKiller"] call btc_rep_fnc_change;

private _city = [_church, values btc_city_all] call btc_fnc_find_closecity;
private _cachingRadius = _city getVariable "cachingRadius";

if (_city distance _church < _cachingRadius) then {
    private _graveList = _city getVariable ["btc_rep_grave", []];
    _graveList pushBack [getPosASL _restingPlace, getDir _restingPlace, typeOf _restingPlace];
    _city setVariable ["btc_rep_grave", _graveList];
};
