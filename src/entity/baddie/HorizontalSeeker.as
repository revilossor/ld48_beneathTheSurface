package entity.baddie 
{
	import flash.geom.Point;
	import model.Embed;
	import model.Model;
	import oli.steer.Steering;
	import oli.steer.VectorFunctions;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class HorizontalSeeker extends Baddie
	{
		private var _range:uint = 110;
		private var _speed:uint = 80;
		
		public function HorizontalSeeker(xp:Number, yp:Number) 
		{
			super(xp, yp);
			loadGraphic(Embed.HORIZONTAL_ROBOT, true, true, 16, 16);
			addAnimation("idle", [4]);
			addAnimation("move", [0, 1, 2, 3]);
			play("idle");
			maxVelocity = new FlxPoint(200, 200);
			acceleration = new FlxPoint(0, 1000);
		}
		override public function update():void {
			seek();
			if (velocity.x > 0) {
				facing = FlxObject.LEFT;
			}else {
				facing = FlxObject.RIGHT;
			}
		}
		private function seek():void {
			var playerLocation:FlxPoint = Model.playerChar.getMidpoint();
			var dist:Number = VectorFunctions.getDistanceBetween(getMidpoint(), playerLocation);
			if (dist < _range) {
				play("move");
				var vec:FlxPoint = Steering.seekAtSpeed(getMidpoint(), playerLocation, _speed);
				velocity.x = vec.x;
			}else {
				play("idle");
				velocity.x *= 0.9;
			}
		}
		
	}

}