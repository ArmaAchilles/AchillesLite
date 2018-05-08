#define IDD_RSCDISPLAYCURATOR 312
#define IDC_RSCDISPLAYCURATOR_CREATE_MODULES 280

params ["_categoryName", "_moduleName", "_moduleCode"];
// Store module code
(getAssignedCuratorLogic player) setVariable [_moduleName, _moduleCode];
// add to Ares_var_modules list
private _cagegoryFound = false;
for "_i_category" from 0 to (count Ares_var_modules - 1) do
{
	if (Ares_var_modules select _i_category select 0 == _categoryName) exitWith
	{
		(Ares_var_modules select _i_category select 1) pushBack _moduleName;
		_cagegoryFound = true;
	};
};
if !(_cagegoryFound) then
{
	Ares_var_modules pushBack [_categoryName, [_moduleName]];
};

disableSerialization;
// Get the UI control
private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;
//prepare lists
private _categoryList = [];
// Get all current categories
for "_i" from 0 to ((_ctrl tvCount []) - 1) do
{
	_categoryList pushBack (_ctrl tvText [_i]);
};

// Add the custom module to the interface
private _categoryIndex = _categoryList find _categoryName;
if (_categoryIndex isEqualTo -1) then
{
	// if it is a new category
	_categoryIndex = _ctrl tvAdd [[], _categoryName];
	_ctrl tvSetPicture [[_categoryIndex], "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeRecent_ca.paa"];
	_categoryList pushBack _categoryName;
};
// add the module
private _moduleIndex = _ctrl tvAdd [[_categoryIndex], _moduleName];
private _modulePath = [_categoryIndex, _moduleIndex];
_ctrl tvSetData [_modulePath, "module_f"];
_ctrl tvSetPicture [_modulePath, "\a3\Ui_F_Curator\Data\Logos\arma3_curator_eye_64_ca.paa"];

//Sort category and module list
_ctrl tvSort [[], false];
for "_i" from 0 to ((_ctrl tvCount []) - 1) do {_ctrl tvSort [[_i], false];};
