#define IDD_RSCDISPLAYCURATOR 312
#define IDC_RSCDISPLAYCURATOR_CREATE_MODULES 280

params ["_curator", "_logic"];
if (typeOf _logic == "module_f") then
{
	// set unit under cursorTarget
	Ares_CuratorObjectPlaced_UnitUnderCursor = if (curatorMouseOver isEqualTo [""]) then {["OBJECT",objNull]} else {curatorMouseOver};
	// Get the UI control
	private _display = findDisplay IDD_RSCDISPLAYCURATOR;
	private _ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;
	// Get the function
	private _path = missionNamespace getVariable ["Ares_var_moduleTreeCurSel", []];
	private _moduleName = _ctrl tvText _path;
	// Set the module name for the list of placed assets in the Zeus interface.
	_logic setName _moduleName;
	// execute the module function
	[position _logic, Ares_CuratorObjectPlaced_UnitUnderCursor select 1, _logic, _curator, _moduleName] spawn 
	{
		params ["_position", "_object", "_logic", "_curator", "_moduleName"];
		private _deleteModuleOnExit = true;
		scopeName "module_cleanup";
		(_this select [0,3]) call (_curator getVariable [_moduleName, {}]);
		if (_deleteModuleOnExit) then {deleteVehicle _logic};
	};
};