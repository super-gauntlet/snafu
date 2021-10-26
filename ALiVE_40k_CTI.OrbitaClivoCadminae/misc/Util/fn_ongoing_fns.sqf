params ["_opcom", "_player_side", "_enemy_sides"];

[_player_side] spawn {
	params ["_player_side"];
	while {true} do {
		[_player_side] call SG_fnc_Update_Forcepool;
		sleep 900;
	};
};

while {count ([_opcom, "objectives"] call ALiVE_fnc_hashget) < 1} do {
	sleep 1;
};

private _objectives = [_opcom, "objectives"] call ALiVE_fnc_hashGet;

[_objectives, _player_side] spawn {
	params ["_objectives", "_player_side"];
	while {true} do {
		[_objectives, _player_side] call SG_fnc_Update_Sectors;
		sleep 5;
	};
};

[_player_side, _enemy_sides] spawn {
	params ["_player_side", "_enemy_sides"];
	while {true} do {
		sleep 60;
		private _all_objectives_taken = [_player_side] call SG_fnc_All_Objectives_Taken;

		if (_all_objectives_taken) exitWith {
		    [_player_side, _enemy_sides] spawn SG_fnc_Endgame;
		};
	};
};

// TODO: pull this out into a function
[_objectives, _player_side] spawn {
	params ["_objectives", "_player_side"];
	private _obj_id_to_owner = "OBJECTIVE_OWNER_MAP" call ALiVE_fnc_ProfileNameSpaceLoad;
	if (_obj_id_to_owner isEqualTo false) then {
		_obj_id_to_owner = [] call ALiVE_fnc_HashCreate;
	} else {
		{
			private _objective = _x;
			private _clusterID = [_objective, "clusterID"] call ALiVE_fnc_hashGet;
			if (_clusterID in (_obj_id_to_owner select 1)) then {
				// load objective owner data if it exists in the saved map
				private _owner = [_obj_id_to_owner, _clusterID] call ALiVE_fnc_hashGet;
				[_objective, "lastTaken", _owner] call ALiVE_fnc_hashSet;
				private _side = _owner call ALiVE_fnc_factionSide;

				private _color = "ColorBlack";
				switch (_side) do {
					case EAST: {_color = "ColorEAST"};
					case WEST: {_color = "ColorWEST"};
					case RESISTANCE: {_color = "ColorGUER"};
					case civilian: {_color = "colorciv"};
				};

				private _marker = [_objective, "marker"] call ALiVE_fnc_hashGet;

				_marker setMarkerColor _color;

				if (_side == _player_side) then {
					// Friendly, add respawn pos if it doesn't exist
					_id = [_objective, "respawnPoint"] call ALiVE_fnc_hashGet;
					if (isNil "_id") then {
						private _pos = getMarkerPos _marker;
						private _radius = (getMarkerSize _marker) select 0;
						_respawnpos2D = [_pos, 0, _radius, 5, 0, 0.2, 0, [], _pos] call BIS_fnc_findSafePos;
						_respawnpos = [_respawnpos2D select 0, _respawnpos2D select 1, 0];
						_id = [_player_side, _respawnpos] call BIS_fnc_addRespawnPosition;
						[_objective, "respawnPoint", _id] call ALive_fnc_hashSet;
					};
				};
			};
		} forEach _objectives;
	};
	while {true} do {
		{
			private _objective = _x;
			private _clusterID = [_objective, "clusterID"] call ALiVE_fnc_hashGet;
			private _owner = [_objective, "lastTaken"] call ALiVE_fnc_hashGet;
			if !(isNil "_owner") then {
				[_obj_id_to_owner, _clusterID, _owner] call ALiVE_fnc_hashSet;
			};
		} forEach _objectives;
		["OBJECTIVE_OWNER_MAP", _obj_id_to_owner] call ALiVE_fnc_ProfileNameSpaceSave;
		sleep 60;
	};
};

// hack specific to 40k mission to force logi
[] spawn {
	while {true} do {
		{
			private _opcom = _x;
			private _side = [_opcom, "side"] call ALiVE_fnc_hashGet;
			if (_side in ["WEST", "EAST"]) then {
				private _objectives = [_opcom, "objectives"] call ALiVE_fnc_hashGet;
				private _sortedObjectives = [_objectives,[],{[_x, "priority", 0] call ALiVE_fnc_hashGet},"DESCEND"] call ALiVE_fnc_SortBy;
				private _highestPriorityObjective = _sortedObjectives select 0;
				[_highestPriorityObjective, "tacom_state", "reserve"] call ALiVE_fnc_hashSet;
			};
		} forEach OPCOM_INSTANCES;
		sleep 60;
	};
};