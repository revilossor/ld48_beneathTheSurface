package states 
{
	import oli.Colours;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class InitState extends AbstractState
	{
		public function InitState() {	super();	}
		override public function create():void {
			super.create();
			FlxG.bgColor = Colours.GREY_3;
		}
		override public function update():void {
			keyHandling();
		}
		private function keyHandling():void {
			if (FlxG.keys.justPressed("SPACE")) {	FlxG.fade(0xffa0a0a0, 0.5, gotoMenuState); 	}
		}
		private function gotoMenuState():void {
		//	FlxG.switchState(new TestState());
			FlxG.switchState(new MenuState());
		}
	}

}