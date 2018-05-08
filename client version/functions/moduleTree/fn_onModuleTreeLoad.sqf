#define IDD_RSCDISPLAYCURATOR 312
#define IDC_RSCDISPLAYCURATOR_CREATE_MODULES 280

disableSerialization;

// Get the UI control
private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;
//prepare lists
private _categoryList = [];

// Get all Vanilla Categories we want and delete the undesired ones	
private _i = 0;
for "_i" from 0 to ((_ctrl tvCount []) - 1) do
{
	private _categoryName = _ctrl tvText [_i];
	_categoryList pushBack _categoryName;
};

// Add Achillite modules
{
	_x params ["_categoryName", "_modules"];
	private _categoryIndex = _categoryList find _categoryName;
	if (_categoryIndex isEqualTo -1) then
	{
		// if it is a new category
		_ctrl tvAdd [[], _categoryName];
		_categoryIndex = count _categoryList;
		_categoryList pushBack _categoryName;
	};
	// add modules
	{
		private _moduleName = _x;
		private _moduleIndex = _ctrl tvAdd [[_categoryIndex], _moduleName];
		private _modulePath = [_categoryIndex, _moduleIndex];
		_ctrl tvSetData [_modulePath, "module_f"];
		_ctrl tvSetPicture [_modulePath, "\a3\Ui_F_Curator\Data\Logos\arma3_curator_eye_64_ca.paa"];
	} forEach _modules;
} forEach Ares_var_modules;


//Sort category and module list
_ctrl tvSort [[], false];
for "_i" from 0 to ((_ctrl tvCount []) - 1) do {_ctrl tvSort [[_i], false];};
