package classes 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class StageRolloverPlayReverser 
	{
		private var _source:MovieClip;
		private var _startFrame:int;
		
		public function StageRolloverPlayReverser(source:MovieClip, startFrame:int) 
		{
			_source = source;
			_startFrame = startFrame;
			
			if (_source.stage != null)
				init();
			else
				_source.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event=null)
		{
			_source.removeEventListener(Event.ADDED_TO_STAGE, init);

			_source.stage.addEventListener(MouseEvent.MOUSE_OVER, handler, false, 0, true);
			_source.stage.addEventListener(MouseEvent.MOUSE_OUT, handler, false, 0, true);
		}
		
		private function handler(event:Event):void
		{
			if(event.type == MouseEvent.MOUSE_OVER)
			{
				_source.removeEventListener(Event.ENTER_FRAME, backwards);
				_source.gotoAndPlay(_startFrame);
			}
			else
			{
				_source.addEventListener(Event.ENTER_FRAME, backwards, false, 0, true);
			}
		}

		private function backwards(event:Event):void
		{
			if(_source.currentFrame > _startFrame)
			{
				_source.prevFrame();
			}
			else
			{
				_source.removeEventListener(Event.ENTER_FRAME, backwards);
			}
		}
		
	}

}