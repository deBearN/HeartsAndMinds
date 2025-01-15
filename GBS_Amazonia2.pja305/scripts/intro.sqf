// Spawn text effects
_this spawn {

	params[
		["_missionName", "CENTRO DE INSTRUÇÃO DE GUERRA NA SELVA"],
		["_missionAuthor", "CENTRO CORONEL JORGE TEIXEIRA"],
		["_missionVersion", "AMAZONIA"],
		["_quote", ""],
		["_duration", 7]
	];

	sleep 10;

	// New "sitrep style" text in bottom right corner, typed out over time.
	[
		[_missionName,"font = 'PuristaSemiBold'"],
		["","<br/>"],
		[_missionAuthor,"font = 'PuristaMedium'"],
		["","<br/>"],
		[_missionVersion,"font = 'PuristaLight'"]
	]  execVM "\a3\missions_f_bootcamp\Campaign\Functions\GUI\fn_SITREP.sqf";

};