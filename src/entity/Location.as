package entity 
{
	import entity.baddie.HorizontalSeeker;
	import entity.entity.Door;
	import entity.entity.Portal;
	import entity.entity.PressureSwitch;
	import entity.entity.Switchable;
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
		public var seekers:FlxGroup;
		public var switchables:FlxGroup;
		
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
			initSwitches();
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
			seekers = new FlxGroup();
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
						var n:HorizontalSeeker;
						entities.add(n = new HorizontalSeeker(object.x, object.y));
						seekers.add(n);
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
		private function initSwitches():void {
			switchables = new FlxGroup();
			var modelData:Array = Model.world.locations[_index].entitySprites;
			var object:Object;
			for (var o:uint = 0; o < modelData.length; o++ ) {
				object = modelData[o];
				switch(object.entity) {
					case "switch":
						var sw:PressureSwitch = new PressureSwitch(object.x, object.y, object.connecting);
						entities.add(sw);
						break;
					case "switchable":
						var swi:Switchable = new Switchable(object.x, object.y, object.value);
						entities.add(swi);
						switchables.add(swi);
						break;
				}
			}
		}
	}

}