class CfgFunctions
{
	class Achillite
	{
		project = "Achillite";
		tag = "Achillite";

		class init
		{
			class serverInit
			{
				file = "\achillite\functions_f\functions\fn_serverInit.sqf";
				preInit = 1;
			};
			class clientInit
			{
				file = "\achillite\functions_f\functions\fn_clientInit.sqf";
			};
			class modulesInit
			{
				file = "\achillite\functions_f\functions\fn_modulesInit.sqf";
			};
		};
		class eventHandlers
		{
			file = "\achillite\functions_f\functions\eventHandlers";
			
			class onModulePlaced;
			class onModuleTreeUnload;
			class onPlayerConnected;
		};
		class modules
		{
			file = "\achillite\functions_f\functions\modules";
			
			class moduleAddFullArsenal;
			class moduleExecuteCode;
		};
		class settings
		{
			file = "\achillite\functions_f\functions\settings";
			
			class videoSettings;
		};
		class ui
		{
			file = "\achillite\functions_f\functions\ui";
			
			class rscDialogDynamic;
			class rscDialogExecuteCode;
		};
	};
	
	class Ares
	{
		project = "Ares";
		tag = "Ares";
		
		class common
		{
			file = "\achillite\functions_f\functions\ares";
			
			class registerCustomModule;
			class showChooseDialog;
			class showZeusMessage;
		};
	};
	
	class Achilles
	{
		project = "Achilles";
		tag = "Achilles";
		
		class common
		{
			file = "\achillite\functions_f\functions\achilles";
			
			class selectUnits;
			class showZeusErrorMessage;
			class sum;
			class textToVariableName;
		};
	};
};
