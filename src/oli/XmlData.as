package oli 
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class XmlData 
	{
		private var _url:String
		private var _data:XML;	public function get data():XML { return _data; }
		
		public function XmlData(url:String) {
			loadXml(_url = url);
		}
		private function loadXml(url:String):void {
			var urlLoader:URLLoader = new URLLoader();
			var urlRequest:URLRequest = new URLRequest(url)
			urlLoader.addEventListener(Event.COMPLETE, xmlLoadComplete);
			urlLoader.addEventListener(ErrorEvent.ERROR, xmlLoadError);
			urlLoader.load(urlRequest);
		}
		
		private function xmlLoadComplete(e:Event):void 
		{
			Debug.log(this, "finished loading " + _url);
			_data = new XML(e.target.data);
			create();
		}
		public function create():void {}
		private function xmlLoadError(e:Event):void {	Debug.error(this, "error loading " + _url);	}
	}

}