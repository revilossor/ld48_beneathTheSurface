package states 
{
	import model.Embed;
	import model.Model;
	import oli.Colours;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class WinState extends AbstractState
	{
		private var _title:FlxSprite;
		private var _space:FlxSprite;
		private var _won:FlxSprite;
		private var deathText:FlxText;
		private var isReady:Boolean;
		private var t:uint = 0;
		
		public function WinState() 
		{
			super();
		}
		override public function create():void {
			super.create();
			add(new FlxSprite(0, 0, Embed.MENU_BG));
			add(_title = new FlxSprite(0, 0, Embed.MENU_TITLE));
			add(_space = new FlxSprite(565, 387, Embed.SPACE_WORD));
			deathText = new FlxText(10, 405, 360, "deaths : " + Model.player.deaths);
			deathText.setFormat(null, 16, 0x7f0000, "left");
			add(deathText);
			add(_won = new FlxSprite(256, 190, Embed.YOU_WON));
			_won.alpha = 0.3;
		}
		override public function update():void {
			keyHandling();
			if (isReady) {
				_title.y += 3;
				_space.alpha *= 0.9;
				_space.scale.x = _space.scale.y *= 1.1;
				_won.scale.x = _won.scale.y *= 0.9;
			}else {
				var sin:Number = 1 * Math.sin(0.03 + (t++*0.03));
				_won.scale.x = _won.scale.y = 2 + sin;
			}
		}
		private function keyHandling():void {
			if (FlxG.keys.justReleased("SPACE")) {
				isReady = true;
				FlxG.play(Embed.SOUND_OK);
				FlxG.fade(Colours.GREY_3, 1, gotoMenuState);
			}
		}
		private function gotoMenuState():void {
			Model.currentLocation = 0;
			FlxG.switchState(new MenuState());
		}
		
		
	}

}