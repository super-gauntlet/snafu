params ["_side"];

private _side_str = str _side;

while {true} do { 
	private _opcom = OPCOM_INSTANCES select {([_x, "side"] call ALiVE_fnc_hashGet) == _side_str} select 0;
	private _objectives = [_opcom, "objectives"] call ALiVE_fnc_hashGet;
	private _filtered_objs = _objectives select {
		([_x, "opcom_state", "none"] call alive_fnc_hashget) in ["attack", "attacking"]
	};
	private _sorted_objs = [_filtered_objs,[],{ 
	  (([_x, "center"] call ALiVE_fnc_hashGet) distance ([_opcom, "module"] call ALiVE_fnc_hashGet)) -  
	  (([_x, "priority"] call ALiVE_fnc_hashGet) + ([_x, "size"] call ALiVE_fnc_hashGet)) 
	},"ASCEND"] call BIS_fnc_sortBy;
	private _obj_to_attack = _sorted_objs select 0;
	private _obj_id = [_obj_to_attack, "objectiveID"] call ALiVE_fnc_hashGet;
	private _marker_name = format ["marker_%1", _obj_id];
	private _pos = [_obj_to_attack, "center"] call ALiVE_fnc_hashGet;
	private _size = [_obj_to_attack, "size"] call ALiVE_fnc_hashGet;
	private _players = (call BIS_fnc_listPlayers) select {(alive _x) && (side _x == _side)};
	private _player_uids = _players apply {getPlayerUID _x};

	[_side, _obj_id, ["Clear the objective of enemies.", "Attack Objective", _marker_name], _pos, "CREATED", 1, true, "", true] call BIS_fnc_taskCreate;

	while {
		_areaClear = [_pos, _players, _side_str, _size] call ALiVE_fnc_taskIsAreaClearOfEnemies;
		!_areaClear
	} do {
		sleep 5;
	};

	[_obj_id, "SUCCEEDED", true] call BIS_fnc_taskSetState;
};