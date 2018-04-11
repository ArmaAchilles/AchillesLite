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
_ctrl ctrlSetPosition [GtC_X(2), GtC_Y(0), GtC_W(38), GtC_H(1.5)];
_ctrl ctrlSetBackgroundColor [0.518,0.016,0,0.8];
_ctrl ctrlSetText localize "STR_AMAE_COPY_PASTE_DIALOG";
_ctrl ctrlSetFontHeight 1.2 * GUI_GRID_H;
_ctrl ctrlCommit 0;
// Ares_Main_Background
_ctrl = _dialog ctrlCreate ["IGUIBack", 2000];
_ctrl ctrlSetPosition [GtC_X(0), GtC_Y(1.5), GtC_W(40), GtC_H(20.5)];
_ctrl ctrlSetBackgroundColor [0.2,0.2,0.2,0.8];
_ctrl ctrlCommit 0;
// Ares_Dialog_Bottom
_ctrl = _dialog ctrlCreate ["IGUIBack", 2010];
_ctrl ctrlSetPosition [GtC_X(7), GtC_Y(20), GtC_W(28), GtC_H(1.5)];
_ctrl ctrlSetBackgroundColor [0,0,0,0.6];
_ctrl ctrlCommit 0;
// Ares_Ok_Button
_ctrl = _dialog ctrlCreate ["RscButtonMenuOK", 3000];
_ctrl ctrlSetPosition [GtC_X(35.5), GtC_Y(20), GtC_W(4), GtC_H(1.5)];
_ctrl ctrlSetTextColor [1,1,1,1];
_ctrl ctrlSetBackgroundColor [0,0,0,0.8];
_ctrl ctrlCommit 0;
_ctrl ctrlAddEventHandler ["ButtonClick", {uiNamespace setVariable ["Ares_CopyPaste_Dialog_Result", 1]; closeDialog 1}];
// Ares_Cancle_Button
_ctrl = _dialog ctrlCreate ["RscButtonMenuCancel", 3010];
_ctrl ctrlSetPosition [GtC_X(0.5), GtC_Y(20), GtC_W(6), GtC_H(1.5)];
_ctrl ctrlSetTextColor [1,1,1,1];
_ctrl ctrlSetBackgroundColor [0,0,0,0.8];
_ctrl ctrlCommit 0;
_ctrl ctrlAddEventHandler ["ButtonClick", {uiNamespace setVariable ["Ares_CopyPaste_Dialog_Result", -1]; closeDialog 2}];
// Ares_Background_Edit
private _ctrl = _dialog ctrlCreate ["IGUIBack", 2040];
_ctrl ctrlSetPosition [GtC_X(0.5), GtC_Y(2), GtC_W(39), GtC_H(17)];
_ctrl ctrlSetBackgroundColor [0,0,0,0.6];
_ctrl ctrlCommit 0;
// Ares_Paragraph_edit
private _ctrl = _dialog ctrlCreate ["RscText", 1020];
_ctrl ctrlSetPosition [GtC_X(1), GtC_Y(2), GtC_W(39), GtC_H(1.5)];
_ctrl ctrlSetText localize "STR_AMAE_COPY_PASTE_CLIPBOARD_CONTENTS_USING_KEYS";
_ctrl ctrlCommit 0;
// Ares_Edit
private _ctrl = _dialog ctrlCreate ["RscEditMulti", 1400];
_ctrl ctrlSetPosition [GtC_X(1), GtC_Y(3.5), GtC_W(38), GtC_H(15)];
_ctrl ctrlSetTextColor [0.5,0.5,0.5,1];
_ctrl ctrlSetBackgroundColor [0,0,0,0.5];
_ctrl ctrlCommit 0;
// Ares_Icon_Background
private _ctrl = _dialog ctrlCreate ["IGUIBack", 2020];
_ctrl ctrlSetPosition [GtC_X(0), GtC_Y(0), GtC_W(2), GtC_H(1.5)];
_ctrl ctrlSetBackgroundColor [0.518,0.016,0,0.8];
_ctrl ctrlCommit 0;
// Ares_Icon
_ctrl = _dialog ctrlCreate ["RscPicture", 2030];
_ctrl ctrlSetText "\a3\Ui_F_Curator\Data\Logos\arma3_curator_eye_64_ca.paa";
_ctrl ctrlSetPosition [GtC_X(0.2), GtC_Y(0.15), GtC_W(1.6), GtC_H(1.2)];
_ctrl ctrlCommit 0;

_dialog;