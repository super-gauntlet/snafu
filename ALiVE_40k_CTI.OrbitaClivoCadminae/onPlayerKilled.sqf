// Load unit loadouts into respawn
_units = [
	"B_IMCA_Cadian_Auto_Rifleman_01",
	"B_IMCA_Cadian_Heavy_AT_01",
	"B_IMCA_Cadian_Marksman_02",
	"B_IMCA_Cadian_Medicae_01",
	"B_IMCA_Cadian_Pilot_01",
	"B_IMCA_Cadian_Plasma_Trooper_01",
	"B_IMCA_Cadian_Rifleman_01",
	"B_IMCA_Cadian_Rifleman_Autogun_01",
	"B_IMCA_Cadian_Rifleman_Female_01",
	"B_IMCA_Cadian_Light_AT_01",
	"B_IMCA_Skitarii_Ranger_01"
];

private _side = missionNamespace getVariable "_PLAYER_SIDE";
{
	[_side, _x] call BIS_fnc_addRespawnInventory;
} forEach _units;