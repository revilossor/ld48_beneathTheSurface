package entity 
{
	import model.Embed;
	import model.LocationModel;
	import oli.Debug;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class LocationIconGroup extends FlxGroup
	{
		private var _locations:Vector.<LocationModel>; 		
		
		private var ww:Number = 50;
		
		public function LocationIconGroup(locations:Vector.<LocationModel>) 
		{
			Debug.log(this, "construct");
			initFromModelData(_locations = locations);
		}
		private function initFromModelData(data:Vector.<LocationModel>):void {
			Debug.log(this, "init " + data.length + " locations from model data");
			var newIcon:FlxSprite;
			for (var i:int = 0; i < data.length; i++) {
				Debug.log(this, "init icon for " + data[i].data.name + " at " + data[i].worldLocation.x + "," + data[i].worldLocation.y);
				data[i].visited?
					newIcon = new FlxSprite(data[i].worldLocation.x - 8, data[i].worldLocation.y - 8, Embed.VISITED_NODE):
					newIcon = new FlxSprite(data[i].worldLocation.x - 8, data[i].worldLocation.y - 8, Embed.UNVISITED_NODE);
				newIcon.immovable = true;
				add(newIcon);
			}
		}
		
	}

}