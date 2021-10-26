// runs on the server. pass in the player + the marker
params ["_player", "_marker"];

private _pos3d = getMarkerPos _marker;
private _pos = [_pos3d select 0, _pos3d select 1];
private _radius = (getMarkerSize _marker) select 0;
private _side_player = (faction _player) call ALiVE_fnc_factionSide;

// Get nearest objective
_opcom = ([str _side_player] call SpyderAddons_fnc_getOpcoms) select 0;
_objectives = [_opcom,"objectives"] call ALiVE_fnc_hashGet;
_objectives = [_objectives,[getPos _player],{_Input0 distance2D ([_x, "center"] call ALiVE_fnc_HashGet)},"ASCEND"] call BIS_fnc_sortBy;
_objective = _objectives select 0;

private _dominant_faction = [_objective, "lastTaken"] call ALiVE_fnc_hashGet;
private _side_dominant = sideEmpty;
if !(isNil "_dominant_faction") then {
	_side_dominant = _dominant_faction call ALiVE_fnc_factionSide;
};

// if the player is in the marker area + there are enemies there, wait until they're cleared
while {(alive _player) and (_player inArea _marker) and !(_side_dominant == _side_player)} do {
	_dominant_faction = [_objective, "lastTaken"] call ALiVE_fnc_hashGet;
	_side_dominant = sideEmpty;
	if !(isNil "_dominant_faction") then {
		_side_dominant = _dominant_faction call ALiVE_fnc_factionSide;
	};

	sleep 1;
};


if (!(alive _player) or !(_player inArea _marker)) exitWith {};
// player has to be alive, in the marker area, and the dominant faction has to be either the player faction or nil

[_player, _marker] remoteExec ["sg_fnc_cluster_add_action_client", owner _player];