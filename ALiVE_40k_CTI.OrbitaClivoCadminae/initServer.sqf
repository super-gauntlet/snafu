// Other things this expects: 
// - a Logic object with the name 'CASH_VAR'
private _PLAYER_SIDE = WEST;
private _ENEMY_SIDES = [RESISTANCE, EAST];

missionNamespace setVariable ["_PLAYER_SIDE", _PLAYER_SIDE, true];
missionNamespace setVariable ["_ENEMY_SIDES", _ENEMY_SIDES, true];


diag_log "[initServer.sqf] Starting Init";
ALiVE_Helper_opcomEventListener = compile preprocessFileLineNumbers "opcomEventListener.sqf";
opcomEventListener = [nil,"create", ["ALiVE_Helper_opcomEventListener", _PLAYER_SIDE]] call ALiVE_Helper_opcomEventListener;
[] execVM "HG\Setup\fn_serverInitialization.sqf";

diag_log "[initServer.sqf] Setting up buy system and autosave";
waitUntil {!isNil "ALiVE_STATIC_DATA_LOADED"};

1800 call ALiVE_fnc_AutoSave_PNS;

diag_log "[initServer.sqf] Setting up ambiance and deleting old ground object clutter";
// [nil, "init", []] spawn SG_fnc_ambiance;
call compile preprocessFile "staticData.sqf";

waitUntil {!isNil "ALiVE_sys_logistics"};
private _counter = 10;
while {(_counter > 0) && (ALiVE_sys_logistics_store select 1) isEqualTo []} do {
	sleep 5;
	_counter = _counter - 1;
};

{
	[ALiVE_sys_logistics, "removeObject", [_x]] call ALiVE_fnc_logistics;
	deleteVehicle _x;
} forEach allMissionObjects "GroundWeaponHolder";

// ALiVE Persistence

private _first_init_complete = profileNamespace getVariable "FIRSTTIME_INIT_COMPLETE";
waitUntil {not isNil "ALIVE_globalForcePool"};
waitUntil {(count (ALIVE_globalForcePool select 1)) > 0};
ALiVE_Helper_logisticsEventListener = compile preprocessFileLineNumbers	"logisticsEventListener.sqf";
logisticsEventListener = [nil, "create", ["ALiVE_Helper_logisticsEventListener", _PLAYER_SIDE]] call ALiVE_Helper_logisticsEventListener;

if (isNil "_first_init_complete") then {
	// run first time setup things
	{
		_faction = _x;
		[ALiVE_globalForcePool, _faction, 0] call ALiVE_fnc_hashSet;
	} forEach (ALiVE_globalForcePool select 1);

	profileNamespace setVariable ["FIRSTTIME_INIT_COMPLETE", true];
	saveProfileNamespace;
} else {
	{
		_faction = _x;
		_save_name = format ["SG_%1_logi", _faction];
		_save_value = profileNamespace getVariable [_save_name, 0];
		[ALiVE_globalForcePool, _faction, _save_value] call ALiVE_fnc_hashSet;
	} forEach (ALiVE_globalForcePool select 1);
};

[] spawn {
	while {true} do {
		sleep 60;
		{
			_faction = _x;
			_save_name = format ["SG_%1_logi", _faction];
			_save_value = [ALiVE_globalForcePool, _faction, 0] call ALiVE_fnc_hashGet;
			profileNamespace setVariable [_save_name, _save_value];
		} forEach (ALiVE_globalForcePool select 1);
	};
};

diag_log "[initServer.sqf] creating markers";
_opcom = OPCOM_INSTANCES select {([_x, "side"] call ALiVE_fnc_hashGet) == str _PLAYER_SIDE} select 0;
while {
	_objectives = [_opcom, "objectives"] call ALiVE_fnc_hashGet;
	(count _objectives) == 0;
} do {
	sleep 5;
};
sleep 5;

private _sorted_markers = [_opcom] call SG_fnc_create_markers;
missionNamespace setVariable ["SG_obj_markers", _sorted_markers, true];

_marker_to_spawnpoint = [] call ALiVE_fnc_hashCreate;
missionNamespace setVariable ["SG_marker_to_spawnpoint", _marker_to_spawnpoint, true];

diag_log "[initServer.sqf] setting up persistent vehicle respawns";
_count = 0;
while {
	_persistent_vehicles = profileNamespace getVariable "persistent_vehicles";
	_count = _count + 1;
	(isNil "_persistent_vehicles") && (_count < 5)
} do {
	sleep 1;
};
_vehicle_ids = profileNamespace getVariable ["persistent_vehicles", []];
{
	_object = _x;
	_id = [ALiVE_sys_logistics, "id", _object] call ALiVE_fnc_logistics;
	if (_id in _vehicle_ids) then {
		[_PLAYER_SIDE, _object] call BIS_fnc_addRespawnPosition;
	};
} forEach ([ALiVE_sys_logistics, "allObjects"] call ALiVE_fnc_logistics);

diag_log "[initServer.sqf] calling ongoing functions";
[_opcom, _PLAYER_SIDE, _ENEMY_SIDES] spawn sg_fnc_ongoing_fns;