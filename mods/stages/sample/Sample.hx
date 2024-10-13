package runtime.stages;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxBasic;

class Sample {
    public function init():FlxTypedGroup<FlxBasic> {
        var stage:FlxTypedGroup<FlxBasic> = new FlxTypedGroup<FlxBasic>();
        return stage;
    }
}