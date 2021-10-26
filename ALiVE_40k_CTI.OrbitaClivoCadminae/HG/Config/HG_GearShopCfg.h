/*
    Author - HoverGuy
    © All Fucks Reserved
	Website - http://www.sunrise-production.com
	
    Defines available gear shops
	
	class YourShopClass - Used as a param for the call, basically the shop you want to display
	{
		conditionToAccess - STRING - Condition that must return either true or false, if true the player will have access to the shop
		
		class ShopCategory - Shop category, can only be Glasses/Headgear/Uniform/Vest/Backpack/MissileLauncher/RocketLauncher/Handgun/AssaultRifle/MachineGun/SubmachineGun/SniperRifle
		{
			content - ARRAY OF ARRAYS - Shop content
			|- 0 - STRING - Classname
			|- 1 - INTEGER - Price
			|- 2 - STRING - Condition that must return either true or false, if true the item appears in the list else no
		};
	};
*/

class HG_DefaultShop // HG_DefaultShop is just a placeholder for testing purposes, you can delete it completely and make your own
{
	conditionToAccess = "true"; // Example: "(playerSide in [west,independent]) AND ((rank player) isEqualTo 'COLONEL')"
	
	class Vest
	{
		displayName = "$STR_HG_SHOP_VESTS";
		content[] =
		{
			{"vn_o_vest_01", 50, "true"},
			{"vn_o_vest_02", 50, "true"},
			{"vn_o_vest_03", 50, "true"},
			{"vn_o_vest_04", 50, "true"},
			{"vn_o_vest_05", 50, "true"},
			{"vn_o_vest_06", 50, "true"},
			{"vn_o_vest_07", 50, "true"},
			{"vn_o_vest_08", 50, "true"},
			{"vn_o_vest_vc_01", 50, "true"},
			{"vn_o_vest_vc_02", 50, "true"},
			{"vn_o_vest_vc_03", 50, "true"},
			{"vn_o_vest_vc_04", 50, "true"},
			{"vn_o_vest_vc_05", 50, "true"}
		};
	};
	
	class Backpack
	{
		displayName = "$STR_HG_SHOP_BACKPACKS";
		content[] =
		{
			{"vn_o_pack_01", 50, "true"},
			{"vn_o_pack_02", 50, "true"},
			{"vn_o_pack_03", 50, "true"},
			{"vn_o_pack_04", 50, "true"},
			{"vn_o_pack_05", 50, "true"},
			{"vn_o_pack_06", 50, "true"},
			{"vn_o_pack_07", 50, "true"},
			{"vn_o_pack_08", 50, "true"},
			{"vn_o_pack_t884_01", 50, "true"},
			{"vn_o_pack_static_base_01", 200, "true"},
			{"vn_o_pack_static_dp28_01", 200, "true"},
			{"vn_o_pack_static_rpd_01", 200, "true"},
			{"vn_o_pack_static_dshkm_high_01", 200, "true"},
			{"vn_o_pack_static_dshkm_high_02", 200, "true"},
			{"vn_o_pack_static_dshkm_low_01", 200, "true"},
			{"vn_o_pack_static_dshkm_low_02", 200, "true"},
			{"vn_o_pack_static_type63_01", 200, "true"},
			{"vn_o_pack_static_type53_01", 200, "true"},
			{"vn_o_pack_static_at3_01", 200, "true"},
			{"vn_o_pack_static_ammo_01", 200, "true"},
			{"vn_o_pack_static_pk_high_01", 200, "true"},
			{"vn_o_pack_static_pk_low_01", 200, "true"}
		};
	};
	
	class MissileLauncher
	{
		displayName = "$STR_HG_SHOP_MISSILE_LAUNCHER";
		content[] =
		{
			{"vn_sa7", 1000, "true"},
			{"vn_sa7b", 1000, "true"}
		};
	};
	
	class RocketLauncher
	{
		displayName = "$STR_HG_SHOP_ROCKET_LAUNCHER";
		content[] =
		{
			{"vn_rpg2", 800, "true"},
			{"vn_rpg7", 1000, "true"},
			{"vn_m79", 500, "true"}
		};
	};
	
	class Handgun
	{
		displayName = "$STR_HG_SHOP_HANDGUN";
		content[] =
		{
			{"vn_izh54_p", 200, "true"},
			{"vn_m1895", 200, "true"},
			{"vn_m712", 200, "true"},
			{"vn_m10", 200, "true"},
			{"vn_pm", 200, "true"},
			{"vn_fkb1_pm", 200, "true"},
			{"vn_tt33", 200, "true"},
			{"vn_m79_p", 300, "true"},
			{"vn_welrod", 300, "true"}
		};
	};
	
	class AssaultRifle
	{
		displayName = "$STR_HG_SHOP_ASSAULT_RIFLE";
		content[] =
		{
			{"vn_type56", 600, "true"},
			{"vn_sks", 600, "true"},
			{"vn_m4956", 600, "true"}
		};
	};
	
	class MachineGun
	{
		displayName = "$STR_HG_SHOP_MACHINE_GUN";
		content[] =
		{
			{"vn_dp28", 1000, "true"},
			{"vn_rpd", 1000, "true"},
			{"vn_pk", 1000, "true"}
		};
	};
	
	class SubmachineGun
	{
		displayName = "$STR_HG_SHOP_SUB_MACHINE_GUN";
		content[] =
		{
			{"vn_mp40", 400, "true"},
			{"vn_ppsh41", 400, "true"},
			{"vn_pps43", 400, "true"},
			{"vn_sten", 400, "true"},
			{"vn_k50m", 400, "true"},
			{"vn_m45_camo", 400, "true"},
			{"vn_mat49", 400, "true"},
			{"vn_mc10", 500, "true"}
		};
	};
	
	class Shotgun
	{
		displayName = "Shotguns";
		content[] =
		{
			{"vn_m1897", 500, "true"},
			{"vn_izh54", 400, "true"},
			{"vn_izh54_shorty", 400, "true"}
		};
	};
};
