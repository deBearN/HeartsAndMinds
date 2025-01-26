
[compileScript ["core\init.sqf"]] call CBA_fnc_directCall;
showGps false;
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