params ["_objective"];
private ["_pos","_radius","_fac","_facs","_profiles","_result","_noCiv","_ret"];

_noCiv = true;

_pos = [_objective, "center"] call ALiVE_fnc_hashGet;
_radius = [_objective, "size"] call ALiVE_fnc_hashGet;

if !(isnil "ALIVE_profileHandler") then {
    _profiles = [ALIVE_profileHandler, "profiles"] call ALIVE_fnc_hashGet;
} else {
    _profiles = [[],[],[]];
};

_facs = [];
{
    if (((_x select 2 select 5) == "entity") && {!(_x select 2 select 1)} && {!(_x select 2 select 30)} && {(_x select 2 select 2) distance _pos < _radius}) then {
        _facs pushback (_x select 2 select 29);
    };
} foreach (_profiles select 2);

{
    if ((_pos distance (getposATL (leader _x)) < _radius) && (!isPlayer (leader _x))) then {
        _facs pushback (faction(leader _x));
    };
} foreach allGroups;

{
    private _player = _x;
    if (_pos distance (getPosATL _player) < _radius) then {
        _facs pushback (faction _player);
    }
} forEach allPlayers;

_result = [];
{
    private ["_fac","_cnt"];
    if (count _facs == 0) exitwith {};

    _fac = _x;
    _cnt = {_fac == _x} count _facs;

    if (_cnt > 0) then {
        _result pushback [_fac,_cnt];
        _facs = _facs - [_fac];
    };
} foreach _facs;

_result = [_result,[],{_x select 1},"DESCEND",{if (_noCiv) then {!(((_x select 0) call ALiVE_fnc_factionSide) == CIVILIAN)} else {true}}] call ALiVE_fnc_SortBy;

_ret = nil;

if ((count _result == 1) && {(_result select 0 select 1) > 0}) then {
    (_result select 0) select 0;
} else {
	if (count _result == 0) then {
		[_objective, "lastTaken"] call ALiVE_fnc_hashGet;
	} else {
		nil
	};
};