params ["_caller"];

if !(local _caller) exitWith {
	[_caller] remoteExec ["SG_fnc_redeploy", _caller];
};

setPlayerRespawnTime 0.5;
_caller enableSimulation false;

private _current_volume = soundVolume;
0 fadeSound 0;

forceRespawn _caller;
hideObject _caller;
deleteVehicle _caller;

[_current_volume] spawn {
	params ["_vol"];
	while {!(alive player)} do {
		sleep 0.5;
	};
	0 fadesound _vol;
	setPlayerRespawnTime 20;
};