/*
    Author - HoverGuy
	© All Fucks Reserved
	Website - http://www.sunrise-production.com
	
    Defines available vehicle shops
	
	class YourShopClass - Used as a param for the call, basically the shop you want to display
	{
		conditionToAccess - STRING - Condition that must return either true or false, if true the player will have access to the shop
		
		class YourShopCategory - Shop category, can be whatever you want
		{
			displayName - STRING - Category display name
			vehicles - ARRAY OF ARRAYS - Shop content
			|- 0 - STRING - Classname
			|- 1 - INTEGER - Price
			|- 2 - STRING - Condition that must return either true or false, if true the vehicle appears in the list else no
			spawnPoints - ARRAY OF ARRAYS - Spawn positions (markers/positions)
			|- 0 - STRING - Display name in the dialog
			|- 1 - ARRAY OF MIXED - Markers/positions
		};
	};
*/

class HG_DefaultShop // HG_DefaultShop is just a placeholder for testing purposes, you can delete it completely and make your own
{
    conditionToAccess = "true"; // Example: "(playerSide in [west,independent]) AND ((rank player) isEqualTo 'COLONEL')"
	class Military
	{
	    displayName = "$STR_HG_SHOP_MILITARY";
		vehicles[] =
		{
		    {"ML700_Taurox_Unarmed", 250, "true"},
		    {"Steve_SAL_Jetbike_VLK", 500, "true"},
		    {"Steve_SAL_Jetbike_PC", 500, "true"},
		    {"Steve_SAL_Jetbike_MM", 500, "true"},
		    {"Steve_SAL_Jetbike_HB", 500, "true"},
		    {"B_IMCA_Rhino_03", 250, "true"},
		    {"TIOW_SAL_Storm", 250, "true"},
		    {"TIOW_SAL_Tornado", 3000, "true"},
		    {"TIOW_SAL_Temp", 3000, "true"},
		    {"TIOW_SAL_Typhoon", 3000, "true"},
		    {"TIOW_Thunderbolt_Base", 4000, "true"},
		    {"ML700_Avenger_BLU", 4000, "true"},
		    {"TIOW_Valkyrie_Rocket_M_B", 3000, "true"},
		    {"TIOW_Drop_Pod_SAL", 1500, "true"},
		    {"Steve_Ass_Ram_UM_1", 3000, "true"},
			{"B_IMCA_Razorback_AC_03", 3000, "true"},
			{"B_IMCA_Razorback_HB_03", 3000, "true"},
			{"B_IMCA_Razorback_LC_03", 3000, "true"},
			{"TIOW_SM_Vindicator_UM", 3000, "true"},
			{"TIOW_SM_Whirlwind_Arty_UM", 3000, "true"},
			{"ML700_Basalisk_ARTY_base", 3000, "true"},
			{"TIOW_SM_Predator_SL", 4000, "true"},
		    {"ML700_Leman_Multilaser", 4000, "true"},
		    {"ML700_Leman_BattleCannon", 4000, "true"},
		    {"ML700_Leman_Punisher", 4000, "true"},
		    {"Sentinel_ML_1491th_1", 4000, "true"},
		    {"Sentinel_HB_1491th_1", 4000, "true"},
		    {"Sentinel_PC_1491th_1", 4000, "true"},
		    {"B_IMCA_Plasma_Titan_01", 7500, "true"},
		    {"B_IMCA_Mega_Bolter_Titan_01", 7500, "true"},
		    {"B_IMCA_Laser_Titan_01", 7500, "true"},
		    {"Baneblade", 7500, "true"}
	    };
		spawnPoints[] =
		{
			{"$STR_HG_MARKER_2",{"military_vehicles_spawn_1"}}
		};
	};
};

