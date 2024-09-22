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
	static public function getExternalAssets(type:AssetType = FILE):Array<String>
	{
		var mainDirectory:String = '/';
		#if (MODS_ALLOWED && mobile)
		mainDirectory = Paths.mobilePath();
		#end
		forEachDirectory(mainDirectory, type);
	    var assetPaths = externalAssetsTemp;
		externalAssetsTemp = [];
		//CoolUtil.showPopUp(Std.string(assetPaths), 'Getting External Assets');
		return assetPaths;
	}
	
	static public function forEachDirectory(key:String = '', type:AssetType) {
		#if sys
		//CoolUtil.showPopUp(key, 'Parent Directory');
		if (FileSystem.exists(key)) {
			for (file in FileSystem.readDirectory(key))
			{
				//CoolUtil.showPopUp(file, 'Child Asset');
				if (file.contains('.') && type == FILE) {
     	   			file = pathFormat(key, file);
     	  		 	externalAssetsTemp.push(file);
				} else if (!file.contains('.') && type == FOLDER) {
     	   			file = pathFormat(key, file);
					forEachDirectory(file, type);
     	  	 		externalAssetsTemp.push(file);
				}
				//CoolUtil.showPopUp(file, 'Child Asset[Formated]');
			}
		}
		#end
	}
	
	static function pathFormat(path:String, key:String = '')
	{
		var cut:String = '';
    	if (!path.endsWith('/') && !key.startsWith('/'))
     		cut = '/';
     	return path + cut + key;
	}
	
	static public function findSongs():Array<String>
	{
		var containSongs:Array<String> = [];
		for (i in getExternalAssets(FOLDER))
		{
			var flag0:Bool = i.contains('mods/songs/');
			if (i.contains('assets/songs/') || flag0)
				var songFrom:String = 'assets/songs/';
				if (flag0)
					songFrom = 'mods/songs/';
				var finalP:String = i.replace(Paths.mobilePath(songFrom));
				CoolUtil.showPopUp(finalP, 'Valid Song Directory');
				containSongs.push(finalP, '');
		}
		return containSongs;
	}
}

enum AssetType 
{
	FILE;
	FOLDER;
}