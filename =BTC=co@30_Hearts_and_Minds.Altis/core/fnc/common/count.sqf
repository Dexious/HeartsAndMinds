
private ["_n"];

_n = count _this;
{_n = _n + (_x call btc_fnc_count);} forEach (_this select {(typeName _x) isEqualTo "ARRAY"});
_n