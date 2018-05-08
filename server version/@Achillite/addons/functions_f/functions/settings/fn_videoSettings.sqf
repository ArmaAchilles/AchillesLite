// allows to change view distances
getObjectViewDistance params ["_objViewDist", "_shadowViewDist"];
private _dialogResults =
[
	"Settings",
	[
		["View Distance [m]", "", str viewDistance, true],
		["Object View Distance [m]", "", str _objViewDist, true],
		["Shadow View Distance [m]", "", str _shadowViewDist, true],
		["Terrain Resolution [m]", "", str getTerrainGrid, true]
	]
] call Ares_fnc_showChooseDialog;
if (_dialogResults isEqualTo []) exitWith {};
_dialogResults params ["_viewDist", "_objViewDist", "_shadowViewDist", "_terrainGrid"];
setViewDistance (_viewDist call BIS_fnc_parseNumber);
setObjectViewDistance [_objViewDist call BIS_fnc_parseNumber, _shadowViewDist call BIS_fnc_parseNumber];
_terrainGrid = _terrainGrid call BIS_fnc_parseNumber;
setTerrainGrid _terrainGrid;
