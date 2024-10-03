package runtime.characters;

import gameObjects.Character;
import Paths;

class Spirit {
    public function init(name):Character {
        if(name == 'spirit'){
            var character:Character = new Character();
            character.frames = Paths.getPackerAtlas('characters/spirit');
            character.animation.addByPrefix('idle', "idle spirit_", 24, false);
            character.animation.addByPrefix('singUP', "up_", 24, false);
            character.animation.addByPrefix('singRIGHT', "right_", 24, false);
            character.animation.addByPrefix('singLEFT', "left_", 24, false);
            character.animation.addByPrefix('singDOWN', "spirit down_", 24, false);

            character.setGraphicSize(Std.int(character.width * 6));
            character.updateHitbox();

            character.playAnim('idle');

            character.antialiasing = false;
            character.characterData.quickDancer = true;

            character.characterData.camOffsetY = 50;
            character.characterData.camOffsetX = 100;
            return character;
        }
        return null;
    }
}