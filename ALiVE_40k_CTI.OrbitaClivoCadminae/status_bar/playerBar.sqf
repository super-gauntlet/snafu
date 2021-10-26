waitUntil {!(isNull (findDisplay 46))};
disableSerialization;

_rscLayer = "statusBar" call BIS_fnc_rscLayer;
_rscLayer cutRsc["statusBar","PLAIN"];
systemChat format["Loading Player info...", _rscLayer];
waitUntil {!isNull player};
waitUntil {!(isNull (findDisplay 46))};
[] spawn 
{

	sleep 5;
	//set the color values.
	//Additional color codes can be found here:  http://html-color-codes.com/
	_colourDefault  = parseText "#ADADAD"; //set your default colour here
	_colour100 = parseText "#67e336";
	_colour90 = parseText "#81e336";
	_colour80 = parseText "#a4e336";
	_colour70 = parseText "#c3e336";
	_colour60 = parseText "#dde336";
	_colour50 = parseText "#e3c636";
	_colour40 = parseText "#e3a936";
	_colour30 = parseText "#e38d36";
	_colour20 = parseText "#e37036";
	_colour10 = parseText "#e35336";
	_colour0 = parseText "#e33636";
	_colourDead = parseText "#000000";


    while {true} do 
    {
        sleep 1;

        //moved the creation of the status bar inside the loop and create it if it is null,
        //this is to handle instance where the status bar is disappearing 
        if(isNull ((uiNamespace getVariable "statusBar")displayCtrl 55555)) then
        {
            diag_log "statusbar is null create";
            disableSerialization;
            _rscLayer = "statusBar" call BIS_fnc_rscLayer;
            _rscLayer cutRsc["statusBar","PLAIN"];
        };

        //initialize variables and set values
        _damage = round ((1 - (damage player)) * 100);
        _fps = format["%1", diag_fps];
        _grid = mapGridPosition  player;
        _xx = (format[_grid]) select  [0,3];
        _yy = (format[_grid]) select  [3,3];
        _cash = CASH_VAR getVariable "HG_CASH";


        //Colour coding
        //Damage
        _colourDamage = _colourDefault;

        switch true do {
            case(_damage >= 100) : {_colourDamage = _colour100;};
            case((_damage >= 90) && (_damage < 100)) : {_colourDamage =  _colour90;};
            case((_damage >= 80) && (_damage < 90)) : {_colourDamage =  _colour80;};
            case((_damage >= 70) && (_damage < 80)) : {_colourDamage =  _colour70;};
            case((_damage >= 60) && (_damage < 70)) : {_colourDamage =  _colour60;};
            case((_damage >= 50) && (_damage < 60)) : {_colourDamage =  _colour50;};
            case((_damage >= 40) && (_damage < 50)) : {_colourDamage =  _colour40;};
            case((_damage >= 30) && (_damage < 40)) : {_colourDamage =  _colour30;};
            case((_damage >= 20) && (_damage < 30)) : {_colourDamage =  _colour20;};
            case((_damage >= 10) && (_damage < 20)) : {_colourDamage =  _colour10;};
            case((_damage >= 1) && (_damage < 10)) : {_colourDamage =  _colour0;};
            case(_damage < 1) : {_colourDamage =  _colourDead;};
        };

        //display the information 
        _formattedText = format [
    		"<t shadow='1' shadowColor='#000000' color='%1'>Health: %2</t> | <t shadow '1' shadowColor='#000000' color='#C0C0C0'>X: %3 Y: %4</t> | <t shadow='1' shadowColor='#000000' color='#ADADAD'>Cash: %5</t>",
    		_colourDamage,
    		_damage,
            _xx,
            _yy,
            _cash
    	];
        ((uiNamespace getVariable "statusBar") displayCtrl 55555) ctrlSetStructuredText (parseText _formattedText);
    };
};