package oli 
{
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Util 
	{
		public static function getScaleMatrix(c:Number):Matrix {
			var m:Matrix = new Matrix();
			m.scale(c, c);
			return m;
		}
		public static function getClourInversionColourTransform():ColorTransform {
			return new ColorTransform( -1, -1, -1, -1, 255, 255, 255, 0);
		}
		
	}

}