package states 
{
	import model.Embed;
	import model.Model;
	import oli.Colours;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class InitState extends AbstractState
	{
		private var _space:FlxSprite;
		
		public function InitState() {	super();	}
		override public function create():void {
			super.create();
			FlxG.bgColor = Colours.GREY_3;
			add(_space = new FlxSprite(565, 387, Embed.SPACE_WORD));
			_space.alpha = 0;
		}
		override public function update():void {
			keyHandling();
			_space.alpha += 0.001;
		}
		private function keyHandling():void {
			if (FlxG.keys.justPressed("SPACE")) {	
				FlxG.play(Embed.SOUND_OK);
				FlxG.fade(0xffa0a0a0, 0.5, gotoMenuState); 	
			}
		}
		private function gotoMenuState():void {
		//	FlxG.switchState(new TestState());
			FlxG.switchState(new MenuState());
		//	FlxG.switchState(new WinState());
		}
	}

}