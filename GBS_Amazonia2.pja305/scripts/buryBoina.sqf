//if (!isServer) exitwith {};
	private ["_cova","_surfaceUnderBury","_grassCutter","_vectorDirBury","_surfaceNormalBury","_cruz","_cruzHeight"];
	_cova = _this select 0;
	_surfaceUnderBury = surfaceType position _cova;
	if (
		(_surfaceUnderBury == "#GdtConcrete") or
		(_surfaceUnderBury == "#GdtStratisConcrete") or
		(_surfaceUnderBury == "#GdtStratisRocky") or
		(_surfaceUnderBury == "#GdtStony")
		) then

	{hint "Essa superfície é muito difícil de cavar."}

		else

	{
		//Verifica se já foi cavado
		if (isNil{_cova getVariable "buryOn"}) then
		{
			// START TO BURY THE COVA
			// ASSIGN BURIED VARIABLE
			_cova setVariable ["buryOn",1,true];

			// CREATE GRASS CUTTER MEDIUM AND MOVE TO COVA
			_grassCutter = createVehicle ["Land_ClutterCutter_small_F",position _cova,[],0,"NONE"];
			_cova setVariable ["nameOfGrassCutter",_grassCutter,true];
			_grassCutter setPos getPos _cova;

			// ALLOW DAMAGE FALSE TO COVA
			_cova allowDamage false;
			_vectorDirBury = vectorDir _cova;
			_surfaceNormalBury = surfaceNormal position _cova;

			// CREATE CROSS AND GROW UP FROM THE GROUND
			_cruz = createVehicle ["GraveCross1",position _cova,[],0,"NONE"];
			_cova setVariable ["nameOfDirtMound",_cruz,true];
			_cruz setPosATL [getPosATLVisual _cova select 0, getPosATLVisual _cova select 1, -1.0]; // -2.1
			_cruz setDir (getDir _cova) + 180;
			_cruzHeight = -0.35;
			_cova say3D "sandDigging";

			// ATTACH CROSS TO GRASS CUTTER
			{
				_cova attachTo [_grassCutter,[0,0,_x]];
				_cova setVectorDirAndUp [_vectorDirBury,_surfaceNormalBury];
				_cruzHeight = _cruzHeight + 0.025;
				_cruz setPosATL [getPosATLVisual _cova select 0, getPosATLVisual _cova select 1, _cruzHeight];
				sleep 0.5;
			} forEach [0.40,0.35,0.30,0.25,0.20,0.15,0.10,0.05,0,-0.05,-0.10,-0.15,-0.20,-0.25,-0.30,-0.35,-0.40];

			_cova lock 2; // locked for all

			sleep 1;

			_cova lock 1; // lock state returned to "default"

			player playMoveNow "AmovPercMstpSlowWrflDnon_Salute";

			deleteVehicle _cova;
		};
	};