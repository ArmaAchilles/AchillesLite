#!/usr/bin/env python3
import os, sys
import re, glob
import lxml.etree

debug = False
pathToFullCodeFormatStr = "../fullcode.{}.min.sqf"
languageKeyAndIsoList = [("English","en"),("German","de"),("French","fr"),("Russian","ru"),("Japanese","jp"),("Chinesesimp","cn")]

def ppModuleFunctionCode(content):
	ppContent = postprocessContent(content)
	# remove trailing semicolon
	if ppContent[-1:] == ";":
		ppContent = ppContent[:-1]
	# ppContent = "{{private _deleteModuleOnExit=true;private _logic=param[2];{}if(_deleteModuleOnExit)then{{deleteVehicle _logic}}}}".format(ppContent)
	ppContent = "{{{}}}".format(ppContent)
	return ppContent

def findFunctionAndPrintCode(functionName):
	pass

def CopyPreprocessedFunctions(inputStream, outputStream):
	ppContent = postprocessContent(inputStream.read())
	# remove trailing semicolon
	if ppContent[-1:] == ";":
		ppContent = ppContent[:-1]
	# add the function
	functionName = "Ares_fnc" + os.path.basename(file.name)[2:-4]
	outputStream.write(functionName + "={" + ppContent + "};")
		
def postprocessContent(content):
	'''
	Preprocess SQF script
	'''
	# remove block comments
	content = re.sub(r"\/\*[\S\s]*?\*\/", r" ", content)
	# remove single line comment
	content = re.sub(r"\/\/.*", r" ", content)
	# replace preprocessor constants
	for key, value in reversed(re.extract(r"#define\s+([^\W^\(]+)\s+(.+)", content)):
		content = re.sub(r"(\W){}(\W)".format(key), r"\1 {}\2".format(value), content)
	# replace preprocessor macros
	for key, arg, macro in reversed(re.extract(r"#define\s+([^\W]+)\(([^\W]+)\)\s+(.+)", content)):
		fnc = lambda x: (x.group(1) + re.sub(r"(^|\W){}(\W|$)".format(arg), r"\1 {}\2".format(x.group(2)), macro) + x.group(3))
		content = re.sub(r"(\W){}\((.*?)\)(\W)".format(key), fnc, content)
	# remove  preprocessors definitions
	content = re.sub(r"\s*#define.+", " ", content)
	# remove #include directives
	content = re.sub(r"\s*#include.+", r" ", content)
	# replace localizations
	content = re.sub(r"localize\s*\"([^\W]*)\"", lambda x: '"{}"'.format(localizeString(x.group(1))), content)
	# remove whitespace
	if not debug:
		content = re.sub(r"\s+([\W])", r"\1", content)
		content = re.sub(r"([\W])\s+", r"\1", content)
		content = re.sub(r"([^\W])\s+([^\W])", r"\1 \2", content)
		content = re.sub(r"^\s+([^\s])", r"\1", content)
	# remove extra semicolons
	content = re.sub(r";}", r"}", content)
	return content

def localizeString(key):
	'''
	Localizes string based on ArmA 3 stringtable.xml
	'''
	nodes = localizeString.tree.xpath('//Key[@ID="{}"]'.format(key))
	if len(nodes) > 0:
		languageNode = nodes[0].find(localizeString.language)
		if languageNode is not None:
			return languageNode.text
		else:
			languageNode = nodes[0].find("Original")
			if languageNode is not None:
				return languageNode.text
			else:
				return key	
	else:
		return key
localizeString.tree = lxml.etree.parse("../../AresModAchillesExpansion/@AresModAchillesExpansion/addons/language_f/stringtable.xml")
localizeString.language = ""

def extract(pattern, string, *args, **kwargs):
	'''
	Extracts regex pattern from string
	'''
	compiledRE = re.compile(pattern, *args, **kwargs)
	matches = compiledRE.findall(string)
	return matches
re.extract = extract


if __name__ == "__main__":
	for language, iso in languageKeyAndIsoList:
		pathToFullCode = pathToFullCodeFormatStr.format(iso)
		localizeString.language = language
		print("[ HINT   ]: Writing {}:".format(os.path.basename(pathToFullCode)))
		with open(pathToFullCode, "w") as outputStream:
			# exit if init was already done
			outputStream.write('if(Ares_var_initDone)exitWith{systemChat"Waring: Achillite was already initialized!"};Ares_var_initDone=true;')
			# pack all achillite functions
			for entry in os.scandir("../functions"):
				if entry.is_dir():
					for file in os.scandir(entry.path):
						with open(file.path, "r") as inputStream:
							CopyPreprocessedFunctions(inputStream, outputStream)
			# get whitelisted Achilles modules
			with open("../modules/whitelist.txt") as whitelistStream:
				whitelistedModules = [line.strip() for line in whitelistStream.read().splitlines()]
			# get category localizations
			with open("../modules/categoryLocalization.txt") as catLocStream:
				categoryDict = {}
				for key, value in re.extract(r"([^\W]+)\s*=\s*(.*)\b", catLocStream.read()):
					categoryDict[key] = localizeString(value)
			# load Achilles modules
			print("[ HINT   ]: Adding modules ...")
			groupedModuleNameList = []
			moduleFunctionList = []
			for cfgVehicleModuleFile in glob.iglob("../../AresModAchillesExpansion/@AresModAchillesExpansion/addons/*/*/cfgVehiclesModules*.hpp"):
				moduleFunctionFolder = os.path.dirname(cfgVehicleModuleFile) + "/functions"
				if os.path.basename(os.path.dirname(cfgVehicleModuleFile)) == "Replacement":
					continue
				with open(cfgVehicleModuleFile, "r") as cfgStream:
					# print(os.path.basename(cfgVehicleModuleFile))
					content = cfgStream.read()
					# print(content)
					categoryKey = re.extract(r"Category\s*=\s*\"([^\W]*)\"", content, re.IGNORECASE)[0]
					moduleNameList = []
					for moduleClass, moduleAttributes in re.extract(r"\s+([^\W]+)[\s|\:]+[^\W]+\s+{([\s\S]*?)}", content):
						if not moduleClass in whitelistedModules:
							continue
						moduleName = localizeString(re.extract(r"displayName\s*=\s*\"\$([^\W]*)\"", moduleAttributes, re.IGNORECASE)[0])
						functionName = re.extract(r"function\s*=\s*\"[^\W]*_fnc([^\W]*)\"", moduleAttributes, re.IGNORECASE)[0]
						with open(moduleFunctionFolder + "/fn" + functionName + ".sqf", "r") as inputStream:
							functionCode = ppModuleFunctionCode(inputStream.read())
						moduleNameList.append(moduleName) 
						moduleFunctionList.append('["{}",{}]'.format(moduleName, functionCode))
						print("[ HINT   ]", categoryDict[categoryKey], moduleName, sep=": ")
					if len(moduleNameList) > 0:
						groupedModuleNameList.append([categoryDict[categoryKey], moduleNameList])
			# define Ares_var_modules
			# print(groupedModuleNameList)
			content = "Ares_var_modules={};".format(groupedModuleNameList)
			content = re.sub(r"\s+([\W])", r"\1", content)
			content = re.sub(r"([\W])\s+", r"\1", content)
			outputStream.write(content)
			# set module code
			content = '{(getAssignedCuratorLogic player)setVariable[_x select 0,_x select 1]}forEach[' + ",".join(moduleFunctionList) + '];'
			outputStream.write(content)
			# print(content)
			# -- to do: load init.sqf
			outputStream.write("[]spawn Ares_fnc_init;")
		print("[ STATUS ]: Packing completed!")
