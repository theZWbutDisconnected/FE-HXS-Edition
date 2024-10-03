package runtime.characters;

import gameObjects.Character;
import Paths;

class BFPixel {
    public function init(name):Character {
        if(name == 'bf-pixel'){
            var character:Character = new Character();
            character.frames = Paths.getSparrowAtlas('characters/bfPixel');
            character.animation.addByPrefix('idle', 'BF IDLE', 24, false);
            character.animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
            character.animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
            character.animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
            character.animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
            character.animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
            character.animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
            character.animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
            character.animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

            character.setGraphicSize(Std.int(character.width * 6));
            character.updateHitbox();

            character.playAnim('idle');

            character.width -= 100;
            character.height -= 100;

            character.antialiasing = false;

            character.flipX = true;
            return character;
        }
        return null;
    }
}