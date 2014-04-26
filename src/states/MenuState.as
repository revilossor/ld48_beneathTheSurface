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
	public class MenuState extends AbstractState
	{
		private var _title:FlxSprite;
		private var _space:FlxSprite;
		
		public function MenuState() 
		{
			super();
		}
		override public function create():void {
			super.create();
			add(new FlxSprite(0, 0, Embed.MENU_BG));
			add(_title = new FlxSprite(0, 0, Embed.MENU_TITLE));
			add(_space = new FlxSprite(565, 387, Embed.SPACE_WORD));
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
			FlxG.switchState(new LocationState(Model.currentLocation));
		}
	}

}