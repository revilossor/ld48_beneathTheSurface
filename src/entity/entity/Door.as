package entity.entity 
{
	import model.Embed;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Door extends FlxSprite
	{
		
		public function Door(xp:uint, yp:uint) 
		{
			super(xp, yp);
			loadGraphic(Embed.DOOR_SPRITE, true, true, 9, 13);
			addAnimation("closed", [0]);
			addAnimation("opening", [1, 2, 3, 4, 5], 10, false);
			addAnimation("open", [5]);
			play("closed");
			immovable = true;
		}
		// set state plays correct amim...
		
	}

}