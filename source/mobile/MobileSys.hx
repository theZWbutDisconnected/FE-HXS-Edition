package mobile;

import flixel.FlxG;
import openfl.utils.Assets;
import sys.FileSystem;

using StringTools;

class MobileSys
{
    public static function justTouched():Bool
	{
		var justTouched:Bool = false;

		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
				justTouched = true;
		}

		#if mobile
 		return justTouched;
		#else
 		return false;
		#end
	}

	public static function androidBack():Bool
	{
		#if mobile
 		return FlxG.android.justReleased.BACK;
		#else
 		return false;
		#end
	}

    /* 
    ** Recreación de FileSystem.readDirectory()...
    ** Gracias a: https://stackoverflow.com/questions/25100106/is-it-possible-to-list-embedded-folder-contents
    ** y https://ashes999.github.io/learnhaxe/sorting-an-array-of-strings-in-haxe.html 
    */
    public static function readDirectory(path:String):Array<String>
	{
        var baseDirectory:Array<String> = [];
        var finalDirectory:Array<String> = [];

        for (trim in Assets.list())
        {
            if (trim.contains(path))
            {
                var cut:String = '';
                if (!path.endsWith('/'))
                    cut = '/';
                var folder:String = trim.replace(path + cut, '');
                baseDirectory.push(folder);
            }
        }

        for (file in baseDirectory)
        {
            var okay:Array<String> = file.split('/');
            if (okay[0].endsWith('assets') && okay.length > 1)
                okay[0] = null;
            if (!finalDirectory.contains(okay[0]))
                finalDirectory.push(okay[0]);
        }

        finalDirectory.sort(function(a:String, b:String):Int 
        {
            a = a.toUpperCase();
            b = b.toUpperCase();

            if (a < b)
                return -1;
            else if (a > b)
                return 1;
            else
                return 0;
        });

        return finalDirectory;
    }

    public static function exists(path:String):Bool
	{
		#if (sys && mobile && MODS_ALLOWED)
        var localPath:String = path.replace(Paths.mobilePath(), '');
        var finalPath:String = localPath;
        if (!localPath.contains(Paths.mobilePath()))
            finalPath = CoolUtil.pathFormat(Paths.mobilePath(), localPath);
		var existsF = FileSystem.exists(finalPath);
		if (existsF)
			return true;
		#end
        #if desktop
        var existsF = FileSystem.exists(CoolUtil.pathFormat('assets/', path));
        if (!existsF)
            existsF = FileSystem.exists(Paths.mods(path));
        if (existsF)
            return true;
        #end
		return #if desktop FileSystem.exists(path) #else Assets.exists(path) #end;
	}

    public static function getContent(path:String):String
    {
    	var daList:String = "";
		#if (sys && MODS_ALLOWED)
		if(FileSystem.exists(path)) daList = File.getContent(path);
		#else
		if(Assets.exists(path)) daList = Assets.getText(path);
		#end
		return daList;
    }
}