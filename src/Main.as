package 
{
	import flash.events.Event;
	import model.ConfigModel;
	import model.Model;
	import oli.Debug;
	import oli.Overlay;
	import org.flixel.FlxGame;
	import states.InitState;
	
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Main extends FlxGame
	{
		public function Main():void 
		{
			super(720, 440, InitState, 1, 60, 30);
			forceDebugger = true;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Debug.log(this, "init");
			initModel();
		}
		private function initModel():void {
 			Debug.log(this, "init model");
			Model.config = new ConfigModel();
			Model.overlay = new Overlay();				stage.addChild(Model.overlay);
		}
		
	}
	
}