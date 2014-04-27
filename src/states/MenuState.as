package states 
{
	import entity.ParticleManager;
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
		private var _by:FlxSprite;
		private var _water:FlxSprite;
		private var t:uint = 0;
		private var isReady:Boolean;
		private var notPlayed:Boolean = true;
		
		public function MenuState() 
		{
			super();
		}
		override public function create():void {
			super.create();
			Model.player.deaths = 0;
			add(new FlxSprite(0, 0, Embed.MENU_BG));
			add(_title = new FlxSprite(0, 0, Embed.MENU_TITLE));
			add(_space = new FlxSprite(565, 387, Embed.SPACE_WORD));
			add(_by = new FlxSprite(5, 50, Embed.BY));
			add(_water = new FlxSprite(0, 440, Embed.MENU_WATER));
		}
		override public function update():void {
			var sin:Number = 1 * Math.sin(0.03 + (t++*0.03));
			_water.alpha = 0.25 + (sin * 0.2);
			if (_water.y > 100) {
				_water.y--;
			}else {
				_water.y-=sin*0.25;
			}
			keyHandling();
			if (isReady) {
				_title.y += 3;
				_space.alpha = _by.alpha *= 0.9;
				_space.scale.x = _space.scale.y *= 1.1;
			}
			if (_title.y + _title.height >= _water.y && notPlayed) {
				notPlayed = false;
				FlxG.play(Embed.SOUND_SPLASH);
			}
		}
		private function keyHandling():void {
			if (FlxG.keys.justReleased("SPACE")) {
				FlxG.play(Embed.SOUND_OK);
				isReady = true;
				FlxG.fade(Colours.GREY_3, 1, gotoPlayState);
			}
		}
		
		private function gotoPlayState():void {
			FlxG.switchState(new LocationState(Model.currentLocation));
		}
	}

}