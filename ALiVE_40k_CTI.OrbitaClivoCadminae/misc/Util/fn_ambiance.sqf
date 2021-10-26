#define COMPONENT amb_ambiance
#include <\x\cba\addons\main\script_macros.hpp>

#define MPATH                   \x\PREFIX\addons
#define CPATH(component)        MPATH\component

#define CDATA(component)        CPATH(component)\data
#define CUI(component)          CDATA(component)\ui
#define CIMAGES(component)      CDATA(component)\images
#define CSOUNDS(component)      CDATA(component)\sounds

#define PREVFOLDER              ..\

#define FUNC(function)          PREFIX##_fnc_##function
#define QFUNC(function)         QUOTE(FUNC(function))

#define getControl(disp,ctrl)       (findDisplay disp displayCtrl ctrl)
#define getSelData(ctrlID)          (lbData [ctrlID,lbCurSel ctrlID])
#define ctrlGetSelData(ctrl)        (ctrl lbData (lbCurSel ctrl))

// oop

#define SUPER(mod)      (call compile ([mod,"superclass"] call FUNC(hashGet)))
#define CLASS(mod)      (call compile ([mod,"mainclass"] call FUNC(hashGet)))

#define init_OOP()      scopename "main"; \
                        private ["_result"];

#define method(name)    case name:
#define defaultMethod() default {_result = _this call SUPERCLASS};


#define return(var)     _result = var;\
                        breakto "main"

#define return          _result =

// ui

#define MOD_COLOR_MAIN      {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",0.7}

#define PREFIX      SG
#define MPREFIX     SG

#define MOD_AUTHOR "supergauntlet"
#define ORIGINAL_MOD_AUTHOR "SpyderBlack723"

#define RECOMPILE   1
//#define DEBUG_MODE_FULL

#define MOD(var1)   PREFIX##_##var1
#define QMOD(var1)  QUOTE(MOD(var1))

SCRIPT(ambiance);

/* ----------------------------------------------------------------------------
Function: SG_fnc_ambiance

Description:
Main handler for ambiance

Parameters:
String - Operation
Array - Arguments

Returns:

Any - Result of the operation

Examples:
(begin example)
(end)

See Also:
- nil

Author: SpyderBlack723

Peer Reviewed:
nil
---------------------------------------------------------------------------- */

private ["_result"];
params [
	["_logic", objNull],
	["_operation", ""],
	["_arguments", []]
];

//-- Define control ID's
#define MAINCLASS SG_fnc_ambiance

