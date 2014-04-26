package states
{
	import entity.WorldMapPlayer;
	import entity.WorldMouse;
	import entity.World;
	import model.Model;
	import oli.Colours;
	import oli.Debug;
	import oli.steer.Steering;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 * 
	 * TODO - actions select what todo next ( ie, what state+vars to goto), then fade/execute
	 * 
	 */
	public class WorldMapState extends AbstractState
	{		
		private var _world:World;
		private var _mouse:WorldMouse;	
		private var _hitDummy:FlxSprite;
		private var _player:WorldMapPlayer;
	
		public function WorldMapState() {	super();	}
		override public function create():void {
			super.create();
			_hitDummy = new FlxSprite();	_hitDummy.makeGraphic(1, 1); add(_hitDummy);
			FlxG.bgColor = Colours.GREY_3;
			add(_world = new World());
			add(_player = new WorldMapPlayer(Model.world.data.width / 2, Model.world.data.height / 2));
			add(_mouse = new WorldMouse());
			FlxG.camera.bounds = new FlxRect(0, 0, Model.world.data.width * Model.world.data.scale, Model.world.data.height * Model.world.data.scale); 
			
		}
		override public function update():void {
			super.update();
			keyHandling();
			mouseHandling();
		}
		
		private function mouseHandling():void {
			handleMapScrolling();
			handleIconSelection();
			var start:FlxPoint = WorldMouse.mapToScreen(new FlxPoint(_world.icons.members[0].x + 8, _world.icons.members[0].y+ 8));
			var end:FlxPoint = WorldMouse.mapToScreen(new FlxPoint(_mouse.mousepos.x, _mouse.mousepos.y));
			Model.lineOverlay.drawLine(	start.x, start.y, 
										end.x, end.y, 
										0xffffff, 
										4, 
										0.1);
		}
		private function get overIcon():uint {
			_hitDummy.x = FlxG.mouse.x;	_hitDummy.y = FlxG.mouse.y;
			for (var i:uint = 0; i < Model.world.locations.length; i++) {
				if (	_hitDummy.x > _world.icons.members[i].x &&
						_hitDummy.x < _world.icons.members[i].x + _world.icons.members[i].width &&
						_hitDummy.y > _world.icons.members[i].y &&
						_hitDummy.y < _world.icons.members[i].y + _world.icons.members[i].height) {
							//Debug.log(this, "over icon " + i + " for location " + Model.world.locations[i].data.name);
							return i;
				}
			}
			return 99;
		}
		private function handleMapScrolling():void {
			if (!_mouse.inSafezone) {  
				var steer:FlxPoint = Steering.seekAtSpeed(_mouse.screnMiddle, _mouse.mousepos, 3);
				FlxG.camera.scroll.x += steer.x;	FlxG.camera.scroll.y += steer.y;
			}
		}
		private function handleIconSelection():void {
			var i:uint = overIcon;
			if (i != 99) {
				//Debug.log(this, "over icon " + i);
				_mouse.cursor = WorldMouse.CURSOR_OVER;
				if (FlxG.mouse.pressed()) { gotoLocation(i); }
			}else {
				_mouse.cursor = WorldMouse.CURSOR_IDLE;
			}
			
			if (FlxG.mouse.justPressed()) {}
			if (FlxG.mouse.pressed()) {
		
			}
			if (FlxG.mouse.justReleased()) {}
		}
		private var _selectedLocationIndex:uint = 99;
		private function keyHandling():void {
			if (FlxG.keys.justReleased("SPACE")) {
				FlxG.fade(0xff0f2023, 1, gotoLocation);
			//	FlxG.switchState(new LocationState(1));
			}
		}
		private function gotoLocation(index:uint):void {
			if (index == 99) { return; }
			FlxG.switchState(new LocationState(index));
		}
	}

}