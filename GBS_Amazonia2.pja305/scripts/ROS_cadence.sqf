/*
ROS_Cadence by Rickoshay

Description
===========
Creates the effect of a call-and-response work song sung by military personnel while running or marching.

How it works
============
Each AI runner unit is locked into a running animation with a forward veloctiy and direction.
In this state they will run in synch and alignment - and through objects in their path, in a straight line - forever.
It is therefore important to have them all pointed in exactly the same direction and be evenly spaced.
The leading unit will be the 3D sound source. There are two sound files - 58s and 1m56s in length. Based on the setting below you
can have them reverse their direction ie -180 degrees after they complete one 58 second run which is about 235m from
their start postion or allow them to continue running for an additional 235m ie. total outbound distance ~470m.
This would require a clear path i.e. no obstructions for ~500m.
(Tip: You can use the HIDE module in Eden to clear any unwanted terrain objects in their path)

See deletion options below.

Legal stuff
===========
Credit must be given in your mission and on the Steam Workshop if this script is oncluded in your work.

Setup and Sound
===============
Create 11 units (the runners) name them run1..run11 starting at the front to the back sequentially - see demo.
Unit run1 - is the leader in front of the group
Place them approximately 3m apart in two slightly staggered lines:
eg:	     3   5   7   8   11
	 1
	    2   4   6   8   10
Add the two march sound classes to your description.ext file in CFGsounds - see demo.

Starting the runners
====================
To call this script, place the following command line on a laptop or trigger or in the init.sqf file:
[] execvm "scripts\ROS_cadence.sqf";

How to delete the runners
=========================
Either adjust the Auto delete options below - or if you want them to stop running at a specific point - create a trigger with an area that covers
the end position with enough overlap to allow for slight variance in the distance and angle on the runners and put the following lines in the trigger:
Cond: run1 in thislist
OnAct field:
{deletevehicle _x} foreach [run1, run2,run3,run4,run5,run6,run7,run8,run9,run10,run11];

//////////////////////////////////////////////////////////////////////////////////////////////*/
// Make cadence runners turn around after the song ends and reverse direction in a continuous loop ie 235m -> then <- return 235m
_endless_loop = false;

// Auto delete the runners after either one or two outward bound songs ie at the 235m or ~470m mark
// Only one of the following can be true and the endless loop above must be false. NB
ROS_deleteRunnersAfter_1 = false;
// or:
ROS_deleteRunnersAfter_2 = true;

///////////////////////////////////////////////////////////////////////////////////////////////

if (!isServer) exitWith {};

scopeName "main";

// Time for units to end and reposition for loopback - sound file is 56 secs long - allowing for overhead
_looptime = 60;
if (ROS_deleteRunnersAfter_2) then {_looptime = 120};

_timer = 0;
_timer = time + _looptime;

// Array of runner
_runners = [run1,run2,run3,run4,run5,run6,run7,run8,run9,run10,run11];

// Leader of the pack
_lead = _runners select 0;

// Get pack offsets from leader
ROS_r1_offsets = [];
{ROS_r1_offsets pushback (_lead worldToModel (getPosASL _x))} foreach (_runners - [_lead]);

// Save _lead dir
_lead setvariable ["orig_dir", getdir _lead];

// Prevent anim switch and damage
{_x disableAI "anim"; _x allowDamage false} foreach _runners;

// Start them running and play cadence sound on first unit
{
	[_timer, _x] spawn {
		params ["_timer", "_x"];
		while {time < _timer} do {
			_x playmove "AmovPercMrunSnonWnonDf";
			sleep 1;
		};
	};
} foreach _runners;

// Play sound on leader _lead
if (ROS_deleteRunnersAfter_2) then {
	[_lead, ["TFM",500]] remoteExec ["say3D",0];
} else {
	[_lead, ["TFM",500]] remoteExec ["say3D",0];
};

// Allow last runner timer to run out
waitUntil {time > _timer};

// Kill sound if run time < looptime
deleteVehicle (allMissionObjects "#soundonvehicle" select 0);

// Delete the runners
if !(_endless_loop) then {
	{deleteVehicle _x} foreach _runners;
	breakTo "Main";
};

sleep 1;

// Restart?
if (_endless_loop) then {

	// Reset, reorientate and reposition runners for return loop
	{_x switchmove "";} foreach _runners;

	// Reorientate _lead
	_dir = (_lead getVariable "orig_dir")-180;
	_lead setdir _dir;
	{
		_pos = ASLToAGL (_lead modelToWorld (ROS_r1_offsets select _foreachindex));
		_x setPosASL _pos;
		_x setdir _dir;
	} foreach (_runners - [_lead]);
	sleep 1;
	if (speed _lead <1) exitWith {[] execvm "scripts\ROS_cadence.sqf";};
};

