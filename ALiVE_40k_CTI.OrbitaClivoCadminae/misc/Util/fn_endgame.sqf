params ["_player_side", "_enemy_sides"];

private _enemy_sides_str = _enemy_sides apply {str _x};

[
    [
        ["ATTN: ", "align = 'center' shadow = '1' size = '1' font='PuristaBold'"], 
        ["All Objectives Taken", "align = 'center' shadow = '1' size = '1'", "#aaaaaa"], 
        ["","<br/>"], // line break 
        ["Enemies being revealed...","align = 'center' shadow = '1' size = '2'"] 
    ],  safeZoneX, safeZoneH / 2
] remoteExec ["BIS_fnc_typeText2", -2];

[_player_side] spawn {
    private _player_side = _this select 0;
    while {[_player_side] call sg_fnc_all_objectives_taken} do {
        [_enemy_sides] remoteExec ["sg_fnc_mark_units", -2];
        sleep 10;
    };
};

sleep 10;

["ALiVE_mil_cqb"] call ALIVE_fnc_pauseModule;

private _timeout = 120;

while {
    private _inactiveEntities = [] call ALIVE_fnc_getInActiveEntitiesForMarking;
    private _all_objectives_taken = [_player_side] call sg_fnc_all_objectives_taken;

    private _enemy_count = count (_inactiveEntities select {(_x select 1) in _enemy_sides_str});
    _enemy_count = _enemy_count + count (allUnits select {side _x in _enemy_sides});
    _timeout = _timeout - 1;

    ((_timeout > 0) && (_enemy_count > 0)) || !_all_objectives_taken
} do {
    sleep 5;
};

private _all_objectives_taken = [_player_side] call sg_fnc_all_objectives_taken;

if !(_all_objectives_taken) exitWith {
    [
        [
            ["ATTN: ", "align = 'center' shadow = '1' size = '1' font='PuristaBold'"], 
            ["Enemies have taken an objective", "align = 'center' shadow = '1' size = '1'", "#aaaaaa"], 
            ["","<br/>"], // line break 
            ["Enemies no longer revealed...","align = 'center' shadow = '1' size = '2'"] 
        ],  safeZoneX, safeZoneH / 2
    ] remoteExec ["BIS_fnc_typeText2", -2];

    [_player_side, _enemy_sides] spawn {
        params ["_player_side", "_enemy_sides"];
        while {true} do {
            sleep 60;
            private _all_objectives_taken = [_player_side] call sg_fnc_all_objectives_taken;

            if (_all_objectives_taken) exitWith {
                ["ALiVE_mil_cqb"] call ALIVE_fnc_unPauseModule;
                [_player_side, _enemy_sides] spawn sg_fnc_endgame;
            };
        };
    };
};

[ 
    [ 
        ["Mission Accomplished!", "align = 'center' shadow = '1' size = '1' font='PuristaBold'"], 
        ["","<br/>"], // line break 
        ["All enemies eliminated...","align = 'center' shadow = '1' size = '2'"] 
    ],  safeZoneX, safeZoneH / 2
] remoteExec ["BIS_fnc_typeText2", -2];

sleep 10;

["end1", true, true, true, true] remoteExec ["BIS_fnc_endMission", 0];