package runtime.characters;

import gameObjects.Character;
import Paths;

class Dad {
    public function init(name):Character {
        if(name == 'dad'){
            var character:Character = new Character();
            var tex = Paths.getSparrowAtlas('characters/DADDY_DEAREST');
            character.frames = tex;
            character.animation.addByPrefix('idle', 'Dad idle dance', 24, false);
            character.animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
            character.animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
            character.animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
            character.animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

            character.playAnim('idle');
            return character;
        }
        return null;
    }
}