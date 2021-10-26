params ["_caller"];

private _position = position _caller;
private _time = if (isMultiplayer) then {serverTime} else {time};
private _caller_time = _caller getVariable ["lastUsed", -300];

if ((_time - 300) < _caller_time) exitWith {
	if (hasInterface) then {
		hint "The repair system has been used in the last 5 minutes! Please wait for a bit.";
	};
};

_caller setVariable ["lastUsed", _time, true];

{
	[_x, 0] remoteExec ["setFatigue", _x];
	_x setDamage 0;
	_x setVariable ["incapacitated",false,true];
	_x setVariable ["compromised", 0, true];
} forEach (_position nearEntities ["Man", 50]) select {(side group _x == side _caller) || (side group _x == civ)};

{
	_x setDamage 0;
	if (_x getVariable ["incapacitated",false]) then {_x setVariable ["incapacitated",false,true]};
	[_x,1] remoteExec ["setVehicleAmmo",_x];
	if (_x getVariable ["INC_naughtyVehicle", false]) then {
		_x setVariable ["INC_naughtyVehicle", false];
	};
} forEach (_position nearEntities [["Car", "Air", "Motorcyle", "Tank"], 50]) select {(side group _x == side _caller) || (side group _x == civ)};

hint parseText "Nearby units have been healed, refreshed, and can go undercover again.<br/><br/> Nearby vehicles have been repaired, rearmed, and are no longer reported.";