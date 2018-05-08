// Defie IDD constants
#define EMPTY_GUI_IDD	-1

// Define some constants for us to use when laying things out.
#define GUI_GRID_X		(0)
#define GUI_GRID_Y		(0)
#define GUI_GRID_W		(0.025)
#define GUI_GRID_H		(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

//converts GUI grid to GUI coordinates
#define GtC_X(GRID)				GRID * GUI_GRID_W + GUI_GRID_X
#define GtC_Y(GRID)				GRID * GUI_GRID_H + GUI_GRID_Y
#define GtC_W(GRID)				GRID * GUI_GRID_W
#define GtC_H(GRID)				GRID * GUI_GRID_H

disableSerialization;

// Bring up an empty dialog and we are going to add things.
createDialog "RscDisplayEmpty";
private _dialog = findDisplay EMPTY_GUI_IDD;
// Ares_Title
private _ctrl = _dialog ctrlCreate ["RscText", 1000];
_ctrl ctrlSetPosition [2 * GUI_GRID_W + GUI_GRID_X, 0 * GUI_GRID_H + GUI_GRID_Y, 38 * GUI_GRID_W, 1.5 * GUI_GRID_H];
_ctrl ctrlSetBackgroundColor [0.518,0.016,0,0.8];
_ctrl ctrlSetFontHeight 1.2 * GUI_GRID_H;
_ctrl ctrlCommit 0;
// Ares_Main_Background
_ctrl = _dialog ctrlCreate ["IGUIBack", 2000];
_ctrl ctrlSetPosition [0 * GUI_GRID_W + GUI_GRID_X, 1.5 * GUI_GRID_H + GUI_GRID_Y, 40 * GUI_GRID_W, 22.5 * GUI_GRID_H];
_ctrl ctrlSetBackgroundColor [0.2,0.2,0.2,0.8];
_ctrl ctrlCommit 0;
// Ares_Content
_ctrl = _dialog ctrlCreate ["RscControlsGroup", 7000];
_ctrl ctrlSetPosition [0 * GUI_GRID_W + GUI_GRID_X, 1.9 * GUI_GRID_H + GUI_GRID_Y, 40 * GUI_GRID_W, 22.5 * GUI_GRID_H];
_ctrl ctrlSetBackgroundColor [0.2,0.2,0.2,0.8];
_ctrl ctrlCommit 0;
// Ares_Dialog_Bottom
_ctrl = _dialog ctrlCreate ["IGUIBack", 2010];
_ctrl ctrlSetPosition [7 * GUI_GRID_W + GUI_GRID_X, 22 * GUI_GRID_H + GUI_GRID_Y, 28 * GUI_GRID_W, 1.5 * GUI_GRID_H];
_ctrl ctrlSetBackgroundColor [0,0,0,0.6];
_ctrl ctrlCommit 0;
// Ares_Ok_Button
_ctrl = _dialog ctrlCreate ["RscButtonMenuOK", 3000];
_ctrl ctrlSetPosition [35.5 * GUI_GRID_W + GUI_GRID_X, 22 * GUI_GRID_H + GUI_GRID_Y, 4 * GUI_GRID_W, 1.5 * GUI_GRID_H];
_ctrl ctrlSetTextColor [1,1,1,1];
_ctrl ctrlSetBackgroundColor [0,0,0,0.8];
_ctrl ctrlCommit 0;
_ctrl ctrlAddEventHandler ["ButtonClick", {uiNamespace setVariable ["Ares_ChooseDialog_Result", 1]; closeDialog 1}];
// Ares_Cancle_Button
_ctrl = _dialog ctrlCreate ["RscButtonMenuCancel", 3010];
_ctrl ctrlSetPosition [0.5 * GUI_GRID_W + GUI_GRID_X, 22 * GUI_GRID_H + GUI_GRID_Y, 6 * GUI_GRID_W, 1.5 * GUI_GRID_H];
_ctrl ctrlSetTextColor [1,1,1,1];
_ctrl ctrlSetBackgroundColor [0,0,0,0.8];
_ctrl ctrlCommit 0;
_ctrl ctrlAddEventHandler ["ButtonClick", {uiNamespace setVariable ["Ares_ChooseDialog_Result", -1]; closeDialog 2}];
// Ares_Icon_Background
private _ctrl = _dialog ctrlCreate ["IGUIBack", 2020];
_ctrl ctrlSetPosition [0 * GUI_GRID_W + GUI_GRID_X, 0 * GUI_GRID_H + GUI_GRID_Y, 2 * GUI_GRID_W, 1.5 * GUI_GRID_H];
_ctrl ctrlSetBackgroundColor [0.518,0.016,0,0.8];
_ctrl ctrlCommit 0;
// Ares_Icon
_ctrl = _dialog ctrlCreate ["RscPicture", 2030];
_ctrl ctrlSetText "\a3\Ui_F_Curator\Data\Logos\arma3_curator_eye_64_ca.paa";
_ctrl ctrlSetPosition [0.2 * GUI_GRID_W + GUI_GRID_X, 0.15 * GUI_GRID_H + GUI_GRID_Y, 1.6 * GUI_GRID_W, 1.2 * GUI_GRID_H];
_ctrl ctrlCommit 0;

_dialog;