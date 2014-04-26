package entity 
{
	import entity.entity.Door;
	import model.Model;
	import oli.Debug;
	import oli.flx.FlxBitmapSprite;
	import org.flixel.FlxGroup;
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
		
		public function Location(index:uint) 
		{
			super();
			_index = index;
			initBackground();
			initMidground();
			initForeground();		
			initEntities();
		}
		override public function update():void {
			super.update();
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
						Debug.log(this, "add door at " + object.x + ", " + object.y);
						var door:Door = new Door(object.x+5, object.y+7);
						entities.add(door);
						break;
				}
			}
		}
	}

}