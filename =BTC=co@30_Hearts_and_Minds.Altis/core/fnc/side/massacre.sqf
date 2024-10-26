
/* ----------------------------------------------------------------------------
Function: btc_side_fnc_massacre

Description:
    Fill me when you edit me !

Parameters:
    _taskID - Unique task ID. [String]

Returns:

Examples:
    (begin example)
        [false, "btc_side_fnc_massacre"] spawn btc_side_fnc_create;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_taskID", "btc_side", [""]]
];

//// Choose an occupied City \\\\
private _useful = values btc_city_all select {
    !((_x getVariable ["type", ""]) in ["NameLocal", "Hill", "NameMarine", "StrongpointArea"])
};
if (_useful isEqualTo []) exitWith {[] spawn btc_side_fnc_create;};
[_useful, true] call CBA_fnc_shuffle;
private _city = objNull;
private _church = objNull;
while {_useful isNotEqualTo []} do {
    _city = _useful deleteAt 0;
    _church = nearestTerrainObjects [_city, ["CHURCH", "CHAPEL"], 470];
    if (_church isNotEqualTo []) then {
        break;
    };
};
if (_useful isEqualTo [] and _church isEqualTo []) exitWith {
    [] spawn btc_side_fnc_create;
};

private _pos = getPos _city;
private _radius = _city getVariable ["cachingRadius", 0];
private _roads = _pos nearRoads _radius/2;
_roads = _roads select {isOnRoad _x};
if (_roads isEqualTo []) exitWith {[] spawn btc_side_fnc_create;};
private _road = selectRandom _roads;

private _churchSorted = _church apply {[_road distance _x, _x]};
_churchSorted sort true;
_church = _churchSorted select 0 select 1;
[_taskID, 42, _church, [_city getVariable "name", typeOf _church]] call btc_task_fnc_create;

private _group = createGroup civilian;
private _civilians = [];
private _tasksID = [];
for "_i" from 1 to 2 do { // (2 + round random 2)
    _pos = getPos _road;

    private _direction = [_road] call btc_fnc_road_direction;
    private _unit = _group createUnit [selectRandom btc_civ_type_units, _pos, [], 0, "CAN_COLLIDE"];
    _unit setDamage 1;
    _civilians pushBack _unit;

    private _civ_taskID = _taskID + "cv" + str _i;
    _tasksID pushBack _civ_taskID;
    [[_civ_taskID, _taskID], 43, _unit, typeOf _unit, false, false] call btc_task_fnc_create;
    _unit setVariable ["btc_rep_playerKiller", _civ_taskID];
};

["ace_placedInBodyBag", {
    params ["_patient", "_bodyBag", "_isGrave", "_medic"];
    if (
        !(_patient in _thisArgs)
    ) exitWith {};

    _thisArgs deleteAt (_thisArgs find _patient);
    private _taskID = _patient getVariable ["btc_rep_playerKiller", ""];
    if (_isGrave) then {
        private _church = nearestTerrainObjects [_restingPlace, ["CHURCH", "CHAPEL"], 50];
        if (_church isEqualTo []) then {
            [_taskID, "FAILED"] call BIS_fnc_taskSetState;
        } else {
            [_taskID, "SUCCEEDED"] call BIS_fnc_taskSetState;
        };
    } else {
        _thisArgs pushBack _bodyBag;
    };
}, _civilians] call CBA_fnc_addEventHandlerArgs;

a = _civilians;

waitUntil {sleep 5;
    _taskID call BIS_fnc_taskCompleted ||
    _civilians select {!isNull _x} isEqualTo []
};

[[], _civilians + [_group]] call btc_fnc_delete;

if (_taskID call BIS_fnc_taskState isEqualTo "CANCELED") exitWith {};

if ("SUCCEEDED" in (_tasksID apply {_x call BIS_fnc_taskState})) then {
    {
        [_x, "FAILED"] call BIS_fnc_taskSetState;
    } forEach (_tasksID select {!(_x call BIS_fnc_taskCompleted)});
    [_taskID, "SUCCEEDED"] call btc_task_fnc_setState;
} else {
    [_taskID, "FAILED"] call btc_task_fnc_setState;
};
