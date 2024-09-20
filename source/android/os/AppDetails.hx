package android.os;

#if (!android && !native)
#error 'extension-androidtools is not supported on your current platform'
#end

import lime.system.JNI;

class AppDetails {
    public static function getVersionName():String {
        var className = "org/haxe/extension/Details";
        var methodName = "getVersionName";
        
        var method = JNI.createStaticMethod(className, methodName, "()Ljava/lang/String;");
        
        return method();
    }
    
    public static function getVersionCode():Int {
        var className = "org/haxe/extension/Details";
        var methodName = "getVersionCode";
        
        var method = JNI.createStaticMethod(className, methodName, "()I");
        
        return method();
    }
    
    public static function getPackageName():String {
        var className = "org/haxe/extension/Details";
        var methodName = "getPackageName";
        
        var method = JNI.createStaticMethod(className, methodName, "()Ljava/lang/String;");
        
        return method();
    }
    
    public static function getAppName():String {
        var className = "org/haxe/extension/Details";
        var methodName = "getAppName";
        
        var method = JNI.createStaticMethod(className, methodName, "()Ljava/lang/String;");
        
        return method();
    }
}