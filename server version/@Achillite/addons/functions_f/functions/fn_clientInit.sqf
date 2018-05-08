#define IDD_RSCDISPLAYCURATOR 312

// not executed for server and HCs
if (isServer or !hasInterface) exitWith {};
// add diary entries
player createDiarySubject ["achilles", "Achilles Server"];
player createDiaryRecord ["achilles", ["Contact",
"
	Join us on discord: <font color='#00FFFF'>https://discord.gg/K5Ds7xy</font>.<br />
	If you have issues with the server/mission, write a message in the <font color='#00FFFF'>public_server</font> channel.
"]];
player createDiaryRecord ["achilles", ["Voting",
"
	Voting is enabled. You need 34% of the players to vote for the same.<br />
	Available voting commands:<br />
	<font color='#808080' size='12' face='EtelkaMonospacePro'>#vote admin </font><font color='#FF0000' size='12' face='EtelkaMonospacePro'>&lt;name&gt; </font>| vote player for admin<br />
	<font color='#808080' size='12' face='EtelkaMonospacePro'>#vote kick </font><font color='#FF0000' size='12' face='EtelkaMonospacePro'>&lt;name&gt;  </font>| kick the player<br />
	<font color='#808080' size='12' face='EtelkaMonospacePro'>#vote restart      </font>| restart mission<br />
"]];
player createDiaryRecord ["achilles", ["Features",
"
	Revive Script:<br />
	<font color='#808080'>
	• Everyone can drag unconscious players.<br />
	&#032;• Only Medics can revive.<br />
	&#032;• AI medics will revive you automatically (depends on the settings).<br />
	&#032;• Zeus can initialize revive for AI (they can then be revived).<br />
	</font><br />
	R3F Logistics:<br />
	<font color='#808080'>
	• You can carry/load/unload objects.<br />
	&#032;• The availablity depends on server settings.<br />
	&#032;• Zeus can enable/disable it for individual objects.<br />
	</font><br />
	Achillite (additional Zeus modules):<br />
	<font color='#808080'>
	• Add Full Arsenal.<br />
	&#032;• Execute Code (some commands/functions are blacklisted).<br />
	</font><br />
	Scroll Menu Settings:<br />
	<font color='#808080'>
	• You can change the view distances.<br />
	</font><br />
"]];
player createDiaryRecord ["achilles", ["Introduction",
"
	<font size='17' face='EtelkaMonospacePro'>[ZGM] Public Achilles Server (EU)<br />__________________________________<br /></font><br />
	Welcome to the public Achilles sever.
	This server allows you to use the Achilles mod as Zeus, but you can also play without it.
	Without Achilles a limited version called Achillite (Achilles Lite) will be available to you (module categories marked with a star).
"]];
// add view distance settings
player addAction ["Settings", Achillite_fnc_videoSettings, [], 0, false, false];
player addEventHandler ["Respawn", {processDiaryLink "<log subject=""achilles"" record=""Record2"" ></log>";player addAction ["Settings", Achillite_fnc_videoSettings, [], 0, false, false]}];
// add Achillite to a Zeus that has no Achilles
waitUntil {uiSleep 1; not isNull player};
private _isCurator = (player in (call BIS_fnc_listCuratorPlayers));
diag_log [_isCurator, "Achillite"];
if (_isCurator and {not isClass (configFile >> "CfgPatches" >> "achilles_modules_f_achilles")}) then
{
	// get Achillite functions from the server
	Achillite_fnc_onModuleTreeUnload = [missionNamespace, "Achillite_fnc_onModuleTreeUnload",{}] call BIS_fnc_getServerVariable;
	Achillite_fnc_onModulePlaced = [missionNamespace, "Achillite_fnc_onModulePlaced",{}] call BIS_fnc_getServerVariable;
	Achillite_fnc_modulesInit = [missionNamespace, "Achillite_fnc_modulesInit",{}] call BIS_fnc_getServerVariable;
	// get common Ares functions
	Ares_fnc_registerCustomModule = [missionNamespace, "Ares_fnc_registerCustomModule",{}] call BIS_fnc_getServerVariable;
	Ares_fnc_showZeusMessage = [missionNamespace, "Ares_fnc_showZeusMessage",{}] call BIS_fnc_getServerVariable;
	// get common Ares functions
	Achilles_fnc_showZeusErrorMessage = [missionNamespace, "Achilles_fnc_showZeusErrorMessage",{}] call BIS_fnc_getServerVariable;
	Achilles_fnc_selectUnits = [missionNamespace, "Achilles_fnc_selectUnits",{}] call BIS_fnc_getServerVariable;
	// add module placement event handler
	(getAssignedCuratorLogic player) addEventHandler ["CuratorObjectPlaced", {_this call Achillite_fnc_onModulePlaced}];
	// import modules
	[] call Achillite_fnc_modulesInit;
	// wait until a respawn was palced
	waitUntil{uiSleep 1; missionnamespace getvariable ["BIS_moduleMPTypeGameMaster_init", false]};
	waitUntil {uiSleep 1; !isNull (findDisplay IDD_RSCDISPLAYCURATOR)};
	// execute the module tree unload EH which reloads the interface
	[] spawn Achillite_fnc_onModuleTreeUnload;
};
