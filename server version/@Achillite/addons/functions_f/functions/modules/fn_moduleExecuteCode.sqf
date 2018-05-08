// Execute code module
disableSerialization;
params ["_position", "_unitUnderCursor", "_logic"];
private _params = [_position,_unitUnderCursor];

// load required functions
if (isNil "Achillite_fnc_rscDialogExecuteCode") then
{
	Achillite_fnc_rscDialogExecuteCode = [missionNamespace, "Achillite_fnc_rscDialogExecuteCode", {}] call BIS_fnc_getServerVariable;
};

// mission designer can disallow usage of execute code module, but it will still be available for logged-in admins
if (!(missionNamespace getVariable ['Ares_Allow_Zeus_To_Execute_Code', true]) and ((call BIS_fnc_admin) == 0)) exitWith
{
	["CODE EXECUTION NOT ALLOWED"] call Ares_fnc_ShowZeusMessage;
};

uiNamespace setVariable ["Ares_ExecuteCode_Dialog_Result", -1];
private _default_target = uiNamespace getVariable ['Ares_ExecuteCode_Dialog_Constraint', 0];
private _dialog = [] call Achillite_fnc_rscDialogExecuteCode;
private _combobox = _dialog displayCtrl 4000;
{_combobox lbAdd _x} forEach ["local","server","global","global & JIP"];
_combobox lbSetCurSel _default_target;
waitUntil { dialog };
waitUntil { !dialog };
private _dialogResult = uiNamespace getVariable ["Ares_ExecuteCode_Dialog_Result", -1];

if (_dialogResult == 1) then
{

	private _target = uiNamespace getVariable ["Ares_ExecuteCode_Dialog_Constraint", 0];
	private _pastedText = uiNamespace getVariable ["Ares_ExecuteCode_Dialog_Text", "[]"];
	// check for server-side blacklist if not admin
	if ((call BIS_fnc_admin) == 0) then
	{
		private _isExecutionGranted = [missionNamespace, "Achilles_fnc_checkCodeBasedOnBlackList", {[]}] call BIS_fnc_getServerVariable;
		private _blacklistedEntries = _pastedText call _isExecutionGranted;
		if !(_blacklistedEntries isEqualTo []) then
		{
			[format ["THIS SERVER DOES NOT ALLOW YOU TO USE %1!", _blacklistedEntries select 0]] call Achilles_fnc_showZeusErrorMessage;
			breakTo "module_cleanup";
		};
	};

	switch (_target) do
	{
		case 0: {_params spawn (compile _pastedText)};
		case 1: {[_params, compile _pastedText] remoteExecCall ["spawn", 2]};
		case 2: {[_params, compile _pastedText] remoteExecCall ["spawn", 0]};
		case 3:
		{
			private _JIP_id = [_params, compile _pastedText] remoteExecCall ["spawn", 0, _logic];
			_logic setName format ["Execute Code: JIP queue %1", _JIP_id];
			_deleteModuleOnExit = false;
		};
	};
};