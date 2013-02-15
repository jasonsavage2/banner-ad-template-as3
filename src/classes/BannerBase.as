package classes
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class BannerBase extends MovieClip 
	{
		
		public var frame:Sprite;

		public var click_btn:Sprite;
		
		/**
		 * Constructor
		 */
		public function BannerBase() 
		{
			super();
			
			Security.allowDomain("*");
			
			if (!stage)
				addEventListener("addedToStage", on_addedToStage);
			else
				on_addedToStage(null);
		}
		
		private function wait(milliseconds:int)
		{
			stop();
			setTimeout(play, milliseconds);
		}
		
		private function on_addedToStage(event:Event=null)
		{
			removeEventListener("addedToStage", on_addedToStage);
			setTimeout(init, 100);
		}
		
		private function init(event:Event=null)
		{
			stage.scaleMode = "showAll";
			stage.align = "TL";
			
			//create frame
			frame = new Sprite();
			frame.graphics.lineStyle(1,0x999999);
			frame.graphics.drawRect(0.5, 0.5, loaderInfo.width-1, loaderInfo.height-1);
			frame.graphics.endFill();
			stage.addChild(frame);
			
			//create button
			if (click_btn == null)
			{
				var btn:Sprite = new Sprite();
				btn.graphics.beginFill(0xffffff, 1);
				btn.graphics.drawRect(0, 0, loaderInfo.width, loaderInfo.height);
				btn.graphics.endFill();
				
				btn.alpha = 0;
				btn.buttonMode = true;
				stage.addChild(btn);
				
				click_btn = btn;
			}
			
			//add listeners
			click_btn.addEventListener("click", clickThru);
			
			//start timeout timer
			setTimeout(onBannerTimeout, 15 * 1000);
			
		}
		
		private function onBannerTimeout():void
		{
			trace("timeout()");
			stage.dispatchEvent(new Event("timerComplete"));
		}
		
		private function clickThru(event:Event):void
		{
			trace("clickThru()");
			
			var paramObj:Object = loaderInfo.parameters;
			var url:String;
			
			for (var i:String in paramObj) {
				if (i.toLowerCase() == "clicktag") {
					url = paramObj[i];
					break;
				}
			}
			if (url && ((url.substr(0, 5) == "http:") || (url.substr(0, 6) == "https:"))) 
			{
				navigateToURL(new URLRequest(url),"_blank");
			}
		}

	}

}