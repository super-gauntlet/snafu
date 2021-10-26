/*
    Author - HoverGuy
    © All Fucks Reserved
    Website - http://www.sunrise-production.com
*/
params["_mode","_unit","_classname","_sp",["_plate",round(random(9999))],["_color",(localize "STR_HG_DEFAULT")],"_vehicle"];

if(!HG_SAVING_EXTDB) then
{
    private["_garage","_index"];
	
    _garage = profileNamespace getVariable["HG_Garage", []];
    _index = [_plate,_garage] call HG_fnc_findIndex;
	
    if(_index != -1) then
    {
	    (_garage select _index) set [3,1];
		_color = (_garage select _index) select 2;
    };
	
    profileNamespace setVariable["HG_Garage",_garage];
	saveProfileNamespace;
} else {
	private _query = if(HG_SAVING_PROTOCOL isEqualTo "SQL") then
	{
		[
			format["INSERT INTO HG_Vehicles (PID, Classname, Plate, Inventory, Active, Color) VALUES ('%1','%2','%3','%4','%5','%6')",(getPlayerUID _unit),_classname,_plate,[],1,_color],
			format["UPDATE HG_Vehicles SET Active = '%1' WHERE PID = '%2' AND Plate = '%3'",1,(getPlayerUID _unit),_plate]
		] select _mode;
	} else {
		[
		    format["HG_vehicleInsert:%1:%2:%3:%4:%5:%6",(getPlayerUID _unit),_classname,_plate,[],1,_color],
			format["HG_vehicleActiveUpdate:%1:%2:%3",1,(getPlayerUID _unit),_plate]
		] select _mode;
	};
	
	[1,_query] call HG_fnc_asyncCall;
};

private _tmpveh = _classname createVehicleLocal [0,0,0];
private _box = boundingBoxReal _tmpveh;
deleteVehicle _tmpveh;
private _size = _box select 2;

_veh_pos = [position _unit, _size / 2, _size * 10, _size, 0, 0.2, 0, [], position _unit] call BIS_fnc_findSafePos;

_veh_pos pushBack 0.5;

_vehicle = createVehicle [_classname, _veh_pos];

_vehicle allowDamage false;
[ALiVE_sys_logistics, "carryObject", [_vehicle, _unit]] remoteExecCall ["ALiVE_fnc_logistics", _unit];

[
	_unit,
	[
		"Drop Vehicle",
		{
			[ALiVE_sys_logistics, "dropObject", [attachedObjects player select 0, player]] call ALiVE_fnc_logistics;
			(_this select 0) removeAction (_this select 2)
		},
		[],
		10,
		false,
		true,
		"",
		"true"
	]
] remoteExec ["addAction", _unit];

if !(_unit isKindOf "BUILDING") then {
	[side _unit, _vehicle] call BIS_fnc_addRespawnPosition;
};

_id = [ALiVE_sys_logistics, "id", _vehicle] call ALiVE_fnc_logistics;

_persistent_vehicles = profileNamespace getVariable ["persistent_vehicles", []];
_persistent_vehicles pushBack _id;
profileNamespace setVariable ["persistent_vehicles", _persistent_vehicles];
saveProfileNamespace;

_vehicle setVehicleLock "UNLOCKED";
// _vehicle setVariable["HG_Owner",[(getPlayerUID _unit),_plate,_color,[]],true];
// [_vehicle,2] call HG_fnc_lock;

if((getNumber(getMissionConfig "CfgClient" >> "clearInventory")) isEqualTo 1) then
{
	clearItemCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	clearWeaponCargoGlobal _vehicle;
	clearBackpackCargoGlobal _vehicle;
};

if(_color != (localize "STR_HG_DEFAULT")) then
{
    private _textures = getArray(configFile >> "CfgVehicles" >> _classname >> "TextureSources" >> _color >> "textures");
	
	for "_i" from 0 to (count _textures)-1 do
	{
	    _vehicle setObjectTextureGlobal [_i,(_textures select _i)];
	};
};

_vehicle allowDamage true;

if(((getNumber(getMissionConfig "CfgClient" >> "enableVehicleInventorySave")) isEqualTo 1) AND (_mode isEqualTo 1)) then
{
	[_vehicle] call HG_fnc_setInventory;
};

if(_mode isEqualTo 1) then
{
	(localize "STR_HG_GRG_VEHICLE_SPAWNED") remoteExecCall ["hint",(owner _unit),false];
};

true;
