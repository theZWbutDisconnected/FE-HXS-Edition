package android;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.graphics.frames.FlxTileFrames;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxDestroyUtil;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.FlxGraphic;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;

class Hitbox extends FlxSpriteGroup
{
    public var hitbox:FlxSpriteGroup;
    public var hint:FlxSprite;
    public var buttonLeft:FlxButton;
    public var buttonDown:FlxButton;
    public var buttonUp:FlxButton;
    public var buttonRight:FlxButton;

    public function new()
    {
        super();

        hitbox = new FlxSpriteGroup();
        hitbox.scrollFactor.set();
        hitbox.add(add(buttonLeft = createHitbox(0, 0, 'left')));
        hitbox.add(add(buttonDown = createHitbox(320, 0, 'down')));
        hitbox.add(add(buttonUp = createHitbox(640, 0, 'up')));
        hitbox.add(add(buttonRight = createHitbox(960, 0, 'right')));
    }

	override public function destroy():Void
    {    
        buttonLeft = null;
        buttonDown = null;
        buttonUp = null;
        buttonRight = null;

        super.destroy();
    }

    public function createHitbox(x:Float, y:Float, curFrame:String) 
    {
        var frames = FlxAtlasFrames.fromSparrow('assets/android/hitbox.png', 'assets/android/hitbox.xml');
        var graphic:FlxGraphic = FlxGraphic.fromFrame(frames.getByName(curFrame));
        var button:FlxButton = new FlxButton(x, y);
        button.loadGraphic(graphic);
        button.alpha = 0;
        button.onDown.callback = function()
        {
            FlxTween.num(0, 0.75, .075, {ease: FlxEase.circInOut}, function(w:Float) 
            { 
                button.alpha = w;
            });
        };
        button.onUp.callback = function()
        {
            FlxTween.num(0.75, 0, .1, {ease: FlxEase.circInOut}, function(w:Float) 
            { 
                button.alpha = w;
            });
        }
        button.onOut.callback = function()
        {
            FlxTween.num(button.alpha, 0, .2, {ease: FlxEase.circInOut}, function(w:Float) 
            { 
                button.alpha = w;
            });
        }

        return button;
    }
}

class VirtualPad extends FlxSpriteGroup
{
	public var buttonA:FlxButton;
	public var buttonB:FlxButton;
	public var buttonC:FlxButton;
	public var buttonY:FlxButton;
	public var buttonX:FlxButton;
	public var buttonLeft:FlxButton;
	public var buttonUp:FlxButton;
	public var buttonRight:FlxButton;
	public var buttonDown:FlxButton;
	public var dPad:FlxSpriteGroup;
	public var actions:FlxSpriteGroup;

