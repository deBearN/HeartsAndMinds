//////////////////////////////////////////////////////////////////////////////////////////////////////////
// Can _snakes kill rabbits? (and do cats eat bats)
_killRabbits = true;
//////////////////////////////////////////////////////////////////////////////////////////////////////////

params ["_killRabbits"];

_dist = 2;
_snakes = [];
_rabbits = [];
_snake = objnull;
_rabbit = objNull;
_bitePprob = 0.6;
_biteRprob = 0.6;

ROS_ChromAberr_fnc = {
    ["ChromAberration", 200, [0.02, 0.02, true]] spawn {
        params ["_name", "_priority", "_effect", "_handle"];
        _ex = _effect select 0;
        _ey = _effect select 1;
        while {
            _handle = ppEffectCreate [_name, _priority];
            _handle < 0
        } do {
            _priority = _priority + 1;
        };
        _handle ppEffectEnable true;
        _handle ppEffectAdjust _effect;
        _handle ppEffectCommit 5;
        waitUntil {ppEffectCommitted _handle};
        _handle ppEffectAdjust [0, 0, true];
        _handle ppEffectCommit 10;
        uiSleep 10;
        _handle ppEffectEnable false;
        ppEffectDestroy _handle;
    };
};

applyRandomDamage = {
    private _player = _this select 0;
    private _damageAmount = 0.7;
    private _bodyParts = ["leg_r", "leg_l"];
    private _randomPart = selectRandom _bodyParts;

    [_player, _damageAmount, _randomPart] spawn {
        params ["_innerPlayer", "_innerDamageAmount", "_innerRandomPart"];
        [_innerPlayer, _innerDamageAmount, _innerRandomPart, "stab"] call ace_medical_fnc_addDamageToUnit;
    };
};

ROS_snakeBiteP_fnc = {
    params ["_snake"];
    // Bite player
    _bitesnd = selectRandom ["snake_bite_scream1","snake_bite_scream2"];
    [[player, player], [_bitesnd, 50, 1, true]] remoteExec ["say3D", 0];
    _dist = _snake distance player;
    _dir = _snake getdir player;
    _snake enableSimulation false;
    _snake setdir _dir;
    sleep 0.5;
    for "_i" from _dist to 0.9 step -0.1 do {
        _dist = _snake distance player;
        _dir = _snake getdir player;
        _pos = _snake getPos [(_dist-_i), _dir];
        _snake setpos _pos;
        sleep 0.01;
    };
    sleep 1;
    _snake enableSimulation true;

    cutText ["Uma cobra me mordeu !", "PLAIN DOWN"];
    [player] call applyRandomDamage;

    if (alive player && damage player > 0.5) then {[] spawn ROS_ChromAberr_fnc};
    
    // Make snake flee
    [_snake] call ROS_snakeFlee_fnc;

    true
};

ROS_snakeBiteR_fnc = {
    params ["_snake", "_rabbit"];
    _snake enableSimulation false;
    _dist = _snake distance _rabbit;
    _dir = _snake getdir _rabbit;
    _snake setdir _dir;
    // Bite rabbit
    [[_rabbit, player], ["snake_bite_rabbit", 100, 1, true]] remoteExec ["say3D", 0];
    sleep 0.5;
    for "_i" from _dist to 0.7 step -0.1 do {
        _dist = _snake distance _rabbit;
        _dir = _snake getdir _rabbit;
        _pos = _snake getPos [(_dist-_i), _dir];
        _snake setpos _pos;
        sleep 0.01;
    };
    sleep 1.5;
    _snake enableSimulation true;
    sleep 7 + random 3;
    _rabbit setdamage 1;
    _rabbit = objnull;
    _snake playMove "Snakes_Idle_Stop";

    true
};

ROS_snakeFlee_fnc = {
    params ["_snake"];
    private _dir = random 360;
    private _distance = 30 + random 30;
    private _fleePos = _snake getPos [ _distance, _dir ];

    _snake moveTo _fleePos;
    sleep 0.1;
    while {alive _snake && _snake distance _fleePos > 1} do {
        sleep 0.1;
    };
    _snake playMove "Snakes_Idle_Stop";
    true
};

///////////////////////////////////////////////////////////////////////////////////////////

while {true} do {

    if (vehicle player == player && isTouchingGround player) then {
        _nearestTarget = objnull;

        // snakes react within 5m radius of player or rabbit
        _snakes = (position player nearObjects  ["Snake_random_F", 5]) select {alive _x};
        if (count _snakes>0) then {
            _snake = selectRandom _snakes;
        } else {
            _snake = objNull;
        };

        if (!isNull _snake) then {

            // Use speech channel due to say3D over attenuation
            0 fadeSound 2;

            // Hiss
            _hisssnd = selectRandom ["snake_hiss1","snake_hiss2","snake_hiss3","snake_hiss4","snake_hiss5"];
            [[_snake, player], [_hisssnd, 30, 1, true]] remoteExec ["say3D", 0];

            sleep 1;

            if (_killRabbits) then {
                _rabbits = (position _snake nearObjects ["Rabbit_F", 15]) select {alive _x};
                if (count _rabbits>0) then {_rabbit = _rabbits select 0} else {_rabbit == objNull};
            } else {
                _rabbit == objNull;
            };

            // Choose target
            if (!isNull _rabbit) then {
                _nearestTarget = [[_rabbit, player], _snake] call BIS_fnc_nearestPosition;
            } else {
                _nearestTarget = player;
            };

            _snake setVariable ["BIS_fnc_animalBehaviour_disable", true];

            if (random 1 < 0.6) then {
                if (_nearestTarget == player) then {_dist = 2} else {_dist = 1.5};

                while {_snake distance _nearestTarget > _dist && alive _nearestTarget} do {
                    _snake setdir (_snake getdir _nearestTarget);
                    _snake moveTo (getPosATL _nearestTarget);
                    sleep 0.01;
                    // Loose interest if out of range
                    if (_snake distance _nearestTarget > 5 or !alive _snake or !alive _nearestTarget) exitWith {
                        _nearestTarget = objNull;
                        _snake playMove "Snakes_Idle_Stop";
                    };
                };
            };

            if (alive _nearestTarget && alive _snake && _snake distance _nearestTarget <=2) then {
                if (_nearestTarget == player) then {
                    if (random 1<_bitePprob) then {[_snake] call ROS_snakeBiteP_fnc};
                } else {
                    if (random 1<_biteRprob) then {[_snake, _nearestTarget] call ROS_snakeBiteR_fnc};
                };
            };

            _snake setVariable ["BIS_fnc_animalBehaviour_disable", false];

        } else {
            0 fadeSound 1;
        }; // !isnull snake

    };

    sleep 1;
    cutText ["", "PLAIN DOWN"];
};
