package android;

import flixel.util.FlxSave;
import flixel.math.FlxPoint;
import android.MobileControls;
import android.*;

class MobileConfig 
{
    var save:FlxSave;

    public function new() 
    {
        save = new FlxSave();
    	save.bind('saveconrtol');
    }

	public function setAlpha(alpha:Float = 0):Float
	{
		if (save.data.alphaControl == null) 
			save.data.alphaControl = 1;

        save.data.alphaControl = alpha;
        save.flush();

        return save.data.alphaControl;
    }

	public function setControlMode(mode:Int = 0):Int 
	{
		if (save.data.buttonsmode == null) 
			save.data.buttonsmode = new Array();

        save.data.buttonsmode[0] = mode;
        save.flush();

        return save.data.buttonsmode[0];
    }

	public function setColor(color:Int = 0):Int 
	{
		if (save.data.colorControl == null) 
			save.data.colorControl = 0;

        save.data.colorControl = color;
        save.flush();

        return save.data.colorControl;
    }

    public function saveCustom(pad:VirtualPad) 
	{
		if (save.data.buttons == null)
		{
			save.data.buttons = new Array();

			for (buttons in pad)
				save.data.buttons.push(FlxPoint.get(buttons.x, buttons.y));
		}
		else
		{
			var tempCount:Int = 0;

			for (buttons in pad)
			{
				save.data.buttons[tempCount] = FlxPoint.get(buttons.x, buttons.y);

				tempCount++;
			}
		}

		save.flush();
	}

	public function getAlpha():Int 
	{
		if (save.data.alphaControl == null)
			save.data.alphaControl = 0;

		if (save.data.alphaControl != null) 
			return save.data.alphaControl;

        return 0;
    }

	public function getControlMode():Int 
	{
		if (save.data.buttonsmode != null) 
			return save.data.buttonsmode[0];

        return 0;
    }

	public function getColor():Int 
	{
		if (save.data.colorControl == null)
			save.data.colorControl = 0;

		if (save.data.colorControl != null) 
			return save.data.colorControl;

        return 0;
    }

	public function loadCustom(pad:VirtualPad):VirtualPad 
	{
		var tempCount:Int = 0;

		if (save.data.buttons == null) 
			return pad;

		for (buttons in pad)
		{
			buttons.x = save.data.buttons[tempCount].x;
			buttons.y = save.data.buttons[tempCount].y;
			tempCount++;
		}	

        return pad;
	}
}