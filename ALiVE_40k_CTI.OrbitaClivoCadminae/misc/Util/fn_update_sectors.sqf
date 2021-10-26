params ["_objectives", "_player_side"];
{
	private _objective = _x;
	[_objective, _player_side] spawn {
		params ["_objective", "_player_side"];
		scopeName "main_scope";

		if ([_objective, "capturing", false] call ALiVE_fnc_hashGet) exitWith {};

		private _marker = [_objective, "marker"] call ALiVE_fnc_hashGet;
		private _pos = getMarkerPos _marker;
		private _radius = (getMarkerSize _marker) select 0;
		private _color = "ColorBlack";
		private _dominant_faction = [_objective] call SG_fnc_Get_Objective_Owner;
		if (isNil "_dominant_faction") then {
			_dominant_faction = [_objective, "lastTaken"] call ALiVE_fnc_hashGet;
		};

		if !(isNil "_dominant_faction") then {
			private _last_taken = [_objective, "lastTaken", "nil"] call ALiVE_fnc_hashGet;
			private _last_side = sideEmpty;
			if (_last_taken isNotEqualTo "nil") then {
				_last_side = _last_taken call ALiVE_fnc_factionSide;
			};
			private _side = _dominant_faction call ALiVE_fnc_factionSide;
			if (_side == _last_side) then {
				breakOut "main_scope";
			};

			// Not same as last side, start capture process (need to add dialog)
			[_objective, "capturing", true] call ALiVE_fnc_hashSet;
			private _capture_status = [_objective, _dominant_faction] call SG_fnc_Do_Capture;
			[_objective, "capturing", false] call ALiVE_fnc_hashSet;

			// If capture fails, exit immediately
			if !(_capture_status) then {
				breakOut "main_scope";
			};

			// Capture successful, select color and set taken side value
			[_objective, "lastTaken", _dominant_faction] call ALiVE_fnc_hashSet;

			switch (_side) do {
				case EAST: {_color = "ColorEAST"};
				case WEST: {_color = "ColorWEST"};
				case RESISTANCE: {_color = "ColorGUER"};
				case civilian: {_color = "colorciv"};
			};

			if (_side == _player_side) then {
				// Friendly, add respawn pos if it doesn't exist
				_id = [_objective, "respawnPoint"] call ALiVE_fnc_hashGet;
				if (isNil "_id") then {
					_respawnpos2D = [_pos, 0, _radius, 5, 0, 0.2, 0, [], _pos] call BIS_fnc_findSafePos;
					_respawnpos = [_respawnpos2D select 0, _respawnpos2D select 1, 0];
					_id = [_player_side, _respawnpos] call BIS_fnc_addRespawnPosition;
					[_objective, "respawnPoint", _id] call ALive_fnc_hashSet;
				};
			} else {
				// Not friendly, delete respawn pos if necessary
				_id = [_objective, "respawnPoint"] call ALiVE_fnc_hashGet;
				if !(isNil "_id") then {
					_id call BIS_fnc_removeRespawnPosition;
				};
			};
		};

		_marker setMarkerColor _color;
	};
} forEach (_objectives select {([_x, "marker", ""] call ALiVE_fnc_hashGet) isNotEqualTo ""});