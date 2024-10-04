package runtime.characters;

import gameObjects.Character;
import Paths;

class Pico {
    public function init(name):Character {
        if(name == 'pico'){
            var character:Character = new Character();
            var tex = Paths.getSparrowAtlas('characters/Pico_FNF_assetss');
            character.frames = tex;
            character.animation.addByPrefix('idle', "Pico Idle Dance", 24, false);
            character.animation.addByPrefix('singUP', 'pico Up note0', 24, false);
            character.animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
            if (character.isPlayer)
            {
                character.animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
                character.animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
                character.animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
                character.animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
            }
            else
            {
                // Need to be flipped! REDO THIS LATER!
                character.animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
                character.animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
                character.animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
                character.animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
            }

            character.animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
            character.animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);

            character.playAnim('idle');

            character.flipX = true;
            return character;
        }
        return null;
    }
}