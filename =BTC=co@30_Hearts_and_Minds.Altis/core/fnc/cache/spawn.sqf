
private ["_n_pos","_max_pos","_holder"];

_n_pos = 0;
while {format ["%1", _this buildingPos _n_pos] != "[0,0,0]" } do {_n_pos = _n_pos + 1};
_max_pos = _n_pos;
_n_pos   = floor (random _max_pos);

btc_cache_pos = (_this buildingPos _n_pos);
if (btc_cache_pos distance [0,0,0] < 10) exitWith {[] spawn {[] call btc_fnc_cache_find_pos;};};
btc_cache_obj = selectRandom btc_cache_type createVehicle btc_cache_pos;
btc_cache_obj setPos btc_cache_pos;
clearWeaponCargoGlobal btc_cache_obj;clearItemCargoGlobal btc_cache_obj;clearMagazineCargoGlobal btc_cache_obj;
btc_cache_obj addEventHandler ["HandleDamage", btc_fnc_cache_hd_cache];

_pos_type_array = ["TOP","FRONT","CORNER_L","CORNER_R"];

for "_i" from 1 to (1 + round random 3) do {
	_holder = createVehicle ["groundWeaponHolder", btc_cache_pos, [], 0, "can_collide"];
	_holder addWeaponCargoGlobal [selectRandom btc_cache_weapons_type, 1];
	_holder setVariable ["no_cache",true];

	_pos_type = selectRandom _pos_type_array;
	_pos_type_array = _pos_type_array - [_pos_type];
	[btc_cache_obj,_holder, _pos_type] call btc_fnc_create_attachto;
};

if (btc_debug_log) then {diag_log format ["CACHE SPAWNED: ID %1 POS %2",btc_cache_n,btc_cache_pos];};

if (btc_debug) then {
	player sideChat format ["Cache spawned in %1",btc_cache_pos];
	//Marker
	createmarker [format ["%1", btc_cache_pos], btc_cache_pos];
	format ["%1", btc_cache_pos] setmarkertype "mil_unknown";
	format ["%1", btc_cache_pos] setMarkerText format ["Cache %1", btc_cache_n];
	format ["%1", btc_cache_pos] setMarkerSize [0.8, 0.8];
};