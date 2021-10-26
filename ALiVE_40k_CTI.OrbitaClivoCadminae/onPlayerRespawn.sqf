_newUnit = _this select 0;

if (hasInterface && local _newUnit) then {
    // spawn client side functions
//    _newUnit spawn sg_fnc_real_camosystem;

    // Allow everyone to be a medic, engineer, and defuse explosives
    _newUnit setUnitTrait ["Medic", true];
    _newUnit setUnitTrait ["Engineer", true];
    _newUnit setUnitTrait ["ExplosiveSpecialist", true];
    if (_newUnit == z1) then {
        _newUnit setUnitRank "CORPORAL";
    };

    if (rank _newUnit == "CORPORAL") then {
        _newUnit addWeapon "LaserDesignator";
    };

	private _markers = nil;
	while {
		_markers = missionNamespace getVariable "SG_obj_markers";
		isNil "_markers"
	} do {
		sleep 1;
	};

	[_newUnit, _markers] spawn SG_fnc_player_in_cluster;
    [_newUnit, nil] call rev_addReviveToUnit;
    (group _newUnit) setVariable ["ALIVE_profileIgnore", true, true];

    uiNamespace setVariable ["in_obj", nil];
    uiNamespace setVariable ["capture_bar", nil];
};