// Random starting location selector script
// Usage: _nil = [this] execVM "scripts\randomStartPos.sqf";

// Remove AllWeapons and Items
player removeWeapon "itemRadio";
player removeWeapon "itemGPS";
removeAllHandgunItems player;
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeBackpackGlobal player;
player addItem "itemCompass";
player assignItem "itemCompass";
player addItem "itemWatch";
player assignItem "itemWatch";
player addItem "itemMap";
player assignItem "itemMap";

// Array de posições de teleporte
private _teleportPositions = ["spawn_1", "spawn_2", "spawn_3", "spawn_4", "spawn_5", "spawn_6", "spawn_7", "spawn_8", "spawn_9", "spawn_10", "spawn_11", "spawn_12", "spawn_13", "spawn_14", "spawn_15"];

// Função de teleporte
private _teleportPlayer = {
    params ["_player"];
    private _startPos = _teleportPositions call BIS_fnc_selectRandom;
    _player setPos (getMarkerPos _startPos); // Teleportar jogador
    _player setDir (markerDir _startPos); // Set the direction of the unit or object to be the same as the marker
    
    // Iniciar cronômetro
    private _startTime = time;
    _player setVariable ["startTime", _startTime];
    _player setVariable ["_teleported", true];
    //systemChat format ["Início do cronômetro: %1", _startTime];
};
//Efeito de tela
["Resolution", 1, [400]] spawn
{
	params ["_name", "_priority", "_effect", "_handle"];
	while {
		_handle = ppEffectCreate [_name, _priority];
		_handle < 0;
	} do {
		_priority = _priority + 1;
	};
	_handle ppEffectEnable true;
	_handle ppEffectAdjust _effect;
	_handle ppEffectCommit 3;
	waitUntil { ppEffectCommitted _handle };
	_handle ppEffectEnable false;
	ppEffectDestroy _handle;
};

// Teleporta o jogador
private _player = player; // O jogador que está sendo teleportado
[_player] call _teleportPlayer;

// Definir as coordenadas do ponto marcado
private _markedPoint = markerPos "Loc_Final"; // Obter a posição do marcador
private _margin = 5; // Margem de erro em metros

// Função para converter tempo em HH:MM:SS
private _timeToString = {
    params ["_time"];
    private _hours = floor (_time / 3600);
    private _minutes = floor ((_time % 3600) / 60);
    private _seconds = _time % 60;

    private _formattedHours = if (_hours < 10) then {"0" + str _hours} else {str _hours};
    private _formattedMinutes = if (_minutes < 10) then {"0" + str _minutes} else {str _minutes};
    private _formattedSeconds = if (_seconds < 10) then {"0" + str _seconds} else {str _seconds};

    format ["%1:%2:%3", _formattedHours, _formattedMinutes, _formattedSeconds]
};

// Função para registrar o tempo no arquivo de log
private _logTime = {
    params ["_player", "_formattedTime"];
    private _playerName = name _player;
    private _logEntry = format [
        "== Nome do player: %1 - Tempo levado: %2 ==",
        _playerName, _formattedTime
    ];

    diag_log str _logEntry; // Registrar no RPT file
};

// Função para verificar a chegada ao ponto marcado
private _checkArrival = {
    params ["_player", "_markedPoint", "_margin", "_timeToString", "_logTime"];
    private _isArrived = false;
    while {!_isArrived} do {
        private _playerPos = getPos _player;
        private _distance = _playerPos distance _markedPoint;
        if (_distance <= _margin) then {
            private _endTime = time;
            private _startTime = _player getVariable ["startTime", 0];
            private _timeTaken = _endTime - _startTime;
            private _formattedTime = _timeTaken call _timeToString;
            //systemChat format ["Tempo decorrido: %1", _formattedTime];
            
            // Verificar e exibir notificação
            //private _notificationMessage = format ["Você chegou ao ponto marcado! Tempo levado: %1", _formattedTime];
            //systemChat format ["Notificação: %1", _notificationMessage];
            ["PontoFinal",["",""]] call BIS_fnc_showNotification;
            
            // Registrar o tempo no log
            [_player, _formattedTime] call _logTime;
            
            _isArrived = true;
        };
        sleep 0.1; // Verificar a cada 100ms para não sobrecarregar o sistema
    };
};

// Iniciar a verificação de chegada em uma thread separada
[_player, _markedPoint, _margin, _timeToString, _logTime] spawn _checkArrival;
