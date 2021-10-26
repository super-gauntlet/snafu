/*
    Author - HoverGuy
	© All Fucks Reserved
	Website - http://www.sunrise-production.com

    Defines available items shops
	
	class YourShopClass - Used as a param for the call, basically the shop you want to display
	{
		conditionToAccess - STRING - Condition that must return either true or false, if true the player will have access to the shop
		
		class YourShopCategory - Shop category, can be whatever you want
		{
			displayName - STRING - Category display name
			items - ARRAY OF ARRAYS - Shop content
			|- 0 - STRING - Classname
			|- 1 - INTEGER - Price
			|- 2 - STRING - Condition that must return either true or false, if true the item appears in the list else no
		};
	};
*/

class HG_DefaultShop // HG_DefaultShop is just a placeholder for testing purposes, you can delete it completely and make your own
{
	conditionToAccess = "true"; // Example: "(playerSide in [west,independent]) AND ((rank player) isEqualTo 'COLONEL')"
	
	class Items
	{
	    displayName = "$STR_HG_SHOP_ITEMS";
		items[] =
		{
			{"vn_b_item_rations_01", 10, "true"},
			{"vn_prop_food_fresh_01", 10, "true"},
			{"vn_prop_food_fresh_02", 10, "true"},
			{"vn_prop_food_meal_01", 10, "true"},
			{"vn_prop_food_sack_01", 10, "true"},
			{"vn_prop_food_sack_02", 10, "true"},
			{"vn_prop_drink_08_01", 10, "true"},
			{"vn_prop_drink_06", 10, "true"},
			{"vn_prop_drink_04", 10, "true"},
			{"vn_prop_drink_02", 10, "true"},
			{"vn_prop_drink_03", 10, "true"},
			{"vn_prop_drink_01", 10, "true"},
			{"vn_prop_drink_07_02", 10, "true"}

/*			{"vn_prop_food_fresh_06", 10, "true"}, add meds back when medical supply run missions are added
			{"vn_prop_food_fresh_02", 10, "true"},
			{"vn_prop_food_pir_01_01", 10, "true"},
			{"vn_prop_food_pir_01_02", 10, "true"},
			{"vn_prop_food_pir_01_04", 10, "true"},
			{"vn_prop_food_pir_01_05", 10, "true"},
			{"vn_prop_food_pir_01_03", 10, "true"},
			{"vn_prop_food_fresh_01", 10, "true"},
			{"vn_prop_food_fresh_03", 10, "true"},
			{"vn_prop_food_fresh_09", 10, "true"},
			{"vn_prop_food_fresh_05", 10, "true"},
			{"vn_prop_food_sack_02", 10, "true"},
			{"vn_prop_food_sack_01", 10, "true"},
			{"vn_prop_food_fresh_10", 10, "true"},

			{"vn_b_item_bugjuice_01", 10, "true"},
			{"vn_prop_med_antibiotics", 10, "true"},
			{"vn_prop_med_antimalaria", 10, "true"},
			{"vn_prop_med_antivenom", 10, "true"},
			{"vn_prop_med_dysentery", 10, "true"},
			{"vn_prop_med_painkillers", 10, "true"},
			{"vn_prop_med_wormpowder", 10, "true"}, */
		};
	};
	
