package model 
{
	import oli.Debug;
	import oli.XmlData;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class ConfigModel extends XmlData
	{
		
		public function ConfigModel() 
		{
			Debug.log(this, "construct");
			super(Model.CONFIG_PATH);
		}
		override public function create():void {
			Debug.log(this, "VERSION : " + data.version);
			Debug.LOGGING_ENABLED = data.debug.loggingEnabled;
			Model.player = new PlayerModel();
			Model.world = new WorldModel();
		}
		
	}

}