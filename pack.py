#!/usr/bin/env python3
import os, sys
import re

pathToFullCode = "fullcode.min.sqf"

def CopyPreprocessedFunctions(inputStream, outputStream):
	ppContent = postprocessContent(inputStream.read())
	# remove trailing semicolon
	if ppContent[-1:] == ";":
		ppContent = ppContent[:-1]
	# add the function
	functionName = "Achillite_fnc" + os.path.basename(file.name)[2:-4]
	outputStream.write(functionName + "={" + ppContent + "};")
		
def postprocessContent(content):
	'''
	Preprocess SQF script
	'''
	# remove single line comment
	content = re.sub(r"\/\/.*", r" ", content)
	# remove block comments
	content = re.sub(r"\/\*[\S\s]*\*\/", r" ", content)
	# replace #define directives with global variable
	content = re.sub(r"\s*#define\s+([^\s]+)\s+(.+)", r"\1=\2;", content)
	# remove whitespace
	content = re.sub(r"\s+([\W])", r"\1", content)
	content = re.sub(r"([\W])\s+", r"\1", content)
	content = re.sub(r"([^\W])\s+([^\W])", r"\1 \2", content)
	# remove extra semicolons
	content = re.sub(r";}", r"}", content)
	return content

if __name__ == "__main__":
	# clear file
	with open(pathToFullCode, "w") as outputStream:
		# pack all functions
		for entry in os.scandir("functions"):
			if entry.is_dir():
				for file in os.scandir(entry.path):
					with open(file.path, "r") as inputStream:
						CopyPreprocessedFunctions(inputStream, outputStream)
	# -- to do: load modules
	# -- to do: load init.sqf
							
