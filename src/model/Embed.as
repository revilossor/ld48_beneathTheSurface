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
		[Embed(source = "../../embed/gfx/entities/portal.png")] public static const PORTAL_SPRITE:Class;
		[Embed(source = "../../embed/gfx/bg/menu-bg.png")] public static const MENU_BG:Class;
		[Embed(source = "../../embed/gfx/words/beneth-the-surface.png")] public static const MENU_TITLE:Class;
	}

}