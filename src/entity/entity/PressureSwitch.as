package entity.entity 
{
	import model.Embed;
	import model.Model;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class PressureSwitch extends FlxSprite
	{
		public var conecting:uint;
		
		public function PressureSwitch(xp:Number, yp:Number, conn:uint) 
		{
			super(xp, yp);
			conecting = conn;
			loadGraphic(Embed.PRESSURE_SWITCH, true, false, 20, 20);
			addAnimation("up", [0]);
			addAnimation("down", [1]);
			play("up");
		}
		override public function update():void {
			super.update();
			play("up");
		}
		
	}

}