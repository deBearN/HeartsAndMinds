// Array de sons possíveis
private _sounds = ["PAArly", "PADiogenes", "PASegadas","PASimas","PASiqueira"];

// Seleciona um som aleatório
private _randomSound = selectRandom _sounds;

// Toca o som aleatório no alto-falante do jogador
player say3D _randomSound;