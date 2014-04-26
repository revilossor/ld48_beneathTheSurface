package model 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import oli.XmlData;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class AbstractModel extends XmlData
	{
		
		public function AbstractModel(url:String) 
		{
			super(url);
		}
		
		protected function loadSprite(src:String, func:Function):void {
			var request:URLRequest = new URLRequest(src);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, func);
			loader.load(request);
		}
		
	}

}