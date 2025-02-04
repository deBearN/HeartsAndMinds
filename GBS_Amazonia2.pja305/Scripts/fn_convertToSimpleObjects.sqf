
private _Barriers = getMissionLayerEntities "Barreiras" select 0;
{
    _simplePos = getPosATL _x;
    _Barrier = _x call BIS_fnc_replaceWithSimpleObject;
    _Barrier setObjectScale 2;
    _Barrier setPosATL _simplePos;

} forEach _Barriers;