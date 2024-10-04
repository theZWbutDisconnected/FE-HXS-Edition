package runtime.characters;

import gameObjects.Character;
import Paths;

class SenpaiAngry {
    public function init(name):Character {
        if(name == 'senpai-angry'){
            var character:Character = new Character();
            character.frames = Paths.getSparrowAtlas('characters/senpai');
            character.animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
            character.animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
            character.animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
            character.animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);
            character.animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);

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