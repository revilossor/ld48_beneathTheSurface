package states 
{
	import model.Model;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class DeathState extends AbstractState
	{
		
		public function DeathState() 
		{
			super();
		}
		override public function create():void {
			FlxG.bgColor = 0xffff00ff
		}
		override public function update():void {
			keyHandling();
		}
		
		private function keyHandling():void {
			if (FlxG.keys.justReleased("SPACE")) {
				FlxG.switchState(new LocationState(Model.currentLocation));
			}
		}
		
	}

}