class HG_FortificationShop // HG_DefaultShop is just a placeholder for testing purposes, you can delete it completely and make your own
{
    conditionToAccess = "true"; // Example: "(playerSide in [west,independent]) AND ((rank player) isEqualTo 'COLONEL')"
	class Military
	{
	    displayName = "$STR_HG_SHOP_MILITARY";
		vehicles[] =
		{
		    {"ML700_Static_Mortar", 500, "true"},
		    {"ML700_Static_LockeLauncher_Tripod", 500, "true"},
		    {"TIOW_IG_MissileLauncher_AA_700_Blu", 500, "true"},
		    {"ML700_Static_HeavyBolter_Tripod_High", 500, "true"},
		    {"ML700_Static_Lascannon_Tripod_High", 500, "true"},
		    {"ML700_Static_Autocannon_Tripod_High", 500, "true"},
		    {"ML700_Static_MultiLaser_Tripod_High", 500, "true"},
		    {"ML700_Hydra_Platform", 500, "true"},
		    {"ML700_EarthShaker_Platform_NoShield_AT", 500, "true"},
			{"bunker_Static", 125, "true"},
			{"Gate_Static", 125, "true"},
			{"Wall_Static", 125, "true"},
			{"Cap_Static", 125, "true"},
			{"land_High_external_wall", 125, "true"},
			{"land_Sandbag_straight", 0, "true"},
			{"land_Sandbag_curved", 0, "true"},
			{"land_Sandbag_static", 0, "true"},
			{"land_Stakes", 0, "true"},
			{"SandbagMound_Long", 0, "true"},
			{"land_TIOW_Skyshield_Fence_long", 0, "true"},
			{"land_TIOW_Skyshield_Fence_medium", 0, "true"},
			{"land_TIOW_Skyshield_Fence_short", 0, "true"},
			{"land_TIOW_adl_double", 0, "true"},
			{"land_TIOW_adl_single", 0, "true"},
			{"land_barrier", 0, "true"},
			{"TIOW_Dragons_teeth_multiple", 0, "true"},
			{"Land_ConcreteHedgehog_01_F", 0, "true"},
			{"Land_DragonsTeeth_01_4x2_new_F", 0, "true"},
			{"Land_HBarrier_3_F", 0, "true"},
			{"Land_HBarrier_5_F", 0, "true"},
			{"Land_HBarrier_1_F", 0, "true"},
			{"WallCorner_Static", 125, "true"},
			{"Land_BagBunker_Small_F", 125, "true"},
			{"Land_PillboxWall_01_3m_round_F", 125, "true"},
			{"Land_PillboxWall_01_3m_F", 125, "true"},
			{"Land_PillboxWall_01_6m_round_F", 125, "true"},
			{"Land_PillboxWall_01_6m_F", 125, "true"},
			{"Land_Bunker_01_blocks_3_F", 125, "true"},
			{"Land_Bunker_01_blocks_1_F", 125, "true"},
			{"Land_HBarrier_Big_F", 125, "true"},
			{"Land_HBarrierWall_corridor_F", 125, "true"},
			{"Land_HBarrierWall_corner_F", 125, "true"},
			{"Land_HBarrierWall6_F", 125, "true"},
			{"Land_HBarrierWall4_F", 125, "true"},
			{"Land_BagBunker_Large_F", 250, "true"},
			{"Land_Cargo_House_V3_F", 250, "true"},
			{"Land_BagBunker_Tower_East_F", 250, "true"},
			{"Land_HBarrierTower_F", 250, "true"},
			{"Land_PillboxBunker_01_big_F", 500, "true"},
			{"Land_PillboxBunker_01_hex_F", 500, "true"},
			{"Land_PillboxBunker_01_rectangle_F", 500, "true"},
			{"Land_Bunker_01_big_F", 500, "true"},
			{"Land_Bunker_01_small_F", 500, "true"},
			{"Land_Bunker_01_tall_F", 500, "true"}
		};
		spawnPoints[] =
		{
			{"$STR_HG_MARKER_2",{"military_vehicles_spawn_1"}}
		};
	};
};