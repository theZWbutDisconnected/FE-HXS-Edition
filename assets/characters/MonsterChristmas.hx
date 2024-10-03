package runtime.characters;

import gameObjects.Character;
import Paths;

class MonsterChristmas {
    public function init(name):Character {
        if(name == 'monster-christmas'){
            var character:Character = new Character();
            var tex = Paths.getSparrowAtlas('characters/monsterChristmas');
            character.frames = tex;
            character.animation.addByPrefix('idle', 'monster idle', 24, false);
            character.animation.addByPrefix('singUP', 'monster up note', 24, false);
            character.animation.addByPrefix('singDOWN', 'monster down', 24, false);
            character.animation.addByPrefix('singRIGHT', 'Monster left note', 24, false);
            character.animation.addByPrefix('singLEFT', 'Monster Right note', 24, false);

            character.playAnim('idle');
            return character;
        }
        return null;
    }
}