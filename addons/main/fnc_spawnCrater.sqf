#include "script_component.hpp"

params ["_pos", "_size"];

[30000, -2, 24, 6] params ["_baseSize", "_baseHeightChange", "_baseDiameter", "_baseDecalSize"];

private _heightChange = (linearConversion [1, _baseSize, _size, 0, _baseHeightChange, true]) * improvedcraters_setting_craterScale;
private _diameter = (linearConversion [1, _baseSize, _size, 0, _baseDiameter, true]) * (improvedcraters_setting_craterScale / 2);
private _scale = (linearConversion [1, _baseSize, _size, 1, _baseDecalSize, true]) * (improvedcraters_setting_craterScale / 4);

if (((_pos # 2) + _heightChange) > getTerrainHeight _pos) exitWith {
	format ["Explosion was too high to make an impact on the ground with a height of %1.", (_pos # 2)] call FUNC(log);
};

format ["Creating crater with a height change of %1 with a diameter of %2", _heightChange, _diameter] call FUNC(log);

private _positions = [_pos, _diameter, _heightChange] call FUNC(getPoints);

setTerrainHeight [_positions];

if (!improvedcraters_setting_allowGroundTextures) exitWith {
	"Ground textures are disabled." call FUNC(log);
};

"Creating ground textures." call FUNC(log);

{
	private _decal = _x createVehicle _pos;
	_decal setDir (random 360);
} foreach ["Land_DirtPatch_03_F", "Land_ClutterCutter_large_F"];