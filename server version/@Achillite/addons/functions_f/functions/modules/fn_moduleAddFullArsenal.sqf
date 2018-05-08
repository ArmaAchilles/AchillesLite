params ["", "_object"];

// If no object has been selected then prompt selection of multiple objects
private _objects = if (isNull _object) then
{
	["OBJECTS"] call Achilles_fnc_SelectUnits;
}
else
{
	[_object];
};
if (isNil "_objects") exitWith {};

// Add Arsenal
{
	["AmmoboxInit", [_x, true]] spawn BIS_fnc_Arsenal;
} forEach _objects;

// Show message
["ARSENAL ADDED!"] call Ares_fnc_ShowZeusMessage;
