package model 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import oli.Colours;
	import oli.Debug;
	import oli.Util;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class LocationModel extends AbstractModel
	{
		public var background:Bitmap;
		public var midground:Bitmap;
		public var midgroundSprites:Array = [];
		public var foreground:Bitmap;
		public var entitySprites:Array = [];
		public var spawnPoints:Array = [];
		
		public var doormap:Bitmap;
		
		public var worldLocation:FlxPoint;
		public var visited:Boolean = false;
		
		public function LocationModel(path:String) 
		{
			Debug.log(this, "construct");
			super(path);
		}
		override public function create():void {
			Debug.log(this, "NAME : " + data.name);
			
			loadBackground();
			loadMidground();
			loadForeground();
			loadSpawnPoints();
			loadDoormap();
		}
		private function loadBackground():void {
			loadSprite("" + (Model.config.data.basepath) + (data.background.sprite), function(e:Event):void {
				Debug.log(this, data.name + " background loaded");
				background = makeScaledGround(e.target.content);
			});
		}
		private function loadMidground():void {
			loadSprite("" + (Model.config.data.basepath) + (data.midground.sprite), function(e:Event):void {
				Debug.log(this, data.name + " midground loaded");
				makeMidground(midground = e.target.content);
			});
		}
		private function makeMidground(src:Bitmap):void {
			var n:Number = data.midground.size;
			for (var x:uint = 0; x < src.bitmapData.width; x++) {
				for (var y:uint = 0; y < src.bitmapData.height; y++) {
					if (src.bitmapData.getPixel(x, y) > 0) midgroundSprites.push( { "x":n * x, "y":n * y, "w":n, "h":n, "col":""+src.bitmapData.getPixel32(x,y) } );
				}
			}
		}
		private function loadForeground():void {
			loadSprite("" + (Model.config.data.basepath) + (data.foreground.sprite), function(e:Event):void {
				Debug.log(this, data.name + " foreground loaded");
				foreground = makeScaledGround(e.target.content);
			});
		}
		private function makeScaledGround(src:Bitmap):Bitmap {
			var bd:BitmapData = new BitmapData(src.bitmapData.width * data.midground.size, src.bitmapData.height * data.midground.size, true, 0x00000000);
			bd.draw(src.bitmapData, Util.getScaleMatrix(data.midground.size));			// blend mode
			return new Bitmap(bd);
		}
		private function loadSpawnPoints():void {
			loadSprite("" + (Model.config.data.basepath) + (data.midground.spawnmap), function(e:Event):void {
				Debug.log(this, data.name + " spawn map loaded");
				makeSpawnPoints(e.target.content);
			});
		}
		public function getSpawnPoint(key:String):FlxPoint {
			Debug.spawn(this, data.name + " getSpawnPoint(" + key + ");");
			for (var i:uint = 0; i < spawnPoints.length; i++) {
				if (spawnPoints[i][key]) {
					Debug.spawn(this, data.name + " key " + key + " found");
					return new FlxPoint(parseFloat(spawnPoints[i][key]["x"]), parseFloat(spawnPoints[i][key]["y"]));
				}
			}
			Debug.spawn(this, data.name + " key " + key + " not found");
			return new FlxPoint();
		}
		private function makeSpawnPoints(src:Bitmap):void {
			var n:Number = data.midground.size;
			for (var x:uint = 0; x < src.bitmapData.width; x++) {
				for (var y:uint = 0; y < src.bitmapData.height; y++) {
					if (src.bitmapData.getPixel(x, y) > 0) {
						switch(src.bitmapData.getPixel(x, y)) {
							case 0x7F6A00:
								spawnPoints.push( { "x":(n * x), "y":(n * y), "entity":"upspike" } );
								break;
							case 0x7F3300:
								spawnPoints.push( { "x":(n * x), "y":(n * y), "entity":"spike" } );
								break;
							case 0x7F0000:
								spawnPoints.push( { "x":(n * x) + 2, "y":(n * y) + 4, "entity":"horizontal-mover" } );
								break;
							case 0xff0000:
								spawnPoints.push( { "player": { "x":n * x, "y":n * y }} );
								spawnPoints.push( { "in": { "x":n * x, "y":n * y }} );
								break;
							case 0 :
							case 0x267f00:
								spawnPoints.push( { "out": { "x":n * x, "y":n * y }} );
								break;
							default:
								Debug.error(this, data.name + " not recognised colour : " + src.bitmapData.getPixel(x,y));
								break;
						}
					}
				}
			}
		}
		private function loadDoormap():void {
			loadSprite("" + (Model.config.data.basepath) + (data.midground.doormap), function(e:Event):void {
				Debug.log(this, data.name + " doormap loaded");
				makeDoormap(doormap = e.target.content);
			});
		}
		private function makeDoormap(src:Bitmap):void {
			var n:Number = data.midground.size;
			for (var x:uint = 0; x < src.bitmapData.width; x++) {
				for (var y:uint = 0; y < src.bitmapData.height; y++) {
				//	trace(src.bitmapData.getPixel(x, y).toString());
					if (src.bitmapData.getPixel(x, y) > 0) entitySprites.push( { "x":n * x, "y":n * y, "entity":"door" } );
				}
			}
		}
		public function getConnectingDoor(value:uint, thisDoor:FlxPoint):FlxPoint {
			for (var x:uint = 0; x < doormap.bitmapData.width; x++) {
				if (x == thisDoor.x && y == thisDoor.y) { continue; }
				for (var y:uint = 0; y < doormap.bitmapData.height; y++) {
					if (x == thisDoor.x && y == thisDoor.y) { 
						continue; 
					}
					if (doormap.bitmapData.getPixel(x, y) == value) {
						return new FlxPoint(x*data.midground.size, y*data.midground.size);
					}
				}
			}
			return new FlxPoint();
		}
		
	}

}