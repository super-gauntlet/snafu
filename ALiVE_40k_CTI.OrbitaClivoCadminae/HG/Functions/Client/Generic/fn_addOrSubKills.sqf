/*
    Author - HoverGuy
    © All Fucks Reserved
    Website - http://www.sunrise-production.com
*/
params[["_mode",0,[0]],["_amount",1,[0]],"_oldVal","_newVal"];

_oldVal = CASH_VAR getVariable "HG_Kills";
_newVal = if(_mode isEqualTo 0) then {(_oldVal + _amount)} else {(_oldVal - _amount)};
if(_newVal < 0) then {_newVal = 0};

HG_CLIENT = [1,(getPlayerUID player),_newVal];
if(isServer) then
{
	[HG_CLIENT] call HG_fnc_clientToServer;
} else {
    publicVariableServer "HG_CLIENT";
};
HG_CLIENT = nil;
CASH_VAR setVariable ["HG_Kills",_newVal,true];

if(HG_HUD_ENABLED) then
{
    if(HG_HUD_TOGGLED) then
	{
	    [4] call HG_fnc_HUD;
	};
};

true;
