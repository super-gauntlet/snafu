params ["_opcom", "_position"];

_objectives = [_opcom,"objectives"] call ALiVE_fnc_hashGet;
_objectives = [_objectives,[_position],{_Input0 distance2D ([_x, "center"] call ALiVE_fnc_HashGet)},"ASCEND"] call BIS_fnc_sortBy;
_objectives select 0