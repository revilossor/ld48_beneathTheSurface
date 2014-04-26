package model 
{
	import entity.Player;
	import oli.Debug;
	import oli.Overlay;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Model 
	{
		public static const BASEPATH:String = Debug.IS_LIVE?"":"";	// use main swf loader info?
		public static const CONFIG_PATH:String = "assets/xml/config.xml";	
		
		public static var config:ConfigModel;
		public static var player:PlayerModel;
		public static var world:WorldModel;
		
		public static var overlay:Overlay;
		
		public static var currentLocation:uint = 1;
		
	}

}