package oli 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Overlay extends MovieClip 
	{		
		public function Overlay() 
		{
			super();
			Debug.log(this, "construct");
			addEventListener(Event.ADDED_TO_STAGE, create);
		}
		protected function create(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, create);
			Debug.log(this, "create");
		}
		public function cls():void {	while (numChildren > 0 ) {	removeChildAt(0);	}	graphics.clear(); }
		public function drawRect(x:Number, y:Number, w:Number, h:Number, colour:uint, a:Number = 1):Overlay {
			graphics.lineStyle(1, colour, a);
			graphics.beginFill(colour, a);
			graphics.drawRect(x, y, w, h);
			graphics.endFill();
			return this;
		}
		public function drawLine(x1:Number, y1:Number, x2:Number, y2:Number, colour:uint, t:uint, a:Number):Overlay {
			graphics.clear();
			graphics.moveTo(x1, y1);
			graphics.lineStyle(t, colour, a);
			graphics.lineTo(x2-t, y2);
			return this;
		}
		public function drawUnfilledRect(x1:Number, y1:Number, w:Number, h:Number, colour:uint, a:Number):Overlay {
			graphics
			graphics.lineStyle(4,0x001bfd);
			graphics.beginFill(0x40404, a);
			graphics.drawRect(x1, y1, w, h);
			graphics.endFill();
			return this;
		}
		public function drawAirBar(percent:Number):void {
			graphics.clear();
			drawUnfilledRect(10, 380, 225, 40, 0x001bfd, 0.4);
			var maxW:Number = 225;
			var wid:Number = maxW * percent;
			drawRect(10, 380, wid, 40, 0x5863A1, 0.7);
		}
	}

}