// pass in player + the marker array, if the player is in any marker add actions and wait until the player isn't in a marker to delete the actions.
params ["_player", "_markers"];

while {alive _player} do {
	private _marker = nil;
	{
		if ((position _player) inArea _x) exitWith {
			_marker = _x;
			[_player, _marker] remoteExec ["sg_fnc_cluster_add_action_server", 2];
		};
	} forEach _markers;
	if (!isNil "_marker") then {
		while {_player inArea _marker} do {
			sleep 1;
		};
	} else {
		sleep 1;
	};
};