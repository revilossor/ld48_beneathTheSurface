package model 
{
	import entity.LocationIconGroup;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import oli.Debug;
	import oli.flx.FlxPerlinMap;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Oliver Ross
	 * 
	 */
	public class WorldModel extends AbstractModel
	{
		private const colourKey:Array = [
			{ value:0.65, colour:0x26a9af},
			{ value:0.6, colour:0x219399},
			{ value:0.55, colour:0x1a757a},
			{ value:0.4, colour:0x155f63},
			{ value:0.35, colour:0x114e51},
			{ value:0.3, colour:0x0c3538},
			{ value:0.25, colour:0x13282c},		
			{ value:0.25, colour:0x0f2023}		
		];
		private var seed:int = Math.round(Math.random() * 1000000);
		private var _mapData:Bitmap;
		public var map:FlxPerlinMap;
		public var locations:Vector.<LocationModel>;
		
		public function WorldModel() 
		{
			Debug.log(this, "construct");
			super(Model.config.data.xml.world);
		}
		override public function create():void {
			Debug.log(this, "NAME : " + data.name + " SEED : " + seed);
			map = terrain;
			_mapData = map.members[0].bitmap;
			initLocations();
		}
		public function get terrain():FlxPerlinMap {
			if (_mapData == null) {	return map = new FlxPerlinMap(data.width, data.width, seed, 32, colourKey, data.scale);}
			return map = new FlxPerlinMap(data.width, data.width, seed, 32, colourKey, data.scale, _mapData); 
		}
		private function initLocations():void {
			var list:XMLList = data.locations.location;
			Debug.log(this, "init " + list.length() + " locations");
			locations = new Vector.<LocationModel>();
			for (var i:uint = 0; i < list.length(); i++) {
				Debug.log(this, "load location : " + list[i].@id);
				var thisLocation:LocationModel = new LocationModel(list[i]);
				thisLocation.worldLocation = new FlxPoint(100 + 100 * i , 100 + 200*i);//-----------------------------
				locations.push(thisLocation);
			}
		}

	}

}