package runtime.characters;

import gameObjects.Character;
import Paths;

class BFPixelDead extends Character {
    public function init(name):Character {
        if (name == 'bf-pixel-dead'){
            var character:Character = new Character();
            character.frames = Paths.getSparrowAtlas('characters/bfPixelsDEAD');
            character.animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
            character.animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
            character.animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
            character.animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
            character.animation.play('firstDeath');

            // pixel bullshit
            character.setGraphicSize(Std.int(character.width * 6));
            character.updateHitbox();
            character.antialiasing = false;
            character.flipX = true;

            character.characterData.offsetY = 180;
            return character;
        }
        return null;
    }
}