package meta.data;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
// import flxanimate.FlxAnimate;
import gameObjects.Boyfriend;
import gameObjects.Character;
import gameObjects.Stage;
import gameObjects.background.*;
import gameObjects.userInterface.HealthIcon;
import gameObjects.userInterface.notes.Note;
import gameObjects.userInterface.notes.Strumline;
import haxe.Exception;
import haxe.Log;
import haxe.ds.StringMap;
import hscript.Expr;
import hscript.Interp;
import hscript.Parser;
import hscript.Printer;
import lime.app.Application;
import lime.app.Application;
import lime.graphics.Image;
import lime.graphics.RenderContext;
import lime.ui.KeyCode;
import lime.ui.KeyModifier;
import lime.ui.MouseButton;
import lime.ui.Window;
import meta.data.dependency.FNFSprite;
import meta.state.PlayState;
import openfl.display.GraphicsShader;
import openfl.display.Shader;
import openfl.display.Sprite;
import openfl.filters.ShaderFilter;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import openfl.utils.Assets as OpenFlAssets;
import openfl.utils.Assets;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;

using StringTools;

#if lime
import lime.app.Application as LimeApplication;
import lime.ui.WindowAttributes;
#end

class HScriptTest
{
	var interp:Interp = new Interp();

	var parser:Parser = new Parser();

	var moduleExpr:Array<ModuleDecl>;

	public function new()
	{
		interp.variables.set("trace", haxe.Log.trace);
		parser.allowTypes = parser.allowJSON = parser.allowMetadata = true;
	}

	public function loadCodePart(path:String, ?params:StringMap<Dynamic>)
	{
		if (params != null)
		{
			for (i in params.keys())
			{
				interp.variables.set(i, params.get(i));
			}
		}
		var handlerMethods = MobileSys.getContent(Paths.script(path));
		var part = parser.parseString(handlerMethods);

		interp.execute(part);
	}

	public function loadModules(path:String, ?params:StringMap<Dynamic>)
	{
		if (params != null)
		{
			for (i in params.keys())
			{
				interp.variables.set(i, params.get(i));
			}
		}
		var handlerMethods = MobileSys.getContent(Paths.script(path));
		moduleExpr = parser.parseModule(handlerMethods);
		return moduleExpr;
	}

	public function getModule(name:String) {
		for (i in moduleExpr) {
			var printer:Printer = new Printer();
			printer.exprToString(i);
			trace(printer);
		}
		var module:Dynamic;
	}

	public function get(field:String):Dynamic
	{
		if (exists(field))
			return interp.variables.get(field);
		return {};
	}

	public function set(field:String, value:Dynamic)
	{
		if (exists(field))
			return interp.variables.set(field, value);
		return {};
	}

	public function exists(field:String):Bool
		return interp.variables.exists(field);
}
