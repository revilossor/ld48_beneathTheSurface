package oli.steer
{
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Oliver Ross
	 * 
	 * 
	 */
	public class VectorFunctions 
	{
		public static function addEq(a:FlxPoint, b:FlxPoint):FlxPoint
		{
			return new FlxPoint(a.x + b.x, a.y + b.y);
		}
		public static function subEq(a:FlxPoint, b:FlxPoint):FlxPoint
		{
			return new FlxPoint(a.x - b.x, a.y - b.y);
		}
		public static function divEq(a:FlxPoint, b:FlxPoint):FlxPoint
		{
			return new FlxPoint(a.x / b.x, a.y / b.y);
		}
		public static function mulEq(a:FlxPoint, b:FlxPoint):FlxPoint
		{
			return new FlxPoint(a.x * b.x, a.y * b.y);
		}
		
		public static function getUnitBetween(a:FlxPoint, b:FlxPoint):FlxPoint
		{
			return getUnit(getBetween(a, b));
		}
		public static function getBetween(a:FlxPoint, b:FlxPoint):FlxPoint
		{
			return new FlxPoint(b.x - a.x, b.y - a.y);
		}
		public static function getDistanceBetween(a:FlxPoint, b:FlxPoint):Number
		{
			return getMagnitude(getBetween(a, b)); 
		}
		public static function getMagnitude(v:FlxPoint):Number
		{
			return Math.sqrt(Math.pow(v.x, 2) + Math.pow(v.y, 2));
		}
		public static function getMagnitudeSq(v:FlxPoint):Number
		{
			return Math.pow(v.x, 2) + Math.pow(v.y, 2);
		}
		public static function getUnit(v:FlxPoint):FlxPoint
		{
			var mag:Number = getMagnitude(v);
			return new FlxPoint(v.x / mag, v.y / mag);
		}
		public static function magnify(v:FlxPoint, m:Number):FlxPoint
		{
			return new FlxPoint(v.x * m, v.y * m);
		}
		
		
	}

}