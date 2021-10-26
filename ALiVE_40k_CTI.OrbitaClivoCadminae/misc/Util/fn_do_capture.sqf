params ["_objective", "_faction"];

scopeName "main_scope";

private _pos = [_objective, "center"] call ALiVE_fnc_hashGet;
private _distance = [_objective, "size"] call ALiVE_fnc_hashGet;
private _pretty_faction_name = getText((_faction call ALiVE_fnc_configGetFactionClass) >> "displayName");
private _objective_letter = [_objective, "letter"] call ALiVE_fnc_hashGet;

private _players_to_send = allPlayers select {(_x distance _pos) < (2 * _distance)};
private _msg = format ["Objective %1 being captured by %2.", _objective_letter, _pretty_faction_name];
{
	private _player = _x;
	[[side _player, "Base"], _msg] remoteExec ["sideChat", _player];
} forEach _players_to_send;

private _counter = 100;
while {_counter > 0} do {
	// Count down from 100, checking each second if the point is still held by the faction. If they're not the owner (returns nil), block capture. 
	// If it returns a different faction (but not nil) exit out of the script, as this means capture failed.
	private _owner = [_objective] call SG_fnc_get_objective_owner;
	_players_to_send = allPlayers select {(_x distance _pos) < (2 * _distance)};
	if (isNil "_owner") then {
		_msg = format ["Objective %1 capture being blocked!", _objective_letter];
		{
			private _player = _x;
			[[side _player, "Base"], _msg] remoteExec ["sideChat", _player];
		} forEach _players_to_send;
	};

	while {isNil "_owner"} do {
		sleep 1;
		_owner = [_objective] call SG_fnc_get_objective_owner;
	};
	if (_owner != _faction) then {
		false breakOut "main_scope";
	};
	_counter = _counter - 1;

	private _progress = (100 - _counter) / 100;
	{
		private _player = _x;
		[_progress, _pos, _distance] remoteExec ["SG_fnc_set_progress", _player];
	} forEach _players_to_send;

	sleep 1;
};

_players_to_send = allPlayers select {(_x distance _pos) < (2 * _distance)};
_msg = format ["Objective %1 has been captured by %2.", _objective_letter, _pretty_faction_name];
{
	private _player = _x;
	[[side _player, "Base"], _msg] remoteExec ["sideChat", _player];
	[0.0, _pos, _distance * 2] remoteExec ["SG_fnc_set_progress", _player];
} forEach _players_to_send;

true