package oli 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class PerlinMap extends Bitmap
	{
		public function PerlinMap(w:uint, h:uint, seed:int, octaves:uint, stitch:Boolean = false, fractal:Boolean = true ) 
		{
			super();
			bitmapData = new BitmapData(w, h);
			bitmapData.perlinNoise(w, h, octaves, seed, stitch, fractal, 7, true);  
		}
		
	}

}