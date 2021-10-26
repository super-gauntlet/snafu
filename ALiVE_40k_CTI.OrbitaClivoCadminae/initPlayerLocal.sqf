if(!hasInterface) exitWith {}; // If headless then exit

// start incon undercover
if (player getVariable ["isSneaky",false]) then {
    [player] execVM "INC_undercover\Scripts\initUCR.sqf";
};
// buy menu + HUD
[] execVM "HG\Setup\fn_clientInitialization.sqf";
[] execVM "status_bar\playerBar.sqf"