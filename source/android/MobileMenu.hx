package android;

import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import openfl.filters.BitmapFilter;
import flixel.input.touch.FlxTouch;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import openfl.filters.ColorMatrixFilter;
import meta.data.font.Alphabet;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.FlxSprite;
import android.MobileControls;
import meta.MusicBeat;
import android.*;

class MobileMenu extends MusicBeatSubState
{
	var alphaItems:Array<Float> = [1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1];
	var controlItems:Array<String> = ['Right', 'Left', 'Keyboard', 'Custom', 'Hitbox'];
	var colorItems:Array<String> = ['Normal', 'Black'];
	var vpad:VirtualPad;
	var hitbox:Hitbox;

	var isTouched:Bool = false;
	var curAlpha:Int = 0;
	var curControl:Int = 0;
	var curColor:Int = 0;

	var arrowGroup:FlxTypedGroup<FlxSprite>;
	var alphaTxt:Alphabet;
	var controlTxt:Alphabet;
	var colorTxt:Alphabet;
	var paramsTxt:FlxText;
	var bindButton:FlxButton;
	var config:MobileConfig;

	public function new()
	{
		super();

		#if desktop
		FlxG.mouse.visible = true;
		#end

		config = new MobileConfig();
		curAlpha = config.getAlpha();
		curControl = config.getControlMode();
		curColor = config.getColor();

		var bg = new FlxSprite(-85);
		bg.loadGraphic(Paths.image('menus/base/menuDesat'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.color = 0xCE64DF;
		bg.antialiasing = true;
		add(bg);

		vpad = new VirtualPad(RIGHT_FULL, NONE);
		vpad.alpha = 0.00001;
		this.add(vpad);

		hitbox = new Hitbox();
		hitbox.visible = false;
		add(hitbox);

		alphaTxt = new Alphabet(-20, 50, '' + alphaItems[0], false, false);
		alphaTxt.screenCenter(X);
		alphaTxt.x -= 400;
		add(alphaTxt);

		controlTxt = new Alphabet(0, 0, controlItems[0], false, false);
		controlTxt.screenCenter(X);
		add(controlTxt);

		colorTxt = new Alphabet(0, -10, colorItems[0], false, false);
		colorTxt.screenCenter(X);
		colorTxt.x += 400;
		add(colorTxt);

		paramsTxt = new FlxText(5, FlxG.height - 72, 0, 'Ok', 18);
		paramsTxt.setFormat('assets/fonts/vcr.ttf', 18, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		paramsTxt.borderSize = 1.45;
		add(paramsTxt);

		var descTxt:FlxText = new FlxText(FlxG.width - 332, FlxG.height - 25, 0, 'Press BACK to return to the options.', 16);
		descTxt.setFormat('assets/fonts/vcr.ttf', 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descTxt.borderSize = 1.6;
		add(descTxt);

		arrowGroup = new FlxTypedGroup<FlxSprite>();
		add(arrowGroup);

		for (i in 0...6)
		{
			var string:String = 'right';
			if (i == 0 || i == 2 || i == 4) string = 'left';
			var arrow:FlxSprite = new FlxSprite(0, 30);
			arrow.frames = FlxAtlasFrames.fromSparrow('assets/android/menu/arrows.png', 'assets/android/menu/arrows.xml');
			arrow.animation.addByPrefix('idle', 'arrow ' + string);
			arrow.animation.addByPrefix('press', 'arrow push ' + string);
			arrow.animation.play('idle');
			arrow.antialiasing = true;
			arrowGroup.add(arrow);
		}

		changeAlpha();
		changeControl();
		changeColor();
	}

	override function update(elapsed:Float)
	{
		if (curControl != 4 && curControl != 2)
		{
			paramsTxt.text = 'Button Up X: ' + vpad.buttonUp.x + ' | Button Up Y: ' + vpad.buttonUp.y +
			'\nButton Down X: ' + vpad.buttonDown.x + ' | Button Down Y: ' + vpad.buttonDown.y +
			'\nButton Left X: ' + vpad.buttonLeft.x + ' | Button Left Y: ' + vpad.buttonLeft.y +
			'\nButton Right X: ' + vpad.buttonRight.x + ' | Button Right Y: ' + vpad.buttonRight.y + '\n';
		}
		else if (curControl != 2)
		{
			paramsTxt.text = 'Hitbox Up X: ' + hitbox.buttonUp.x + ' | Hitbox Up Y: ' + hitbox.buttonUp.y +
			'\nHitbox Down X: ' + hitbox.buttonDown.x + ' | Hitbox Down Y: ' + hitbox.buttonDown.y +
			'\nHitbox Left X: ' + hitbox.buttonLeft.x + ' | Hitbox Left Y: ' + hitbox.buttonLeft.y +
			'\nHitbox Right X: ' + hitbox.buttonRight.x + ' | Hitbox Right Y: ' + hitbox.buttonRight.y + '\n';
		}

		if (curControl == 2)
			paramsTxt.alpha = 0.0001;
		else
			paramsTxt.alpha = 1;

		if (curColor == 1 && curControl == 4)
			hitbox.color = FlxColor.BLACK;
		else if (curControl != 2)
			vpad.alpha = alphaItems[curAlpha];

		if (controls.BACK || MobileSys.androidBack())
		{
			config.setAlpha(curAlpha);
            config.setControlMode(curControl);
			config.setColor(curColor);

	    	if (curControl == 3)
        		config.saveCustom(vpad);

			FlxG.switchState(new meta.state.menus.OptionsMenuState());
		}

		for (touch in FlxG.touches.list)
		{
			if (touch.overlaps(arrowGroup.members[0]) && touch.justPressed)
				changeAlpha(-1);
			else if (touch.overlaps(arrowGroup.members[1]) && touch.justPressed)
				changeAlpha(1);

			if (touch.overlaps(arrowGroup.members[2]) && touch.justPressed)
				changeControl(-1);
			else if (touch.overlaps(arrowGroup.members[3]) && touch.justPressed)
				changeControl(1);

			if (touch.overlaps(arrowGroup.members[4]) && touch.justPressed)
				changeColor(-1);
			else if (touch.overlaps(arrowGroup.members[5]) && touch.justPressed)
				changeColor(1);

			trackButton(touch);
		}

		#if desktop
		if (FlxG.mouse.overlaps(arrowGroup.members[0]) && FlxG.mouse.justPressed)
			changeAlpha(-1);
		else if (FlxG.mouse.overlaps(arrowGroup.members[1]) && FlxG.mouse.justPressed)
			changeAlpha(1);

		if (FlxG.mouse.overlaps(arrowGroup.members[2]) && FlxG.mouse.justPressed)
			changeControl(-1);
		else if (FlxG.mouse.overlaps(arrowGroup.members[3]) && FlxG.mouse.justPressed)
			changeControl(1);

		if (FlxG.mouse.overlaps(arrowGroup.members[4]) && FlxG.mouse.justPressed)
			changeColor(-1);
		else if (FlxG.mouse.overlaps(arrowGroup.members[5]) && FlxG.mouse.justPressed)
			changeColor(1);
		#end

		super.update(elapsed);
	}

	function changeAlpha(change:Int = 0)
	{
		curAlpha += change;
	
		if (curAlpha < 0)
			curAlpha = alphaItems.length - 1;
		if (curAlpha >= alphaItems.length)
			curAlpha = 0;

		remove(alphaTxt);
		alphaTxt = new Alphabet(-20, 50, '' + alphaItems[curAlpha], false, false);
		alphaTxt.screenCenter(X);
		alphaTxt.x -= 400;
		add(alphaTxt);

		arrowGroup.members[0].x = alphaTxt.x - 60;
		arrowGroup.members[1].x = alphaTxt.x + alphaTxt.width + 15;
		
		FlxG.camera.flash(FlxColor.BLACK, 0.15);
		FlxG.sound.play('assets/sounds/scrollMenu.ogg');
		config.setAlpha(curAlpha);
	}

	function changeControl(change:Int = 0,?forceChange:Int)
	{
		curControl += change;
	
		if (curControl < 0)
			curControl = controlItems.length - 1;
		if (curControl >= controlItems.length)
			curControl = 0;
	
		if (forceChange != null)
		{
			curControl = forceChange;
			if (curControl == 2)
				vpad.visible = true;

			return;
		}

		remove(controlTxt);
		controlTxt = new Alphabet(0, -10, controlItems[curControl], false, false);
		controlTxt.screenCenter(X);
		add(controlTxt);

		arrowGroup.members[2].x = controlTxt.x - 60;
		arrowGroup.members[3].x = controlTxt.x + controlTxt.width + 15;

		hitbox.visible = false;
		
		FlxG.camera.flash(FlxColor.BLACK, 0.15);
		FlxG.sound.play('assets/sounds/scrollMenu.ogg');
				
		switch (curControl)
		{
			case 0:
				this.remove(vpad);
				vpad = null;
				vpad = new VirtualPad(RIGHT_FULL, NONE);
				vpad.alpha = 0.75;
				this.add(vpad);
			case 1:
				this.remove(vpad);
				vpad = null;
				vpad = new VirtualPad(FULL, NONE);
				vpad.alpha = 0.75;
				this.add(vpad);
			case 2:
				this.remove(vpad);
			case 3:
				this.add(vpad);
				vpad.alpha = 0.75;
        		vpad = config.loadCustom(vpad);	
			case 4:
				remove(vpad);
				vpad.alpha = 0.00001;
				hitbox.visible = true;
		}
	}

	function changeColor(change:Int = 0)
	{
		curColor += change;
	
		if (curColor < 0)
			curColor = colorItems.length - 1;
		if (curColor >= colorItems.length)
			curColor = 0;

		remove(colorTxt);
		colorTxt = new Alphabet(0, -10, colorItems[curColor], false, false);
		colorTxt.screenCenter(X);
		colorTxt.x += 400;
		add(colorTxt);

		arrowGroup.members[4].x = colorTxt.x - 60;
		arrowGroup.members[5].x = colorTxt.x + colorTxt.width + 15;
		
		FlxG.camera.flash(FlxColor.BLACK, 0.15);
		FlxG.sound.play('assets/sounds/scrollMenu.ogg');

		switch (colorItems[curColor])
		{
			case 'Black':
				hitbox.color = FlxColor.BLACK;
			case 'Normal':
				hitbox.color = FlxColor.WHITE;
		}
	}

	function moveButton(touch:FlxTouch, button:FlxButton) 
	{
		button.x = touch.x - vpad.buttonUp.width / 2;
		button.y = touch.y - vpad.buttonUp.height / 2;

		bindButton = button;
		isTouched = true;
	}

	function trackButton(touch:FlxTouch)
	{
		if (isTouched)
		{
			if (bindButton.justReleased && touch.justReleased)
			{
				bindButton = null;
				isTouched = false;
			}
			else 
				moveButton(touch, bindButton);
		}
		else 
		{
			if (vpad.buttonUp.justPressed) 
			{
				if (curControl != 3)
					changeControl(0, 3);

				moveButton(touch, vpad.buttonUp);
			}
			
			if (vpad.buttonDown.justPressed) 
			{
				if (curControl != 3)
					changeControl(0, 3);

				moveButton(touch, vpad.buttonDown);
			}

			if (vpad.buttonRight.justPressed) 
			{
				if (curControl != 3)
					changeControl(0, 3);

				moveButton(touch, vpad.buttonRight);
			}

			if (vpad.buttonLeft.justPressed) 
			{
				if (curControl != 3)
					changeControl(0, 3);

				moveButton(touch, vpad.buttonLeft);
			}
		}
	}
}