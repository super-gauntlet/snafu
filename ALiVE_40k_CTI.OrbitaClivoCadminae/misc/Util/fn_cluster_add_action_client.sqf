// runs on the client. player and marker should be passed in.
params ["_player", "_marker"];
private ["_unit_action", "_vehicle_action", "_fortify_action", "_heal_action", "_redeploy_action", "_pylon_action"];

// add actions here
_unit_action = _player addAction [
	"Recruit Units",
	{_this call HG_fnc_dialogOnLoadUnits},
	"HG_DefaultShop",
	0,
	false,
	false,
	"",
	'(alive player) && !dialog && player distance _target < 5'
];
_vehicle_action = _player addAction [
	"Spawn Vehicles",
	{_this call HG_fnc_dialogOnLoadVehicles},
	"HG_DefaultShop",
	0,
	false,
	false,
	"",
	'(alive player) && !dialog && player distance _target < 5'
];
_fortify_action = _player addAction [
	"Spawn Fortifications",
	{_this call HG_fnc_dialogOnLoadVehicles},
	"HG_FortificationShop",
	0,
	false,
	false,
	"",
	'(alive player) && !dialog && player distance _target < 5'
];
_heal_action = _player addAction [
	"Heal Units",
	{
		[_this select 1] call SG_fnc_heal;
	},
	"",
	0,
	false,
	false,
	"",
	"(alive player) && !dialog"
];
_redeploy_action = _player addAction [
	"Redeploy",
	{
		[_this select 1] call SG_fnc_redeploy;
	},
	"",
	0,
	false,
	false,
	"",
	"(alive player) && !dialog"
];
_pylon_action = _player addAction [
	"Edit Aircraft Loadouts",
	{
		[_this select 1] spawn GOM_fnc_aircraftloadout;
	},
	"",
	0,
	false,
	false,
	"",
	"(alive player) && !dialog"
];
_swap_action = _player addAction [
	"Swap into AI Unit",
	{
		[_this select 0, cursorObject] call SG_fnc_switch_unit;
	},
	"",
	10,
	false,
	false,
	"",
	"(alive player) && !dialog && (cursorObject getVariable ['SPAWNED_AI', false])"
];

// change opacity
_marker setMarkerAlphaLocal 0.5;

// wait until the player is dead or not in the marker anymore
while {(alive _player) and (_player inArea _marker)} do {
	sleep 1;
};

// delete actions here
_marker setMarkerAlphaLocal 0.25;
_player removeAction _unit_action;
_player removeAction _vehicle_action;
_player removeAction _fortify_action;
_player removeAction _heal_action;
_player removeAction _redeploy_action;
_player removeAction _pylon_action;
_player removeAction _swap_action;