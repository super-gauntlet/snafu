/*
    Author - HoverGuy
    © All Fucks Reserved
    Website - http://www.sunrise-production.com
*/
params["_value",["_mode",0,[0]],"_balance",["_hasEnough",false]];

if (_value <= 0) exitWith {true};

_balance = if(_mode isEqualTo 0) then
{
    CASH_VAR getVariable HG_CASH_VAR;
} else {
    CASH_VAR getVariable HG_BANK_VAR;
};

if(_balance >= _value) then
{
    _hasEnough = true;
};

_hasEnough;
