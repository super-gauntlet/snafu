params ["_position"];

_nearestCluster = nil;

_sector = [ALIVE_sectorGrid, "positionToSector", _position] call ALIVE_fnc_sectorGrid;
_sectorData = [_sector,"data",["",[],[],nil]] call ALIVE_fnc_hashGet;
if ("clustersCiv" in (_sectorData select 1)) then {
	_civClusters = [_sectorData,"clustersCiv"] call ALIVE_fnc_hashGet;
	_settlementClusters = [_civClusters,"settlement"] call ALIVE_fnc_hashGet;
	_sortedClusters = [_settlementClusters,[_position],{_Input0 distance2D (_x select 0)},"ASCEND"] call BIS_fnc_sortBy; 
	_nearestClusterID = _sortedClusters select 0 select 1;
	_nearestCluster = [ALIVE_clusterHandler, "getCluster", _nearestclusterID] call ALIVE_fnc_clusterHandler;
};
_nearestCluster;