
btc_version = [
    1,
    24,
<<<<<<< HEAD:GBS_Amazonia2.pja305/core/def/mission.sqf
    2
=======
    4
>>>>>>> main:=BTC=co@30_Hearts_and_Minds.Altis/core/def/mission.sqf
];
diag_log format (["=BTC= HEARTS AND MINDS VERSION %1.%2.%3"] + btc_version);

//Param
//<< Time options >>
btc_p_time = "btc_p_time" call BIS_fnc_getParamValue;
btc_p_acctime = "btc_p_acctime" call BIS_fnc_getParamValue;
btc_db_load = ("btc_p_load" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_auto_db = "btc_p_auto_db" call BIS_fnc_getParamValue isEqualTo 1;
btc_p_db_autoRestartTime = "btc_p_db_autoRestartTime" call BIS_fnc_getParamValue;
btc_p_db_autoRestartHour = [
    "btc_p_db_autoRestartHour1" call BIS_fnc_getParamValue,
    "btc_p_db_autoRestartHour2" call BIS_fnc_getParamValue
];
btc_p_db_autoRestartType = "btc_p_db_autoRestartType" call BIS_fnc_getParamValue;
btc_p_slot_isShare = "btc_p_slot_isShare" call BIS_fnc_getParamValue isEqualTo 1;
btc_p_change_time = ("btc_p_change_time" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_change_weather = ("btc_p_change_weather" call BIS_fnc_getParamValue) isEqualTo 1;

//<< Respawn options >>
btc_p_respawn_location = "btc_p_respawn_location" call BIS_fnc_getParamValue;
btc_p_respawn_fromFOBToBase = ("btc_p_respawn_fromFOBToBase" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_rallypointTimer = "btc_p_rallypointTimer" call BIS_fnc_getParamValue;
btc_p_respawn_arsenal = ("btc_p_respawn_arsenal" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_respawn_ticketsAtStart = "btc_p_respawn_ticketsAtStart" call BIS_fnc_getParamValue;
btc_p_respawn_ticketsLost = 1 - ("btc_p_respawn_ticketsLost" call BIS_fnc_getParamValue);
btc_p_respawn_ticketsShare = ("btc_p_respawn_ticketsShare" call BIS_fnc_getParamValue) isEqualTo 0;
btc_p_respawn_ticketsFromPrisoners = "btc_p_respawn_ticketsFromPrisoners" call BIS_fnc_getParamValue;
btc_p_body_timeBeforeShowMarker = ("btc_p_body_timeBeforeShowMarker" call BIS_fnc_getParamValue) * 60;

//<< Faction options >>
private _p_en = "btc_p_en" call BIS_fnc_getParamValue;
private _p_en_AA = ("btc_p_AA" call BIS_fnc_getParamValue) isEqualTo 1;
private _p_en_tank = ("btc_p_tank" call BIS_fnc_getParamValue) isEqualTo 1;
private _p_civ = "btc_p_civ" call BIS_fnc_getParamValue;
private _p_civ_veh = "btc_p_civ_veh" call BIS_fnc_getParamValue;

//<< IED options >>
btc_p_ied = ("btc_p_ied" call BIS_fnc_getParamValue)/2;
private _p_ied_spot = "btc_p_ied_spot" call BIS_fnc_getParamValue;
btc_p_ied_placement = "btc_p_ied_placement" call BIS_fnc_getParamValue;
btc_p_ied_drone = ("btc_p_ied_drone" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_ied_power = "btc_p_ied_power" call BIS_fnc_getParamValue;

//<< Hideout/Cache options >>
btc_hideout_n = "btc_p_hideout_n" call BIS_fnc_getParamValue;
btc_info_cache_def = "btc_p_cache_info_def" call BIS_fnc_getParamValue;
btc_info_cache_ratio = "btc_p_cache_info_ratio" call BIS_fnc_getParamValue;
btc_info_intel_chance = "btc_p_info_chance" call BIS_fnc_getParamValue;
btc_p_info_houseDensity = "btc_p_info_houseDensity" call BIS_fnc_getParamValue;

//<< Skill options >>
btc_p_set_skill  = ("btc_p_set_skill" call BIS_fnc_getParamValue) isEqualTo 1;
btc_AI_skill = [
    ("btc_p_set_skill_general" call BIS_fnc_getParamValue)/10,//general
    ("btc_p_set_skill_aimingAccuracy" call BIS_fnc_getParamValue)/10,//aimingAccuracy
    ("btc_p_set_skill_aimingShake" call BIS_fnc_getParamValue)/10,//aimingShake
    ("btc_p_set_skill_aimingSpeed" call BIS_fnc_getParamValue)/10,//aimingSpeed
    ("btc_p_set_skill_endurance" call BIS_fnc_getParamValue)/10,//endurance
    ("btc_p_set_skill_spotDistance" call BIS_fnc_getParamValue)/10,//spotDistance
    ("btc_p_set_skill_spotTime" call BIS_fnc_getParamValue)/10,//spotTime
    ("btc_p_set_skill_courage" call BIS_fnc_getParamValue)/10,//courage
    ("btc_p_set_skill_reloadSpeed" call BIS_fnc_getParamValue)/10,//reloadSpeed
    ("btc_p_set_skill_commanding" call BIS_fnc_getParamValue)/10//commanding
];

//<< Spawn options >>
btc_p_density_of_occupiedCity = ("btc_p_density_of_occupiedCity" call BIS_fnc_getParamValue)/100;
btc_p_mil_group_ratio = ("btc_p_mil_group_ratio" call BIS_fnc_getParamValue)/100;
btc_p_mil_wp_houseDensity = ("btc_p_wp_houseDensity" call BIS_fnc_getParamValue)/100;
btc_p_mil_static_group_ratio = ("btc_p_mil_static_group_ratio" call BIS_fnc_getParamValue)/100;
btc_p_civ_group_ratio = ("btc_p_civ_group_ratio" call BIS_fnc_getParamValue)/100;
btc_p_animals_group_ratio = ("btc_p_animals_group_ratio" call BIS_fnc_getParamValue)/100;
btc_p_veh_armed_ho = ("btc_p_veh_armed_ho" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_veh_armed_spawn_more = ("btc_p_veh_armed_spawn_more" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_patrol_max = "btc_p_patrol_max" call BIS_fnc_getParamValue;
btc_p_civ_max_veh = "btc_p_civ_max_veh" call BIS_fnc_getParamValue;

//<< Gameplay options >>
btc_p_sea = ("btc_p_sea" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_chem = ("btc_p_chem" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_spect = ("btc_p_spect" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_side_mission_cycle = "btc_p_side_mission_cycle" call BIS_fnc_getParamValue;

//<< Arsenal options >>
btc_p_arsenal_Type = "btc_p_arsenal_Type" call BIS_fnc_getParamValue;
btc_p_arsenal_Restrict = "btc_p_arsenal_Restrict" call BIS_fnc_getParamValue;
btc_p_garage = ("btc_p_garage" call BIS_fnc_getParamValue) isEqualTo 1;
btc_p_autoloadout = "btc_p_autoloadout" call BIS_fnc_getParamValue;

//<< Other options >>
btc_global_reputation = "btc_p_rep" call BIS_fnc_getParamValue;
btc_p_rep_notify = "btc_p_rep_notify" call BIS_fnc_getParamValue;
btc_city_radiusOffset = ("btc_p_city_radiusOffset" call BIS_fnc_getParamValue) * 100;
btc_p_trigger = if (("btc_p_trigger" call BIS_fnc_getParamValue) isEqualTo 1) then {
    "this && (false in (thisList apply {_x isKindOf 'Plane'})) && (false in (thisList apply {(_x isKindOf 'Helicopter') && (speed _x > 190)}))"
} else {
    "this"
};
private _p_city_free_trigger = "btc_p_city_free_trigger" call BIS_fnc_getParamValue;
btc_p_flag = "btc_p_flag" call BIS_fnc_getParamValue;
btc_p_debug = "btc_p_debug" call BIS_fnc_getParamValue;

switch (btc_p_debug) do {
    case 0 : {
        btc_debug_log = true;
        btc_debug = false;
    };
    case 1 : {
        btc_debug_log = true;
        btc_debug = true;
        btc_debug_graph = false;
        btc_debug_frames = 0;
    };
    case 2 : {
        btc_debug_log = true;
        btc_debug = false;
    };
};

if (!isMultiplayer) then {
    btc_debug_log = true;
    btc_debug = true;
    btc_debug_graph = false;
    btc_debug_frames = 0;
};

private _cfgVehicles = configFile >> "CfgVehicles";
private _allClassVehicles = ("true" configClasses _cfgVehicles) apply {configName _x};
private _allClassSorted = _allClassVehicles select {getNumber (_cfgVehicles >> _x >> "scope") isEqualTo 2};

if (isServer) then {
    btc_final_phase = false;
    btc_delay_time = 0;

    //City
    btc_city_blacklist = [];//NAME FROM CFG
    btc_p_city_free_trigger_condition = if (_p_city_free_trigger isEqualTo 0) then {
        "thisList isEqualTo []"
    } else {
        format ["[thisList, %1] call btc_city_fnc_trigger_free_condition", _p_city_free_trigger]
    };

    //Civ
    btc_civ_veh_active = [];

    //Database
    btc_db_serverCommandPassword = "btc_password"; //Define the same password in server.cfg like this: serverCommandPassword = "btc_password";
    btc_db_warningTimeAutoRestart = 5;

    //Hideout
    btc_hideout_cityID = []; // List of city ID visible in debug mode for custom hideout location
    btc_hideouts = []; publicVariable "btc_hideouts";
    btc_hideouts_radius = 1000;
    if (btc_hideout_n isEqualTo 99) then {
        btc_hideout_n = round random 10;
    };
    btc_hideout_safezone = 4000;
    btc_hideout_range = 3500;
    btc_hideout_cap_time = 1800;
    btc_hideout_minRange = btc_hideout_range;

    //IED
    btc_ied_suic_time = 900;
    btc_ied_suic_spawned = - btc_ied_suic_time;
    btc_ied_offset = [0, -0.03, 0] select _p_ied_spot;
    btc_ied_list = [];
    btc_ied_range = 0;
    btc_ied_power = ["APERSBoundingMine_Range_Ammo", "APERSTripMine_Wire_Ammo"] select btc_p_ied_power;

    //FOB
    btc_fobs = [[], [], []];
    btc_fob_rallypointTimer = 60 * btc_p_rallypointTimer;
    btc_body_deadPlayers  = [];

    //Patrol
    btc_patrol_active = [];
    btc_patrol_area = 2500;

    //Rep
    btc_rep_militia_call_time = 600;
    btc_rep_militia_called = - btc_rep_militia_call_time;
    btc_rep_delayed = [0, []];

    //Chem
    btc_chem_decontaminate = [];
    btc_chem_contaminated = []; publicVariable "btc_chem_contaminated"; //Preserve reference

    //Spect
    btc_spect_emp = []; publicVariable "btc_spect_emp"; //Preserve reference

    //Cache
    btc_cache_type = [
        _allClassSorted select {
            _x isKindOf "ReammoBox_F" &&
            {getText(_cfgVehicles >> _x >> "model") isEqualTo "\A3\weapons_F\AmmoBoxes\AmmoBox_F"}
        },
        ["Land_PlasticCase_01_small_black_CBRN_F", "Land_PlasticCase_01_small_olive_CBRN_F", "Land_PlasticCase_01_small_CBRN_F"]
    ];
    private _weapons_usefull = "true" configClasses (configFile >> "CfgWeapons") select {
        getNumber (_x >> 'type') isEqualTo 1 &&
        {getArray (_x >> 'magazines') isNotEqualTo []} &&
        {getNumber (_x >> 'scope') isEqualTo 2}
    };
    btc_cache_weapons_type = _weapons_usefull apply {(toLower getText (_x >> "model")) select [1]};

    //Hideout classname
    btc_type_campfire = ["MetalBarrel_burning_F"] + (_allClassSorted select {_x isKindOf "Land_Campfire_F"});
    btc_type_Scrapyard = _allClassSorted select {
        _x isKindOf "Scrapyard_base_F" &&
        {!("scrap" in toLower _x)}
    };
    btc_type_bigbox = ["Box_FIA_Ammo_F", "Box_East_AmmoVeh_F", "CargoNet_01_box_F", "O_CargoNet_01_ammo_F"] + btc_type_Scrapyard;
    btc_type_seat = ["Land_WoodenLog_F", "Land_CampingChair_V2_F", "Land_CampingChair_V1_folded_F", "Land_CampingChair_V1_F"];
    btc_type_sleepingbag = _allClassSorted select {_x isKindOf "Land_Sleeping_bag_F"};
    btc_type_tent = ["Land_TentA_F", "Land_TentDome_F"] + (_allClassSorted select {
        _x isKindOf "Land_TentSolar_01_base_F" &&
        {!(_x isKindOf "Land_TentSolar_01_folded_base_F")}
    });
    btc_type_camonet = ["Land_IRMaskingCover_02_F"] + (_allClassSorted select {_x isKindOf "Shelter_base_F"});
    btc_type_satelliteAntenna = _allClassSorted select {_x isKindOf "Land_SatelliteAntenna_01_F"};

    //Side
    btc_side_ID = 0;
    btc_side_list = ["supply", "mines", "vehicle", "get_city", "tower", "civtreatment", "checkpoint", "convoy", "rescue", "capture_officer", "hostage", "hack", "kill", "EMP", "removeRubbish"]; // On ground (Side "convoy" and "capture_officer" are not design for map with different islands. Start and end city can be on different islands.)
    if (btc_p_sea) then {btc_side_list append ["civtreatment_boat", "underwater_generator"]}; // On sea
    if (btc_p_chem) then {btc_side_list append ["chemicalLeak", "pandemic"]};
    btc_side_list_use = [];
    btc_type_tower = ["Land_Communication_F", "Land_TTowerBig_1_F", "Land_TTowerBig_2_F"];
    btc_type_barrel = ["Land_GarbageBarrel_01_F", "Land_BarrelSand_grey_F", "MetalBarrel_burning_F", "Land_BarrelWater_F", "Land_MetalBarrel_F", "Land_MetalBarrel_empty_F"];
    btc_type_canister = ["Land_CanisterPlastic_F"];
    btc_type_pallet = ["Land_Pallets_stack_F", "Land_Pallets_F", "Land_Pallet_F"];
    btc_type_box = ["Box_East_Wps_F", "Box_East_WpsSpecial_F", "Box_East_Ammo_F"] + (btc_cache_type select 0);
    btc_type_generator = _allClassSorted select {_x isKindOf "Land_Device_assembled_F"};
    btc_type_storagebladder = _allClassSorted select {_x isKindOf "StorageBladder_base_F"};
    btc_type_mines = ["APERSMine", "APERSBoundingMine", "APERSTripMine"];
    btc_type_power = ["Land_PowerGenerator_F", "Land_PortableGenerator_01_F"] + (_allClassSorted select {_x isKindOf "Machine_base_F"});
    btc_type_cord = ["Land_ExtensionCord_F"];
    btc_type_cones = ["Land_RoadCone_01_F", "RoadCone_F", "RoadCone_L_F"];
    btc_type_fences = ["Land_PlasticNetFence_01_long_F", "Land_PlasticNetFence_01_long_d_F", "RoadBarrier_F", "TapeSign_F"];
    btc_type_barrier = ["Land_CncBarrier_stripes_F", "Land_CncBarrier_F"];
    btc_type_portable_light = _allClassSorted select {_x isKindOf "Land_PortableLight_single_F"};
    btc_type_portableLamp = _allClassSorted select {
        _x isKindOf "Land_PortableLight_02_base_F" ||
        {_x isKindOf "TentLamp_01_standing_base_F"}
    };
    btc_type_tentLamp = _allClassSorted select {_x isKindOf "TentLamp_01_base_F"};
    btc_type_first_aid_kits = ["Land_FirstAidKit_01_open_F", "Land_FirstAidKit_01_closed_F"];
    btc_type_body_bags = _allClassSorted select {
        _x isKindOf "Land_Bodybag_01_base_F" ||
        {_x isKindOf "Land_Bodybag_01_empty_base_F"} ||
        {_x isKindOf "Land_Bodybag_01_folded_base_F"}
    };
    btc_type_signs = _allClassSorted select {_x isKindOf "Land_Sign_Mines_F"};
    btc_type_bloods = _allClassSorted select {_x isKindOf "Blood_01_Base_F"};
    btc_type_medicals = _allClassSorted select {_x isKindOf "MedicalGarbage_01_Base_F"};
    btc_type_table = _allClassSorted select {_x isKindOf "Land_CampingTable_F"};
    btc_type_garbage = ["Land_Garbage_line_F","Land_Garbage_square3_F","Land_Garbage_square5_F"];
    btc_type_foodSack = _allClassSorted select {_x isKindOf "Land_FoodSack_01_empty_base_F"};
    btc_type_PaperBox = _allClassSorted select {
        _x isKindOf "Land_PaperBox_01_small_ransacked_base_F" ||
        {_x isKindOf "Land_PaperBox_01_small_open_base_F"} ||
        {_x isKindOf "Land_PaperBox_01_small_destroyed_base_F"}
    };
    btc_type_EmergencyBlanket = _allClassSorted select {_x isKindOf "Land_EmergencyBlanket_01_base_F"};
    btc_type_Sponsor = _allClassSorted select {
        _x isKindOf "SignAd_Sponsor_F" &&
        {"idap" in toLower _x}
    };
    btc_type_PlasticCase = _allClassSorted select {_x isKindOf "PlasticCase_01_base_F"};
    btc_type_MedicalTent = _allClassSorted select {_x isKindOf "Land_MedicalTent_01_base_F"};
    btc_type_cargo_ruins = _allClassSorted select {
        _x isKindOf "Ruins_F" &&
        {
            "cargo40" in toLower _x ||
            "cargo20" in toLower _x
        }
    };
    btc_type_spill = ["Oil_Spill_F", "Land_DirtPatch_01_6x8_F"] + (_allClassSorted select {
        _x isKindOf "Land_DirtPatch_02_base_F" ||
        {_x isKindOf "WaterSpill_01_Base_F"}
    });
    btc_type_tarp = _allClassSorted select {_x isKindOf "Tarp_01_base_F"};
    btc_type_SCBA = _allClassSorted select {_x isKindOf "SCBACylinder_01_base_F"};
    btc_type_brush = _allClassSorted select {_x isKindOf "Brush_01_base_F"};
    btc_type_broom = _allClassSorted select {_x isKindOf "Broom_01_base_F"};
    btc_type_sponge = _allClassSorted select {_x isKindOf "Sponge_01_base_F"};
    btc_type_connectorTentClosed = _allClassSorted select {_x isKindOf "Land_ConnectorTent_01_closed_base_F"};
    btc_type_crossTent = _allClassSorted select {_x isKindOf "Land_ConnectorTent_01_cross_base_F"};
    btc_type_connectorTent = (_allClassSorted select {_x isKindOf "Land_ConnectorTent_01_base_F"}) - btc_type_connectorTentClosed - btc_type_crossTent;
    btc_type_cargoEMP = _allClassSorted select {_x isKindOf "Cargo_EMP_base_F"};
    btc_type_antenna = _allClassSorted select {_x isKindOf "OmniDirectionalAntenna_01_base_F"};
    btc_type_solarPanel = _allClassSorted select {_x isKindOf "Land_SolarPanel_04_base_F"};

    // The two arrays below are prefixes of buildings and their multiplier.
    // They will multiply the values of btc_rep_malus_building_destroyed and btc_rep_malus_building_damaged,
    // if a building is not present here it will be multiplied by 1.0.
    // Use 0.0 to disable reputation hit on a specific's building destruction.
    // You can modify this for any other terrain, clearing the table will also make all buildings just have a 1.0 multiplier.
    // If there's a hit in btc_buildings_multiplier, btc_buildings_categories_multipliers will NOT be run
    btc_buildings_multipliers = [
        // Specific buildings that need to have a custom modifier.
        ["Land_BellTower", 0.2 ], ["Land_WIP", 1.5], ["Land_u_Addon_01", 0.2],
        ["Land_Airport_Tower", 10.0], ["Land_Mil_ControlTower", 10.0],
        ["Land_TentHangar", 7.0], ["Land_i_Shed_Ind", 1.5], ["Land_u_Shed_Ind", 1.5],
        ["Land_TTowerBig", 6.0], ["Land_TTowerSmall", 4.5], ["Land_cmp_Tower", 4.0]
    ];

    // The multipliers are applied on top of each other, so "Chapel" and "Small" will both multiply the malus value
    btc_buildings_categories_multipliers = [
        ["Shed", 0.75], ["Slum", 0.8], ["Small", 0.8], ["Big", 1.5], ["Villa", 2.0], ["Main", 3.0], ["Tower", 2.0],
        ["HouseBlock", 2.0], ["Panelak", 2.0], ["Tenement", 7.0],
        ["Barn", 1.5], ["School", 3.0], ["Office", 2.0], ["Shop", 1.5], ["Store", 1.5], ["Hospital", 12.0],
        ["Castle", 2.5], ["Chapel", 3.0], ["Minaret", 3.0], ["Mosque", 4.0], ["Church", 4.0], ["Kostel", 4.0],
        ["Lighthouse", 4.0],
        ["Airport", 4.0], ["Hangar", 1.75], ["ControlTower", 2.25], ["Terminal", 3.0],
        ["Hopper", 2.0], ["Tank", 4.0], ["Factory", 2.0], ["Transformer", 1.1],
        ["FuelStation", 5.0],
        ["Barracks", 1.75],
        ["spp", 3.0], ["Powerstation", 3.0],
        ["Pump", 2.5]
    ];
    btc_buildings_changed = [];

    //TAGS
    btc_type_tags = ["Land_Graffiti_01_F", "Land_Graffiti_02_F", "Land_Graffiti_03_F", "Land_Graffiti_04_F", "Land_Graffiti_05_F"];
    btc_type_tags_sentences = [
        "STR_BTC_HAM_TAG_GO",
        "STR_BTC_HAM_TAG_LN",
        "STR_BTC_HAM_TAG_WWKY",
        "STR_BTC_HAM_TAG_BA",
        "STR_BTC_HAM_TAG_GH",
        "STR_BTC_HAM_TAG_IE",
        "STR_BTC_HAM_TAG_DWY",
        "STR_BTC_HAM_TAG_WHY",
        "STR_BTC_HAM_TAG_YGD"
    ];
    btc_tags_player = [];
    btc_tags_server = [];

    //Flowers
    btc_type_flowers = _allClassSorted select {_x isKindOf "FlowerBouquet_base_F"};

    //IED
    private _ieds = 
        [   "c_rock_stones",
            "Land_Bare_boulder_02_F", 
            "Land_RM_boulder2", 
            "Land_RM_boulder1", 
            "Land_Cliff_stoneCluster_F", 
            "Land_SharpStones_erosion", 
            "Land_dirt_road_rocks_01_F", 
            "c_red_dirt_small_stones", 
            "c_red_dirt_large_stones", 
            "c_red_dirt_small_stones1", 
            "c_red_dirt_small_stones2", 
            "c_volcano_stones", 
            "CUP_Stone3_clutter",
            "CUP_vetev_1_buk", 
            "CUP_p_Helianthus_summer", 
            "c_plant_greenbunch", 
            "c_flower_brushmedium_white", 
            "t_PopulusN3s_leaf", 
            "b_NeriumO2s_leaf", 
            "c_branches_deciduous", 
            "c_branches_picea", 
            "c_branchesBig_picea", 
            "c_forest_violet_leaves", 
            "c_forest_violet_single", 
            "c_Grass_short_nettle", 
            "d_FallenTrunk_roots"
        ];
    /* ORIGINAL
    ["Land_GarbageContainer_closed_F", "Land_GarbageContainer_open_F", "Land_Portable_generator_F", "Land_WoodenBox_F", "Land_BarrelTrash_grey_F", "Land_Sacks_heap_F", "Land_Wreck_Skodovka_F", "Land_WheelieBin_01_F", "Land_GarbageBin_03_F"] + btc_type_pallet + btc_type_barrel + (_allClassSorted select {
        _x isKindOf "GasTank_base_F" ||
        {_x isKindOf "Garbage_base_F"} ||
        {_x isKindOf "Stall_base_F"} ||
        {_x isKindOf "Market_base_F"} ||
        (_x isKindOf "Constructions_base_F" &&
        {
            "bricks" in toLower _x
        }) ||
        (_x isKindOf "Wreck_base_F" &&
        {
            "car" in toLower _x ||
            "offroad" in toLower _x
        })
    });*/
    btc_type_ieds = _ieds - ["Land_Garbage_line_F","Land_Garbage_square3_F","Land_Garbage_square5_F", "Land_MarketShelter_F", "Land_ClothShelter_01_F", "Land_ClothShelter_02_F"];
    btc_model_ieds = btc_type_ieds apply {(toLower getText(_cfgVehicles >> _x >> "model")) select [1]};
    btc_type_blacklist = btc_type_tags + btc_type_flowers + ["UserTexture1m_F"]; publicVariable "btc_type_blacklist";

    btc_groundWeaponHolder = [];

    //Respawn
    btc_respawn_tickets = createHashMap;

    btc_slots_serialized = createHashMap;

    //Delay
    btc_delay_agent = 0.1;
    btc_delay_unit = 0.2;
    btc_delay_vehicle = 0.3;
    btc_delay_exec = 0.1;

    //Explosives
    btc_explosives = [];
    btc_explosives_objectSide = createVehicle ["CBA_NamespaceDummy", [-1000, -1000, 0], [], 0, "NONE"];
};

//Civ
// Get all faction from mod there are currently running
//copyToClipboard str (["CIV"] call btc_fnc_get_class);
private _allfaction = ["CIV_F","DEFAULT","CFP_C_AFG","CFP_C_AFRCHRISTIAN","CFP_C_AFRISLAMIC","CFP_C_ASIA","CFP_C_CHERNO_WIN","CFP_C_MALDEN","CFP_C_ME","CSLA_CIV","CUP_C_CHERNARUS","CUP_C_SAHRANI","CUP_C_TK","CUP_C_RU","CWR3_FACTION_CIV","GM_FC_GC_CIV","GM_FC_GE_CIV","LIB_CIV","OPTRE_UEG_CIV","CIV_IDAP_F","RDS_POL_CIV","RDS_RUS_CIV","SPE_CIV","UK3CB_ADC_C","UK3CB_CHC_C","UK3CB_MEC_C","UK3CB_TKC_C","UNSUNG_C","C_VIET"]; //All factions
_p_civ = _allfaction select _p_civ; //Select faction selected from mission parameter
_p_civ_veh = _allfaction select _p_civ_veh; //Select faction selected from mission parameter
private _allclasse = [[_p_civ]] call btc_civ_fnc_class; //Create classes from factions, you can combine factions from the SAME side : [[_p_civ, "btc_ac","LOP_TAK_CIV"]] call btc_civ_fnc_class.

//Save class name to global variable
btc_civ_type_units = _allclasse select 0;
_allclasse = [[_p_civ_veh]] call btc_civ_fnc_class;
btc_civ_type_veh = _allclasse select 2;
btc_civ_type_boats = _allclasse select 1;

btc_w_civs = [
    ["srifle_DMR_06_hunter_F", "sgun_HunterShotgun_01_F", "srifle_DMR_06_hunter_khs_F", "sgun_HunterShotgun_01_Sawedoff_F", "Hgun_PDW2000_F", "arifle_AKM_F", "arifle_AKS_F"],
    ["hgun_Pistol_heavy_02_F", "hgun_Rook40_F", "hgun_Pistol_01_F"]
];
btc_g_civs = ["HandGrenade", "MiniGrenade", "ACE_M84", "ACE_M84"];

// ANIMALS
btc_animals_type = ["Hen_random_F", "Cock_random_F", "Fin_random_F", "Alsatian_Random_F", "Goat_random_F", "Sheep_random_F"];

//FOB
btc_fob_mat = "Misc_Cargo1B_military";
btc_fob_structure = "Land_Cargo_HQ_V1_F";
btc_fob_flag = "Brazil_Flag";
btc_fob_id = 0;
btc_fob_minDistance = 1500;

//IED
btc_type_ieds_ace = ["APERSTripMine"];
btc_ied_deleteOn = -1;

//Int
btc_int_ordersRadius = 25;
btc_int_search_intel_time = 4;
btc_int_sirenRadius = 35;
btc_int_beaconRadius = 15;
btc_int_hornRadius = 20;
btc_int_hornDelay = time;

//Info
btc_info_intel_type = [80, 95];//cache - hd - both
btc_info_hideout_radius = 4000;
btc_info_intels = ["Land_Camera_01_F", "Land_HandyCam_F", "Land_File1_F", "Land_FilePhotos_F", "Land_File2_F", "Land_File_research_F", "Land_MobilePhone_old_F", "Land_PortableLongRangeRadio_F", "Land_Laptop_02_unfolded_F"];
private _mapsIntel = switch (worldName) do {
    case "Altis": {["Land_Map_altis_F", "Land_Map_unfolded_Altis_F"]};
    case "Stratis": {["Land_Map_stratis_F", "Land_Map_unfolded_F"]};
    case "Tanoa": {["Land_Map_Tanoa_F", "Land_Map_unfolded_Tanoa_F"]};
    case "Malden": {["Land_Map_Malden_F", "Land_Map_unfolded_Malden_F"]};
    case "Enoch": {["Land_Map_Enoch_F", "Land_Map_unfolded_Enoch_F"]};
    default {["Land_Map_blank_F"]};
};
btc_info_intels append _mapsIntel;

//Supplies
btc_supplies_cargo = "Land_PaperBox_01_small_stacked_F";
btc_supplies_mat = [
    _allClassSorted select {_x isKindOf "Land_FoodSack_01_cargo_base_F"},
    _allClassSorted select {_x isKindOf "Land_WaterBottle_01_stack_F"}
];

//Hazmat
btc_type_hazmat = ["HazmatBag_01_F", "Land_MetalBarrel_F"] + (_allClassSorted select {
    _x isKindOf "Land_GarbageBarrel_02_base_F" ||
    {_x isKindOf "Land_FoodContainer_01_F"} ||
    {_x isKindOf "Land_CanisterFuel_F"} ||
    {_x isKindOf "CBRNContainer_01_base_F"} ||
    {_x isKindOf "PlasticCase_01_base_F"}
});

//Containers
btc_containers_mat = ["Land_Cargo20_military_green_F", "Land_Cargo40_military_green_F"];

//Player
btc_player_side = west;
btc_respawn_marker = "respawn_west";
btc_player_type = ["SoldierWB", "SoldierEB", "SoldierGB"] select ([west, east, independent] find btc_player_side);

//Log
btc_construction_array =
[
    [
        "Fortifications",
		"Fortifications [Boxloader]",
        "Static",
        "Ammobox",
        "Containers",
		"Containers [Boxloader]",
        "Supplies",
        "FOB",
        "Decontamination",
        "Vehicle Logistic"
    ],
    [
        [
            //"Fortifications"
            "Land_BagBunker_Small_F",
            "Land_BagFence_Corner_F",
            "Land_BagFence_End_F",
            "Land_BagFence_Long_F",
            "Land_BagFence_Round_F",
            "Land_BagFence_Short_F",
            "Land_HBarrier_1_F",
            "Land_HBarrier_3_F",
            "Land_HBarrier_5_F",
            "Land_HBarrierBig_F",
            "Land_Razorwire_F",
            "Land_CncBarrier_F",
            "Land_CncBarrierMedium_F",
            "Land_CncBarrierMedium4_F",
            "Land_CncWall1_F",
            "Land_CncWall4_F",
            "Land_Mil_ConcreteWall_F",
            "Land_Mil_WallBig_4m_F",
            "Land_Mil_WallBig_Corner_F",
            "Land_PortableLight_double_F",
            "Land_Pod_Heli_Transport_04_medevac_black_F"
        ],
		[
            //"Fortifications Boxloader"
            "Land_Boxloader_Hesco_BigFlat",
			"Land_Boxloader_Fort_Roof_Flat",
			"Land_Boxloader_Camonet_Green_Flat",
			"Land_Boxloader_Camonet_Tan_Flat",
			"Land_Boxloader_Fort_Wire_Flat",
			"Land_Boxloader_Fort_Helipad_Tarp_Flat",
			"Land_Boxloader_Hesco_Flat",
			"Land_Boxloader_LME_Flat_Green",
			"Land_Boxloader_LME_Flat_Tan",
			"Land_Boxloader_Hesco_SmallFlat",
			"Land_Boxloader_Fort_Plat_Flat",
			"Land_Boxloader_Fort_Wall_Flat",
			"land_boxloader_temper_window_flat_green",
			"land_boxloader_Temper_window_flat_tan",
			"Land_Boxloader_Temper_Vestibule_Flat_Green",
			"Land_Boxloader_Temper_Vestibule_Flat_Tan",
			"Land_Boxloader_Temper_Divider_Flat",
			"Land_Boxloader_Temper_Medsign_Flat",
			"Land_Boxloader_Temper_Lights_Flat",
			"Land_Boxloader_Temper_End_Flat_Green",
			"Land_Boxloader_Temper_End_Flat_Tan",
			"Land_Boxloader_Temper_Door_Flat_Green",
			"land_boxloader_Temper_door_flat_tan",
			"Land_Boxloader_Sandbag_Pile2",
			"Land_Boxloader_Sandbag_Pile2_tall",
			"Land_Boxloader_Fort_iso_Green",
			"Land_Boxloader_Fort_iso_Brown",
			"Land_Boxloader_Fort_iso_Aid"
        ],
        [
            //"Static"
        ] + (_allClassSorted select {(
            _x isKindOf "GMG_TriPod" ||
            {_x isKindOf "StaticMortar"} ||
            {_x isKindOf "HMG_01_base_F"} ||
            {_x isKindOf "AA_01_base_F"} ||
            {_x isKindOf "AT_01_base_F"}) && {
                getNumber (_cfgVehicles >> _x >> "side") isEqualTo ([east, west, independent, civilian] find btc_player_side)
            }
        }),
        [
            //"Ammobox"
            "Land_WoodenBox_F"

        ] + (_allClassSorted select {
            _x isKindOf "ReammoBox_F" &&
            {!(_x isKindOf "Slingload_01_Base_F")} &&
            {!(_x isKindOf "Pod_Heli_Transport_04_base_F")}
        }),
        [
            //"Containers"

        ] + btc_containers_mat,
		[
			//"Containers Boxloader"
			"Land_Boxloader_iso_20ft_green",
			"Land_Boxloader_iso_20ft_black",
			"Land_Boxloader_iso_20ft_sand",
			"Land_Boxloader_iso_20ft_aid",
			"Land_Boxloader_iso_tricon_black",
			"Land_Boxloader_iso_tricon_green",
			"Land_Boxloader_iso_tricon_aid",
			"Land_Boxloader_iso_tricon_sand"
		],
        [
            //"Supplies"
            btc_supplies_cargo
        ],
        [
            //"FOB"
            btc_fob_mat
        ],
        [
            //"Decontamination"
            "DeconShower_01_F"
        ],
        [
            //"Vehicle logistic"
            "ACE_Wheel",
            "ACE_Track",
            "B_Slingload_01_Ammo_F",
            "B_Slingload_01_Fuel_F"
        ] + (_allClassSorted select {_x isKindOf "FlexibleTank_base_F"})
    ]
];

(btc_construction_array select 1) params [
    "_cFortifications", "_cStatics", "_cAmmobox",
    "_cContainers", "_cSupplies", "_cFOB",
    "_cDecontamination", "_cVehicle_logistic"
];
btc_log_def_loadable = flatten (btc_construction_array select 1) + flatten btc_supplies_mat + btc_type_hazmat;
btc_log_def_can_load = _cContainers;
btc_log_def_placeable = (_cFortifications + _cContainers + _cSupplies + _cFOB + _cDecontamination + _cVehicle_logistic + flatten btc_supplies_mat + btc_type_hazmat) select {
    getNumber(_cfgVehicles >> _x >> "ace_dragging_canCarry") isEqualTo 0
};
btc_tow_vehicleTowing = objNull;
btc_log_placing_max_h = 12;
btc_log_placing = false;
btc_log_obj_created = [];

btc_log_fnc_get_nottowable = {
    params ["_tower"];

    switch (true) do {
        case (_tower isKindOf "Tank") : {
            ["Plane", "Helicopter"]; //The tower is a tank so it can't tow: plane and helicopter
        };
        case (_tower isKindOf "Truck_F") : {
            ["Plane", "Helicopter"];
        };
        case (_tower isKindOf "Truck") : {
            ["Plane", "Helicopter"];
        };
        case (_tower isKindOf "Ship") : {
            [];
        };
        case (_tower isKindOf "Car") : {
            ["Truck", "Truck_F", "Tank", "Plane", "Helicopter"]; //The tower is a car so it can't tow: truck, tank, plane and helicopter
        };
        default {
            ["Car", "Truck", "Truck_F", "Tank", "Plane", "Helicopter", "Ship"];
        };
    };
};

//Lift
btc_lift_fnc_getLiftable = {
    params ["_chopper"];

    private _array = [];
    switch (typeOf _chopper) do {
        case "B_SDV_01_F" : {
            _array = ["Motorcycle", "ReammoBox", "ReammoBox_F", "StaticWeapon", "Car", "Truck", "Wheeled_APC_F", "Tracked_APC", "APC_Tracked_01_base_F", "APC_Tracked_02_base_F", "Air", "Ship", "Tank"] + ((btc_construction_array select 1) select 3) + ((btc_construction_array select 1) select 4) + ((btc_construction_array select 1) select 5);
        };
        default {
            private _MaxCargoMass = getNumber (configOf _chopper >> "slingLoadMaxCargoMass");
            switch (true) do {
                case (_MaxCargoMass <= 510) : {
                    _array = ["Motorcycle", "ReammoBox", "ReammoBox_F", "Quadbike_01_base_F", "Strategic"];
                };
                case (_MaxCargoMass <= 2100) : {
                    _array = ["Motorcycle", "ReammoBox", "ReammoBox_F", "StaticWeapon", "Car"];
                };
                case (_MaxCargoMass <= 4100) : {
                    _array = ["Motorcycle", "ReammoBox", "ReammoBox_F", "StaticWeapon", "Car", "Truck_F", "Truck", "Wheeled_APC_F", "Air", "Ship"] + ((btc_construction_array select 1) select 3) + ((btc_construction_array select 1) select 4) + ((btc_construction_array select 1) select 5);
                };
                case (_MaxCargoMass <= 14000) : {
                    _array = ["Motorcycle", "ReammoBox", "ReammoBox_F", "StaticWeapon", "Car", "Truck_F", "Truck", "Wheeled_APC_F", "Tracked_APC", "APC_Tracked_01_base_F", "APC_Tracked_02_base_F", "Air", "Ship", "Tank"] + ((btc_construction_array select 1) select 3) + ((btc_construction_array select 1) select 4) + ((btc_construction_array select 1) select 5);
                };
                default {
                    _array = ["Motorcycle", "ReammoBox", "ReammoBox_F", "StaticWeapon", "Car", "Truck_F", "Truck", "Wheeled_APC_F", "Tracked_APC", "APC_Tracked_01_base_F", "APC_Tracked_02_base_F", "Air", "Ship", "Tank"] + ((btc_construction_array select 1) select 3) + ((btc_construction_array select 1) select 4) + ((btc_construction_array select 1) select 5);
                };
            };
        };
    };
    _array
};

btc_ropes_deployed = false;
btc_lift_min_h  = 7;
btc_lift_max_h  = 12;
btc_lift_radius = 3;
btc_lift_HUD_x  = 0.874;
btc_lift_HUD_y  = 0.848;

//Mil
btc_hq = objNull;
// Get all faction from mod there are currently running
//copyToClipboard str (["EN"] call btc_fnc_get_class);
private _allfaction = ["CFP_I_WESTULTRA"]; //All factions
_p_en = _allfaction select _p_en; //Select faction selected from mission parameter
_allclasse = [[_p_en], _p_en_AA, _p_en_tank] call btc_mil_fnc_class; //Create classes from factions, you can combine factions like that: [[_p_en , "IND_F"], _p_en_AA, _p_en_tank] call btc_mil_fnc_class;

//Save class name to global variable
btc_enemy_side = _allclasse select 0;
btc_type_units = _allclasse select 1;
btc_type_divers = _allclasse select 2;
btc_type_crewmen = _allclasse select 3;
btc_type_boats = _allclasse select 4;
btc_type_motorized = _allclasse select 5;
btc_type_motorized_armed = _allclasse select 6;
btc_type_mg = _allclasse select 7;
btc_type_gl = _allclasse select 8;

//Sometimes you need to remove units: - ["Blabla","moreBlabla"];
//Sometimes you need to add units: + ["Blabla","moreBlabla"];
switch (_p_en) do {
    /*case "Myfactionexemple" : {
        btc_type_units = btc_type_units - ["Blabla","moreBlabla"];
        btc_type_divers = btc_type_divers + ["Blabla","moreBlabla"];
        btc_type_crewmen = "Blabla";
        btc_type_boats = btc_type_boats;
        btc_type_motorized = btc_type_motorized;
        btc_type_mg = btc_type_mg;
        btc_type_gl = btc_type_gl;
    };*/
    case "CIV_F" : {
        btc_type_boats = btc_type_boats + 
        [
            "braf_voadeira_03", 
            "braf_voadeira_04", 
            "braf_voadeira_05", 
            "braf_voadeira_06"
        ];
    };
    case "CFP_I_WESTULTRA" : {
        btc_type_motorized = btc_type_motorized + 
                            [
							"CUP_I_Pickup_Unarmed_PMC", 
							"CUP_I_LSV_02_unarmed_ION", 
							"CUP_I_SUV_ION", 
							"CUP_B_M1151_NATO_T", 
							"CUP_B_nM1025_Unarmed_NATO_T", 
							"CUP_B_nM1038_NATO_T", 
							"CUP_B_nM1038_4s_NATO_T", 
							"CFP_B_USCIA_MB_4WD_01", 
							"CUP_C_Datsun_4seat", 
							"CUP_C_Golf4_black_Civ", 
							"CUP_C_Golf4_blue_Civ", 
							"CUP_C_Golf4_green_Civ", 
							"CUP_C_Golf4_camodark_Civ", 
							"CUP_C_Golf4_camodigital_Civ", 
							"CUP_C_Golf4_camo_Civ", 
							"CUP_C_Golf4_white_Civ", 
							"CUP_C_Golf4_yellow_Civ", 
							"C_Offroad_02_unarmed_F", 
							"C_Truck_02_covered_F", 
							"C_Offroad_01_F", 
							"C_Offroad_01_covered_F", 
							"CUP_C_Pickup_unarmed_CIV", 
							"CUP_C_Octavia_CIV", 
							"C_Quadbike_01_F", 
							"C_Tractor_01_F", 
							"C_Van_02_transport_F", 
							"CFP_C_AFG_Datsun_Pickup_Covered_01", 
							"CFP_C_AFG_Lada_01", 
							"CFP_C_AFG_Skoda_Octavia_01", 
							"CFP_C_AFG_Skoda_105_L_01", 
							"CFP_C_AFG_SUV_01",
							"CFP_C_AFG_SUV_01",
							"CFP_C_AFRCHRISTIAN_Ikarus_01",
							"CFP_C_AFRCHRISTIAN_Pickup_Old_01",
							"CFP_C_AFRCHRISTIAN_Land_Rover_01",
							"CFP_C_AFRCHRISTIAN_UAZ_Open_01",
							"CFP_C_AFG_SUV_01", 
							"CFP_C_AFRCHRISTIAN_Ikarus_01",
							"CFP_C_AFRCHRISTIAN_Pickup_Old_01",
							"CFP_C_AFRCHRISTIAN_Land_Rover_01",
							"CFP_C_AFRCHRISTIAN_UAZ_Open_01",
							"CFP_C_AFRISLAMIC_Land_Rover_01",
							"CFP_C_AFRISLAMIC_Land_Rover_01",
							"CFP_C_AFRISLAMIC_Skoda_Blue_01",
							"CFP_O_RUMVD_Ural_Open_01",
							"CFP_C_AFRISLAMIC_Land_Rover_01", 
							"CFP_C_AFRISLAMIC_Skoda_Blue_01",
							"CFP_O_RUMVD_Ural_Open_01",
							"CFP_C_AFRISLAMIC_Ural_Blue_01", 
							"CFP_C_AFRISLAMIC_Ural_Yellow_01", 
							"CFP_C_ASIA_Praga_V3S_01",
							"CFP_C_ASIA_Praga_V3S_01",
							"CFP_C_CHERNO_WIN_UAZ_TAN_01",
							"CFP_C_ASIA_Praga_V3S_01", 
							"CFP_C_CHERNO_WIN_UAZ_TAN_01",
							"CUP_C_S1203_CIV_CR", 
							"CUP_C_Tigr_4x4_CIV", 
							"CUP_O_Hilux_unarmed_TK_CIV", 
							"CUP_O_Hilux_unarmed_TK_CIV_Red", 
							"CUP_O_Hilux_unarmed_TK_CIV_Tan", 
							"CUP_O_Hilux_unarmed_TK_CIV_White", 
							"CUP_C_Ikarus_Chernarus", 
							"CFP_C_AFRCHRISTIAN_Ikarus_01", 
							"CFP_C_ME_Ikarus_01", 
							"CUP_C_Ikarus_TKC"
							];
        btc_type_motorized_armed = btc_type_motorized_armed + 
                            [
							"CUP_I_SUV_Armored_ION", 
							"CUP_B_nM1025_SOV_M2_NATO_T"
							];

        btc_type_units = btc_type_units + 
                            [
							"I_L_Criminal_SG_F", 
							"I_L_Criminal_SMG_F", 
							"I_L_Looter_SG_F", 
							"I_L_Looter_SMG_F", 
							"I_C_Soldier_Bandit_5_F", 
							"I_C_Soldier_Bandit_1_F", 
							"CFP_I_SDRebelsrf_Soldier_02", 
							"I_C_Soldier_Bandit_7_F", 
							"I_C_Soldier_Bandit_3_F", 
							"I_C_Soldier_Bandit_8_F", 
							"I_C_Soldier_Bandit_4_F", 
							"CUP_I_PMC_Bodyguard_M4", 
							"CUP_I_PMC_Contractor1", 
							"CUP_I_PMC_Contractor2", 
							"CUP_I_PMC_Medic", 
							"CUP_I_PMC_Soldier_AT", 
							"CUP_I_PMC_Soldier_M4A3", 
							"CUP_I_PMC_Soldier", 
							"CUP_I_PMC_Soldier_TL"
							];
        btc_type_boats = 
        [
            "B_G_Boat_Transport_01_F", 
            "CFP_B_USMC_Zodiac_DES_01", 
            "I_C_Boat_Transport_02_F", 
            "braf_voadeira_03", 
            "braf_voadeira_04", 
            "braf_voadeira_05", 
            "braf_voadeira_06", 
            "C_Boat_Civil_01_F", 
            "C_Boat_Transport_02_F", 
            "C_Scooter_Transport_01_F", 
            "CFP_C_ASIA_Fishing_Boat_01", 
            "CUP_C_PBX_CIV"
        ];
        btc_type_divers = 
        [
            "B_G_Boat_Transport_01_F", 
            "CFP_B_USMC_Zodiac_DES_01", 
            "I_C_Boat_Transport_02_F", 
            "braf_voadeira_03", 
            "braf_voadeira_04", 
            "braf_voadeira_05", 
            "braf_voadeira_06", 
            "C_Boat_Civil_01_F", 
            "C_Boat_Transport_02_F", 
            "C_Scooter_Transport_01_F", 
            "CFP_C_ASIA_Fishing_Boat_01", 
            "CUP_C_PBX_CIV"
        ];

    };
};

//Chem
btc_chem_range = 3;

//Spect
btc_spect_range = 1000;
btc_spect_updateOn = -1;

//Rep
btc_rep_bonus_cache = 200;
btc_rep_bonus_civ_hh = 3;
btc_rep_bonus_disarm = 30;
btc_rep_bonus_hideout = 500;
btc_rep_bonus_mil_killed = 1;
btc_rep_bonus_IEDCleanUp = 10;
btc_rep_bonus_removeTag = 5;
btc_rep_bonus_removeTagLetter = 2;
btc_rep_bonus_foodGive = 10;

btc_rep_malus_civ_hd = - 4;
btc_rep_malus_animal_hd = - 2;
btc_rep_malus_civ_killed = - 50;
btc_rep_malus_animal_killed = - 25;
btc_rep_malus_civ_suppressed = - 10;
btc_rep_malus_player_respawn = - 0.1;
btc_rep_malus_veh_killed = - 25;
btc_rep_malus_building_damaged = - 5;
btc_rep_malus_building_destroyed = - 50;
btc_rep_malus_foodRemove = - btc_rep_bonus_foodGive;
btc_rep_malus_breakDoor = - 2;
btc_rep_malus_wheelChange = - 7;
btc_rep_malus_mil_killed = - 10;

btc_rep_level_veryLow = 0;
btc_rep_level_low = 200;
btc_rep_level_normal = 500;
btc_rep_level_high = 750;

btc_rep_food = "ACE_Humanitarian_Ration";

//Headless
btc_units_owners = [];

//Door
btc_door_breaking_time = 60;

//Flag
btc_flag_textures = [
    "\A3\Data_F\Flags\flag_red_CO.paa",
    "\A3\Data_F\Flags\flag_green_CO.paa",
    "\A3\Data_F\Flags\flag_blue_CO.paa",
    '#(argb,8,8,3)color(0.9,0.9,0,1)',
    "\A3\Data_F\Flags\flag_NATO_CO.paa"
];

//Respawn
btc_body_bagTicketPlayer = 1;
btc_body_prisonerTicket = 1;

btc_startDate = [2024, 6, 24, 12, 15];
