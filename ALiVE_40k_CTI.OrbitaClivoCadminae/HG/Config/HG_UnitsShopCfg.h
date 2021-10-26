/*
    Author - HoverGuy
	© All Fucks Reserved
	Website - http://www.sunrise-production.com
	
    Defines available units shops
	
	class YourShopClass - Used as a param for the call, basically the shop you want to display
	{
		conditionToAccess - STRING - Condition that must return either true or false, if true the player will have access to the shop
		spawnPosition - STRING - Marker name
		
		class UnitClassname
		{
			displayName - STRING - Unit display name
			rank - STRING - Unit rank, can be PRIVATE/CORPORAL/SERGEANT/LIEUTENANT/CAPTAIN/MAJOR/COLONEL
			cost - INTEGER - Unit cost in money, -1 means free
			unit - STRING - Has to be an existing class from CfgVehicles of the same player side (B_Soldier_F, O_Soldier_F etc...)
			
			class Loadout - Unit loadout, follows this format https://community.bistudio.com/wiki/getUnitLoadout
			{
				uniformClass - STRING - Uniform classname
				backpack - STRING - Backpack classname
				linkedItems - ARRAY OF STRING - Linked items classnames
				weapons - ARRAY OF STRING - Primary/secondary/handgun classnames
				items - ARRAY OF STRING - Items classnames
				magazines - ARRAY OF STRING - Magazines classnames
			};
		};
	};
*/

class HG_DefaultShop // HG_DefaultShop is just a placeholder for testing purposes, you can delete it completely and make your own
{
    conditionToAccess = "playerSide isEqualTo west"; // Example: "true" OR "(playerSide in [west,independent]) AND ((rank player) isEqualTo 'COLONEL')"
	spawnPosition = "units_spawn";
	
	class Rifleman
	{
		displayName = "Cadian Rifleman";
		rank = "PRIVATE";
		cost = -1;
		unit = "B_IMCA_Cadian_Rifleman_01";
	};
	class Autorifleman
	{
		displayName = "Cadian Autorifleman";
		rank = "PRIVATE";
		cost = -1;
		unit = "B_IMCA_Cadian_Auto_Rifleman_01";
	};
	class CombatLifesaver
	{
		displayName = "Cadian Medicae";
		rank = "PRIVATE";
		cost = -1;
		unit = "B_IMCA_Cadian_Medicae_01";
	};
	class Engineer
	{
		displayName = "Death Korps Engineer";
		rank = "PRIVATE";
		cost = -1;
		unit = "B_IMCA_Death_Korps_Engineer_01";
	};
	class Grenadier
	{
		displayName = "Death Korps Grenadier";
		rank = "PRIVATE";
		cost = -1;
		unit = "B_IMCA_Death_Korps_Grenadier_01";
	};
	class LAT
	{
		displayName = "Cadian Light AT";
		rank = "PRIVATE";
		cost = -1;
		unit = "B_IMCA_Cadian_Light_AT_01";
	};
	class Marksman
	{
		displayName = "Skitarii Ranger";
		rank = "PRIVATE";
		cost = -1;
		unit = "B_IMCA_Skitarii_Ranger_01";
	};
	class SpecOpsBasic0
	{
		displayName = "Tactical with Phobos";
		rank = "PRIVATE";
		cost = 1000;
		unit = "B_IMCA_Tactical_WPhobos_Mk_III_06";
	};
	class SpecOpsBasic1
	{
		displayName = "Tactical with Tigrus Exitus";
		rank = "PRIVATE";
		cost = 1000;
		unit = "B_IMCA_Tactical_WTigrus_Exitus_Mk_IV_06";
	};
	class SpecOpsBasic2
	{
		displayName = "Tactical Marine";
		rank = "PRIVATE";
		cost = 1000;
		unit = "B_IMCA_Tactical_Marine_Mk_06";
	};
	class SpecOpsAdvanced0
	{
		displayName = "Auto Cannon Gunner";
		rank = "PRIVATE";
		cost = 2000;
		unit = "B_IMCA_Auto_Cannon_Gunner_Mk_III_06";
	};
	class SpecOpsAdvanced1
	{
		displayName = "Heavy Bolter Marine";
		rank = "PRIVATE";
		cost = 2000;
		unit = "B_IMCA_Devastator_wHeavy_Bolter_Mk_06";
	};
	class SpecOpsAdvanced2
	{
		displayName = "Lascannon Gunner";
		rank = "PRIVATE";
		cost = 2000;
		unit = "B_IMCA_Lascannon_Gunner_Mk_IV_06";
	};
	class SpecOpsAdvanced3
	{
		displayName = "Meltagunner";
		rank = "PRIVATE";
		cost = 2000;
		unit = "B_IMCA_Meltagunner_Mk_VI_06";
	};
	class SpecOpsAdvanced4
	{
		displayName = "Plasmagunner";
		rank = "PRIVATE";
		cost = 2000;
		unit = "B_IMCA_Plasmagunner_Mk_IV_06";
	};
	class SpecOpsAdvanced5
	{
		displayName = "Rotor Gunner";
		rank = "PRIVATE";
		cost = 2000;
		unit = "B_IMCA_Rotor_Gunner_Mk_III_06";
	};
	class SpecOpsAdvanced6
	{
		displayName = "Volkite Caliver";
		rank = "PRIVATE";
		cost = 2000;
		unit = "B_IMCA_Volkite_Caliver_Mk_III_06";
	};
	class BigGuy4U
	{
		displayName = "Ultramarines Dreadnought";
		rank = "PRIVATE";
		cost = 4000;
		unit = "B_IMCA_AoD_Dreadnought_Contemptor_UM_01";
	};
};
