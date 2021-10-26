params ["_entity"];

if ((local _entity) && (_entity isKindOf "Air")) then {
	(group _entity) setVariable ["Vcm_Disable", true, true];
};

_PLAYER_SIDE = missionNamespace getVariable "_PLAYER_SIDE";

[_entity, _PLAYER_SIDE] spawn {
	params ["_entity", "_PLAYER_SIDE"];

	waitUntil {!isNil "rev_addReviveToUnit"};
	_side = side _entity;
	if (_side == sideUnknown) then {
		_side = side group _entity;
	};
	if (_side == civilian && _entity isKindOf "CAManBase") then {
	    _entity addAction [
        	"<t color='#33FF42'>Try to steal clothes from this unit</t>", {
        		params ["_giver","_reciever"];
        		private ["_gwh","_reciverUniform","_giverUniform","_droppedRecUni"];

        		if (40 > random 100) then {
    				_gwh = createVehicle ["GroundWeaponHolder", getPosATL _reciever, [], 0, "CAN_COLLIDE"];
    				_reciverUniform = uniform _reciever;
    				_giverUniform = uniform _giver;
    				_gwh addItemCargoGlobal [_reciverUniform, 1];
    				_droppedRecUni = (((everyContainer _gwh) select 0) select 1);
    				{_droppedRecUni addItemCargoGlobal [_x, 1];} forEach (uniformItems _reciever);
    				{_droppedRecUni addItemCargoGlobal [_x, 1];} forEach (uniformItems _giver);
    				removeUniform _reciever;
    				removeUniform _giver;
    				_reciever forceAddUniform _giverUniform;

                    // remoteexec this
                    [position _reciever, [str side _reciever], 3 + floor random 3] call ALiVE_fnc_updateSectorHostility;
                    
    				if (20 > (random (rating _reciever / 10))) then {_reciever call INCON_ucr_fnc_compromised};

    				private _civComment = selectRandom ["That's a real dick move.","Fuck you.","I hope you get caught!","You're a horrible human!","What are you playing at?","You've lost my support.","I'll take one for the cause now but not again."];
    				[[_giver, _civComment] remoteExec ["globalChat",0]];
    			} else {
    				[[_giver,"runAway"] remoteExecCall ["INCON_ucr_fnc_ucrMain",_giver]];
    				if (rating _reciever > 800) then {_reciever addrating -800};
    				if (30 > (random (rating _reciever / 10))) then {_reciever call INCON_ucr_fnc_compromised};
    				private _civComment = selectRandom ["You can fuck off.","What am I going to wear?","Creep!","Go away!","Is this how you treat your women?","Sounds like a dirty ruse.","So now the truth comes out.","This is my favourite shirt.","You'd like that wouldn't you?"];
    				[[_giver, _civComment] remoteExec ["globalChat",0]];
        		};

        		_giver setVariable ["INC_alreadyTried",true];

        		},[],6,true,true,"","((_this getVariable ['isUndercover',false]) && {!(_target getVariable ['INC_alreadyTried',false])} && {alive _target} && {uniform _target != ''} && {(currentWeapon _this != '') && {(currentWeapon _this == primaryWeapon _this) || {currentWeapon _this == handgunWeapon _this}}})",4
        ];
	};
};

if (!isServer) exitWith {};

_entity setVariable ["SIDE", (side _entity)];

_entity addMPEventHandler ["MPKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];

	if (!isServer) exitWith {};
	diag_log format ["[killed_eh] unit: %1, killer: %2, instigator: %3", _unit, _killer, _instigator];
	_PLAYER_SIDE = missionNamespace getVariable "_PLAYER_SIDE";
	if (not isNull _instigator) then {
		_killer = _instigator;
	};
	if (_unit == _killer) exitWith {};

	_side_unit = _unit getVariable "SIDE";
	_side_killer = _killer getVariable "SIDE";
	_side_instigator = _instigator getVariable "SIDE";
	diag_log format ["[killed_eh] unit side: %1, killer side: %2, instigator side: %3", _side_unit, _side_killer, _side_instigator];
	if (_side_unit == civilian) then {
		[position _unit, [str _PLAYER_SIDE], 10] call ALiVE_fnc_updateSectorHostility;
	};
	if (_side_killer == _PLAYER_SIDE) then {
		if ((_side_unit == _PLAYER_SIDE) || (_side_unit == civilian)) then {
			// TK penalty
			if (!(_unit isKindOf "CAManBase")) exitWith {};
			_cash = CASH_VAR getVariable ["HG_CASH", 0];
			_cash = _cash - 100;
			if (_cash < 0) then {
				_cash = 0;
			};
			if (isPlayer _killer) then {
				CASH_VAR setVariable ["HG_CASH", _cash, true];
			};
		} else {
			// Kill reward
			_reward = 0;
			if (_unit isKindOf "CAManBase") then {
				// reward for killing a man
				_reward = 100;
			};
			if (_unit isKindOf "LandVehicle") then {
				// reward for destroying a car
				_reward = 1000;
			};
			if (_unit isKindOf "Air") then {
				// reward for destroying a chopper
				_reward = 5000;
			};
			if (_unit isKindOf "Ship") then {
				// reward for destroying a boat
				_reward = 2000;
			};
			if (isPlayer _killer) then {
				_cash = CASH_VAR getVariable ["HG_CASH", 0];
				_cash = _cash + _reward;
				CASH_VAR setVariable ["HG_CASH", _cash, true];
			};
		};
	};
}];