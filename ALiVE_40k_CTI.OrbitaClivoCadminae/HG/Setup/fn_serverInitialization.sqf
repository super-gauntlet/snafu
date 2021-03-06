/*
    Author - HoverGuy
    © All Fucks Reserved
    Website - http://www.sunrise-production.com
*/

HG_SAVING_EXTDB = false;


_var_name = "HG_CASH";
_cash = profileNamespace getVariable [_var_name, 1000];
CASH_VAR setVariable [_var_name, _cash, true];
[] spawn {
	while {true} do {
		sleep 60;
		_cash = CASH_VAR getVariable "HG_CASH";
		profileNamespace setVariable ["HG_CASH", _cash];
		saveProfileNamespace;
	};
};

private "_compile";

{
    _compile = compileFinal preprocessFileLineNumbers (_x select 1);
    missionNamespace setVariable[(_x select 0),_compile];
} forEach 
[
	["HG_fnc_activeReset","HG\Functions\Server\fn_activeReset.sqf"],
	["HG_fnc_cleanup","HG\Functions\Server\fn_cleanup.sqf"],
	["HG_fnc_clientToServer","HG\Functions\Server\fn_clientToServer.sqf"],
	["HG_fnc_deleteVehicle","HG\Functions\Server\fn_deleteVehicle.sqf"],
	["HG_fnc_disconnect","HG\Functions\Server\fn_disconnect.sqf"],
	["HG_fnc_findIndex","HG\Functions\Server\fn_findIndex.sqf"],
	["HG_fnc_getGear","HG\Functions\Server\fn_getGear.sqf"],
	["HG_fnc_getInventory","HG\Functions\Server\fn_getInventory.sqf"],
	["HG_fnc_getType","HG\Functions\Server\fn_getType.sqf"],
	["HG_fnc_getWhitelist","HG\Functions\Server\fn_getWhitelist.sqf"],
	["HG_fnc_lock","HG\Functions\Server\fn_lock.sqf"],
	["HG_fnc_requestGarage","HG\Functions\Server\fn_requestGarage.sqf"],
	["HG_fnc_resetGarages","HG\Functions\Server\fn_resetGarages.sqf"],
	["HG_fnc_resetMoney","HG\Functions\Server\fn_resetMoney.sqf"],
	["HG_fnc_setInventory","HG\Functions\Server\fn_setInventory.sqf"],
	["HG_fnc_spawnVehicle","HG\Functions\Server\fn_spawnVehicle.sqf"],
	["HG_fnc_storeVehicleServer","HG\Functions\Server\fn_storeVehicleServer.sqf"],
	["HG_fnc_updateWhitelist","HG\Functions\Server\fn_updateWhitelist.sqf"]
];

if(((getNumber(getMissionConfig "CfgClient" >> "storeVehiclesOnDisconnect")) isEqualTo 1) OR (getNumber(getMissionConfig "CfgClient" >> "deleteBodyOnDisconnect") isEqualTo 1) OR (getNumber(getMissionConfig "CfgClient" >> "enableWhitelist") isEqualTo 1)) then
{
    addMissionEventHandler ["HandleDisconnect",{_this call HG_fnc_disconnect; false;}];
};

if((getNumber(getMissionConfig "CfgClient" >> "resetGaragesOnServerStart")) isEqualTo 1) then
{
    [] call HG_fnc_resetGarages;
} else {
    [] call HG_fnc_activeReset;
};

if((getNumber(getMissionConfig "CfgClient" >> "resetSavedMoney")) isEqualTo 1) then
{
    [] call HG_fnc_resetMoney;
};

if((getNumber(getMissionConfig "CfgClient" >> "enableWhitelist")) isEqualTo 1 AND HG_SAVING_EXTDB) then
{
    [] call HG_fnc_getWhitelist;
};

"HG_CLIENT" addPublicVariableEventHandler {[(_this select 1)] call HG_fnc_clientToServer;};

HG_CLEANUP_THREAD = [] spawn HG_fnc_cleanup;
