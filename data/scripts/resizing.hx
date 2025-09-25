
import openfl.system.Capabilities;
import funkin.backend.utils.ShaderResizeFix;
import flixel.system.scaleModes.RatioScaleMode;

public function ratioThing(width:Int,height:Int,?skip:Bool = false){
	//camHUD.fade(FlxColor.BLACK, 0);
	final winYRatio: Float = (1080 / Capabilities.screenResolutionY);
	final winY = height * winYRatio;
	final winX = width * winYRatio;

	FlxTween.cancelTweensOf(window);
	if (!skip){	
		FlxTween.tween(window, {
			width: winX,
			height: winY, 
			y: Math.floor((Capabilities.screenResolutionY / 2) - (winY / 2)), 
			x: Math.floor(((Capabilities.screenResolutionX) / 2) - (winX / 2)) + ((Capabilities.screenResolutionX) * Math.floor(window.x / (Capabilities.screenResolutionX)))
		}, 0.4, {
			ease: FlxEase.quadInOut,
			onComplete: function(a) camHUD.fade(FlxColor.BLACK, 0, true)
		});
	} else {
		FlxG.resizeWindow(width, height);
		FlxG.width = winX;
		FlxG.height = winY;
		window.y = Math.floor((Capabilities.screenResolutionY / 2) - (winY / 2));
		window.x = Math.floor(((Capabilities.screenResolutionX) / 2) - (winX / 2)) + ((Capabilities.screenResolutionX) * Math.floor(window.x / (Capabilities.screenResolutionX)));
	}
	FlxG.scaleMode = new RatioScaleMode(true);
	window.resizable = width == 1280;
}