switch (_operation) do {

	case "create": {

		_result = [] call CBA_fnc_hashCreate;

	};

	case "init": {

		if !(isServer) exitWith {};

		private ["_logics"];

		_synced = _arguments;

		//-- Get module parameters
		_debug = false;
		_timer = 20;
		_spawnRange = 500;
		_whitelistMarkers = [];
		_blacklistMarkers = [];
		_locations = ["NameVillage","NameCity","NameCityCapital","NameLocal"];
		_ambientAnimals = true;
		_animalChance = 20;
		_animalClasses = ["Goat_Random_F","Sheep_random_f"];
		_ambientVehicles = true;
		_vehicleChance = 100;
		_maxVehiclesPerZone = 3;
		_vehicleClasses = ["C_Van_01_fuel_F", "C_Hatchback_01_F", "C_Hatchback_01_sport_F", "C_Offroad_02_unarmed_F", "C_Offroad_01_F", "C_SUV_01_F", "C_Van_01_transport_F", "C_Van_01_box_F", "C_Truck_02_box_F", "C_Truck_02_fuel_F", "C_Truck_02_transport_F", "C_Truck_02_covered_F"];
		_civilianClasses = ["C_man_p_beggar_F_euro", "C_Man_casual_2_F_euro", "C_Man_casual_8_F_euro", "C_Man_formal_3_F_euro", "C_Man_smart_casual_2_F_euro", "C_man_sport_2_F_euro", "C_Man_casual_5_F_euro", "C_man_polo_4_F_euro", "C_man_polo_1_F_euro", "C_man_shorts_1_F_euro", "C_man_p_shorts_1_F_euro", "C_scientist_02_formal_F", "C_scientist_02_informal_F", "C_man_shorts_3_F_euro"];
		_enemiesInsideVehicles = true;
		_enemyChance = 10;
		_enemyClasses = ["B_GEN_Soldier_F", "B_GEN_Commander_F", "B_G_Soldier_lite_F", "B_G_officer_F"];

		//-- Make markers invisible
		{_x setMarkerAlpha 0} forEach (_whitelistMarkers + _blacklistMarkers);

		//-- Get valid locations
		_validLocations = [_logic,"validateLocations", [_locations, _whitelistMarkers, _blacklistMarkers]] call MAINCLASS;

		//-- Create location logics
		//-- Locations are more efficient than "Logic_F". Use a location that nobody ever uses as to avoid polluting nearestLocations.
		_validLocs = [];
		{
			_pos = _x;
			_loc = createLocation ["Mount", _pos, 1, 1];
			_loc setVariable ["Debug", _debug];
			_loc setVariable ["Position", _pos];
			_loc setVariable ["Activated", false];
			_loc setVariable ["Objects", []];
			_loc setVariable ["SpawnRange", _spawnRange];
			_loc setVariable ["AmbientAnimals", _ambientAnimals];
			_loc setVariable ["AnimalChance", _animalChance];
			_loc setVariable ["AnimalClasses", _animalClasses];
			_loc setVariable ["AmbientVehicles", _ambientVehicles];
			_loc setVariable ["VehicleChance", _vehicleChance];
			_loc setVariable ["MaxVehiclesPerZone", _maxVehiclesPerZone];
			_loc setVariable ["VehicleClasses", _vehicleClasses];
			_loc setVariable ["CivilianClasses", _civilianClasses];
			_loc setVariable ["EnemiesInsideVehicles", _enemiesInsideVehicles];
			_loc setVariable ["EnemyChance", _enemyChance];
			_loc setVariable ["EnemyClasses", _enemyClasses];

			if (_debug) then {
				_marker = createMarker [str _pos, _pos];
				_marker setMarkerShape "ELLIPSE";
				_marker setMarkerSize [1000,1000];
				_marker setMarkerAlpha 0.3;

				_loc setVariable ["Marker", _marker];
				_loc setVariable ["DebugMarkers", []];
			};

			_validLocs pushBack _loc;
		} forEach _validLocations;

		[_logic,"addToQueue", _validLocs] call MAINCLASS;
		[_logic,"startQueue", _timer] call MAINCLASS;

	};

	case "validateLocations": {

		private ["_valid"];

		_arguments params ["_locations", "_whitelistMarkers", "_blacklistMarkers"];

		//-- Get valid locations
		_result = [];
		_mapLocations = configfile >> "CfgWorlds" >> worldName >> "Names";

		for "_i" from 0 to (count _mapLocations - 1) do {
			_location = _mapLocations select _i;
			_locationPos = getArray(_location >> "position");
			_locationType = getText(_location >> "type");

			if (_locationType in _locations) then {
				_valid = true;

				//-- Check if location is blacklisted
				{
					if ([_x, _locationPos] call BIS_fnc_inTrigger) then {
						_valid = false;
					};
				} forEach _blacklistMarkers;

				//-- Check if location is whitelisted
				if (_valid) then {
					{
						if !([_x, _locationPos] call BIS_fnc_inTrigger) then {
							_valid = false;
						};
					} forEach _whitelistMarkers;
				};

				if (_valid) then {_result pushBack _locationPos};
			};

		};

	};

	case "addToQueue": {

		_locs = _arguments;

		if (isNil QMOD(ambianceHandler)) then {
			MOD(ambianceHandler) = [nil,"create"] call MAINCLASS;
			[MOD(ambianceHandler),"Logics", _locs] call CBA_fnc_hashSet;
		} else {
			_logics = [MOD(ambianceHandler),"Logics"] call CBA_fnc_hashGet;
			{_logics pushBack _x} forEach _locs;
			[MOD(ambianceHandler),"Logics", _logics] call CBA_fnc_hashSet;
		};

	};

	case "startQueue": {

		_timer = _arguments;

		//-- This does not allow for multiple delays with multiple ambiance modules are placed, consider doing so at the cost of perf
		if (isNil {[SG_ambianceHandler,"perFrameID"] call CBA_fnc_hashGet}) then {
			_perFrameID = [{
				{
					_logic = _x;
					_pos = _logic getVariable "Position";
					_activated = _logic getVariable "Activated";
					_spawnRange = _logic getVariable "SpawnRange";
					_playerCount = {(_x distance2D _pos) < _spawnRange} count allPlayers;

					if (_playerCount == 0) then {
						if (_activated) then {
							[_logic,"Deactivate"] call SG_fnc_ambiance;
						};
					} else {
						if !(_activated) then {
							[_logic,"Activate"] call SG_fnc_ambiance;
						};
					};
				} forEach ([SG_ambianceHandler,"Logics"] call CBA_fnc_hashGet);
			}, _timer, []] call CBA_fnc_addPerFrameHandler;

			[SG_ambianceHandler,"perFrameID", _perFrameID] call CBA_fnc_hashSet
		};

	};

	case "Activate": {

		_logic setVariable ["Activated", true];

		if (_logic getVariable "AmbientAnimals") then {
			[_logic,"activateAnimals"] call MAINCLASS;
		};

		if (_logic getVariable "AmbientVehicles") then {
			[_logic,"activateVehicles"] call MAINCLASS;
		};

		if (_logic getVariable "Debug") then {
			_marker = _logic getVariable "Marker";
			_marker setMarkerAlpha 0.4;
			_marker setMarkerColor "ColorBlue";
		};

	};

	case "Deactivate": {

		private ["_group"];

		_logic setVariable ["Activated", false];

        private _remaining = [];

		{
            private _keep = false;

			if (_x isKindOf "Man") then {
				_group = group _x;
			};

            // need to actually check for car/motorcycle/etc because checking
            // for the Vehicle type doesn't work for some reason
            if (
            		(_x isKindOf "Car") ||
            		(_x isKindOf "Helicopter") ||
            		(_x isKindOf "Motorcycle") ||
            		(_x isKindOf "Plane") ||
            		(_x isKindOf "Ship") ||
            		(_x isKindOf "Submarine") ||
            		(_x isKindOf "TrackedAPC") ||
            		(_x isKindOf "Tank") ||
            		(_x isKindOf "WheeledAPC")
            ) then {
            	// Check if a player is in the vehicle
                {
                    if (isPlayer _x) then {
                        _keep = true;
                    };
                } foreach (crew _x);

                // Check if any player is within 500m of an empty vehicle
                private _veh = _x;
                {
                	if ((_veh distance _x) < 500 and (count crew _veh) == 0) then {
                		_keep = true;
                	};
                } forEach allPlayers;

                if (_keep) then {
                    _remaining pushback _x;
                };

            };

            if (!_keep) then {
                deleteVehicle _x;
            };

			if (!isNil "_group" && {count (units _group) == 0}) then {
				deleteGroup _group;
			};

			_group = nil;
		} forEach (_logic getVariable "Objects");

		_logic setVariable ["Objects", _remaining];

		if (_logic getVariable "Debug") then {
			_marker = _logic getVariable "Marker";
			_marker setMarkerAlpha 0.3;
			_marker setMarkerColor "ColorBlack";

			{deleteMarker _x} forEach (_logic getVariable "DebugMarkers");
			_logic setVariable ["DebugMarkers", []];
		};

	};

	case "activateAnimals": {

		_chance = _logic getVariable "AnimalChance";
		_classes = _logic getVariable "AnimalClasses";

		if (floor random 100 <= _chance) then {
			_pos = _logic getVariable "Position";
			_pos = [_pos, 0, 400, 21, 0, 1, 0] call BIS_fnc_findSafePos;
			[_logic,"spawnHerd", [_pos,_classes]] spawn MAINCLASS;
		};

	};

	case "activateVehicles": {

		_pos = _logic getVariable "Position";
		_chance = _logic getVariable "AnimalChance";
		_maxVehicles = _logic getVariable "MaxVehiclesPerZone";
		_vehClasses = _logic getVariable "VehicleClasses";
		_civClasses = _logic getVariable "CivilianClasses";

		for "_i" from 1 to _maxVehicles step 1 do {
			if (floor random 100 <= _chance) then {
				[_logic,"spawnVehicles", [_pos,_vehClasses,_civClasses]] spawn MAINCLASS;
			};
		};

	};

	case "spawnHerd": {

		private ["_objects","_marker"];

		_arguments params ["_pos","_classes"];
		_objects = _logic getVariable "Objects";

		_herdType = selectRandom _classes;
		_newGroup = createGroup civilian;

		for "_i" from 0 to 2 + floor(random 3) step 1 do {
			_animal = _newGroup createUnit [_herdType, _pos, [], 20, "NONE"];
			_objects pushBack _animal;
			sleep .2;
		};

		_logic setVariable ["Objects", _objects];

		if (_logic getVariable "Debug") then {
			_marker = createMarker [str _pos, _pos];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "mil_dot";
			_marker setMarkerSize [1,1];
			_marker setMarkerText "Herd";

			_markers = _logic getVariable "DebugMarkers";
			_markers pushBack _marker;
			_logic setVariable ["DebugMarkers", _markers];
		};

	};

	case "spawnVehicles": {

		private ["_objects","_unitClasses","_enemyVehicle","_driver","_group","_seats"];

		_arguments params ["_pos","_vehClasses","_civClasses"];
		_enemies = _logic getVariable "EnemiesInsideVehicles";
		_enemyChance = _logic getVariable "EnemyChance";
		_enemyClasses = _logic getVariable "EnemyClasses";
		_objects = _logic getVariable "Objects";
		_group = createGroup civilian;

		//-- Check if vehicle is occupied by civs or enemies
		if ((floor random 100 <= _enemyChance) and (_enemies)) then {
			_unitClasses = _enemyClasses;
			_enemyVehicle = true;
			_driver = selectRandom _unitClasses;
		} else {
			_unitClasses = _civClasses;
			_enemyVehicle = false;
			_driver = selectRandom _unitClasses;
		};

		//-- Create vehicle
		_road = selectRandom (_pos nearRoads 400);
		if (isNil "_road") exitWith {};
		_vehicle = (selectRandom _vehClasses) createVehicle (getPos _road);
		_driver = _group createUnit [(selectRandom _unitClasses), [0,0,0], [], 5, "NONE"];
		_objects pushBack _vehicle;

		//-- Assign driver
		_driver assignAsDriver _vehicle;
		_driver moveInDriver _vehicle;
		_objects pushBack _driver;

		//-- Fill cargo
		_seats = _vehicle emptyPositions "cargo";
		if (_seats > 4) then {_seats  = ceil random 3};
		for "_i" from 1 to (floor random _seats) step 1 do {
			_unit = _group createUnit [(selectRandom _unitClasses), [0,0,0], [], 5, "NONE"];
			_unit assignAsCargo _vehicle;
			_unit moveInCargo _vehicle;
			_objects pushBack _unit;
			sleep .2;
		};
		_group setBehaviour "CARELESS";

		//-- Assign waypoints
		_roads = _pos nearRoads 800;
		for "_i" from 0 to 4 step 1 do {
			_road = selectRandom _roads;
			if (!isNil "_road") then {
				_wp =_group addWaypoint [getPos _road, 0];
				_wp setWaypointSpeed "Limited";
				if (_i == 4) then {_wp setWaypointType "CYCLE"} else {_wp setWaypointType "MOVE"};
			};
		};

		if (_enemyVehicle) then {
			[_group] spawn {
				params ["_group"];
				waitUntil {sleep 2;{_x distance2D (leader _group) < 50} count allPlayers > 0 || isNull (leader _group)};
				if !(isNull (leader _group)) then {
					[SG_ambianceHandler,"selectAction", _group] call SG_fnc_ambiance;
				} else {
					deleteGroup _group;
				};
			};
		};

		if (_logic getVariable "Debug") then {
			_pos = getPos _vehicle;
			_marker = createMarker [str _pos, _pos];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "mil_dot";
			_marker setMarkerSize [1,1];

			if !(_enemyVehicle) then {
				_marker setMarkerText "Civilian Vehicle";
			} else {
				_marker setMarkerText "Enemy Vehicle";
			};

			_markers = _logic getVariable "DebugMarkers";
			_markers pushBack _marker;
			_logic setVariable ["DebugMarkers", _markers];
		};

	};

	case "getSide": {

		_number = _arguments;

		switch (str _number) do {
			case "0": {_result = EAST};
			case "1": {_result = WEST};
			case "2": {_result = RESISTANCE};
			case "3": {_result = CIV};
			default {_result = EAST};
		};

	};

	case "selectAction": {

		_group = _arguments;
		if (_group getVariable "Decided") exitWith {};

		_action = round(random 6);	//-- This should be a weighted selection instead

		_leader = leader _group;
		_vehicle = vehicle _leader;
		_group setVariable ["Decided", true];

		//-- Make group hostile
		_sideNum = getNumber (configFile >> "CfgVehicles" >> (typeOf _leader) >> "side");
		_side = [_logic,"getSide", _sideNum] call SG_fnc_ambiance;
		_group = createGroup _side;
		{[_x] joinSilent _group} forEach units group _leader;

		switch true do {
			case (_action > 4): {
				_retreatPos = _vehicle getRelPos [400, (getDir _vehicle) - 180];
				(driver _vehicle) doMove _retreatPos;
				_group setCombatMode "BLUE";
				(driver _vehicle) forceSpeed 70;
			};
			case (_action == 4): {
				_targets = [];
				{
					if (_x distance2D _vehicle < 65) then {
						_targets pushBack _x;
					};
				} forEach allPlayers;

				_target = selectRandom _targets;
				(driver _vehicle) forceSpeed 60;

				[_vehicle,_target] spawn {
					_this params ["_vehicle","_target"];
					waitUntil {sleep 1;(_vehicle distance _target < 15)};
					"Bo_Mk82" createVehicle (getPos _vehicle);
				};

				while {(_vehicle distance _target >= 4) && (alive _target)} do {
					sleep 1;
					(driver _vehicle) domove getposATL _target;
				};
			};
			case (_action == 3): {
				_group setCombatMode "BLUE";
				{
					_x leaveVehicle _vehicle;
					[_x] spawn {
						_this params ["_unit"];
						waitUntil {vehicle _unit == _unit};
						_unit action ["DROPWEAPON", _unit, primaryWeapon _unit];
						_unit setCaptive true;
						_unit switchmove "";
						_unit playActionNow "Surrender";
					};
				} foreach units _group;
			};
			case (_action < 3): {
				_group setBehaviour "COMBAT";
				_group leaveVehicle _vehicle;
			};
		};

	};

};

//-- Return result if any exists
if (!isNil "_result") then {_result} else {nil};