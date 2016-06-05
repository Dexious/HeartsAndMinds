//MOT
private ["_pos","_veh_type","_veh","_gunner","_commander","_cargo","_wp"];
_start_pos = _this select 0;
if (count (_start_pos nearRoads 100) > 0) then {
	_pos = getPos ((_start_pos nearRoads 100) select 0);
} else {
	_pos = [_start_pos, 10, 200, 13, 0, 60 * (pi / 180), 0] call BIS_fnc_findSafePos;
};
_group = createGroup btc_enemy_side;
_group setVariable ["no_cache",true];
_veh_type = selectRandom btc_type_motorized_armed;
_veh = createVehicle [_veh_type, _start_pos, [], 0, "FLY"];
[_veh,_group,false,"",btc_type_crewmen] call BIS_fnc_spawnCrew;
_cargo = (_veh emptyPositions "cargo") - 1;
for "_i" from 0 to _cargo do
{
	_unit_type = selectRandom btc_type_units;
	_unit_type createUnit [_start_pos, _group, "this moveinCargo _veh;this assignAsCargo _veh;"];
};

_group selectLeader (driver _veh);

_wp = _group addWaypoint [_pos, 60];
_wp setWaypointType "MOVE";
_wp setWaypointCombatMode "RED";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "NORMAL";
_wp setWaypointStatements ["true","(group this) spawn btc_fnc_data_add_group;"];
_wp_1 = _group addWaypoint [_pos, 60];
_wp_1 setWaypointType "UNLOAD";
_wp_2 = _group addWaypoint [_start_pos, 60];
_wp_2 setWaypointType "SAD";
if (btc_debug_log) then
{
	diag_log format ["fnc_rep_call_militia = MOT %1/%2 POS %3",_group,_veh_type,_pos];
};