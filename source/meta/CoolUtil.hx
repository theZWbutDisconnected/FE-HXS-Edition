package meta;

import meta.state.PlayState;

using StringTools;

class CoolUtil
{
	public static var difficultyArray:Array<String> = ['EASY', "NORMAL", "HARD"];
	public static var difficultyLength = difficultyArray.length;

	public static function difficultyFromNumber(number:Int):String
	{
		return difficultyArray[number];
	}

	public static function dashToSpace(string:String):String
	{
		return string.replace("-", " ");
	}

	public static function spaceToDash(string:String):String
	{
		return string.replace(" ", "-");
	}

	public static function swapSpaceDash(string:String):String
	{
		return StringTools.contains(string, '-') ? dashToSpace(string) : spaceToDash(string);
	}

	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = MobileSys.getContent(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static function getOffsetsFromTxt(path:String):Array<Array<String>>
	{
		var fullText:String = MobileSys.getContent(path);

		var firstArray:Array<String> = fullText.split('\n');
		var swagOffsets:Array<Array<String>> = [];

		for (i in firstArray)
			swagOffsets.push(i.split(' '));

		return swagOffsets;
	}

	public static function returnAssetsLibrary(library:String, ?subDir:String = 'assets/images'):Array<String>
	{
		var libraryArray:Array<String> = [];

		var unfilteredLibrary = MobileSys.readDirectory('$subDir/$library');

		for (folder in unfilteredLibrary)
		{
			if (!folder.contains('.'))
				libraryArray.push(folder);
		}

		trace(libraryArray);

		return libraryArray;
	}

	public static function getAnimsFromTxt(path:String):Array<Array<String>>
	{
		var fullText:String = MobileSys.getContent(path);

		var firstArray:Array<String> = fullText.split('\n');
		var swagOffsets:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagOffsets.push(i.split('--'));
		}

		return swagOffsets;
	}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}
	
	public static function showPopUp(message:String, title:String):Void
	{
		#if android
		AndroidTools.showAlertDialog(title, message, {name: "OK", func: null}, null);
		#else
		FlxG.stage.window.alert(message, title);
		#end
	}
	
	static var externalAssetsTemp:Array<String> = [];
	static public function getExternalAssets():Array<String>
	{
		#if (sys && MODS_ALLOWED)
		forEachAssets(Paths.mods());
		#end
	    var assetPaths = externalAssetsTemp;
		externalAssetsTemp = [];
		CoolUtil.showPopUp(Std.string(assetPaths), "test");
		return assetPaths;
	}
	
	static public function forEachAssets(key:String = '') {
		CoolUtil.showPopUp(key, "for");
		if (FileSystem.exists(key)) {
			CoolUtil.showPopUp("true", "exists");
			for (folder in FileSystem.readDirectory(key))
			{
				var cut:String = '';
    	        if (!key.endsWith('/'))
     	   			cut = '/';
				if (!folder.contains('.')) {
					forEachAssets(folder);
				}
     	   		folder = key + cut + folder;
     	  	 	externalAssetsTemp.push(folder);
				CoolUtil.showPopUp(folder, "test");
			}
		}
	}
}
