package entity 
{
	import model.Embed;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class WorldMouse extends FlxGroup
	{
		private var _overCursor:FlxSprite; public function get overCursor():FlxSprite { return _overCursor; }
		private var _idleCursor:FlxSprite;
		
		private var _safezoneWidth:uint = 50;
		private var _mouseSafezone:FlxRect;
	
		public static const CURSOR_IDLE:String = "idle";
		public static const CURSOR_OVER:String = "over";
		
		
		public function WorldMouse() 
		{
			super();
			
			_mouseSafezone = new FlxRect(_safezoneWidth, _safezoneWidth, 
								FlxG.width - (_safezoneWidth * 2), FlxG.height - (_safezoneWidth * 2));
		
			_overCursor = new FlxSprite();
			_overCursor.loadGraphic(Embed.CURSOR_CROSSHAIRS, true, false, 8, 4);
			_overCursor.addAnimation("idle", [2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0], 10);
			_overCursor.play("idle");
			_overCursor.scale.x = _overCursor.scale.y = 4;
			add(_overCursor);
			
			_idleCursor = new FlxSprite();
			_idleCursor.loadGraphic(Embed.CURSOR_IDLE, true, false, 8, 8);
			_idleCursor.addAnimation("idle", [1, 2, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 2], 10);
			_idleCursor.play("idle"); 
			_idleCursor.scale.x = _idleCursor.scale.y = 2;
			add(_idleCursor);
			
			_overCursor.alpha = _idleCursor.alpha = 0.5;
			
			cursor = CURSOR_IDLE;
		}
		public function set cursor(type:String):void {
			_idleCursor.visible = _overCursor.visible = false;
			switch(type) {
				case CURSOR_OVER: _overCursor.visible = true; break;
				default: _idleCursor.visible = true; break;
			}
		}
		public function get inSafezone():Boolean {
			return FlxG.mouse.screenX > _mouseSafezone.x && FlxG.mouse.screenY  > _mouseSafezone.y &&
						FlxG.mouse.screenX  < _mouseSafezone.x + _mouseSafezone.width &&
						FlxG.mouse.screenY  < _mouseSafezone.y + _mouseSafezone.height;
		}
		override public function update():void {
			super.update();
			_idleCursor.x = _overCursor.x = FlxG.mouse.x - _overCursor.width;
			_idleCursor.y = _overCursor.y = FlxG.mouse.y - _overCursor.height;
		}
		public function get screnMiddle():FlxPoint { return new FlxPoint(FlxG.camera.scroll.x + FlxG.width / 2, FlxG.camera.scroll.y + FlxG.height / 2); }
		public function get mousepos():FlxPoint { return new FlxPoint(FlxG.mouse.x, FlxG.mouse.y); }
		public static function mapToScreen(point:FlxPoint):FlxPoint {	return new FlxPoint(point.x - FlxG.camera.scroll.x, point.y - FlxG.camera.scroll.y); }
	}

}