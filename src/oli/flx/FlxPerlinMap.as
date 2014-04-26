package oli.flx 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import oli.Debug;
	import oli.PerlinMap;
	import oli.Util;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class FlxPerlinMap extends FlxGroup
	{		
		public function FlxPerlinMap(width:uint, height:uint, seed:int, octaves:uint, colourKey:Array, tileSize:uint = 1, data:Bitmap = null) 
		{
			super();
			if (data == null) {
				Debug.log(this, "no bitmap data passed in - generating terrain");
				createTerrain(width, height, seed, octaves, colourKey.sortOn(['value']).reverse(), tileSize);
			}else {
				Debug.log(this, "dont generate perlin this time - just add the bitmap");
				add(new FlxBitmapSprite(0, 0, data));
			}
		}
		private function createTerrain(width:uint, height:uint, seed:int, octaves:uint, colourKey:Array, tileSize:uint = 1):void {
			var perlin:PerlinMap = new PerlinMap(width, height, seed, octaves);
			var bd:BitmapData = new BitmapData(width * tileSize, height * tileSize);
			bd.draw(getPercentBitmap(perlin, colourKey), Util.getScaleMatrix(tileSize));
			add(new FlxBitmapSprite(0, 0, new Bitmap(bd)));
		}
		private function getPercentBitmap(perlin:PerlinMap, colourKey:Array):Bitmap {
			var bd:BitmapData = new BitmapData(perlin.bitmapData.width, perlin.bitmapData.height);
			for (var y:uint = 0; y < perlin.bitmapData.height; y++) {
				for (var x:uint = 0; x < perlin.bitmapData.width; x++) {
					bd.setPixel(x, y, getColour(getPercentPixel(x, y, perlin), colourKey));
				}
			}
			return new Bitmap(bd);
		}
		private function getColour(percent:Number, key:Array):uint {
			for (var i:uint = 0; i < key.length; i++) {
				if (percent > key[i].value) { return key[i].colour; }
			}
			return 0x000000;
		}
		private function getPercentPixel(xp:uint, yp:uint, bitmap:Bitmap):Number {	// RGB
			return bitmap.bitmapData.getPixel(xp, yp) / 0xffffff;
		}
		
	}

}