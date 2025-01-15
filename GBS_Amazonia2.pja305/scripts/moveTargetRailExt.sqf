if (!isDedicated) exitWith {}; // Garantir que o script seja executado apenas no servidor

// Leitura dos parâmetros
private _movArr = _this select 0;      // Array  - array que descreve o tipo de movimento que o alvo irá realizar
private _Seg = _this select 1;         // Number - número total de seções do trilho
private _target = _this select 2;      // Object - alvo

private _speed = _movArr select 0;     // Number - Velocidade n/s
private _times = _movArr select 1;     // Number - vezes
private _delay = _movArr select 2;     // Number - tempo que o alvo irá descansar
private _downTime = _movArr select 3;  // Bool   - alvo irá surgir em true
private _start = _movArr select 4;     // Object - gatilho
private _reset = _movArr select 5;     // Object - gatilho
private _frstRail = _target getVariable "_base"; // baseRail

// Manipulador de eventos de hit customizado
_target addEventHandler ["HitPart", {[(_this select 0)] execVM 'scripts\PopUpTarget.sqf';}];

// Calculando a distância para o movimento
private _dist = _Seg - 1 + 2 * 0.05;
private _dw = _speed * 0.01;

// Se o gatilho for usado, espere até que ele seja ativado
if (!isNull _start) then {
    _target animate ["terc", 1];
    waitUntil {triggerActivated _start};
    _target animate ["terc", 0];
};

// Loop até as vezes terminarem, o alvo não aparecer novamente ou infinito
private _i = 0; // Contando vezes

while {(_i < _times || _times == -1)} do {
    private _aktw = 0;

    // Alvo se movendo para baixo no trilho
    while {(_aktw < _dist) && !(_target getVariable "_down")} do {
        _aktw = _aktw + _dw;
        _target setPos (_frstRail modelToWorld [(_aktw - 0.15), 0, -0.10]);
        sleep 0.01;
    };

    // Alvo se movendo para cima no trilho novamente
    while {(_aktw > 0) && !(_target getVariable "_down")} do {
        _aktw = _aktw - _dw;
        _target setPos (_frstRail modelToWorld [(_aktw - 0.15), 0, -0.10]);
        sleep 0.01;
    };

    _i = _i + 1;
};

// Para alvos do tipo swivel, adicione o seguinte trecho para garantir que eles se movam
if (typeOf _target == "Target_Swivel_01_base_F") then {
    while {true} do {
        // Exemplo de movimento horizontal simples
        _target setPos (getPos _target vectorAdd [5, 0, 0]);
        sleep 0.01; // Pequeno delay para suavizar o movimento
        _target setPos (getPos _target vectorAdd [-5, 0, 0]);
        sleep 0.01; // Pequeno delay para suavizar o movimento
    };
};

true
