if (!isDedicated) exitWith {}; // Garantir que o script seja executado apenas no servidor
// Leitura dos parâmetros
private _frstRail = _this select 0;    // Object - primeiro segmento do trilho
private _Seg = _this select 1;         // Number - número total de seções do trilho
private _targetDir = _this select 2;   // Number - direção que o alvo irá enfrentar
private _type = _this select 3;        // Number - tipo de alvo no trilho
private _moveArr = _this select 4;     // Array  - array que descreve o tipo de movimento que o alvo irá realizar

private _target = objNull;             // Object - Alvo móvel
private _railArr = [];                 // Array  - Contém todos os objetos usados
private _downTime = _moveArr select 3; // Bool   - alvo irá surgir em true (salvo como objVar "_nopop")

// Construção dos trilhos
private _initPos = getPos _frstRail;   
private _aktRail = "Target_Rail_End_F" createVehicle _initPos; // início
_aktRail attachTo [_frstRail, [-0.53, 0, 0]];
_railArr = [_aktRail, _frstRail];

for [{_x = 1}, {_x < _Seg}, {_x = _x + 1}] do { // partes do trilho
    _aktRail = "Target_Rail_F" createVehicle _initPos;
    _aktRail attachTo [_frstRail, [_x, 0, 0]];
    _railArr = _railArr + [_aktRail];
};

_aktRail = "Target_Rail_End_F" createVehicle _initPos; // fim
_aktRail attachTo [_frstRail, [(_Seg - 0.53), 0, 0]];
_railArr = _railArr + [_aktRail];

// Determinação do tipo de alvo
private _type1 = floor (_type / 10);
private _type2 = _type mod 10;

private _typeStr = switch (_type1) do {
    case 1: {"Target_PopUp_Moving"};
    case 2: {"Target_PopUp2_Moving"};
    case 3: {"Target_PopUp3_Moving"};
    case 4: {"Zombie_PopUp_Moving"};
    default {"Target_PopUp_Moving"};
};

private _accStr = switch (_type2) do {
    case 0: {""};
    case 1: {"_Acc1"};
    case 2: {"_Acc2"};
    default {""};
};

// Configuração do alvo
_target = switch (_targetDir) do {
    case 0: { // Alvo se move para a direita
        private _target = (_typeStr + _accStr + "_F") createVehicle _initPos;
        _target setPos (_frstRail modelToWorld [-0.1, 0, -0.10]);
        _target setDir (getDir _frstRail);
        _target
    };
    case 1: { // Alvo se move para a esquerda
        private _target = (_typeStr + "_90deg" + _accStr + "_F") createVehicle _initPos;
        _target setPos (_frstRail modelToWorld [-0.1, 0, -0.10]);
        _target setDir (getDir _frstRail + 90);
        _target
    };
    case 2: { // Alvo se move para trás
        private _target = (_typeStr + _accStr + "_F") createVehicle _initPos;
        _target setPos (_frstRail modelToWorld [-0.1, 0, -0.10]);
        _target setDir (getDir _frstRail - 180);
        _target
    };
    case 3: { // Alvo se move para frente
        private _target = (_typeStr + "_90deg" + _accStr + "_F") createVehicle _initPos;
        _target setPos (_frstRail modelToWorld [-0.1, 0, -0.10]);
        _target setDir (getDir _frstRail - 90);
        _target
    };
};

// Variáveis de objeto
_target setVariable ["_downTime", _downTime, true];
_target setVariable ["_down", false, true];
_target setVariable ["_base", _frstRail, true];
_target setVariable ["_objArr", _railArr, true];

// Execução do movimento
_move = [_moveArr, _Seg, _target] execVM "scripts\moveTargetRailExt.sqf";

// Retorno do alvo
_target
