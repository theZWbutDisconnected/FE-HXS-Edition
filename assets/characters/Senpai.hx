package runtime.characters;

import gameObjects.Character;
import Paths;

class Senpai {
    public function init(name):Character {
        if(name == 'senpai'){
            var character:Character = new Character();
            character.frames = Paths.getSparrowAtlas('characters/senpai');
            character.animation.addByPrefix('idle', 'Senpai Idle', 24, false);
            character.animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
            character.animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
            character.animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
            character.animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

            character.playAnim('idle');

            character.setGraphicSize(Std.int(character.width * 6));
            character.updateHitbox();

            character.antialiasing = false;

            character.characterData.camOffsetY = -330;
            character.characterData.camOffsetX = -200;
            return character;
        }
        return null;
    }
}