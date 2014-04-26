package entity.world 
{
	import model.Embed;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class PlayerIcon extends FlxSprite
	{
		
		public function PlayerIcon(xp:uint, yp:uint) 
		{
			super(xp, yp);
			loadGraphic(Embed.PLAYER_ICON, true, false, 24, 24);
			addAnimation("idle", [1, 2, 3, 4, 5, 6, 7, 8, 7, 6, 5, 4, 3, 2, 1, 7, 7, 7, 7, 7, 7, 8, 7], 12);
			play("idle");
		}
		
	}

}