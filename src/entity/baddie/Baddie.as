package entity.baddie 
{
	import model.Embed;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Baddie extends FlxSprite
	{	
		public function Baddie(xp:Number, yp:Number) 
		{
			super(xp, yp);
			makeGraphic(16, 16, 0xffff00ff);
		}
	
	}

}