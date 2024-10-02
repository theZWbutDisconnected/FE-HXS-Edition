package meta.data;

import interpret.Env;
import interpret.DynamicModule;
import interpret.DynamicInstance;

using StringTools;

#if lime
import lime.app.Application as LimeApplication;
import lime.ui.WindowAttributes;
#end


class HScript
{
	var env:Env = new Env();
	var packag3:String;

	public function new() {
		env.addDefaultModules();
		env.addModule('haxe.Log', DynamicModule.fromStatic(haxe.Log));
		env.addModule('StringTools', DynamicModule.fromStatic(StringTools));
		env.addModule('meta.state.PlayState', DynamicModule.fromStatic(meta.state.PlayState));
	}

	public function loadModule(path:String) {
		var pArr = path.split('/');
		var expr:DynamicModule = DynamicModule.fromString(env, pArr[pArr.length - 1], MobileSys.getContent(Paths.script(path)));
		packag3 = expr.pack;
		env.addModule(packag3, expr);
		env.link();
	}

	public function getClass(name:String) {
		var clazz = env.modules.get(packag3).dynamicClasses.get(name);
		return clazz.createInstance();
	}

	public function callf(classInstance:DynamicInstance, name:String, ?args:Array<Dynamic>) {
		return classInstance.call(name, args);
	}
}
