package runtime.characters;

import gameObjects.Character;
import Paths;

class Mom extends Character {
    public function init(name):Character {
        if(name == 'mom'){
            var character:Character = new Character();
            var tex = Paths.getSparrowAtlas('characters/Mom_Assets');
            character.frames = tex;

            character.animation.addByPrefix('idle', "Mom Idle", 24, false);
            character.animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
            character.animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
            character.animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
            // ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
            // CUZ DAVE IS DUMB!

            // maybe youre just dumb for not telling him to name it that
            // dw im also dumb
            character.animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

            character.playAnim('idle');

            character.characterData.camOffsetY = 100;
            return character;
        }
        return null;
    }
}