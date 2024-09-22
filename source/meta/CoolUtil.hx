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
		#if MODS_ALLOWED
		var mainDirectory:String = Paths.mobilePath();
		switch (type) {
			case FILE:
				forEachAssets(mainDirectory);
			case FOLDER:
				forEachFolders(mainDirectory);
		}
		#end
	    var assetPaths = externalAssetsTemp;
		externalAssetsTemp = [];
		return assetPaths;
	}
	
	static public function forEachAssets(key:String = '') {
		#if sys
		if (FileSystem.exists(key)) {
			for (file in FileSystem.readDirectory(key))
			{
				if (file.contains('.')) {
     	   			file = pathFormat(key, file);
     	  		 	externalAssetsTemp.push(file);
				}
			}
		}
		#end
	}
	
	static public function forEachFolders(key:String = '') {
		#if sys
		if (FileSystem.exists(key)) {
			for (folder in FileSystem.readDirectory(key))
			{
				if (!folder.contains('.')) {
     	   			folder = pathFormat(key, folder);
					forEachAssets(folder);
     	  	 		externalAssetsTemp.push(folder);
				}
			}
		}
		#end
	}
	
	static function pathFormat(path:String, key:String = '')
	{
		var cut:String = '';
    	if (!path.endsWith('/') && !key.startWith('/'))
     		cut = '/';
     	return path + cut + key;
	}
	
	static public function findSongs():Array<String>
	{
		var containSongs:Array<String> = []
		for (i in getExternalAssets(FOLDER))
		{
			if (i.contains('assets/songs') || i.contains('mods/songs'))
				containSongs.push(i);
		}
		return containSongs;
	}
}

enum AssetType 
{
	FILE;
	FOLDER;
}