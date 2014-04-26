package states 
{
	import model.Model;
	import oli.Debug;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class AbstractState extends FlxState
	{
		public function AbstractState() 	{	super();	}
		override public function create():void {
			super.create();
			Debug.log(this, "create");
		}
		override public function update():void {
			super.update();
	//		Debug.log(this, "update");
		}
		override public function destroy():void {
			super.destroy();
			Model.overlay.cls();
			Debug.log(this, "destroy");
		}
	}

}