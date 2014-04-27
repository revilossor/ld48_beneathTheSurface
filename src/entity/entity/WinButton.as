package entity.entity 
{
	import model.Embed;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class WinButton extends PressureSwitch
	{
		
		public function WinButton(xp:Number, yp:Number) 
		{
			super(xp, yp, 0xff00ff);
			loadGraphic(Embed.WIN_BUTTON, true, false, 20, 20);
		}
		
	}

}