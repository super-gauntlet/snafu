params ["_profiles", "_destination", "_side"];

// Watch profiles until they are either destroyed, captured, or make it to their destination. Destruction/capture is task success, destination is task fail.
private _marker_to_update = "";

private _convoy_alive = false;
private _convoy_not_reached = true;
{
	private _profile_data = [ALiVE_profileHandler, "getProfile", _x] call ALiVE_fnc_profileHandler;

	if !(isNil "_profile_data") then {
		_convoy_alive = true;

		private _pos = [_profile_data, "position"] call ALiVE_fnc_hashGet;
		private _id = [_profile_data, "profileID"] call ALiVE_fnc_hashGet;
		private _side = [_profile_data, "side"] call ALiVE_fnc_hashGet;
		private _marker_type = "mil_unknown";
		switch (_side) do {
			case "WEST": {
				_marker_type = "b_unknown";
			};
			case "EAST": {
				_marker_type = "o_unknown";
			};
			case "GUER": {
				_marker_type = "n_unknown";
			};
		};
		if (_forEachIndex == 0) then {
			private _marker_str = format ["|%1_marker|%2|%3|ICON|[1,1]|0|Solid|Default|1|Reinforcements", _id, _pos, _marker_type];
			_marker_str call BIS_fnc_stringToMarker;
			_marker_to_update = format ["%1_marker", _id];
		};
		if ((_pos distance _destination) < 50) then {
			_convoy_not_reached = false;
		};
	};
} forEach _profiles;

[
    _side,
    _marker_to_update,
    ["Intercept and destroy the reinforcement convoy", "Intercept Convoy", _marker_to_update],
    getMarkerPos _marker_to_update,
    "CREATED",
    1,
    true,
    "",
    true
] call BIS_fnc_taskCreate;


while {_convoy_alive && _convoy_not_reached} do {
	_convoy_alive = false;
	_convoy_not_reached = true;
	{
		private _profile_data = [ALiVE_profileHandler, "getProfile", _x] call ALiVE_fnc_profileHandler;
		private _marker_moved = false;
		if !(isNil "_profile_data") then {
			_convoy_alive = true;
			private _pos = [_profile_data, "position"] call ALiVE_fnc_hashGet;
			if !(_marker_moved) then {
				_marker_moved = true;
				_marker_to_update setMarkerPos _pos;
			};
			if ((_pos distance _destination) < 50) then {
				_convoy_not_reached = false;
			};
		};
	} forEach _profiles;
	sleep 10;
};

deleteMarker _marker_to_update;

if !(_convoy_not_reached) then {
	// Convoy reached, fail task	
	[_marker_to_update, "FAILED", true] call BIS_fnc_taskSetState;
} else {
	// Disrupted convoy, consider this success
	[_marker_to_update, "SUCCEEDED", true] call BIS_fnc_taskSetState;
};