	public function new(?DPad:FlxDPadMode, ?Action:FlxActionMode)
	{
		super();
		scrollFactor.set();

		if (DPad == null)
			DPad = FULL;

		if (Action == null)
			Action = A_B_C;

		dPad = new FlxSpriteGroup();
		dPad.scrollFactor.set();

		actions = new FlxSpriteGroup();
		actions.scrollFactor.set();

		switch (DPad)
		{
			case UP_DOWN:
				dPad.add(add(buttonUp = createButton(0, FlxG.height - 85 * 3, 44 * 3, 45 * 3, "up")));
				dPad.add(add(buttonDown = createButton(0, FlxG.height - 45 * 3, 44 * 3, 45 * 3, "down")));
			case LEFT_RIGHT:
				dPad.add(add(buttonLeft = createButton(0, FlxG.height - 45 * 3, 44 * 3, 45 * 3, "left")));
				dPad.add(add(buttonRight = createButton(42 * 3, FlxG.height - 45 * 3, 44 * 3, 45 * 3, "right")));
			case UP_LEFT_RIGHT:
				dPad.add(add(buttonUp = createButton(35 * 3, FlxG.height - 81 * 3, 44 * 3, 45 * 3, "up")));
				dPad.add(add(buttonLeft = createButton(0, FlxG.height - 45 * 3, 44 * 3, 45 * 3, "left")));
				dPad.add(add(buttonRight = createButton(69 * 3, FlxG.height - 45 * 3, 44 * 3, 45 * 3, "right")));
			case FULL:
				dPad.add(add(buttonUp = createButton(35 * 3, FlxG.height - 116 * 3, 44 * 3, 45 * 3, "up")));
				dPad.add(add(buttonLeft = createButton(0, FlxG.height - 81 * 3, 44 * 3, 45 * 3, "left")));
				dPad.add(add(buttonRight = createButton(69 * 3, FlxG.height - 81 * 3, 44 * 3, 45 * 3, "right")));
				dPad.add(add(buttonDown = createButton(35 * 3, FlxG.height - 45 * 3, 44 * 3, 45 * 3, "down")));
			case RIGHT_FULL:
				dPad.add(add(buttonUp = createButton(FlxG.width - 86 * 3, FlxG.height - 66 - 116 * 3, 44 * 3, 45 * 3, "up")));
				dPad.add(add(buttonLeft = createButton(FlxG.width - 130 * 3, FlxG.height - 66 - 81 * 3, 44 * 3, 45 * 3, "left")));
				dPad.add(add(buttonRight = createButton(FlxG.width - 44 * 3, FlxG.height - 66 - 81 * 3, 44 * 3, 45 * 3, "right")));
				dPad.add(add(buttonDown = createButton(FlxG.width - 86 * 3, FlxG.height - 66 - 45 * 3, 44 * 3, 45 * 3, "down")));
			case NONE: 
				// Do nothing
		}

		switch (Action)
		{
			case A:
				actions.add(add(buttonA = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 45 * 3, "a")));
			case B:
				actions.add(add(buttonB = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 45 * 3, "b")));
			case A_B:
				actions.add(add(buttonA = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 45 * 3, "a")));
				actions.add(add(buttonB = createButton(FlxG.width - 86 * 3, FlxG.height - 45 * 3, 44 * 3, 45 * 3, "b")));
			case A_B_C:
				actions.add(add(buttonC = createButton(FlxG.width - 128 * 3, FlxG.height - 45 * 3, 44 * 3, 45 * 3, "c")));
				actions.add(add(buttonB = createButton(FlxG.width - 86 * 3, FlxG.height - 45 * 3, 44 * 3, 45 * 3, "b")));								
				actions.add(add(buttonA = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 45 * 3, "a")));
			case A_B_X_Y:
				actions.add(add(buttonY = createButton(FlxG.width - 170 * 3, FlxG.height - 45 * 3, 44 * 3, 45 * 3, "y")));
				actions.add(add(buttonX = createButton(FlxG.width - 128 * 3, FlxG.height - 45 * 3, 44 * 3, 45 * 3, "x")));
				actions.add(add(buttonB = createButton(FlxG.width - 86 * 3, FlxG.height - 45 * 3, 44 * 3, 45 * 3, "b")));								
				actions.add(add(buttonA = createButton(FlxG.width - 44 * 3, FlxG.height - 45 * 3, 44 * 3, 45 * 3, "a")));
			case NONE:
				// Do nothing
		}
	}

	override public function destroy():Void
	{
		super.destroy();

		dPad = FlxDestroyUtil.destroy(dPad);
		actions = FlxDestroyUtil.destroy(actions);

		dPad = null;
		actions = null;
		buttonA = null;
		buttonB = null;
		buttonC = null;
		buttonY = null;
		buttonX = null;
		buttonLeft = null;
		buttonUp = null;
		buttonDown = null;
		buttonRight = null;
	}

	public function createButton(X:Float, Y:Float, Width:Int, Height:Int, Graphic:String, ?OnClick:Void->Void):FlxButton
	{
		var button = new FlxButton(X, Y);
		var frame = FlxAtlasFrames.fromSpriteSheetPacker('assets/android/virtualpad.png', 'assets/android/virtualpad.txt').getByName(Graphic);
		button.frames = FlxTileFrames.fromFrame(frame, FlxPoint.get(Width, Height));
		button.resetSizeFromFrame();
		button.solid = false;
		button.immovable = true;
		button.scrollFactor.set();

		#if FLX_DEBUG
		button.ignoreDrawDebug = true;
		#end

		if (OnClick != null)
			button.onDown.callback = OnClick;

		return button;
	}
}

enum FlxDPadMode
{
	UP_DOWN;
	LEFT_RIGHT;
	UP_LEFT_RIGHT;
	RIGHT_FULL;
	FULL;
	NONE;
}

enum FlxActionMode
{
	A;
	B;
	A_B;
	A_B_C;
	A_B_X_Y;
	NONE;
}

class MobileControls extends FlxSpriteGroup
{
	public var mode:ControlsGroup = HITBOX;
	public var hitbox:Hitbox;
	public var virtualPad:VirtualPad;

	var config:MobileConfig;

	public function new() 
	{
		super();
		
		config = new MobileConfig();
		mode = getModeFromNumber(config.getControlMode());

		switch (mode)
		{
			case VIRTUALPAD_RIGHT:
				initVirtualPad(0);
			case VIRTUALPAD_LEFT:
				initVirtualPad(1);
			case VIRTUALPAD_CUSTOM:
				initVirtualPad(2);
			case HITBOX:
				hitbox = new Hitbox();
				if (config.getColor() == 1)
					hitbox.color = FlxColor.BLACK;
				add(hitbox);
			case KEYBOARD:
		}
	}

	function initVirtualPad(vpadMode:Int) 
	{
		switch (vpadMode)
		{
			case 1:
				virtualPad = new VirtualPad(FULL, NONE);
			case 2:
				virtualPad = new VirtualPad(FULL, NONE);
				virtualPad = config.loadCustom(virtualPad);
			default:
				virtualPad = new VirtualPad(RIGHT_FULL, NONE);
		}

		virtualPad.alpha = config.getAlpha() / 100;
		add(virtualPad);
	}

	public static function getModeFromNumber(modeNum:Int):ControlsGroup 
	{
		return switch (modeNum)
		{
			case 0: 
				VIRTUALPAD_RIGHT;
			case 1: 
				VIRTUALPAD_LEFT;
			case 2: 
				KEYBOARD;
			case 3: 
				VIRTUALPAD_CUSTOM;
			case 4:	
				HITBOX;
			default: 
				VIRTUALPAD_RIGHT;
		}
	}
}

enum ControlsGroup 
{
	VIRTUALPAD_RIGHT;
	VIRTUALPAD_LEFT;
	KEYBOARD;
	VIRTUALPAD_CUSTOM;
	HITBOX;
}