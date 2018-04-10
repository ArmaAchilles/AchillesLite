#define IDD_RSCDISPLAYCURATOR 312
#define IDC_RSCDISPLAYCURATOR_CREATE_MODULES 280
// #define IDC_RSCDISPLAYCURATOR_MODEMODULES 15706

disableSerialization;

waitUntil {([player] call Ares_fnc_IsZeus)};

//Wait for the curator screen to be displayed
waitUntil {!isNull (findDisplay IDD_RSCDISPLAYCURATOR)};

// add cutator event handlers
(getAssignedCuratorLogic player) addEventHandler ["CuratorObjectPlaced", {_this call Ares_fnc_onModulePlaced}];

/*
private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;

// Wait until Zeus modules are aviable
waitUntil {sleep 1; _ctrl tvText [(_ctrl tvCount []) - 1] == localize "STR_ZEUS"};
[["Ares", "AresFieldManual"]] call BIS_fnc_advHint;

// key event handler for remote controlled unit

_display = findDisplay 46;
_display displayAddEventHandler ["KeyDown", { _this call Ares_fnc_HandleRemoteKeyPressed; }];
*/
// set modules
/*
(getAssignedCuratorLogic player) setVariable ["Test", {systemChat str _this; systemChat str Ares_CuratorObjectPlaced_UnitUnderCursor}];
Ares_var_modules = [["Zeus",["Test"]]];
*/
// run during mission
while {true} do {
	// Wait for the player to become zeus again (if they're not - eg. if on dedicated server and logged out)
	waitUntil {sleep 1; ([player] call Ares_fnc_IsZeus)};

	//Wait for the curator screen to be displayed
	waitUntil {sleep 1; !isNull (findDisplay IDD_RSCDISPLAYCURATOR)};
	
	// get module tree control
	private _display = findDisplay IDD_RSCDISPLAYCURATOR;
	private _ctrl = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;
	// set module tree EHs
	_ctrl ctrlAddEventHandler ["TreeSelChanged", {params["","_path"]; if !(_path isEqualTo []) then {missionNamespace setVariable ["Ares_var_moduleTreeCurSel",_path]}}];
	/*
	// key press variables;
	Ares_Ctrl_Key_Pressed = false;
	Ares_Shift_Key_Pressed = false;
	
	_display displayAddEventHandler ["KeyDown", { _this call Ares_fnc_HandleCuratorKeyPressed; }];
	_display displayAddEventHandler ["KeyUp", { _this call Ares_fnc_HandleCuratorKeyReleased; }];
	*/
	[] call Ares_fnc_onModuleTreeLoad;

	//Wait for the curator screen to be removed
	waitUntil {sleep 1; isNull (findDisplay IDD_RSCDISPLAYCURATOR)};
};

Achilles_fnc_sum =
{
	private _array = _this;
	private _sum = 0;

	{
		_sum = _sum + _x;
	} forEach _array;
	_sum
};

Achilles_fnc_TextToVariableName =
{
	if (isNil "Achilles_var_old_special_char_unicode") then
	{
		Achilles_var_old_special_char_unicode = [];
		Achilles_var_new_special_char_unicode = [];

		private _old_letters = [" ",":","(",")","[","]"];
		private _new_letters = ["_","_","_","_","_","_"];

		switch (language) do
		{
			case "German":
			{
				_old_letters append ["Ä","ä","Ö","ö","Ü","ü"];
				_new_letters append ["A","a","O","o","U","u"];
			};
			case "French":
			{
				_old_letters append ["é","è","à","ç","î","ë","ê","ù","û","ô","â","ï","ÿ"];
				_new_letters append ["e","e","a","c","i","e","e","u","u","o","a","i","y"];
			};
			case "Russian":
			{
				_old_letters append ["А","а","Б","б","В","в","Г","г","Д","д","Е","е","Ё","ё","Ж","ж","З","з","И","и","Й","й","К","к","Л","л","М","м","Н","н","О","о","П","п","Р","р","С","с","Т","т","У","у","Ф","ф","Х","х","Ц","ц","Ч","ч","Ш","ш","Щ","щ","Ъ","ъ","Ы","ы","Ь","ь","Э","э","Ю","ю","Я","я"];
				_new_letters append ["A","a","B","b","V","v","G","g","D","d","E","e","E","e","Z","z","Z","z","I","i","J","j","K","k","L","l","M","m","N","n","O","o","P","p","R","r","S","s","T","t","U","u","F","f","C","c","C","c","C","c","S","s","S","s","_","_","Y","y","_","_","E","e","U","u","J","j"];
			};
		};

		for "_i" from 0 to ((count _old_letters) - 1) do
		{
			Achilles_var_old_special_char_unicode append (toArray (_old_letters select _i));
			Achilles_var_new_special_char_unicode append (toArray (_new_letters select _i));
		};
	};

	private _input_unicode = toArray _this;

	for "_i" from 0 to ((count _input_unicode) - 1) do
	{
		private _letter_index = Achilles_var_old_special_char_unicode find (_input_unicode select _i);
		if (_letter_index != -1) then
		{
			_input_unicode set [_i,Achilles_var_new_special_char_unicode select _letter_index];
		};
	};
	toString _input_unicode
};