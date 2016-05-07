
private ["_obj","_pos"];

if (count _this > 1) then {
	_pos = _this select 1;
} else {
	_pos = getpos btc_create_object_point;
};

if (getText (configFile >> "cfgVehicles" >> (_this select 0) >> "displayName") isEqualTo "") then {
	_obj = [btc_create_object_point,(_this select 0)] call ace_rearm_fnc_createDummy;
	_obj setPos _pos;
} else {
	_obj = (_this select 0) createVehicle [_pos select 0,_pos select 1,0];
};

if (((_this select 0) == "B_CargoNet_01_ammo_F") || ((_this select 0) == "Box_NATO_AmmoVeh_F")) then {
	[_obj,500] remoteExec ["btc_fnc_log_set_mass",0];
};
if (((_this select 0) == btc_supplies_mat) || ((_this select 0) == btc_fob_mat)) then {
	[_obj,2000] remoteExec ["btc_fnc_log_set_mass",0];
};

btc_log_obj_created = btc_log_obj_created + [_obj];
btc_curator addCuratorEditableObjects [[_obj], false];