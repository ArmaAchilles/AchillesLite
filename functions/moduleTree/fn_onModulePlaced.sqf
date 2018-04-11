#define IDD_RSCDISPLAYCURATOR 312
#define IDC_RSCDISPLAYCURATOR_CREATE_MODULES 280

params ["_curator", "_logic"];
if (typeOf _logic == "module_f") then
{
	// set unit under cursorTarget
	Ares_CuratorObjectPlaced_UnitUnderCursor = curatorMouseOver;
	// Get the UI control
	private _display = findDisplay IDD_RSCDISPLAYCURATOR;
	private _ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;
	// Get the function
	private _path = missionNamespace getVariable ["Ares_var_moduleTreeCurSel", []];
	private _moduleName = _ctrl tvText _path;
	Ares_CuratorObjectPlaced_ModuleFunction = _curator getVariable [_moduleName, {}];
	// execute the module function
	[position _logic, Ares_CuratorObjectPlaced_UnitUnderCursor select 1, _logic] spawn 
	{
		private _deleteModuleOnExit = true;
		private _logic = param [2];
		_this call Ares_CuratorObjectPlaced_ModuleFunction;
		if (_deleteModuleOnExit) then {deleteVehicle _logic};
	};
};