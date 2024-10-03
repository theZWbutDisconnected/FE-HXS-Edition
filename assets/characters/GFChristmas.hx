package runtime.characters;

import gameObjects.Character;
import Paths;

class GFChristmas {
    public function init(name):Character {
        if(name == 'gf-christmas'){
            var character:Character = new Character();
            var tex = Paths.getSparrowAtlas('characters/gfChristmas');
            character.frames = tex;
            character.animation.addByPrefix('cheer', 'GF Cheer', 24, false);
            character.animation.addByPrefix('singLEFT', 'GF left note', 24, false);
            character.animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
            character.animation.addByPrefix('singUP', 'GF Up Note', 24, false);
            character.animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
            character.animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
            character.animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
            character.animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
            character.animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
            character.animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
            character.animation.addByPrefix('scared', 'GF FEAR', 24);

            character.playAnim('danceRight');
            return character;
        }
        return null;
    }
}