// Group of npc's do some exercise at a base - by RickOShay
// Npcs are called kar,kar_1,kar_2,...kar_n
// nul = [] execVM "scripts\exercise.sqf";
// "karate","pushups"
_exercise = ["karate","pushups","karate","pushups","karate","pushups"] call BIS_fnc_selectRandom;

//hint format ["Exercise %1",_exercise];

switch _exercise do {

		case "karate":
		{
			// 33.333
			{_x playMove "AmovPercMstpSnonWnonDnon_exerciseKata"} foreach
			[kar_0,kar_1,kar_2,kar_3,kar_4,kar_5,kar_6,kar_7,kar_8];

			sleep 0.2;

			{_x playMove "AmovPercMstpSnonWnonDnon_exerciseKata"} foreach
			[kar_9,kar_10,kar_11,kar_12,kar_13,kar_14,kar_15,kar_16,kar_17,kar_18];

			[kar_9, "karate"] remoteExec ["say3D"];
		};

		case "pushups":
		{
			// 15.733s
			for "_i" from 1 to 3 do {
				{_x playMove "AmovPercMstpSnonWnonDnon_exercisePushup"} foreach
				[kar_0,kar_1,kar_2,kar_3,kar_4,kar_5,kar_6,kar_7,kar_8];

				sleep 0.1;

				{_x playMove "AmovPercMstpSnonWnonDnon_exercisePushup"} foreach
				[kar_9,kar_10,kar_11,kar_12,kar_13,kar_14,kar_15,kar_16,kar_17,kar_18];
				[kar_9, "pushups"] remoteExec ["say3D"];
				sleep 5.5;
			};
		};
};

