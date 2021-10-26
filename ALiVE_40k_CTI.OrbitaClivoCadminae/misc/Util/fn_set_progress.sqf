params ["_progress", "_position", "_distance"];

disableSerialization;

private _bar = uiNamespace getVariable "capture_bar";
if (isNil "_bar") then {
	disableSerialization;
	_bar = findDisplay 46 ctrlCreate ["RscProgress", -1];
	uiNamespace setVariable ["capture_bar", _bar];
	_bar ctrlSetPosition [safeZoneX, safezoneY + safezoneH * 0.02, safezoneW, safezoneH * 0.01];
	_bar ctrlCommit 0;
	_bar progressSetPosition 0.0;
};

_bar progressSetPosition _progress;

private _waiting_on_obj_leave = uiNamespace getVariable ["in_obj", false];
if !(_waiting_on_obj_leave) then {
	[_position, _distance, _bar] spawn {
		params ["_position", "_distance", "_bar"];

		disableSerialization;
		uiNamespace setVariable ["in_obj", true];
		while {((position player) distance _position) < _distance} do {
			sleep 1;
		};
		_bar progressSetPosition 0.0;
		uiNamespace setVariable ["in_obj", false];
	};
};