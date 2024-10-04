package runtime.characters;

import gameObjects.Character;
import Paths;

class ParentsChristmas extends Character {
    public function init(name):Character {
        if(name == 'parents-christmas'){
            var character:Character = new Character();
            character.frames = Paths.getSparrowAtlas('characters/mom_dad_christmas_assets');
            character.animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
            character.animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
            character.animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
            character.animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
            character.animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);

            character.animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);

            character.animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
            character.animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
            character.animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);

            character.playAnim('idle');
            return character;
        }
        return null;
    }
}