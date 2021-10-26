params ["_player_side"];

private _opcom = OPCOM_INSTANCES select {([_x, "side"] call ALiVE_fnc_hashGet) == str _player_side} select 0;
private _objectives = [_opcom, "objectives"] call ALiVE_fnc_hashGet;
private _factions = [_opcom, "factions"] call ALiVE_fnc_hashGet;
private _all_objectives_taken = true;
{
    private _objective = _x;
    private _owner = [_objective] call SG_fnc_get_objective_owner;
    if (isNil "_owner") then {
    	_owner = [_objective, "lastTaken"] call ALiVE_fnc_hashGet;
    };
    private _dominant_side = sideEmpty;
    if !(isNil "_owner") then {
        _dominant_side = _owner call ALiVE_fnc_factionSide;
    };
    if (_dominant_side != _player_side) then {
        _all_objectives_taken = false;
    };
} forEach _objectives;

_all_objectives_taken