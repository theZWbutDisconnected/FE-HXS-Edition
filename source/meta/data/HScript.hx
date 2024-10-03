package meta.data;

import interpret.Env;
import interpret.DynamicModule;
import interpret.DynamicInstance;
import haxe.macro.Expr;

using StringTools;

#if lime
import lime.app.Application as LimeApplication;
import lime.ui.WindowAttributes;
#end

class HScript
{
	public var env:Env = new Env();
	public var packag3:String;

	public function new(?path:String)
	{
		env.addDefaultModules();
		env.addModule('StringTools', DynamicModule.fromStatic(StringTools));
		env.addModule('flixel.FlxCamera', DynamicModule.fromStatic(flixel.FlxCamera));
		env.addModule('flixel.FlxG', DynamicModule.fromStatic(flixel.FlxG));
		env.addModule('flixel.FlxSprite', DynamicModule.fromStatic(flixel.FlxSprite));
		env.addModule('flixel.graphics.FlxGraphic', DynamicModule.fromStatic(flixel.graphics.FlxGraphic));
		env.addModule('flixel.graphics.tile.FlxGraphicsShader', DynamicModule.fromStatic(flixel.graphics.tile.FlxGraphicsShader));
		env.addModule('flixel.graphics.frames.FlxAtlasFrames', DynamicModule.fromStatic(flixel.graphics.frames.FlxAtlasFrames));
		env.addModule('flixel.group.FlxGroup', DynamicModule.fromStatic(flixel.group.FlxGroup));
		env.addModule('flixel.math.FlxMath', DynamicModule.fromStatic(flixel.math.FlxMath));
		env.addModule('flixel.math.FlxRect', DynamicModule.fromStatic(flixel.math.FlxRect));
		env.addModule('flixel.tweens.FlxEase', DynamicModule.fromStatic(flixel.tweens.FlxEase));
		env.addModule('flixel.tweens.FlxTween', DynamicModule.fromStatic(flixel.tweens.FlxTween));
		env.addModule('flixel.util.FlxColor', DynamicModule.fromStatic(flixel.util.RealColor));
		env.addModule('flixel.util.FlxTimer', DynamicModule.fromStatic(flixel.util.FlxTimer));
		env.addModule('haxe.Exception', DynamicModule.fromStatic(flixel.FlxCamera));
		env.addModule('haxe.Log', DynamicModule.fromStatic(haxe.Log));
		env.addModule('haxe.ds.StringMap', DynamicModule.fromStatic(haxe.ds.StringMap));
		env.addModule('lime.app.Application', DynamicModule.fromStatic(lime.app.Application));
		env.addModule('lime.graphics.Image', DynamicModule.fromStatic(lime.graphics.Image));
		env.addModule('lime.graphics.RenderContext', DynamicModule.fromStatic(lime.graphics.RenderContext));
		env.addModule('lime.ui.KeyCode', DynamicModule.fromStatic(lime.ui.KeyCode));
		env.addModule('lime.ui.MouseButton', DynamicModule.fromStatic(lime.ui.MouseButton));
		env.addModule('lime.ui.Window', DynamicModule.fromStatic(lime.ui.Window));
		env.addModule('openfl.display.Sprite', DynamicModule.fromStatic(openfl.display.Sprite));
		env.addModule('openfl.display.GraphicsShader', DynamicModule.fromStatic(openfl.display.GraphicsShader));
		env.addModule('openfl.display.Shader', DynamicModule.fromStatic(openfl.display.Shader));
		env.addModule('openfl.filters.ShaderFilter', DynamicModule.fromStatic(openfl.filters.ShaderFilter));
		env.addModule('openfl.geom.Matrix', DynamicModule.fromStatic(openfl.geom.Matrix));
		env.addModule('openfl.geom.Rectangle', DynamicModule.fromStatic(openfl.geom.Rectangle));
		env.addModule('openfl.utils.Assets', DynamicModule.fromStatic(openfl.utils.Assets));
		env.addModule('sys.FileSystem', DynamicModule.fromStatic(sys.FileSystem));
		env.addModule('sys.io.File', DynamicModule.fromStatic(sys.io.File));
		env.addModule('Paths', DynamicModule.fromStatic(Paths));
		env.addModule('Main', DynamicModule.fromStatic(Main));
		// env.addModule('Init', DynamicModule.fromStatic(Init));
		env.addModule('ForeverTools', DynamicModule.fromStatic(ForeverTools));
		env.addModule('ForeverAssets', DynamicModule.fromStatic(ForeverAssets));
		env.addModule('mobile.MobileConfig', DynamicModule.fromStatic(mobile.MobileConfig));
		// env.addModule('mobile.MobileControls', DynamicModule.fromStatic(mobile.MobileControls));
		env.addModule('mobile.MobileMenu', DynamicModule.fromStatic(mobile.MobileMenu));
		env.addModule('mobile.MobileSys', DynamicModule.fromStatic(mobile.MobileSys));
		env.addModule('mobile.backend.StorageUtil', DynamicModule.fromStatic(mobile.backend.StorageUtil));
		env.addModule('meta.Controls', DynamicModule.fromStatic(meta.Controls));
		env.addModule('meta.CoolUtil', DynamicModule.fromStatic(meta.CoolUtil));
		env.addModule('meta.MusicBeat', DynamicModule.fromStatic(meta.MusicBeat));
		env.addModule('meta.Overlay', DynamicModule.fromStatic(meta.Overlay));
		env.addModule('meta.subState.GameOverSubstate', DynamicModule.fromStatic(meta.subState.GameOverSubstate));
		env.addModule('meta.subState.OptionsSubstate', DynamicModule.fromStatic(meta.subState.OptionsSubstate));
		env.addModule('meta.subState.PauseSubState', DynamicModule.fromStatic(meta.subState.PauseSubState));
		env.addModule('meta.subState.charting.PreferenceSubstate', DynamicModule.fromStatic(meta.subState.charting.PreferenceSubstate));
		env.addModule('meta.state.CustomTitlescreen', DynamicModule.fromStatic(meta.state.CustomTitlescreen));
		env.addModule('meta.state.PlayState', DynamicModule.fromStatic(meta.state.PlayState));
		env.addModule('meta.state.TitleState', DynamicModule.fromStatic(meta.state.TitleState));
		env.addModule('meta.state.menus.FreeplayState', DynamicModule.fromStatic(meta.state.menus.FreeplayState));
		env.addModule('meta.state.menus.MainMenuState', DynamicModule.fromStatic(meta.state.menus.MainMenuState));
		env.addModule('meta.state.menus.OptionsMenuState', DynamicModule.fromStatic(meta.state.menus.OptionsMenuState));
		env.addModule('meta.state.menus.StoryMenuState', DynamicModule.fromStatic(meta.state.menus.StoryMenuState));
		env.addModule('meta.state.charting.ChartingState', DynamicModule.fromStatic(meta.state.charting.ChartingState));
		env.addModule('meta.state.charting.OriginalChartingState', DynamicModule.fromStatic(meta.state.charting.OriginalChartingState));
		// env.addModule('meta.state.charting.TestState', DynamicModule.fromStatic(meta.state.charting.TestState));
		env.addModule('meta.data.ChartLoader', DynamicModule.fromStatic(meta.data.ChartLoader));
		env.addModule('meta.data.Conductor', DynamicModule.fromStatic(meta.data.Conductor));
		env.addModule('meta.data.Highscore', DynamicModule.fromStatic(meta.data.Highscore));
		env.addModule('meta.data.HScript', DynamicModule.fromStatic(meta.data.HScript));
		env.addModule('meta.data.PlayerSettings', DynamicModule.fromStatic(meta.data.PlayerSettings));
		env.addModule('meta.data.Section', DynamicModule.fromStatic(meta.data.Section));
		env.addModule('meta.data.Song', DynamicModule.fromStatic(meta.data.Song));
		env.addModule('meta.data.Timings', DynamicModule.fromStatic(meta.data.Timings));
		env.addModule('meta.data.font.Alphabet', DynamicModule.fromStatic(meta.data.font.Alphabet));
		env.addModule('meta.data.font.Dialogue', DynamicModule.fromStatic(meta.data.font.Dialogue));
		env.addModule('meta.data.dependency.Discord', DynamicModule.fromStatic(meta.data.dependency.Discord));
		env.addModule('meta.data.dependency.FNFSprite', DynamicModule.fromStatic(meta.data.dependency.FNFSprite));
		env.addModule('meta.data.dependency.FNFTransition', DynamicModule.fromStatic(meta.data.dependency.FNFTransition));
		env.addModule('meta.data.dependency.FNFUIState', DynamicModule.fromStatic(meta.data.dependency.FNFUIState));
		env.addModule('gameObjects.Boyfriend', DynamicModule.fromStatic(gameObjects.Boyfriend));
		env.addModule('gameObjects.Character', DynamicModule.fromStatic(gameObjects.Character));
		env.addModule('gameObjects.Stage', DynamicModule.fromStatic(gameObjects.Stage));
		env.addModule('gameObjects.background.BackgroundDancer', DynamicModule.fromStatic(gameObjects.background.BackgroundDancer));
		env.addModule('gameObjects.background.BackgroundGirls', DynamicModule.fromStatic(gameObjects.background.BackgroundGirls));
		env.addModule('gameObjects.userInterface.ClassHUD', DynamicModule.fromStatic(gameObjects.userInterface.ClassHUD));
		env.addModule('gameObjects.userInterface.DialogueBox', DynamicModule.fromStatic(gameObjects.userInterface.DialogueBox));
		env.addModule('gameObjects.userInterface.HealthIcon', DynamicModule.fromStatic(gameObjects.userInterface.HealthIcon));
		env.addModule('gameObjects.userInterface.notes.Note', DynamicModule.fromStatic(gameObjects.userInterface.notes.Note));
		env.addModule('gameObjects.userInterface.notes.NoteSplash', DynamicModule.fromStatic(gameObjects.userInterface.notes.NoteSplash));
		env.addModule('gameObjects.userInterface.notes.Strumline', DynamicModule.fromStatic(gameObjects.userInterface.notes.Strumline));
		env.addModule('gameObjects.userInterface.menu.Checkmark', DynamicModule.fromStatic(gameObjects.userInterface.menu.Checkmark));
		env.addModule('gameObjects.userInterface.menu.DebugUI', DynamicModule.fromStatic(gameObjects.userInterface.menu.DebugUI));
		env.addModule('gameObjects.userInterface.menu.MenuCharacter', DynamicModule.fromStatic(gameObjects.userInterface.menu.MenuCharacter));
		env.addModule('gameObjects.userInterface.menu.MenuItem', DynamicModule.fromStatic(gameObjects.userInterface.menu.MenuItem));
		env.addModule('gameObjects.userInterface.menu.Selector', DynamicModule.fromStatic(gameObjects.userInterface.menu.Selector));

		if (path != null)
			loadModule(path);
	}

