package entity 
{
	import model.Model;
	import oli.Debug;
	import oli.flx.FlxPerlinMap;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class World extends FlxGroup
	{
		private var _terrain:FlxPerlinMap;
		private var _icons:LocationIconGroup;	public function get icons():LocationIconGroup { return _icons; }
		
		public function World() 
		{
			super();
			Debug.log(this, "construct world");
			add(_terrain = Model.world.terrain);
			add(_icons = new LocationIconGroup(Model.world.locations));
		}
			
	}

}