private ["_pos","_start_pos","_group","_veh_type","_unit_type","_veh","_gunner","_commander","_cargo","_wp","_wp_1","_wp_2"];

_pos = _this select 0;

_start_pos = _pos;
_group = createGroup btc_enemy_side;
_group setVariable ["no_cache",true];
_veh_type = btc_type_motorized select (floor random count btc_type_motorized);
_veh = createVehicle [_veh_type, _start_pos, [], 0, "NONE"];
_gunner = _veh emptyPositions "gunner";
_commander = _veh emptyPositions "commander";
_cargo = (_veh emptyPositions "cargo") - 1;
btc_type_crewmen createUnit [_start_pos, _group, "this moveinDriver _veh;this assignAsDriver _veh;"];
if (_gunner > 0) then {btc_type_crewmen createUnit [_start_pos, _group, "this moveinGunner _veh;this assignAsGunner _veh;"];};
if (_commander > 0) then {btc_type_crewmen createUnit [_start_pos, _group, "this moveinCommander _veh;this assignAsCommander _veh;"];};
for "_i" from 0 to _cargo do
{
	_unit_type = btc_type_units select (round (random ((count btc_type_units) - 1)));
	_unit_type createUnit [_start_pos, _group, "this moveinCargo _veh;this assignAsCargo _veh;"];
};

_group selectLeader (driver _veh);

_wp = _group addWaypoint [_pos, 60];
_wp setWaypointType "MOVE";
_wp setWaypointCombatMode "RED";
_wp setWaypointBehaviour "AWARE";
_wp setWaypointSpeed "NORMAL";
_wp setWaypointStatements ["true","(group this) spawn btc_fnc_data_add_group;"];
_wp_1 = _group addWaypoint [_pos, 60];
_wp_1 setWaypointType "UNLOAD";
_wp_2 = _group addWaypoint [_pos, 60];
_wp_2 setWaypointType "SAD";