package entity.entity 
{
	import model.Embed;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Portal extends FlxSprite
	{
		public static const NEXT:String = "next";
		public static const LAST:String = "last";
		
		private var _dir:String; public function get direction():String { return _dir; }
		
		public function Portal(xp:uint, yp:uint, dir:String) 
		{
			super(xp, yp);
			_dir = dir;
			loadGraphic(Embed.PORTAL_SPRITE, true, true, 9, 13);
			addAnimation("closed", [0]);
			addAnimation("opening", [1, 2, 3, 4, 5], 10, false);
			addAnimation("open", [5]);
			play("closed");
			immovable = true;
		}
		
	}

}