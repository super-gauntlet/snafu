private ["_vehicle", "_result", "_typename"];
_vehicle = _this;

_result = _vehicle call ORIG_ALIVE_fnc_vehicleGetKindOf;

// Motorized
if (_vehicle in 
	[
		"ML700_Taurox_Autocannon",
		"ML700_Taurox_Stubber",
		"ML700_Taurox_Unarmed",
		"ML700_Taurox_Autocannon_BP",
		"ML700_Taurox_Stubber_BP",
		"ML700_Taurox_Unarmed_BP",
		"TIOW_SM_Rhino_UM",
		"TIOW_SM_Rhino_WE",
		"Steve_SAL_Jetbike_VLK",
		"Steve_WE_Jetbike_VLK",
		"Steve_SAL_Jetbike_MM",
		"Steve_WE_Jetbike_MM",
		"Trukk1"
	]
) then {
	_result = "Car";
};

if (_vehicle in
	[
		"ML700_Chimera_Autocannon",
		"ML700_Chimera_Bolter_Optic",
		"ML700_Chimera_Bolter",
		"ML700_Chimera_Multilas",
		"ML700_Leman_BattleCannon",
		"ML700_Leman_Autocannon",
		"ML700_Leman_Bolter",
		"ML700_Leman_Bolter_Optic",
		"ML700_Leman_Punisher",
		"ML700_Hydra_NonFlak",
		"ML700_Leman_Multilaser",
		"ML700_Hydra_base",
		"ML700_Chimera_Autocannon_BP",
		"ML700_Chimera_Bolter_Optic_BP",
		"ML700_Chimera_Bolter_BP",
		"ML700_Chimera_Multilas_BP",
		"ML700_Leman_BattleCannon_BP",
		"ML700_Leman_Autocannon_BP",
		"ML700_Leman_Bolter_BL",
		"ML700_Leman_Bolter_Optic_BL",
		"ML700_Leman_Punisher_BL",
		"ML700_Hydra_NonFlak_BL",
		"ML700_Leman_Multilaser_BL",
		"ML700_Hydra_base_BL",
		"Sentinel_ML_1491th_1",
		"Sentinel_LC_1491th_1",
		"Sentinel_HB_1491th_1",
		"Sentinel_PC_1491th_1",
		"Sentinel_AC_1491th_1",
		"Sentinel_MLA_1491th_1",
		"Sentinel_ML_Possessed_0_BL",
		"Sentinel_LC_Possessed_0_BL",
		"Sentinel_HB_Possessed_0_BL",
		"Sentinel_PC_Possessed_0_BL",
		"Sentinel_AC_Possessed_0_BL",
		"Sentinel_MLA_Possessed_0_BL",
		"TIOW_SM_Razorback_AC_SL",
		"TIOW_SM_Razorback_LC_SL",
		"TIOW_SM_Razorback_SL",
		"TIOW_SM_Razorback_AC_WE",
		"TIOW_SM_Razorback_LC_WE",
		"TIOW_SM_Razorback_WE"
	]
) then {
	_result = "Armored";
};

if (_vehicle in
	[
		"WBK_DT_Cont_4",
		"TIOW_Warhound_MP_VMB_BLU",
		"TIOW_Warhound_MP_PBG_BLU",
		"TIOW_Warhound_MP_TLD_BLU",
		"WBK_DT_Cont_2_chaos",
		"TIOW_Warhound_MP_VMB_OP_T",
		"TIOW_Warhound_MP_PBG_OP_T",
		"TIOW_Warhound_MP_TLD_OP_T",
		"TIOW_Stompa_01_ds_IND",
		"TIOW_Stompa_01_es_IND",
		"TIOW_Stompa_01_bm_IND"
	]
) then {
    _result = "Tank";	
};

_result