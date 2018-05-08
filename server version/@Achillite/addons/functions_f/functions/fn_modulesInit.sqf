// Sets the module functions that are available
private _curator = getAssignedCuratorLogic player;
Ares_var_modules =
[
	#include "modules.hpp"
];

for "_i_category" from 0 to (count Ares_var_modules - 1) do
{
	(Ares_var_modules select _i_category) params ["_moduleCategory", "_moduleList"];
	for "_i_module" from 0 to (count _moduleList - 1) do
	{
		(_moduleList select _i_module) params ["_moduleName", "_moduleFncName"];
		private _moduleCode = [missionNamespace, _moduleFncName, {}] call BIS_fnc_getServerVariable;
		_curator setVariable [_moduleName, _moduleCode];
		_moduleList set [_i_module, _moduleName];
	};
};
