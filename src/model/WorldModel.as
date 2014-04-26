package model 
{
	import oli.Debug;
	/**
	 * ...
	 * @author Oliver Ross
	 * 
	 */
	public class WorldModel extends AbstractModel
	{
		public var locations:Vector.<LocationModel>;
		
		public function WorldModel() 
		{
			Debug.log(this, "construct");
			super(Model.config.data.xml.world);
		}
		override public function create():void {
			Debug.log(this, "NAME : " + data.name);
			initLocations();
		}
		private function initLocations():void {
			var list:XMLList = data.locations.location;
			Debug.log(this, "init " + list.length() + " locations");
			locations = new Vector.<LocationModel>();
			for (var i:uint = 0; i < list.length(); i++) {
				Debug.log(this, "load location : " + list[i].@id);
				var thisLocation:LocationModel = new LocationModel(list[i]);
				locations.push(thisLocation);
			}
		}

	}

}