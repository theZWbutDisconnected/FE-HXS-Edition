package meta.data.script;

import meta.data.script.HScript;

class ScriptHandler {
    public var scripts:Array<HScript> = [];
    public var allows:Array<String>;

    public function new(allowScriptPaths:Array<String>) {
        allows = allowScriptPaths;
        for (i in CoolUtil.findScripts()) {
            if (contains(i)) {
                var script:HScript = new HScript();
                script.loadModule(i);
                scripts.push(script);
            }
        }
    }

    public function callFunction(name:String, ?args:Array<Dynamic>) {
        for (i in scripts) {
            for (j in i.getPackageFile().dynamicClasses) {
                var clazz = j.createInstance();
                if (clazz.exists(name)) {
                    var callback = i.callf(clazz, name, args);
                    if (callback != null)
                        return callback;
                }
            }
        }
        return null;
    }

    function contains(str:String) {
        for (i in allows) {
            if (str.toLowerCase().contains(i)) {
                return true;
            }
        }
        return false;
    }
}
