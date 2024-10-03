package runtime.characters;

import gameObjects.Character;
import Paths;

class BFCar {
    public function init(name):Character {
        if (name == 'bf-car') {
            var character:Character = new Character();
            var tex = Paths.getSparrowAtlas('characters/bfCar');
            character.frames = tex;
            character.animation.addByPrefix('idle', 'BF idle dance', 24, false);
            character.animation.addByIndices('idlePost', 'BF idle dance', [8, 9, 10, 11, 12, 13, 14], "", 24, true);
            character.animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
            character.animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
            character.animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
            character.animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
            character.animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
            character.animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
            character.animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
            character.animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

            character.playAnim('idle');

            character.flipX = true;
            return character;
        }
        return null;
    }
}