package states 
{
	import entity.baddie.Baddie;
	import entity.baddie.HorizontalSeeker;
	import entity.entity.Door;
	import entity.entity.Portal;
	import entity.entity.PressureSwitch;
	import entity.entity.Switchable;
	import entity.entity.WinButton;
	import entity.Location;
	import entity.ParticleManager;
	import entity.Player;
	import entity.Spike;
	import entity.TopSpike;
	import model.Embed;
	import model.Model;
	import model.PlayerModel;
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
			if (Model.currentLocation == 9) {
				_map.entities.add(new WinButton(32 * 20, 15 * 20));
			}
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
			if(_player.beneathSurface){
				if (!_beneathLastFrame) {
					Debug.log(this, "do splash particles");
					FlxG.play(Embed.SOUND_SPLASH, 0.8);
					_particleManager.doSplash(_player);
				}
				if (Model.player.currentAir > 0) { Model.player.currentAir--; } 
			}else {
				if (Model.player.currentAir < Model.player.maxAir) { Model.player.currentAir += 10; }
			}
			_beneathLastFrame = _player.beneathSurface;
			Model.overlay.drawAirBar(Model.player.currentAir / Model.player.maxAir);
			if (Model.player.currentAir == 0 && _player.alive) { playerDie(); }
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
			FlxG.overlap(_map.entities, _map.entities, entityOverEntity);
			FlxG.collide(_particleManager, _map.midground);
			FlxG.collide(_map.entities, _map.midground);
			FlxG.collide(_player, _map.switchables, playerHitSwitchables);
			FlxG.collide(_map.entities, _map.switchables);
			FlxG.collide(_map.seekers, _map.seekers);
		}
		
		private function playerHitSwitchables(a:FlxSprite, b:FlxSprite):void {
			if (_player.x > b.x && _player.y < b.x + b.width) {
				playerDie();
			}
		}
		private function entityOverEntity(pl:FlxSprite, en:FlxSprite):void {
			if (en is PressureSwitch && pl is HorizontalSeeker) {
				var sw:PressureSwitch = en as PressureSwitch;
				sw.play("down");
				pl.y = sw.y + 8;
				getSwitchable(sw.conecting).doOpen();
			}
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
						FlxG.play(Embed.SOUND_PORTAL, 0.3);
						_player.active = false;
						if(portal.direction == Portal.NEXT){
							FlxG.fade(Colours.GREY_3, 1, gotoNextLocation);
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
			else if (en is PressureSwitch) {
				_player.onSwitch = true;
				_player.jumpState = Player.STATE_TOUCHING;
				var sw:PressureSwitch = en as PressureSwitch;
				Debug.log(this, "player on switch : " + sw.conecting);
				sw.play("down");
				_player.y = sw.y + 8;
				if (sw.conecting == 0xff00ff) {
					playerWin();
					return;
				}
				getSwitchable(sw.conecting).doOpen();
			}
		}
		private function playerWin():void {
			Debug.log(this, "WIN!");
			FlxG.fade(Colours.GREY_3, 1, gotoWinState);
		}
		private function gotoWinState():void {
			FlxG.switchState(new WinState());
		}
		private function getSwitchable(conecting:uint):Switchable {
			for (var i:int = 0; i < _map.switchables.length; i++) {
				if (_map.switchables.members[i].value == conecting) {
					return _map.switchables.members[i];
				}
			}
			return null;
		}
		private function playerDie(): void {
			_player.exists = false;
			_player.kill();
			FlxG.play(Embed.SOUND_DIE);
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
			trace("" + Model.currentLocation);
			if (Model.currentLocation == 0) {
				FlxG.switchState(new MenuState());
			}else{
				Debug.log(this, "goto pre room");
				FlxG.switchState(new LocationState(--Model.currentLocation, true));
			}
		}
		private function gotoOtherDoor():void {
			FlxG.play(Embed.SOUND_DOOR);
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