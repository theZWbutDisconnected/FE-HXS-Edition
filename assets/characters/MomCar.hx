package runtime.characters;

import gameObjects.Character;
import Paths;

class MomCar {
    public function init(name):Character {
        if(name == 'mom-car'){
            var character:Character = new Character();
            var tex = Paths.getSparrowAtlas('characters/momCar');
            character.frames = tex;

            character.animation.addByPrefix('idle', "Mom Idle", 24, false);
            character.animation.addByIndices('idlePost', 'Mom Idle', [10, 11, 12, 13], "", 24, true);
            character.animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
            character.animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
            character.animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
            // ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
            // CUZ DAVE IS DUMB!
            character.animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

            character.playAnim('idle');
            return character;
        }
        return null;
    }
}