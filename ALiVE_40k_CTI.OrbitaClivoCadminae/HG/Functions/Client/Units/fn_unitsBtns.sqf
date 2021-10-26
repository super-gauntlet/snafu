#include "HG_Macros.h"
/*
    Author - HoverGuy
    © All Fucks Reserved
    Website - http://www.sunrise-production.com
*/
private["_class","_price","_u","_rank","_sp","_unit"];

disableSerialization;

_class = HG_UNITS_UNIT_SWITCH lbData (lbCurSel HG_UNITS_UNIT_SWITCH);
_price = HG_UNITS_UNIT_SWITCH lbValue (lbCurSel HG_UNITS_UNIT_SWITCH);
_u = getText(getMissionConfig "CfgClient" >> "HG_UnitsShopCfg" >> HG_STRING_HANDLER >> _class >> "unit");
_rank = getText(getMissionConfig "CfgClient" >> "HG_UnitsShopCfg" >> HG_STRING_HANDLER >> _class >> "rank");
_sp = getText(getMissionConfig "CfgClient" >> "HG_UnitsShopCfg" >> HG_STRING_HANDLER >> "spawnPosition");

_unit_pos = position player;

_unit = (group player) createUnit [_u, _unit_pos, [], 5, "NONE"];
if (isClass (getMissionConfig "CfgClient" >> "HG_UnitsShopCfg" >> HG_STRING_HANDLER >> _class >> "Loadout")) then {
	_unit setUnitLoadout (configFile >> "EmptyLoadout");
	_unit setUnitLoadout (getMissionConfig "CfgClient" >> "HG_UnitsShopCfg" >> HG_STRING_HANDLER >> _class >> "Loadout");
};
_unit setUnitRank _rank;
_unit setVariable ["SPAWNED_AI", true, true];
[_unit, nil] call rev_addReviveToUnit;


hint format[(localize "STR_HG_UNIT_BOUGHT"),getText(getMissionConfig "CfgClient" >> "HG_UnitsShopCfg" >> HG_STRING_HANDLER >> _class >> "displayName"),if(_price <= 0) then {(localize "STR_HG_DLG_FREE")} else {([_price,true] call HG_fnc_currencyToText)}];

[] call HG_fnc_unitsRefresh;

true;
