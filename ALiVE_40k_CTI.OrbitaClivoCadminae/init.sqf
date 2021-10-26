waitUntil {!isNil "ALIVE_fnc_vehicleGetKindOf"};
waitUntil {!isNil "SG_fnc_vehicle_get_kind_of"};
ORIG_ALIVE_fnc_vehicleGetKindOf = ALIVE_fnc_vehicleGetKindOf;
ALIVE_fnc_vehicleGetKindOf = SG_fnc_vehicle_get_kind_of;

// Set up for revive system
reviveTime = 10;
bleedTime = 300;

publicVariable "reviveTime";
publicVariable "bleedTime";

#include "sun_revive\reviveFunctions.sqf";

// Set server-side view distance
setViewDistance 1500;

// Set up logistics addons
waitUntil {!isNil "ALiVE_STATIC_DATA_LOADED"};
waitUntil {!isNil "ALIVE_sys_logistics_carryable"};
while {count (ALiVE_sys_logistics_carryable select 1) < 1} do {
	sleep 5;
};
ALiVE_sys_logistics_carryable = [["Man"],["Reammobox_F","Static","StaticWeapon","ThingX","NonStrategic","House","Vehicle","Car","Helicopter","TrackedAPC","Plane","Tank"],[]];

ASL_SLING_RULES_OVERRIDE = [
	["All","CAN_SLING","All"]
];
ASL_HEAVY_LIFTING_MIN_LIFT_OVERRIDE = 0;