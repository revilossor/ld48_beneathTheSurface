package entity 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class ParticleManager extends FlxGroup
	{
		private static var water_colour:uint = 0xff4BB071;
		private static var blood_colour:uint = 0xffff0000;
		
		private var _splashParticles:FlxGroup;
		
		
		public function ParticleManager() 
		{
			super();
			add(_splashParticles = new FlxGroup());
		}
		public function doSplash(ent:FlxSprite):void {
			for (var i:int = 0; i < 10; i++) {
				_splashParticles.add(new Particle(ent.getMidpoint().x, ent.getMidpoint().y, 
						new FlxPoint( (-ent.velocity.x + (-10 + (Math.random()*20))*5),
							-ent.velocity.y * (0.5 + (Math.random()*0.5))), 
						water_colour));
			}
		}
		public function doDeath(ent:FlxSprite):void {
			for (var i:int = 0; i < 100; i++) {
				_splashParticles.add(	new Particle(ent.getMidpoint().x, ent.getMidpoint().y, 
										new FlxPoint( -50 + (Math.random() * 100), -(100 + (Math.random() * 100))), 
										blood_colour)	);
			}
		}
		override public function update():void {
			for (var s:int = 0; s < _splashParticles.length; s++) {
				if (!_splashParticles.members[s].alive) {
					_splashParticles.members[s].destroy();
					_splashParticles.remove(_splashParticles.members[s], true);
				}
			}
			super.update();
		}
		
	}

}