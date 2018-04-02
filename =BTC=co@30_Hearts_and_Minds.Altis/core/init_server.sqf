call compile preprocessFileLineNumbers "core\fnc\city\init.sqf";

{[_x] spawn btc_fnc_task_create} foreach [0,1];

if (btc_db_load && {profileNamespace getVariable [format ["btc_hm_%1_db",worldName],false]}) then {
    if (btc_version isEqualTo (profileNamespace getVariable [format ["btc_hm_%1_version",worldName],1.13])) then {
        call compile preprocessFileLineNumbers "core\fnc\db\load.sqf";
    } else {
        call compile preprocessFileLineNumbers "core\fnc\db\load_old.sqf";
    };
} else {
    for "_i" from 1 to btc_hideout_n do {[] call btc_fnc_mil_create_hideout;};

    private _date = date;
    _date set [3, btc_p_time];
    setDate _date;

    call compile preprocessFileLineNumbers "core\fnc\cache\init.sqf";

    {[{!isNull _this},{_this call btc_fnc_db_add_veh;}, _x] call CBA_fnc_waitUntilAndExecute;} forEach btc_vehicles;
};

call btc_fnc_db_autosave;

addMissionEventHandler ["HandleDisconnect",btc_fnc_eh_handledisconnect];

addMissionEventHandler ["BuildingChanged",btc_fnc_eh_buildingchanged];

["ace_explosives_defuse", btc_fnc_eh_explosives_defuse] call CBA_fnc_addEventHandler;

["Initialize"] call BIS_fnc_dynamicGroups;

setTimeMultiplier btc_p_acctime;

if (btc_p_arsenalType > 0) then {[btc_gear_object, !(btc_p_arsenalRestrict isEqualTo 1), true] call ace_arsenal_fnc_initBox;};
if (btc_p_arsenalType < 3) then {["AmmoboxInit", [btc_gear_object, !(btc_p_arsenalRestrict isEqualTo 1), {true}]] spawn BIS_fnc_arsenal;};


{[_x,30,false] spawn btc_fnc_eh_veh_add_respawn;} forEach btc_helo;

if (btc_p_side_mission_cycle) then {
    [true] spawn btc_fnc_side_create;
};
