package entity 
{
	import flash.geom.Point;
	import model.Embed;
	import model.Model;
	import oli.Debug;
	import oli.flx.FlxBitmapSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Player extends FlxSprite
	{
		public var RIGHT_KEY:String;
		public var LEFT_KEY:String;
		public var UP_KEY:String;
		public var DOWN_KEY:String; 
		
		private var BASE_VEOCITY:FlxPoint;
		private var BASE_TERMINAL_VELOCITY:FlxPoint;
		private var BASE_HORIZONTAL_DECELLERATION:Number;
		private var BASE_HORIZONTAL_SKID_DECELLERATION:Number;
		private var BASE_HORIZONTAL_SKID_TIME:Number;
		private var BASE_JUMP_DECELLERATION:Number;
		private var BASE_JUMP_IMPULSE:Number;
		private var BASE_JUMP_ACCELERATION:Number;
		private var BASE_JUMP_DURATION:Number;
		private var IDLE_VELOVITY_THRESHOLD:Number;
		
		private var UNDERWATER_VEOCITY:FlxPoint;
		private var UNDERWATER_TERMINAL_VELOCITY:FlxPoint;
		private var UNDERWATER_HORIZONTAL_DECELLERATION:Number;
		private var UNDERWATER_HORIZONTAL_SKID_DECELLERATION:Number;
		private var UNDERWATER_HORIZONTAL_SKID_TIME:Number;
		private var UNDERWATER_JUMP_DECELLERATION:Number;
		private var UNDERWATER_JUMP_IMPULSE:Number;
		private var UNDERWATER_JUMP_ACCELERATION:Number;
		private var UNDERWATER_JUMP_DURATION:Number;
		
		public static const STATE_RUNNING:String = "running";
		public static const STATE_IDLE:String = "idle";
		public static const STATE_FALLING:String = "falling";
		public static const STATE_JUMPING:String = "jumping";
		public static const STATE_TOUCHING:String = "touching";
		
		private var _jumpState:String; 
			public function get jumpState():String { return _jumpState; }
			public function set jumpState(v:String):void { _jumpState = v; }
		private var _moveState:String;
		private var _jumpTimer:int;
		
		public var beneath:Boolean;
		private var _lastJumpState:String;
		public var onSwitch:Boolean = false;	
		
		public function Player(xp:Number, yp:Number) 
		{
			super(xp, yp);
			
			loadGraphic(Embed.PLAYER_SPRITE, true, true, 7, 10);
			addAnimation("idle", [0]);
			addAnimation("run", [0,1,0,2],10);
			addAnimation("jump", [5]);
			addAnimation("fall", [6]);
			
			play("idle");
			
			getSettingsFromModel();
			_jumpState = STATE_FALLING;
			_moveState = STATE_IDLE;
			_jumpTimer = BASE_JUMP_DURATION;
			acceleration = new FlxPoint(0, 1000);
			maxVelocity = BASE_TERMINAL_VELOCITY;
		}
		private function getSettingsFromModel():void {
			RIGHT_KEY = Model.player.data.controlls.right;
			LEFT_KEY = Model.player.data.controlls.left;
			UP_KEY = Model.player.data.controlls.up;
			DOWN_KEY = Model.player.data.controlls.down;
			BASE_VEOCITY = new FlxPoint(parseFloat(Model.player.data.velocity.x), parseFloat(Model.player.data.velocity.y));
			BASE_TERMINAL_VELOCITY = new FlxPoint(parseFloat(Model.player.data.velocity.max.x), parseFloat(Model.player.data.velocity.max.y));
			BASE_HORIZONTAL_DECELLERATION = parseFloat(Model.player.data.run.decelleration);
			BASE_HORIZONTAL_SKID_DECELLERATION = parseFloat(Model.player.data.run.skid.decelleration);
			BASE_HORIZONTAL_SKID_TIME = parseFloat(Model.player.data.run.skid.duration);
			BASE_JUMP_DECELLERATION = parseFloat(Model.player.data.jump.decelleration);
			BASE_JUMP_IMPULSE = parseFloat(Model.player.data.jump.impulse);
			BASE_JUMP_ACCELERATION = parseFloat(Model.player.data.jump.acceleration);
			BASE_JUMP_DURATION = parseFloat(Model.player.data.jump.duration);
			IDLE_VELOVITY_THRESHOLD = parseFloat(Model.player.data.idle.threshold);
			
			UNDERWATER_VEOCITY = new FlxPoint(parseFloat(Model.player.data.underwater.velocity.x), parseFloat(Model.player.data.underwater.velocity.y));
			UNDERWATER_TERMINAL_VELOCITY = new FlxPoint(parseFloat(Model.player.data.underwater.velocity.max.x), parseFloat(Model.player.data.underwater.velocity.max.y));
			UNDERWATER_HORIZONTAL_DECELLERATION = parseFloat(Model.player.data.underwater.run.decelleration);
			UNDERWATER_HORIZONTAL_SKID_DECELLERATION = parseFloat(Model.player.data.underwater.run.skid.decelleration);
			UNDERWATER_HORIZONTAL_SKID_TIME = parseFloat(Model.player.data.underwater.run.skid.duration);
			UNDERWATER_JUMP_DECELLERATION = parseFloat(Model.player.data.underwater.jump.decelleration);
			UNDERWATER_JUMP_IMPULSE = parseFloat(Model.player.data.underwater.jump.impulse);
			UNDERWATER_JUMP_ACCELERATION = parseFloat(Model.player.data.underwater.jump.acceleration);
			UNDERWATER_JUMP_DURATION = parseFloat(Model.player.data.underwater.jump.duration);

		}
		override public function update():void {
			super.update();
			if (beneath = beneathSurface) {
				acceleration = new FlxPoint(0, 500);
				maxVelocity = UNDERWATER_TERMINAL_VELOCITY;
			}else {
				acceleration = new FlxPoint(0, 1000);
				maxVelocity = BASE_TERMINAL_VELOCITY;
			}
			keyHandling();
			animationHandling();
			if(_jumpState == STATE_TOUCHING && _lastJumpState != STATE_TOUCHING && isTouching(FlxObject.FLOOR) && onSwitch == false){
				FlxG.play(Embed.SOUND_LAND);
			}
			_lastJumpState = _jumpState;
			onSwitch = false;
		}

		
		private function animationHandling():void {
			if (Math.abs(velocity.x) < Model.player.data.idle.threshold) {
				_moveState = STATE_IDLE;
			}
			if(_jumpState != STATE_JUMPING){
				if (!isTouching(FlxObject.ANY)) {
					Debug.state(this, "jump state " + (_jumpState = STATE_FALLING));
				}else if (isTouching(FlxObject.FLOOR)) {
					Debug.state(this, "jump state " + (_jumpState = STATE_TOUCHING));
					_jumpTimer = beneathSurface?UNDERWATER_JUMP_DURATION:BASE_JUMP_DURATION;
				}else if (velocity.x > -IDLE_VELOVITY_THRESHOLD && velocity.x < IDLE_VELOVITY_THRESHOLD) { 
					Debug.state(this, "move state " + (_moveState = STATE_IDLE));
				} 
			}else {
				if (_jumpTimer < 0) {
					_jumpTimer = beneathSurface?UNDERWATER_JUMP_DURATION:BASE_JUMP_DURATION;
					_jumpState = STATE_FALLING;
				}else {
					_jumpState = STATE_JUMPING;
				}
				if (isTouching(FlxObject.FLOOR)) {
					Debug.state(this, "jump state " + (_jumpState = STATE_TOUCHING));
					_jumpTimer =beneathSurface?UNDERWATER_JUMP_DURATION:BASE_JUMP_DURATION;
				}
			}
	//		Debug.log(this, "jump state : " + _jumpState + ", move state : " + _moveState);
			switch(_jumpState) {
				case STATE_JUMPING:
					switch(_moveState) {
						case STATE_IDLE:	play("jump");		break;
						case STATE_RUNNING:	play("jump");		break;
						default:			play("fall");		break;
					}
				break;
				case STATE_FALLING:
					switch(_moveState) {
						case STATE_IDLE:	play("fall");		break;
						case STATE_RUNNING:	play("jump");		break;
						default:			play("fall");		break;
					}
				break;
				default:
					switch(_moveState) {
						case STATE_IDLE:	play("idle");		break;
						case STATE_RUNNING:	play("run");		break;
						default:			play("idle");		break;
					}
				break;
			}
		}
		
		public function hit(player:FlxSprite, thing:FlxObject):void {
			Debug.hit(this, player, thing);
			var stadingOn:Boolean = player.isTouching(FlxObject.FLOOR);
			if(!stadingOn){
				FlxG.shake(0.0015, 1 / 30);
			}
		}
		public function get beneathSurface():Boolean {
			return isPixelBeneath(getMidpoint());
		}
		public function get playerPixel():Point {
			return new Point(Math.floor(getMidpoint().x / 20), Math.floor(getMidpoint().y / 20));
		}
		public function isPixelBeneath(p:FlxPoint):Boolean {
			return Model.world.locations[Model.currentLocation].foreground.bitmapData.getPixel(p.x, p.y) != 0;
		}
		
		private function keyHandling():void {
			
			if (FlxG.keys.justPressed(RIGHT_KEY)) 								{ right_pressed(); }
			if (FlxG.keys.pressed(RIGHT_KEY)) 									{ right_held(); }
			if (FlxG.keys.justReleased(RIGHT_KEY))							 	{ right_released(); }
			if (FlxG.keys.justPressed(LEFT_KEY)) 								{ left_pressed(); }
			if (FlxG.keys.pressed(LEFT_KEY)) 									{ left_held(); }
			if (FlxG.keys.justReleased(LEFT_KEY)) 								{ left_released(); }
			if (FlxG.keys.justPressed(UP_KEY)) 									{ up_pressed(); }
			if (FlxG.keys.pressed(UP_KEY)) 										{ up_held(); }
			if (FlxG.keys.justReleased(UP_KEY)) 								{ up_released(); }
			if (FlxG.keys.justPressed(DOWN_KEY)) 								{ down_pressed(); }
			if (FlxG.keys.pressed(DOWN_KEY)) 									{ down_held(); }
			if (FlxG.keys.justReleased(DOWN_KEY)) 								{ down_released(); }
			
			if (!FlxG.keys.pressed(RIGHT_KEY) && !FlxG.keys.pressed(LEFT_KEY)) 	{ horizotal_clamp(); }
			if (!FlxG.keys.pressed(UP_KEY)) 									{ vertical_clamp(); }
			
			if(FlxG.keys.justReleased("Q")){
				Debug.log(this, "is player beneath : " + beneathSurface);
			}
		}
		
		private function vertical_clamp():void {
			if (velocity.y < 0) { velocity.y *= beneath?UNDERWATER_JUMP_DECELLERATION:BASE_JUMP_DECELLERATION; }
		}
		private function horizotal_clamp():void {
			velocity.x *= beneath?UNDERWATER_HORIZONTAL_DECELLERATION:BASE_HORIZONTAL_DECELLERATION;
		}
		
		public function get pressingNone():Boolean {
			return !(FlxG.keys.pressed(RIGHT_KEY) && FlxG.keys.pressed(LEFT_KEY) && FlxG.keys.pressed(UP_KEY) && FlxG.keys.pressed(DOWN_KEY));
		}
		
		private function right_pressed():void { 
			Debug.input(this, "right pressed"); 
		}
		private function right_held():void { 
			Debug.input(this, "right held");
			Debug.state(this, "move state " + (_moveState = STATE_RUNNING));
			velocity.x += beneath?UNDERWATER_VEOCITY.x:BASE_VEOCITY.x;
			facing = FlxObject.RIGHT;
	//		play("run");
		}
		private function right_released():void { 
			Debug.input(this, "right released");
//			velocity.x *= 0.75;
	//		play("idle");
		}
		private function left_pressed():void { 
			Debug.input(this, "left pressed"); 
		}
		private function left_held():void {
			Debug.input(this, "left held");
			Debug.state(this, "move state " + (_moveState= STATE_RUNNING));
			velocity.x -= beneath?UNDERWATER_VEOCITY.x:BASE_VEOCITY.x;
			facing = FlxObject.LEFT;
		//	play("run");
		}
	//	private function hitSwitchables(a:FlxSprite, b:FlxSprite):void {
	//		if (isTouching(FlxObject.UP)) {
	//			
	//		}
	//	}
		private function left_released():void { 
			Debug.input(this, "left released"); 
	//		velocity.x *= 0.75;
	//		play("idle");
		}
		private function up_pressed():void { 
			Debug.input(this, "up pressed");
			if (beneath) {
			//	if (_jumpTimer == (beneathSurface?UNDERWATER_JUMP_DURATION:BASE_JUMP_DURATION)) {
					Debug.state(this, "jump state " + (_jumpState = STATE_JUMPING));
					velocity.y = -UNDERWATER_JUMP_IMPULSE;
					FlxG.play(Embed.SOUND_SWIM, 0.5);
			//	}
			}else{
				if (_jumpState == STATE_TOUCHING && _jumpTimer == (beneath?UNDERWATER_JUMP_DURATION:BASE_JUMP_DURATION)) {
					Debug.state(this, "jump state " + (_jumpState = STATE_JUMPING));
					velocity.y -= beneath?UNDERWATER_JUMP_IMPULSE:BASE_JUMP_IMPULSE;
					FlxG.play(Embed.SOUND_JUMP, 0.5);
				}
			}
		}
		private function up_held():void { 
			Debug.input(this, "up held"); 
			if (_jumpTimer-- > 0) {
				velocity.y *= beneath?UNDERWATER_JUMP_ACCELERATION:BASE_JUMP_ACCELERATION;
			}
	//		play("jump");
		}
		private function up_released():void {
			Debug.input(this, "up released");
		//	play("fall");
		}
		private function down_pressed():void { 
			Debug.input(this, "down pressed");
		}
		private function down_held():void { 
			Debug.input(this, "down held"); 
		}
		private function down_released():void { 
			Debug.input(this, "down released"); 
		}
	}

}