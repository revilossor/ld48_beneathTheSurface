package entity.entity 
{
	import model.Embed;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Switchable extends FlxSprite
	{
		public var value:uint;
		private var _initY:Number;
		private var _opening:Boolean;
		private var t:uint = 0;
		public function Switchable(xp:Number, yp:Number, val:uint) 
		{
			super(xp, yp, Embed.SWITCHABLE);
			_initY = yp;
			immovable = true;
			value = val;
		}
		public function doOpen():void {
			_opening = true;
			if (y > _initY - height) {
				y -= 0.1;
			}
		}
		override public function update():void {
			super.update();
			if (!_opening) {
				if (y < _initY) {
					y += 0.02;
				}
			}
			if (_opening && t++ % 13 == 0 && y > _initY - height) {
				FlxG.play(Embed.SOUND_SWITCHABLE, 0.3);
			}
			_opening = false;
		}
		
	}

}