package oli.steer 
{
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Steering 
	{
		
		public static function seek(e:FlxPoint, t:FlxPoint):FlxPoint
		{
			return VectorFunctions.getUnitBetween(e, t);
		}
		public static function flee(e:FlxPoint, t:FlxPoint):FlxPoint
		{
			return VectorFunctions.getUnitBetween(t, e);
		}
		
		public static function seekAtSpeed(e:FlxPoint, t:FlxPoint, s:Number):FlxPoint
		{
			return VectorFunctions.magnify(VectorFunctions.getUnitBetween(e, t), s);
		}
		public static function fleeAtSpeed(e:FlxPoint, t:FlxPoint, s:Number):FlxPoint
		{
			return VectorFunctions.magnify(VectorFunctions.getUnitBetween(t, e), s);
		}
	}

}