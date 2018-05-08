////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 5/1/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_SelectUnits.sqf
//  DESCRIPTION: Let the curator select units and submit the selection
//
//	ARGUMENTS:
//	_this select 0:		STRING	- (Default: localize "STR_AMAE_OBJECTS") Tells what has to be selected
//	_this select 1:		BOOL	- (Default: false) If true only one object is returned. Otherwise the array of all groups / objects is returned.
//
//	RETURNS:
//	_this:				OBJECT or GROUP or ARRAY of objects or groups or NIL if the selection was cancled
//
//	Example:
//	_selected_units_array = ["units"] call Achilles_fnc_SelectUnits;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

params[["_type", "OBJECTS", [""]], ["_single", false, [false]]];

disableSerialization;
private _display = finddisplay IDD_RSCDISPLAYCURATOR;
private _ctrlMessage = _display displayctrl IDC_RSCDISPLAYCURATOR_FEEDBACKMESSAGE;
private _ctrlHint = _display ctrlCreate ["RscStructuredText", -1];

Achilles_var_submit_selection = nil;

// Inform curator what he has to do
playSound "FD_Finish_F";

// set message
_ctrlMessage ctrlsettext toupper (format ["SELECT %1 TO WHICH THE MODULE SHOULD BE APPLIED!", _type]);
_ctrlMessage ctrlsetfade 1;
_ctrlMessage ctrlcommit 0;
_ctrlMessage ctrlsetfade 0;
_ctrlMessage ctrlcommit 0.1;
// set hint
_ctrlHint ctrlSetPosition [safeZoneX+safeZoneW*0.68,safeZoneY+(safeZoneH*0.1),safeZoneW*0.14,safeZoneH*0.07];
_ctrlHint ctrlSetBackgroundColor [0, 0, 0, 0.7];
_ctrlHint ctrlSetStructuredText parsetext "<t align='center'>Confirm the selection with ENTER<br />- or -<br />Cancel with ESCAPE</t>";
_ctrlHint ctrlCommit 0;

// Add key event handler
private _handler_id = _display displayAddEventHandler ["KeyDown",
{
	private _key = _this select 1;
	if (_key == 28) then {Achilles_var_submit_selection = true; true} else {false};
	if (_key == 1) then {Achilles_var_submit_selection = false; true} else {false};
}];

// executed when the choice is submitted or cancled
WaitUntil {!isNil "Achilles_var_submit_selection" or {isNull findDisplay 312}};

// remove the key handler and the message
_display displayRemoveEventHandler ["KeyDown", _handler_id];
_ctrlMessage ctrlsetfade 1;
_ctrlMessage ctrlcommit 0.5;
// remove hint
ctrlDelete _ctrlHint;

// if escape was pressed
if (!isNil "Achilles_var_submit_selection" && {!Achilles_var_submit_selection}) exitWith {["SELECTION CANCLED"] call Achilles_fnc_ShowZeusErrorMessage; nil};

// if enter was pressed
["SELECTION SUBMITTED"] call Ares_fnc_ShowZeusMessage;

if (_single) exitWith
{
	[objNull, (curatorSelected select 0) select 0] select (count (curatorSelected select 0) > 0)
};
curatorSelected select 0;
