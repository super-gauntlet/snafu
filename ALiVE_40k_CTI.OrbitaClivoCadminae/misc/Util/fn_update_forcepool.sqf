params ["_player_side"];

private ["_obj_to_owned_map", "_force_coefs", "_objective_to_logi_coef", "_filtered_objs"];

_obj_to_owned_map = [] call ALiVE_fnc_HashCreate;
_force_coefs = [
    3, // Infantry
    2, // Motorized
    1, // Mechanized
    0.5, // Armored
    0, // Artillery
    0, // AAA
    0, // Air
    0 // Sea (temporarily 0 to fix the spawns + fix groups to have a boat that actually makes sense on this map)
];
_objective_to_logi_coef = 0.5;
_filtered_objs = [];


diag_log "[fn_update_forcepool.sqf] updating OPCOMs with new force strength array";
waitUntil {not isNil "ALIVE_globalForcePool"};
waitUntil {(count (ALIVE_globalForcePool select 1)) > 0};
private _player_opcom = (OPCOM_INSTANCES select {([_x, "side"] call ALiVE_fnc_hashGet) isEqualTo (str _player_side)}) select 0;
private _player_objectives = [_player_opcom, "objectives"] call ALiVE_fnc_hashGet;
private _player_obj_owners = _player_objectives apply {[_x, "lastTaken", "none"] call ALiVE_fnc_hashGet};

hint str _player_obj_owners;

for [{_i = 0}, {_i < (count OPCOM_INSTANCES)}, {_i = _i + 1}] do {
    private _opcom = OPCOM_INSTANCES select _i;
    private _factions = ([_opcom, "factions"] call ALiVE_fnc_HashGet) call BIS_fnc_sortAlphabetically;
    private _faction = _factions select 0;
    private _owned_objectives = count (_player_obj_owners select {_x in _factions});
    private _new_forcestrength = [];

    private _cash_to_add = _owned_objectives * 250;
    private _new_cash = (CASH_VAR getVariable ["HG_CASH", 0]) + _cash_to_add;
    CASH_VAR setVariable ["HG_CASH", _new_cash];

    if (_owned_objectives < 9) then {
        _owned_objectives = 9;
    };

    if (_owned_objectives > 24) then {
        _owned_objectives = 24;
    };

    _owned_objectives = _owned_objectives + 1;

    // update logistics pool based on owned objectives
    private _current_forcepool = [ALIVE_globalForcePool, _faction, 0] call ALiVE_fnc_hashGet;
    private _new_forcepool = _current_forcepool + (floor (_objective_to_logi_coef * _owned_objectives));

    if (_new_forcepool > 100) then {
        _new_forcepool = 100;
    };

    [ALIVE_globalForcePool, _faction, _new_forcepool] call ALiVE_fnc_hashSet;

    // update force strength array in line with owned objectives
    {
        _new_forcestrength pushBack (floor (_x * _owned_objectives));
    } forEach _force_coefs;
    [_opcom, "startForceStrength", _new_forcestrength] call ALiVE_fnc_HashSet;
    OPCOM_INSTANCES set [_i, _opcom];
};