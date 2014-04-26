package model 
{
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Embed 
	{
		[Embed(source = "../../embed/gfx/player.png")] public static const PLAYER_SPRITE:Class;
		[Embed(source = "../../embed/gfx/entities/door.png")] public static const DOOR_SPRITE:Class;
		[Embed(source = "../../embed/gfx/map/icons/visited-node.png")] public static const VISITED_NODE:Class;
		[Embed(source = "../../embed/gfx/map/icons/unvisited-node.png")] public static const UNVISITED_NODE:Class;
		[Embed(source = "../../embed/gfx/map/cursor/cursor-crosshairs.png")] public static const CURSOR_CROSSHAIRS:Class;
		[Embed(source = "../../embed/gfx/map/cursor/cursor-idle.png")] public static const CURSOR_IDLE:Class;
		[Embed(source = "../../embed/gfx/map/icons/player-icon.png")] public static const PLAYER_ICON:Class;
	}

}