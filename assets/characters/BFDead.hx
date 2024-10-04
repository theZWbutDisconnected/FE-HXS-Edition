package runtime.characters;

import gameObjects.Character;
import Paths;

class BFDead extends Character {
    public function init(name):Character {
        if(name == 'bf-dead'){
            var character:Character = new Character();
            character.frames = Paths.getSparrowAtlas('characters/BF_DEATH');

            character.animation.addByPrefix('firstDeath', "BF dies", 24, false);
            character.animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
            character.animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

            character.playAnim('firstDeath');

            character.flipX = true;
            return character;
        }
        return null;
    }
}