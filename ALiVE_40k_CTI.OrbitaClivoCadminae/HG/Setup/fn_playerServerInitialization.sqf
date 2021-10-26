#define ADMINS getArray(getMissionConfig "CfgClient" >> "admins")
#define WHITELIST getNumber(getMissionConfig "CfgClient" >> "enableWhitelist") isEqualTo 1
#define WHITELIST_SIDES getArray(getMissionConfig "CfgClient" >> "whitelistSides")
/*
    Author - HoverGuy
    © All Fucks Reserved
    Website - http://www.sunrise-production.com
*/
params["_player","_uid","_result","_cash","_bank"];

_uid = getPlayerUID _player;

HG_SAVING_EXTDB = false;

if(WHITELIST) then
{
    if(!(_uid in ADMINS)) then
    {
	    private "_isWhitelisted";
		
		if(!(toLower(str(side _player)) in WHITELIST_SIDES)) exitWith {_isWhitelisted = true;};
		
		private _whitelist = HG_WHITELIST select (WHITELIST_SIDES find toLower(str(side _player)));
		_isWhitelisted = _uid in _whitelist;
	
	    if(!_isWhitelisted) exitWith 
	    {
	        ["NotWhitelisted",false,false,false,true] remoteExecCall ["BIS_fnc_endMission",(owner _player),false];
	    };
    } else {
	    if(isNil "HG_ADMINS") then {HG_ADMINS = [];};
		HG_ADMINS pushBack _player;
		(owner _player) publicVariableClient "HG_WHITELIST";
	};
};

// CASH_VAR setVariable [getText(getMissionConfig "CfgClient" >> "cashVariable"),_cash,true];
// CASH_VAR setVariable [getText(getMissionConfig "CfgClient" >> "bankVariable"),_bank,true];

if((getNumber(getMissionConfig "CfgClient" >> "enableXP")) isEqualTo 1) then
{
    private "_xp";
	
    if(HG_SAVING_EXTDB) then
	{
	    _xp = _result select 2;
	} else {
	    _xp = profileNamespace getVariable format["HG_XP_%1",_uid];
		
		if(isNil "_xp") then
	    {
		    _xp = [(rank _player),0];
	        profileNamespace setVariable [format["HG_XP_%1",_uid],_xp];
		    saveProfileNamespace;
	    }
	};
	
	_player setUnitRank (_xp select 0);
	_player setVariable ["HG_XP",_xp,true];
};

if((getNumber(getMissionConfig "CfgClient" >> "enableKillCount")) isEqualTo 1) then
{
    private "_kc";
	
    if(HG_SAVING_EXTDB) then
	{
	    _kc = _result select 3;
	} else {
	    _kc = profileNamespace getVariable "HG_Kills";
		
		if(isNil "_kc") then
	    {
		    _kc = 0;
	        profileNamespace setVariable ["HG_Kills", _kc];
		    saveProfileNamespace;
	    };
	};
	
	// CASH_VAR setVariable ["HG_Kills",_kc,true];
};

if((getNumber(getMissionConfig "CfgClient" >> "enablePlayerInventorySave")) isEqualTo 1) then
{
    private "_gear";
	
    if(HG_SAVING_EXTDB) then
	{
	    _gear = _result select 4;
	} else {
	    _gear = profileNamespace getVariable format["HG_Gear_%1",_uid];
		
		if(isNil "_gear") then
		{
		    _gear = getUnitLoadout _player;
		    profileNamespace setVariable [format["HG_Gear_%1",_uid],_gear];
            saveProfileNamespace;
		};
	};

	[_gear] remoteExecCall ["HG_fnc_parseGear",(owner _player),false];
};

if(!HG_SAVING_EXTDB) then
{
    if(isNil {profileNamespace getVariable ["HG_Garage",[]]}) then
    {
        profileNamespace setVariable["HG_Garage",[]];
	    saveProfileNamespace;
    };
};

/*
    Init HUD (if applicable)
*/
if((getNumber(getMissionConfig "CfgClient" >> "enableHUD")) isEqualTo 1) then
{
    [0] remoteExecCall ["HG_fnc_HUD",(owner _player),false];
};
