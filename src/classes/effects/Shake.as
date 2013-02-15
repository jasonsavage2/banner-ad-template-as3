package classes.effects 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class Shake 
	{
		private var _origin:Point;
		private var _target:DisplayObject;
		private var _syncQueue:Array;
		private var _duration:int;
		private var _amplitude:Number = 3;
		private var _timerId:int;
		
		public function Shake(target:DisplayObject, duration:int) 
		{
			_target = target;
			_duration = duration;
			
			start(); //auto start
		}
		
		public function start():void
		{
			_origin = new Point(_target.x, _target.y);
			
			_target.addEventListener(Event.ENTER_FRAME, update);
			
			_timerId = setTimeout(end, _duration);
		}
		
		public function end():void
		{
			clearTimeout(_timerId);
			_target.removeEventListener(Event.ENTER_FRAME, update);
			_target.x = _origin.x;
			_target.y = _origin.y;
		}
		
		public function sync(shake:Shake):void
		{
			shake.end();
			
			if (_syncQueue == null)
				_syncQueue = new Array();
				
			_syncQueue.push(shake);
		}
		
		public function step(pt:Point):void
		{
			_target.x = _origin.x + pt.x;
			_target.y = _origin.y + pt.y;
		}
		
		private function update(event:Event):void
		{
			var min = (_amplitude * -1);
			var max = (_amplitude * 2); 
			
			var pt:Point = new Point();
			pt.x = min + (Math.random() * max);
			pt.y = min + (Math.random() * max);
			
			step(pt);
			
			for each(var eff:Shake in _syncQueue)
			{
				eff.step(pt);
			}
		}
	}

}