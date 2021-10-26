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
    
        private _listenerID = [ALiVE_eventLog, "addListener", [_logic, ["LOGISTICS_DESTINATION"]]] call ALiVE_fnc_eventLog;
        private _eventsInProgress = [] call ALiVE_fnc_hashCreate;
        [_logic, "eventsInProgress", _eventsInProgress] call ALiVE_fnc_hashSet;
        
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
        
        private _forceStatus = "high";
		private _currentPercent = 100;
		private _currentPercentformatted = 100;
		private _factionmaxforcePool = 25;
		private _factionformatted = "PAVN";
				
        switch (_type) do {
		    case "LOGISTICS_DESTINATION": {
		        private["_eventID","_eventData","_position","_side","_faction","_logEventID","_logcom","_event_queue","_event","_profiles","_eventsInProgress","_logisticsEvent","_destination"];

		        _eventID = [_args, "id"] call ALiVE_fnc_hashGet;
		        _eventData = [_args, "data"] call ALiVE_fnc_hashGet;

		        _position = _eventData select 0;
		        _faction = _eventData select 1;
		        _side = _eventData select 2;
		        _logEventID = _eventData select 3;

		        _logcom = entities "Module_F" select {((_x getVariable "moduleType") == "ALIVE_ML") && (([_x, "side"] call ALiVE_fnc_ML) == _side)} select 0;
		        _event_queue = [_logcom, "eventQueue"] call ALiVE_fnc_ML;
		        while {
		        	_event = [_event_queue, _logEventID] call ALiVE_fnc_hashGet;
		        	isNil "_event"
		        } do {
		        	sleep 1;
		        };
		        while {
		        	_profiles = [_event, "transportProfiles", []] call ALiVE_fnc_hashGet;
		        	(count _profiles) == 0
		        } do {
		        	sleep 1;
		        };

		        _destination = [_event, "finalDestination"] call ALiVE_fnc_hashGet;

		        if !(_side isEqualTo str _playerside) then {
			        [_profiles, _destination, _playerside] spawn sg_fnc_convoy_intercept_task;
		        };
		    };
        };
    };
};

if (!isnil "_result") then {_result} else {nil};