	//	function importClass(packag3:String) {
	//		var resolvedClass:Expr = cast Type.resolveClass(packag3);
	//		env.addModule(packag3, DynamicModule.fromString(resolvedClass));
	//	}

	public function loadModule(path:String)
	{
		var pArr = path.split('/'); /** WITHOUT POSTFIX IS IMPORTANT! **/
		var expr:DynamicModule = DynamicModule.fromString(env, pArr[pArr.length - 1], MobileSys.getContent(Paths.script(path)));
		packag3 = expr.pack;
		env.addModule(packag3, expr);
		env.link();
	}

	public function hasClass(name:String)
		return env.modules.get(packag3).dynamicClasses.exists(name);

	public function getClass(name:String)
	{
		if (hasClass(name))
		{
			return env.modules.get(packag3).dynamicClasses.get(name).createInstance();
		}
		else
		{
			CoolUtil.alert("Module Name: " + name + " not exists.", "HScript Runtime Error");
		}
		return null;
	}

	/** Receive return val **/
	public function callf(classInstance:DynamicInstance, name:String, ?args:Array<Dynamic>)
	{
		try
		{
			return classInstance.call(name, args);
		}
		catch (e)
		{
			CoolUtil.alert('An error occurred while trying to execute the method: \n' + e, "HScript Runtime Error");
		}
		return null;
	}

	/** Can't get callback **/
	public function get(classInstance:DynamicInstance, name:String, ?unwrap:Bool = true)
		return classInstance.get(name);

	/** Set a value **/
	public function set(classInstance:DynamicInstance, name:String, value:Dynamic, ?unwrap:Bool = true)
		return classInstance.set(name, value);

	/** Check methods or fields exists **/
	public function exists(classInstance:DynamicInstance, name:String)
		return classInstance.exists(name);

	/** Check if the field is a method **/
	public function isMethod(classInstance:DynamicInstance, name:String)
		return classInstance.isMethod(name);
}
