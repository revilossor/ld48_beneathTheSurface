package entity 
{
	import entity.baddie.Baddie;
	import model.Embed;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class TopSpike extends Baddie
	{
		
		public function TopSpike(xp:Number, yp:Number) 
		{
			super(xp, yp);
			loadGraphic(Embed.UPSPIKE_SPRITE, false, false, 8, 8);
		}
		
	}

}