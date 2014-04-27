package model 
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import oli.Debug;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class PlayerModel extends AbstractModel
	{
		public var worldLocation:FlxPoint;
		
		public var maxAir:int = 500;
		public var currentAir:uint = 250;
		
		public function PlayerModel() 
		{
			Debug.log(this, "construct");
			super(Model.config.data.xml.player);
		}
		override public function create():void {
			worldLocation = new FlxPoint(200, 200); 
			Debug.log(this, "NAME : " + data.name);
		}
						
	}

}