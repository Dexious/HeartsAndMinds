
private ["_suicider","_soundPath","_soundToPlay"];

_suicider = _this getVariable "suicider";

_soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
_soundToPlay = _soundPath + "core\sounds\allahu_akbar.ogg";
if (alive _suicider) then {
	playSound3d [_soundToPlay, _suicider, false, (getPosASL _suicider), 10, 1];
	sleep 1.4;
	{deleteVehicle _x;} forEach attachedObjects _suicider;
	"Bo_GBU12_LGB_MI10" createVehicle getPos _suicider;
	playSound3d["A3\Missions_F_EPA\data\sounds\combat_deafness.wss", _suicider, false, (getPosASL _suicider), 5, 1, 100];
};