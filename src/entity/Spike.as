package entity 
{
	import entity.baddie.Baddie;
	import model.Embed;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Spike extends Baddie
	{
		
		public function Spike(xp:Number, yp:Number) 
		{
			super(xp, yp);
			loadGraphic(Embed.SPIKE_SPRITE, false, false, 8, 8);
		}
		
	}

}