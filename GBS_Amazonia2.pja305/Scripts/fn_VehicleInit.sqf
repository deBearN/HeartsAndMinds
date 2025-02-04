// Wait for 10 seconds before enabling simulation
waitUntil {time > 10};

// Get all objects in the mission layer "btc_vehicles" and enable simulation
{
    _x enableSimulation true;
} forEach (getMissionLayerEntities "btc_vehicles" select 0);