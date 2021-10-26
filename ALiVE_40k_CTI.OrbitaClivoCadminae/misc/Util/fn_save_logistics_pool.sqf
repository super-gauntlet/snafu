blufor_logi = [ALIVE_globalForcePool, "CUP_B_US_Army<p></p>"] call ALiVE_fnc_hashGet;
redfor_logi = [ALIVE_globalForcePool, "CUP_O_RU"] call ALiVE_fnc_hashGet;

if ((isNil "blufor_logi") || (isNil "redfor_logi")) exitWith {};

[ALiVE_sys_data_mission_data, "logi_blufor_pool", blufor_logi] call ALiVE_fnc_hashSet;
[ALiVE_sys_data_mission_data, "logi_redfor_pool", redfor_logi] call ALiVE_fnc_hashSet;

diag_log "saved logistics pool info to profile"