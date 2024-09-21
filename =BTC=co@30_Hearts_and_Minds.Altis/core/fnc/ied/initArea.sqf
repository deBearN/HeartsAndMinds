
/* ----------------------------------------------------------------------------
Function: btc_ied_fnc_initArea

Description:
    Initialize positions of IEDS.

Parameters:
    _city - City to initialise. [Object]
    _area - Area to create IED. [Number]
    _n - Number of IED, real and fake. [Number]

Returns:

Examples:
    (begin example)
        _result = [] call btc_ied_fnc_initArea;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_city", objNull, [objNull]],
    ["_area", 100, [0]],
    ["_n", 1, [0]]
];

private _pos = getPos _city;
private _array = _city getVariable ["ieds", []];

private _cities = (values btc_city_all) - [_city];
_cities = _cities inAreaArray [_city, _area, _area];
private _blackListCities = _cities select {
    _x getVariable ["ieds", []] isNotEqualTo []
};
private _blackListPos = _blackListCities apply {(_x getVariable ["ieds", []]) select 0};
_blackListPos = flatten _blackListPos;
_blackListPos = _blackListPos inAreaArray [_city, _area, _area];

{
    for "_i" from 1 to _n do {
        private _sel_pos = [_pos, _area] call btc_fnc_randomize_pos;
        private _dir = random 360;

        private _roads = _sel_pos nearRoads 50;
        if (_roads isNotEqualTo []) then {
            private _arr = (selectRandom _roads) call btc_ied_fnc_randomRoadPos;
            _sel_pos = _arr select 0;
            _dir = _arr select 1;
        };
        if (
            _roads isEqualTo [] ||
            {_blackListPos inAreaArray [_sel_pos, 1, 1] isNotEqualTo []}
        ) then {
            _sel_pos = [_sel_pos, 0, 100, 1, false] call btc_fnc_findsafepos;
        };

        _array pushBack [_sel_pos, selectRandom btc_model_ieds, _dir, _x];

        if (btc_debug) then {
            private _marker = createMarker [format ["btc_ied_%1", _sel_pos], _sel_pos];
            _marker setMarkerType "mil_warning";
            _marker setMarkerColor (["ColorBlue", "ColorRed"] select _x);
            _marker setMarkerText (["IED (fake)", "IED"] select _x);
            _marker setMarkerSize [0.8, 0.8];
        };
        if (btc_debug_log) then {
            [format ["_this = %1  POS %2 N %3(%4)", _this, _sel_pos, _i, _n], __FILE__, [false]] call btc_debug_fnc_message;
        };
    };
} forEach [true, false];

_city setVariable ["ieds", _array];
