params ["_opcom"];

private _NATO_ALPHABET = [
	"ALPHA",
	"BRAVO",
	"CHARLIE",
	"DELTA",
	"ECHO",
	"FOXTROT",
	"GOLF",
	"HOTEL",
	"INDIA",
	"JULIETT",
	"KILO",
	"LIMA",
	"MIKE",
	"NOVEMBER",
	"OSCAR",
	"PAPA",
	"QUEBEC",
	"ROMEO",
	"SIERRA",
	"TANGO",
	"UNIFORM",
	"VICTOR",
	"WHISKEY",
	"XRAY",
	"YANKEE",
	"ZULU"
];

// I know this is a silly way of doing this, but this already supports 234 objectives which is like 2x what you'll ever need in alive
_LOOP_INDEX_NAME = [
	"ONE",
	"TWO",
	"THREE",
	"FOUR",
	"FIVE",
	"SIX",
	"SEVEN",
	"EIGHT",
	"NINE"
];

private _objectives = [_opcom, "objectives"] call ALiVE_fnc_hashGet;
private _obj_markers = [];
{
	private _objective = _x;
	private _name = format ["marker_%1", [_objective, "objectiveID"] call ALiVE_fnc_hashGet];
	private _position = [_objective, "center"] call ALiVE_fnc_hashGet;
	private _size = [_objective, "size"] call ALiVE_fnc_hashGet;
	createMarkerLocal [_name, _position];
	_name setMarkerShapeLocal "ELLIPSE";
	_name setMarkerAlphaLocal 0.25;
	_name setMarkerSize [_size, _size];
	_name setMarkerText _name;
	private _overlaps = _obj_markers select {([_x, _name] call BIS_fnc_inTrigger) || ([_name, _x] call BIS_fnc_inTrigger)};
	if ((count _overlaps) == 0) then {
		_obj_markers pushBack _name;
		[_objective, "marker", _name] call ALiVE_fnc_hashSet;
	} else {
		deleteMarker _name;
	};
} forEach _objectives;
private _module = [_opcom, "module"] call ALiVE_fnc_hashGet;
private _sorted_markers = [_obj_markers, [], {(position _module) distance2D (getMarkerPos _x)}, "ASCEND"] call BIS_fnc_sortBy;

private _index = 0;
private _loop = 0;
{
	private _objective = _x;
	private _marker = [_objective, "marker"] call ALiVE_fnc_hashGet;
	private _pos_marker = getMarkerPos _marker;
	private _pos = [_pos_marker select 0, (_pos_marker select 1) + 20, 0];
	private _name_marker = format ["%1_name", _marker];
	private _name_marker_letter = "";
	if ((count _sorted_markers) < 26) then {
		_name_marker_letter = _NATO_ALPHABET select _index;
	} else {
		_name_marker_letter = format ["%1 %2", _NATO_ALPHABET select _index, _LOOP_INDEX_NAME select _loop];
	};
	[_objective, "letter", _name_marker_letter] call ALiVE_fnc_hashSet;
	_index = _index + 1;
	if (_index >= (count _NATO_ALPHABET)) then {
		_index = 0;
		_loop = _loop + 1;
	};
	private _new_marker_str = format ["|%1|%2|EmptyIcon|ICON|[1,1]|0|Solid|ColorWhite|1|%3", _name_marker, _pos, _name_marker_letter];
	_new_marker_str call BIS_fnc_stringToMarker;
	_new_marker_str setMarkerShadow true;
} forEach _objectives;

_sorted_markers