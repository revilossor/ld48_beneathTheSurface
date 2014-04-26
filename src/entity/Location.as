package entity 
{
	import entity.baddie.HorizontalRobot;
	import entity.entity.Door;
	import entity.entity.Portal;
	import model.Model;
	import oli.Debug;
	import oli.flx.FlxBitmapSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Location extends FlxGroup
	{
		public var background:FlxBitmapSprite
		public var midground:FlxGroup;
		public var foreground:FlxBitmapSprite;
		
		public var entities:FlxGroup;
		private var _index:uint = 0;
		
		public var portalIn:Portal;
		public var portalOut:Portal;
		
		public function Location(index:uint) 
		{
			super();
			_index = index;
			initBackground();
			initMidground();
			initForeground();		
			initEntities();
			initPortals();
		}
		override public function update():void {
			super.update();
		}
		
		private function initPortals():void {
			var location:FlxPoint = Model.world.locations[_index].getSpawnPoint("in");
			portalIn = new Portal(location.x+5, location.y+7, Portal.LAST);
			location = Model.world.locations[_index].getSpawnPoint("out");
			portalOut = new Portal(location.x+5, location.y+7, Portal.NEXT);
			entities.add(portalIn);	entities.add(portalOut);
		}
		
		private function initForeground():void {
			add(foreground = new FlxBitmapSprite(0, 0, Model.world.locations[_index].foreground));
			foreground.alpha = 0.4;
		}
		private function initMidground():void {
			midground = new FlxGroup();
			var modelData:Array = Model.world.locations[_index].midgroundSprites;
			var object:Object;
			for (var o:uint = 0; o < modelData.length; o++ ) {
				object = modelData[o];
				var s:FlxBitmapSprite = new FlxBitmapSprite(object.x, object.y);
				s.makeGraphic(Model.world.locations[_index].data.midground.size, Model.world.locations[_index].data.midground.size, object.col);
				s.immovable = true;
				midground.add(s);
			}
		}
		private function initBackground():void {
			add(background = new FlxBitmapSprite(0, 0, Model.world.locations[_index].background));
		}		
		private function initEntities():void {
			entities = new FlxGroup();
			var modelData:Array = Model.world.locations[_index].entitySprites;
			var object:Object;
			for (var o:uint = 0; o < modelData.length; o++ ) {
				object = modelData[o];
				switch(object.entity) {
					case "door":
						var door:Door = new Door(object.x+5, object.y+7);
						entities.add(door);
						break;
				}
			}
			modelData = Model.world.locations[_index].spawnPoints
			for (var p:uint = 0; p < modelData.length; p++ ) {
				object = modelData[p];
				switch(object.entity) {
					case "horizontal-mover":
						entities.add(new HorizontalRobot(object.x, object.y));
						break;
					case "spike":
						entities.add(new Spike(object.x+2, object.y + 12));
						entities.add(new Spike(object.x + 12, object.y + 12));
						break;
					case "upspike":
						entities.add(new TopSpike(object.x + 2, object.y));
						entities.add(new TopSpike(object.x + 12, object.y));
						break;
				}
			}
		}
	}

}