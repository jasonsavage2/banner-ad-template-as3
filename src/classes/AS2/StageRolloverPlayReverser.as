

var _startFrame = this._currentFrame + 1;

//this == _root
click_btn.onRollOver = function ():Void
{
	//this == click_btn
	_root.onEnterFrame = null;
	_root.gotoAndPlay(_startFrame);
}
click_btn.onRollOut = function():Void
{
	//this == click_btn
	_root.onEnterFrame = function():Void
	{
		//this == _root
		if(this._currentFrame > _startFrame)
		{
			this.prevFrame();
		}
		else
		{
			this.onEnterFrame = null;
		}
	}
}


		
