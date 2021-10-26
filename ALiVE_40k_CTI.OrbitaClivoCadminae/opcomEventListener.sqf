params ["_logic","_operation","_args"];

private "_result";

switch (_operation) do {
    case "create": {
        _args params ["_functionName", "_playerside"];
        
        private _logic = [
            [
                ["class", _functionName]
            ]
        ] call ALiVE_fnc_hashCreate;
    
        private _listenerID = [ALiVE_eventLog, "addListener", [_logic, ["TACOM_ORDER_ISSUED"]]] call ALiVE_fnc_eventLog;
        
        [_logic, "listenerID", _listenerID] call ALiVE_fnc_hashSet;
        [_logic, "playerSide", _playerside] call ALiVE_fnc_hashSet;
        
        _result = _logic;
    };
    
    case "handleEvent": {
        private _event = _args;
        
        private _class = [_logic,"class"] call ALiVE_fnc_hashGet;
        private _thisFunction = missionNamespace getvariable _class;
        private _playerside = [_logic, "playerSide"] call ALiVE_fnc_hashGet;
        
        private _type = [_event,"type"] call ALiVE_fnc_hashGet;
        private _eventData = [_event,"data"] call ALiVE_fnc_hashGet;

        switch (_type) do {
            case "TACOM_ORDER_ISSUED": {
                _eventData params ["_opcomID","_target","_operation","_side","_factions","_success","_orderArguments"];
                if (_side == str _playerside && _operation in ["capture", "recon"]) then {
                    [_playerside, _target] spawn {
                        params ["_side", "_objective"];

                        private _obj_id = [_objective, "objectiveID"] call ALiVE_fnc_hashGet;
                        private _marker_name = format ["marker_%1", _obj_id];
                        private _pos = [_objective, "center"] call ALiVE_fnc_hashGet;
                        private _size = [_objective, "size"] call ALiVE_fnc_hashGet;
                        private _players = (call BIS_fnc_listPlayers) select {(alive _x) && (side _x == _side)};
                        private _player_uids = _players apply {getPlayerUID _x};


                        [
                            _side,
                            _obj_id,
                            ["Clear the objective of enemies.", "Attack Objective", _marker_name],
                            _pos,
                            "CREATED",
                            1,
                            true,
                            "",
                            true
                        ] call BIS_fnc_taskCreate;

                        while {
                            private	_owner = [_objective, "lastTaken"] call ALiVE_fnc_hashGet;
                            private _obj_side = sideEmpty;

                            if (isNil "_owner") then {
                            	_obj_side = sideEmpty;
                            } else {
                            	_obj_side = _owner call ALiVE_fnc_factionSide;
                            };
                            _obj_side != _side
                        } do {
                            sleep 5;
                        };

                        [_obj_id, "SUCCEEDED", true] call BIS_fnc_taskSetState;

                    };
                };
            };
        };
    };
};

if (!isnil "_result") then {_result} else {nil};