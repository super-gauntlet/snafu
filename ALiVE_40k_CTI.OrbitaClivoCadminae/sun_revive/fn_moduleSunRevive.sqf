disableSerialization;

{
	_x createDiarySubject ["sun_revive", "Sunday Revive"];
	_x createDiaryRecord ["sun_revive", ["Sunday Revive", "	
	<font image='sun_revive\images\revive_img.jpg' width='350' height='175'></font>
	<br /><br /><font size='18'>Sunday Revive</font>
	<br /><br />Sunday Revive is a revive system that intends to bring the experience of a multiplayer game to singleplayer and small group players.<br /><br />The system is matched as close as possible with the built in Arma revive system to be mechanically and visually similar, however it has also been built from the ground up to work with AI so that they can revive and be revived by human players. If you have any feedback or bug reports please email me at mbrdmn@gmail.com.
	<br /><br />Development of Sunday Revive and the DXO mission series it was created for is helped by the generous supporters at www.patreon.com/mbrdmn. If you've enjoyed the system and would like to help support further development please consider a donation! Everything is appreciated and will directly go towards new content and improvements.
	"]];
	
} forEach allPlayers;


_module = param [0,objNull,[objNull]];
reviveTime = _module getVariable ["sun_reviveTime", 10];
bleedTime = _module getVariable ["sun_bleedTime", 300];

publicVariable "reviveTime";
publicVariable "bleedTime";
diag_log ((param [1,[],[[]]]));
//_group = group((param [1,[],[[]]]) select 0);
{
	[group _x] execVM "sun_revive\initRevive.sqf";
} forEach ((param [1,[],[[]]]));
