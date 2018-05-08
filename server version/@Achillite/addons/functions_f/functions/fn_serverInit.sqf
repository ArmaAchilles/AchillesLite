// broadcast functions to clients
publicVariable "Ares_fnc_showChooseDialog";
publicVariable "Achillite_fnc_clientInit";
publicVariable "Achillite_fnc_videoSettings";
// add event handler for clients that join
addMissionEventHandler ["PlayerConnected",  {_this call Achillite_fnc_onPlayerConnected}];
