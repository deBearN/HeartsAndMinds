_nr = _this select 0;

applyRandomDamage = {
    private _player = _this select 0;
    private _damageAmount = 0.1;
    private _bodyParts = ["head", "body", "hand_r", "hand_l", "leg_r", "leg_l"];
    private _randomPart = selectRandom _bodyParts;

    [_player, _damageAmount, _randomPart] spawn {
        params ["_innerPlayer", "_innerDamageAmount", "_innerRandomPart"];
        [_innerPlayer, _innerDamageAmount, _innerRandomPart, "bullet"] call ace_medical_fnc_addDamageToUnit;
    };
};

switch (_nr) do {
    case "1": {
        missionNamespace setVariable [format ["%1_hp", player], getDammage player];
        missionNamespace setVariable [format ["%1_loop", player], 1];

        player allowDamage true;

        while {missionNamespace getVariable [format ["%1_loop", player], 0] == 1} do {
            player setVariable ["ace_medical_allowDamage", true];
            [player] call applyRandomDamage;
            //cutText ["Você está fora da Área Permitida !!! Volte Agora !!!", "PLAIN DOWN"];
            ["ForaAreaSegura", ["", ""]] call BIS_fnc_showNotification;
            sleep 10;
        };
    };

    case "2": {
        missionNamespace setVariable [format ["%1_loop", player], 0];
        player setDamage (missionNamespace getVariable [format ["%1_hp", player], 0]);
        //cutText ["Você está em uma Área Segura !!!\n\nMais cuidado da próxima vez.", "PLAIN DOWN"];
        ["AreaSegura", ["", ""]] call BIS_fnc_showNotification;
    };
};