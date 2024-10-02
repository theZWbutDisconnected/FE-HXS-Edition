package meta.data;

import flixel.FlxG;
// import flxanimate.FlxAnimate;
import haxe.ds.StringMap;
import hscript.Interp;
import hscript.Parser;
import mobile.MobileSys;

using StringTools;

#if lime
import lime.app.Application as LimeApplication;
import lime.ui.WindowAttributes;
#end


class HScript
{
	var interp:Interp = new Interp();

	var parser:Parser = new Parser();

	public function new()
	{
		parser.allowTypes = parser.allowJSON = parser.allowMetadata = true;
	}

	public function loadModule(path:String, ?params:StringMap<Dynamic>)
	{
		// interp.expr(parser.parseString(code));
		if (params != null)
		{
			for (i in params.keys())
			{
				interp.variables.set(i, params.get(i));
			}
		}

		var handlerMethods = MobileSys.getContent(Paths.script(path));
		// handlerMethods = Preprocessor.preprocess(handlerMethods);

		// importing!!
		var imports = extractImports(handlerMethods);
		var classes:Array<String> = [];
		if (imports != null)
		{
			for (importLine in imports)
			{
				var moduleName = getModuleName(importLine);
				classes.push(moduleName);
				importClass(moduleName);
				handlerMethods = handlerMethods.replace(importLine, "");
			}
			trace("Import Classes: " + classes);
		}
		trace('[Script] ' + handlerMethods);
		interp.execute(parser.parseString(handlerMethods, path));
	}

	function extractImports(script:String):Array<String>
	{
		var importLines = [];
		var lines = script.split("\n");
		for (line in lines)
		{
			if (line.trim().startsWith("import"))
			{
				var s = line.trim();
				importLines.push(s + check(s));
			}
		}
		return importLines;
	}

	function check(v:String):String
	{
		if (!v.endsWith(';'))
		{
			FlxG.log.warn('Missing ;');
			throw("Missing ;");
			return ';';
		}
		return '';
	}

	function getModuleName(importLine:String):String
	{
		return importLine.replace("import ", "").replace(";", "");
	}

	function importClass(className:String)
	{
		// importClass("flixel.util.FlxSort") should give you FlxSort.byValues, etc
		// i would LIKE to do like.. flixel.util.* but idk if I can get everything in a namespace
		var classSplit:Array<String> = className.split(".");
		var daClassName = classSplit[classSplit.length - 1]; // last one
		if (daClassName == '*')
		{
			var daClass = Type.resolveClass(className);
			while (classSplit.length > 0 && daClass == null)
			{
				daClassName = classSplit.pop();
				daClass = Type.resolveClass(classSplit.join("."));
				if (daClass != null)
					break;
			}
			if (daClass != null)
			{
				for (field in Reflect.fields(daClass))
				{
					interp.variables.set(field, Reflect.field(daClass, field));
				}
			}
			else
			{
				trace('Could not import class ${daClass}');
			}
		}
		else
		{
			var daClass = Type.resolveClass(className);
			if (daClass == null)
			{
				trace('Could not import class ${daClass}');
				return;
			}
			interp.variables.set(daClassName, daClass);
		}
	}

	public function get(field:String):Dynamic
	{
		if (exists(field))
		{
			return interp.variables.get(field);
		}
		return {};
	}

	public function set(field:String, value:Dynamic)
	{
		if (exists(field))
		{
			return interp.variables.set(field, value);
		}
		return {};
	}

	public function exists(field:String):Bool
	return interp.variables.exists(field);
}
