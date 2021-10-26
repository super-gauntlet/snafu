// HAS TO BE RUN LOCAL TO PLAYER THAT IS SWITCHING UNITS
params ["_old_unit", "_new_unit"];

SWAP_WITHOUT_EH = {
	params ["_old_unit", "_new_unit"];
	if !(_new_unit getVariable ["SPAWNED_AI", false]) exitWith {
		false
	};

	if (_old_unit == z1) then {
		missionNamespace setVariable ["z1", _new_unit, true];
	};

	private _name = name _old_unit;
	private _rank = rank _old_unit;
	private _type = typeOf _old_unit;
	private _group = group _old_unit;
	private _is_leader = false;
	if (_old_unit == leader _group) then {
		_is_leader = true;
	};
	selectPlayer _new_unit;

	_old_unit setPos [0, 0, 0];
	_old_unit setDammage 1;

	_new_unit setUnitRank _rank;
	_new_unit setName _name;
	[_new_unit] join _group;
	if (_is_leader) then {
		_group selectLeader _new_unit;
	};
};

private _ret = [_old_unit, _new_unit] call SWAP_WITHOUT_EH;
if !(_ret) exitWith {_ret};

[_new_unit] execVM "onPlayerRespawn.sqf";

// Swapping from a unit that was swapped into? Delete the EH
// so it isn't triggered when we delete the unit
private _eh_id = _old_unit getVariable "SWAP_EH_INDEX";
if !(isNil "_eh_id") then {
	_old_unit removeEventHandler ["Respawn", _eh_id];
	_old_unit setVariable ["SWAP_EH_INDEX", nil];
};

_type = _old_unit getVariable "OLD_TYPE";
if (isNil "_type") then {
	_type = typeOf _old_unit;
};

_new_unit setVariable ["OLD_TYPE", _type, true];
private _eh_index = _new_unit addEventHandler ["Respawn", {
	_this spawn {
		params ["_unit", "_corpse"];
	    ["RESPAWN_BLACK_SCREEN", false, 1] call BIS_fnc_blackOut;
    	waitUntil {position _unit isNotEqualTo [0, 0, 0]};
		sleep 1;
		private _eh_id = _unit getVariable "SWAP_EH_INDEX";
		private _type = _corpse getVariable "OLD_TYPE";
		private _group = group _unit;
		private _side = side _unit;
		private _loadout = getUnitLoadout _unit;

		if !(isNil "_eh_id") then {
			_unit removeEventHandler ["Respawn", _eh_id];
			_unit setVariable ["SWAP_EH_INDEX", nil];
		};
		if (isNil "_group") then {
			_group = createGroup (side _unit);
		};
		_new_unit = _group createUnit [_type, position _unit, [], 5, "NONE"];
		_new_unit setVariable ["SPAWNED_AI", true];
		[_unit, _new_unit] call SWAP_WITHOUT_EH;
		[_new_unit] execVM "onPlayerRespawn.sqf";
		sleep 1;
		_new_unit setUnitLoadout (getUnitLoadout _unit);
		["RESPAWN_BLACK_SCREEN", true, 1] call BIS_fnc_blackIn
	};
}];

_new_unit setVariable ["SWAP_EH_INDEX", _eh_index, true];