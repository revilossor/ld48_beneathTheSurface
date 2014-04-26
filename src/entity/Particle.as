package entity 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Particle extends FlxSprite
	{
		private var _t:int = 25 + Math.round(Math.random()*10);
		
		public function Particle(xp:Number, yp:Number, vel:FlxPoint, col:uint) 
		{
			super(xp, yp);
			makeGraphic(2, 2, col);
			maxVelocity = new FlxPoint(200, 200);
			velocity = vel;
			if (Math.abs(velocity.y) < 10) { 
				velocity.y -= 100 + (Math.random() * 100);
			}
			alpha = 0.5 + (Math.random() * 0.5);
			acceleration = new FlxPoint(0, 1000);
		}
		override public function update():void {
			if (--_t == 0) {
				kill();
			}
		}
		
	}

}