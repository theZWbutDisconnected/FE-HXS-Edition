package runtime.characters;

import gameObjects.Character;
import Paths;

class BFChristmas {
    public function init(name):Character {
        if (name == 'bf-christmas') {
            var character:Character = new Character();
            var tex = Paths.getSparrowAtlas('characters/bfChristmas');
            character.frames = tex;
            character.animation.addByPrefix('idle', 'BF idle dance', 24, false);
            character.animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
            character.animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
            character.animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
            character.animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
            character.animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
            character.animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
            character.animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
            character.animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
            character.animation.addByPrefix('hey', 'BF HEY', 24, false);

            character.playAnim('idle');

            character.flipX = true;
            return character;
        }
        return null;
    }
}