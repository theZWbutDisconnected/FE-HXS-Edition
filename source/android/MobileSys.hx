package android;

import flixel.FlxG;
import openfl.utils.Assets;

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
		return Assets.exists(path);
	}

    public static function getContent(path:String):String
    {
        return Assets.getText(path);
    }
}