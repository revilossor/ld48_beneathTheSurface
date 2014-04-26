package states 
{
	import entity.baddie.Baddie;
	import entity.entity.Door;
	import entity.entity.Portal;
	import entity.Location;
	import entity.ParticleManager;
	import entity.Player;
	import entity.Spike;
	import entity.TopSpike;
	import model.Model;
	import oli.Colours;
	import oli.Debug;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class LocationState extends AbstractState
	{
		private var _map:Location;	
		private var _player:Player;
		private var _index:uint;
		private var _particleManager:ParticleManager;
	
		private var _doorTimer:int = 0;
		
		private var _beneathLastFrame:Boolean = false;
		private var _fromNext:Boolean;
		
		public function LocationState(index:uint, fromNext:Boolean = false) 	{	
			super();	
			_index = index;
			_fromNext = fromNext;
		}
		override public function create():void {
			super.create();
			FlxG.bgColor = Colours.BLACK;
			_map = new Location(_index);
			add(_map.background);
			add(_map.midground);
			add(_map.entities);
			var playerSpawn:FlxPoint = Model.world.locations[_index].getSpawnPoint("player");
			_fromNext?
				Model.playerChar = _player = new Player(_map.portalOut.x, _map.portalOut.y):
				Model.playerChar = _player = new Player(playerSpawn.x, playerSpawn.y);
			add(_player);
			add(_map.foreground);
			add(_particleManager = new ParticleManager());
		
			FlxG.camera.focusOn(_player.getMidpoint());
			FlxG.camera.zoom = 8;
			FlxG.camera.follow(_player, FlxCamera.STYLE_TOPDOWN_TIGHT);
			FlxG.worldBounds = new FlxRect( 0, 0, _map.background.width, _map.background.height);
		}
		private var t:uint = 0;
		override public function update():void {
			super.update();
			collision();
			keyHandling();
			zoom();
			var sin:Number = 1 * Math.sin(0.03 + (t++*0.03));
			_map.foreground.alpha = 0.25 + (sin * 0.2);
			
			if (!_beneathLastFrame && _player.beneathSurface) {
				Debug.log(this, "do splash particles");
				_particleManager.doSplash(_player);
			}
			_beneathLastFrame = _player.beneathSurface;
		}
		private function keyHandling():void {
			if (FlxG.keys.justPressed("Q")) {
				var p:FlxPoint = getBitmapPoint(_player.x, _player.y);
				var value:uint = Model.world.locations[_index].doormap.bitmapData.getPixel(p.x, p.y);
				Debug.log(this, "value : " + value);
			}
		}		
		private function getBitmapPoint(x:Number, y:Number):FlxPoint {
			var mid:FlxPoint = _player.getMidpoint();
			var size:Number = Model.world.locations[_index].data.midground.size;
			return new FlxPoint(Math.floor(mid.x / size), 
													Math.floor(mid.y / size));
		}
		
		private function collision():void {
			FlxG.collide(_player, _map.midground, _player.hit);
			FlxG.overlap(_player, _map.entities, playerOverEntity);
			FlxG.collide(_particleManager, _map.midground);
			FlxG.collide(_map.entities, _map.midground);
		}
		
		private function playerOverEntity(pl:Player, en:FlxSprite):void {
			if (en is Door) {
				var door:Door = en as Door;
				if (FlxG.keys.pressed(_player.DOWN_KEY)) {
					door.play("opening");
				}
				if (_doorTimer > 0) { _doorTimer--; }
				if (FlxG.keys.justReleased(_player.DOWN_KEY) && _doorTimer == 0) {
					_doorTimer = 30;
					_player.active = false;
					gotoOtherDoor();
				}
			}
			else if (en is Portal) {
				var portal:Portal = en as Portal;
					if (FlxG.keys.pressed(_player.DOWN_KEY)) {
						portal.play("opening");
						_player.active = false;
						if(portal.direction == Portal.NEXT){
							FlxG.fade(Colours.GREY_3, 1, gotoNextLocation)
						}else{
							FlxG.fade(Colours.GREY_3, 1, gotoPreLocation);
						}
					}
			}
			else if (en is TopSpike) {
				_particleManager.doDeath(_player);
				playerDie();
			}
			else if (en is Spike) {
				if (_player.velocity.y > 0) {
					_particleManager.doDeath(_player);
					playerDie();
				}
			}
			else if (en is Baddie) {
				_particleManager.doDeath(_player);
				playerDie();
			}
		}
		private function playerDie(): void {
			_player.exists = false;
			FlxG.flash(0xffff0000, 0.5);
			FlxG.fade(Colours.GREY_3, 1, gotoDeathState);
		}	
		private function gotoDeathState():void {
			FlxG.switchState(new DeathState());
		}
		private function gotoNextLocation():void {
			Debug.log(this, "goto next room");
			FlxG.switchState(new LocationState(++Model.currentLocation));
		}
		private function gotoPreLocation():void {
			Debug.log(this, "goto pre room");
			FlxG.switchState(new LocationState(--Model.currentLocation, true));
		}
		private function gotoOtherDoor():void {
			FlxG.flash(0xff000000, 2.5); 
			FlxG.camera.zoom *= 2 ;
			if (FlxG.camera.zoom > 6) { FlxG.camera.zoom = 6; }
			//FlxG.camera.focusOn(_player.getMidpoint());
			var thisPoint:FlxPoint = getBitmapPoint(_player.getMidpoint().x, +_player.getMidpoint().y);
			var thisValue:uint = Model.world.locations[_index].doormap.bitmapData.getPixel(thisPoint.x, thisPoint.y);
			var moveTo:FlxPoint = Model.world.locations[_index].getConnectingDoor(thisValue, thisPoint);
			_player.x = moveTo.x + _player.width;	_player.y = moveTo.y;
			Debug.log(this, "move to : " + moveTo.x + ", " + moveTo.y);
			_player.active = true;
		}
		
		private function zoom():void {
			var current:Number = (Math.abs(Math.round(_player.velocity.x)) / _player.maxVelocity.x);
			var target:Number = 1.5 - (current - 0.5);
			var d:Number = FlxG.camera.zoom - target;
			FlxG.camera.zoom -= d * 0.01;
			if (_player.pressingNone) {
				FlxG.camera.zoom += 0.003;
			}
			
			
		}
	}

}