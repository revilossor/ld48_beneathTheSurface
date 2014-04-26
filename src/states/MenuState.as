package states 
{
	import oli.Colours;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class MenuState extends AbstractState
	{
		
		public function MenuState() 
		{
			super();
		}
		override public function create():void {
			super.create();
		}
		override public function update():void {
			keyHandling();
		}
		private function keyHandling():void {
			if (FlxG.keys.justReleased("SPACE")) {
				FlxG.fade(Colours.GREY_3, 1, gotoPlayState);
			}
		}
		
		private function gotoPlayState():void {
			FlxG.switchState(new LocationState(0));
		}
	}

}