package entity 
{
	import entity.world.PlayerIcon;
	import flash.ui.ContextMenuBuiltInItems;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class WorldMapPlayer extends FlxGroup
	{
		public var icon:PlayerIcon;
		
		
		public function set x(v:Number):void { x = icon.x = v; }
		public function set y(v:Number):void { y = icon.y = v; }
		
		public function WorldMapPlayer(xp:Number, yp:Number) 
		{
			super();
			add(icon = new PlayerIcon(xp, yp));
		}
		
	}

}