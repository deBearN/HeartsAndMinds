enableSaving [false, false];

[] call compileScript ["core\def\mission.sqf"];
[] call compileScript ["define_mod.sqf"];

if (isServer) then {
    [] call compileScript ["core\init_server.sqf"];
    {
    _x enableSimulation true;
    // _bbp = ((boundingBoxReal [_x, "ViewGeometry"])select 1);
    // _vehiclepos = getPosASL _x;
    // _ShootVehicleEntity = "CBA_B_InvisibleTargetVehicle" createVehicle [0,0,0];
    // _ShootVehicleEntity setMass 0.1;

    // west createVehicleCrew _ShootVehicleEntity;
    
    
    
    // _ShootVehicleEntity setPosASL (_vehiclepos);
    // _ShootVehicleEntity attachTo [_x];

    
} forEach (getMissionLayerEntities "btc_vehicles" select 0);
};

[] call compileScript ["core\init_common.sqf"];

if (!isDedicated && hasInterface) then {
    [] call compileScript ["core\init_player.sqf"];
};

if (!isDedicated && !hasInterface) then {
    [] call compileScript ["core\init_headless.sqf"];
};

{
    _x enableSimulation true;
    // _bbp = ((boundingBoxReal [_x, "ViewGeometry"])select 1);
    // _vehiclepos = getPosASL _x;
    // _ShootVehicleEntity = "CBA_B_InvisibleTargetVehicle" createVehicle [0,0,0];
    // _ShootVehicleEntity setMass 0.1;

    // west createVehicleCrew _ShootVehicleEntity;
    
    
    
    // _ShootVehicleEntity setPosASL (_vehiclepos);
    // _ShootVehicleEntity attachTo [_x];

    
} forEach (getMissionLayerEntities "btc_vehicles" select 0);
