package runtime.characters;

import gameObjects.Character;
import Paths;

class Spooky {
    public function init(name):Character {
        if(name == 'spooky'){
            var character:Character = new Character();
            var tex = Paths.getSparrowAtlas('characters/spooky_kids_assets');
            character.frames = tex;
            character.animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
            character.animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
            character.animation.addByPrefix('singLEFT', 'note sing left', 24, false);
            character.animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
            character.animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
            character.animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

            character.characterData.quickDancer = true;

            character.playAnim('danceRight');
            return character;
        }
        return null;
    }
}