	class Magazines
	{
	    displayName = "$STR_HG_SHOP_MAGAZINES";
		items[] =
		{
			{"vn_sa7_mag", 0, "true"},
			{"vn_sa7b_mag", 0, "true"},
			{"vn_rpg2_mag", 0, "true"},
			{"vn_rpg7_mag", 0, "true"},
			{"rpg7_f", 0, "true"},
			{"vn_40mm_m381_he_mag", 0, "true"},
			{"vn_40mm_m406_he_mag", 0, "true"},
			{"vn_40mm_m397_ab_mag", 0, "true"},
			{"vn_40mm_m433_hedp_mag", 0, "true"},
			{"vn_40mm_m583_flare_w_mag", 0, "true"},
			{"vn_40mm_m661_flare_g_mag", 0, "true"},
			{"vn_40mm_m662_flare_r_mag", 0, "true"},
			{"vn_40mm_m695_flare_y_mag", 0, "true"},
			{"vn_40mm_m680_smoke_w_mag", 0, "true"},
			{"vn_40mm_m682_smoke_r_mag", 0, "true"},
			{"vn_40mm_m715_smoke_g_mag", 0, "true"},
			{"vn_40mm_m716_smoke_y_mag", 0, "true"},
			{"vn_40mm_m717_smoke_p_mag", 0, "true"},
			{"vn_40mm_m651_cs_mag", 0, "true"},
			{"1rnd_he_grenade_shell", 0, "true"},
			{"1rnd_smoke_grenade_shell", 0, "true"},
			{"1rnd_smokered_grenade_shell", 0, "true"},
			{"1rnd_smokegreen_grenade_shell", 0, "true"},
			{"1rnd_smokeyellow_grenade_shell", 0, "true"},
			{"1rnd_smokepurple_grenade_shell", 0, "true"},
			{"1rnd_smokeblue_grenade_shell", 0, "true"},
			{"1rnd_smokeorange_grenade_shell", 0, "true"},
			{"ugl_flarewhite_f", 0, "true"},
			{"ugl_flaregreen_f", 0, "true"},
			{"ugl_flarered_f", 0, "true"},
			{"ugl_flareyellow_f", 0, "true"},
			{"ugl_flarecir_f", 0, "true"},
			{"vn_40mm_m576_buck_mag", 0, "true"},
			{"vn_izh54_so_mag", 0, "true"},
			{"vn_izh54_mag", 0, "true"},
			{"vn_m1895_mag", 0, "true"},
			{"vn_m712_mag", 0, "true"},
			{"vn_m10_mag", 0, "true"},
			{"vn_pm_mag", 0, "true"},
			{"vn_pm_mag", 0, "true"},
			{"vn_tt33_mag", 0, "true"},
			{"vn_40mm_m381_he_mag", 0, "true"},
			{"vn_40mm_m406_he_mag", 0, "true"},
			{"vn_40mm_m397_ab_mag", 0, "true"},
			{"vn_40mm_m433_hedp_mag", 0, "true"},
			{"vn_40mm_m583_flare_w_mag", 0, "true"},
			{"vn_40mm_m661_flare_g_mag", 0, "true"},
			{"vn_40mm_m662_flare_r_mag", 0, "true"},
			{"vn_40mm_m695_flare_y_mag", 0, "true"},
			{"vn_40mm_m680_smoke_w_mag", 0, "true"},
			{"vn_40mm_m682_smoke_r_mag", 0, "true"},
			{"vn_40mm_m715_smoke_g_mag", 0, "true"},
			{"vn_40mm_m716_smoke_y_mag", 0, "true"},
			{"vn_40mm_m717_smoke_p_mag", 0, "true"},
			{"vn_40mm_m651_cs_mag", 0, "true"},
			{"1rnd_he_grenade_shell", 0, "true"},
			{"1rnd_smoke_grenade_shell", 0, "true"},
			{"1rnd_smokered_grenade_shell", 0, "true"},
			{"1rnd_smokegreen_grenade_shell", 0, "true"},
			{"1rnd_smokeyellow_grenade_shell", 0, "true"},
			{"1rnd_smokepurple_grenade_shell", 0, "true"},
			{"1rnd_smokeblue_grenade_shell", 0, "true"},
			{"1rnd_smokeorange_grenade_shell", 0, "true"},
			{"ugl_flarewhite_f", 0, "true"},
			{"ugl_flaregreen_f", 0, "true"},
			{"ugl_flarered_f", 0, "true"},
			{"ugl_flareyellow_f", 0, "true"},
			{"ugl_flarecir_f", 0, "true"},
			{"vn_40mm_m576_buck_mag", 0, "true"},
			{"vn_welrod_mag", 0, "true"},
			{"vn_type56_mag", 0, "true"},
			{"vn_type56_t_mag", 0, "true"},
			{"30rnd_762x39_mag_f", 0, "true"},
			{"30rnd_762x39_mag_green_f", 0, "true"},
			{"30rnd_762x39_mag_tracer_f", 0, "true"},
			{"30rnd_762x39_mag_tracer_green_f", 0, "true"},
			{"30rnd_762x39_ak12_mag_f", 0, "true"},
			{"30rnd_762x39_ak12_mag_tracer_f", 0, "true"},
			{"75rnd_762x39_mag_f", 0, "true"},
			{"75rnd_762x39_mag_tracer_f", 0, "true"},
			{"30rnd_762x39_ak12_lush_mag_f", 0, "true"},
			{"30rnd_762x39_ak12_lush_mag_tracer_f", 0, "true"},
			{"30rnd_762x39_ak12_arid_mag_f", 0, "true"},
			{"30rnd_762x39_ak12_arid_mag_tracer_f", 0, "true"},
			{"75rnd_762x39_ak12_mag_f", 0, "true"},
			{"75rnd_762x39_ak12_mag_tracer_f", 0, "true"},
			{"75rnd_762x39_ak12_lush_mag_f", 0, "true"},
			{"75rnd_762x39_ak12_lush_mag_tracer_f", 0, "true"},
			{"75rnd_762x39_ak12_arid_mag_f", 0, "true"},
			{"75rnd_762x39_ak12_arid_mag_tracer_f", 0, "true"},
			{"vn_sks_mag", 0, "true"},
			{"vn_sks_t_mag", 0, "true"},
			{"vn_m4956_10_mag", 0, "true"},
			{"vn_m4956_10_t_mag", 0, "true"},
			{"vn_dp28_mag", 0, "true"},
			{"vn_rpd_100_mag", 0, "true"},
			{"vn_rpd_125_mag", 0, "true"},
			{"vn_pk_100_mag", 0, "true"},
			{"vn_mp40_mag", 0, "true"},
			{"vn_mp40_t_mag", 0, "true"},
			{"vn_ppsh41_35_mag", 0, "true"},
			{"vn_ppsh41_35_t_mag", 0, "true"},
			{"vn_ppsh41_71_mag", 0, "true"},
			{"vn_ppsh41_71_t_mag", 0, "true"},
			{"vn_pps_mag", 0, "true"},
			{"vn_pps_t_mag", 0, "true"},
			{"vn_sten_mag", 0, "true"},
			{"vn_sten_t_mag", 0, "true"},
			{"vn_ppsh41_35_mag", 0, "true"},
			{"vn_ppsh41_35_t_mag", 0, "true"},
			{"vn_ppsh41_71_mag", 0, "true"},
			{"vn_ppsh41_71_t_mag", 0, "true"},
			{"vn_m45_mag", 0, "true"},
			{"vn_m45_t_mag", 0, "true"},
			{"vn_mat49_mag", 0, "true"},
			{"vn_mat49_t_mag", 0, "true"},
			{"vn_mc10_mag", 0, "true"},
			{"vn_mc10_t_mag", 0, "true"},
			{"vn_m1897_fl_mag", 0, "true"},
			{"vn_m1897_buck_mag", 0, "true"},
			{"vn_izh54_mag", 0, "true"},
			{"vn_izh54_so_mag", 0, "true"},
			{"vn_izh54_mag", 0, "true"}
		};
	};
	
	class Attachments
	{
	    displayName = "Attachments";
		items[] =
		{
		    {"vn_b_type56",0,"true"},
		    {"vn_s_m1895",100,"true"},
			{"vn_b_m4956",100,"true"},
			{"vn_b_m38",100,"true"},
			{"vn_b_sks",100,"true"},
			{"vn_s_mk22",100,"true"},
			{"vn_s_pm",100,"true"},
			{"vn_s_sten",100,"true"},
			{"vn_s_m45_camo",150,"true"},
			{"vn_s_mc10",150,"true"},
			{"vn_o_3x_m9130",200,"true"},
		    {"vn_o_4x_m4956",200,"true"}
		};
	};
};
