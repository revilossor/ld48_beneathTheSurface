package oli 
{
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Debug 
	{
		public static var LOGGING_ENABLED:Boolean = true;
		public static var HIT_LOGGING_ENABLED:Boolean = false;
		public static var MOVEMENT_LOGGING_ENABLED:Boolean = false;
		public static var STATE_LOGGING_ENABLED:Boolean = false;
		public static var SPAWN_LOGGING_ENABLED:Boolean = false;
		public static var IS_LIVE:Boolean = false;
		
		public static function log(from:*, message:String):void {	if(LOGGING_ENABLED){trace("[" + getQualifiedClassName(from) + "] " + message);}	}
		public static function error(from:*, message:String):void {	if (LOGGING_ENABLED) { trace("***[" + getQualifiedClassName(from) + "]*** " + message); }	}
		public static function input(from:*, message:String):void {	if (LOGGING_ENABLED && MOVEMENT_LOGGING_ENABLED) { trace(">[" + getQualifiedClassName(from) + "]< " + message); }	}
		public static function spawn(from:*, message:String):void {	if (LOGGING_ENABLED && SPAWN_LOGGING_ENABLED) { trace("$[" + getQualifiedClassName(from) + "]$ " + message); }	}
		public static function state(from:*, message:String):void {	if (LOGGING_ENABLED && STATE_LOGGING_ENABLED) { trace("~[" + getQualifiedClassName(from) + "]~ " + message); }	}
		public static function hit(from:*, first:*, second:*):void {	if (LOGGING_ENABLED && HIT_LOGGING_ENABLED) { trace("...[" + getQualifiedClassName(from) + "]... " + getQualifiedClassName(first) + " hit " + getQualifiedClassName(second)); }	}	
	}

}