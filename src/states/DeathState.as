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
	public class DeathState extends AbstractState
	{
		private var _title:FlxSprite;
		private var _space:FlxSprite;
		private var _died:FlxSprite;
		
		private var isReady:Boolean;
		private var t:uint = 0;
		
		public function DeathState() 
		{
			super();
		}
		override public function create():void {
			super.create();
			add(new FlxSprite(0, 0, Embed.MENU_BG));
			add(_title = new FlxSprite(0, 0, Embed.MENU_TITLE));
			add(_space = new FlxSprite(565, 387, Embed.SPACE_WORD));
			add(_died = new FlxSprite(256, 190, Embed.YOU_DIED));
			_died.alpha = 0.3;
		}
		override public function update():void {
			keyHandling();
			if (isReady) {
				_title.y += 3;
				_space.alpha *= 0.9;
				_space.scale.x = _space.scale.y *= 1.1;
				_died.scale.x = _died.scale.y *= 0.9;
			}else {
				var sin:Number = 1 * Math.sin(0.03 + (t++*0.03));
				_died.scale.x = _died.scale.y = 2 + sin;
			}
		}
		private function keyHandling():void {
			if (FlxG.keys.justReleased("SPACE")) {
				isReady = true;
				FlxG.fade(Colours.GREY_3, 1, gotoPlayState);
			}
		}
		private function gotoPlayState():void {
			FlxG.switchState(new LocationState(Model.currentLocation));
		}
		
	}

}