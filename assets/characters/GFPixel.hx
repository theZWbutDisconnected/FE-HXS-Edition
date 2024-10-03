package runtime.characters;

import gameObjects.Character;
import Paths;
import meta.state.PlayState;

class GFPixel {
    public function init(name):Character {
        if(name == 'gf-pixel'){
            var character:Character = new Character();
            var tex = Paths.getSparrowAtlas('characters/gfPixel');
            character.frames = tex;
            character.animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
            character.animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
            character.animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

            character.addOffset('danceLeft', 0);
            character.addOffset('danceRight', 0);

            character.playAnim('danceRight');

            character.setGraphicSize(Std.int(character.width * PlayState.daPixelZoom));
            character.updateHitbox();
            character.antialiasing = false;
            return character;
        }
        return null;
    }
}