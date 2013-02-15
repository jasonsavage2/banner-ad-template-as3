
var frame;
var click_btn;

//set Security
Security.allowDomain("*");

this._lockroot = true;

//init banner
init();
	
function wait(milliseconds)
{
	stop();
	setTimeout(play, milliseconds);
}

function init()
{
	Stage.scaleMode = "showAll";
	Stage.align = "TL";
	
	//create frame
	frame = _root.createEmptyMovieClip("frame", _root.getNextHighestDepth());
	frame.lineStyle(1,0x999999);
	frame.moveTo(0.5, 0.5);
	frame.lineTo(Stage.width-1, 0.5);
	frame.lineTo(Stage.width-1, Stage.height-1);
	frame.lineTo(0.5, Stage.height-1);
	frame.lineTo(0.5, 0.5);
	
	//create button
	if (click_btn == null)
	{
		click_btn = _root.createEmptyMovieClip("click_btn", _root.getNextHighestDepth());
		click_btn.beginFill(0xffffff, 1);
		click_btn.moveTo(0, 0);
		click_btn.lineTo(Stage.width, 0);
		click_btn.lineTo(Stage.width, Stage.height);
		click_btn.lineTo(0, Stage.height);
		click_btn.lineTo(0, 0);
		click_btn.endFill();
		
		click_btn._alpha = 0;
		click_btn._buttonMode = true;
	}

	
	//add listeners
	click_btn.onRelease = clickThru;
	
	//start timeout timer
	setTimeout(onBannerTimeout, 15 * 1000);
	
}

function onBannerTimeout()
{
	trace("timeout()");
	
	if(_root.onTimeout != null)
		_root.onTimeout();
}

function clickThru(event)
{
	trace("clickThru()");
	
	var url:String = _level0.clickTag || _level0.ClickTag || _level0.clickTAG;
	getURL(url, "_blank");
}
