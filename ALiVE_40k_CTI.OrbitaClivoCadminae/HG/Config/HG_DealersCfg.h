/*
    Author - HoverGuy
	© All Fucks Reserved
	Website - http://www.sunrise-production.com
	
    Defines available traders
	
	class YourDealerClass - Used as a param for the call, basically the dealer you want to display
	{
		conditionToAccess - STRING - Condition that must return either true or false, if true the player will have access to the dealer
		
		interestedIn - ARRAY OF ARRAYS - Vehicles that the dealer is interested in buying
		|- 0 - STRING - Vehicle classname
		|- 1 - INTEGER - Vehicle sell price
	};
*/

class HG_DefaultDealer // HG_DefaultDealer is just a placeholder for testing purposes, you can delete it completely and make your own
{
	conditionToAccess = "true"; // Example: "(playerSide in [west,independent]) AND ((rank player) isEqualTo 'COLONEL')"
	
	interestedIn[] = 
	{
		{"vn_c_bicycle_01", 50},
		{"vn_c_bicycle_02", 100},
		{"vn_c_wheeled_m151_01", 500},
		{"vn_c_wheeled_m151_02", 500},
		{"vn_b_wheeled_m54_03", 500},
		{"vn_b_wheeled_m151_mg_04", 1000},
		{"vn_b_wheeled_m151_mg_04_mp", 1000},
		{"vn_b_wheeled_m151_mg_02", 1000},
		{"vn_b_wheeled_m151_mg_02_mp", 1000},
		{"vn_b_wheeled_m151_mg_03", 1000},
		{"vn_b_wheeled_m151_mg_03_mp", 1000},
		{"vn_b_wheeled_m151_01", 1000},
		{"vn_b_wheeled_m151_02", 1000},
		{"vn_b_wheeled_m151_02_mp", 1000},
		{"vn_b_wheeled_m151_01_mp", 1000},
		{"vn_b_wheeled_m54_repair", 1000},
		{"vn_b_wheeled_m54_repair_airport", 1000},
		{"vn_b_wheeled_m54_fuel", 1000},
		{"vn_b_wheeled_m54_fuel_airport", 1000},
		{"vn_b_wheeled_m54_ammo", 1000},
		{"vn_b_wheeled_m54_ammo_airport", 1000},
		{"vn_b_wheeled_m54_01", 1000},
		{"vn_b_wheeled_m54_01_airport", 1000},
		{"vn_b_wheeled_m54_01_sog", 1000},
		{"vn_b_wheeled_m54_02_sog", 1000},
		{"vn_b_wheeled_m54_02", 1000},
		{"vn_b_wheeled_m54_mg_01", 1500},
		{"vn_b_wheeled_m54_mg_03", 1500},
		{"vn_b_wheeled_m54_mg_02", 1500},
		{"vn_o_wheeled_z157_01_vcmf", 2000},
		{"vn_o_wheeled_z157_02_vcmf", 2000},
		{"vn_i_wheeled_m54_02", 1000},
		{"vn_i_wheeled_m54_01", 1000},
		{"vn_o_air_mi2_01_01", 10000},
		{"vn_o_air_mi2_01_03", 10000},
		{"vn_o_air_mi2_01_02", 10000},
		{"vn_i_air_ch34_02_01", 10000},
		{"vn_i_air_ch34_01_02", 10000},
		{"vn_i_air_ch34_02_02", 10000},
		{"vn_b_air_uh1c_07_07", 15000},
		{"vn_b_air_uh1c_04_07", 15000},
		{"vn_b_air_uh1c_02_07", 15000},
		{"vn_b_air_uh1c_05_07", 15000},
		{"vn_b_air_uh1c_01_07", 15000},
		{"vn_b_air_uh1d_01_07", 15000},
		{"vn_b_air_uh1d_02_07", 15000},
		{"vn_b_armor_m41_01_02", 20000},
		{"vn_b_armor_m41_01_01", 20000},
		{"vn_o_armor_type63_01_nva65", 20000},
		{"vn_o_armor_m41_01", 20000},
		{"vn_o_armor_type63_01", 20000},
		{"vn_o_armor_m41_02_vcmf", 20000},
		{"vn_i_armor_m41_01", 20000},
		{"vn_i_armor_type63_01", 20000}
	};
};

