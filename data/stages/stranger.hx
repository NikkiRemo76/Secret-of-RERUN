importScript("data/scripts/hud");

var colorShader = new CustomShader('adjustColor');
colorShader.brightness = 0;
colorShader.hue = 0;
colorShader.contrast = 0;
colorShader.saturation = 0;

introLength = 0;

evev = new CustomShader('evev');

function create() {
    camGame.addShader(colorShader);

	animbg.visible = false;
	animbg.shader = evev;
	animbg.updateHitbox();
	animbg.screenCenter();
	animbg.setGraphicSize(1980 + 400);
	//animbg.velocityAngle = -50;

	fg.zoomFactor = 0.95;
	trees1.zoomFactor = 1.1;
	trees2.zoomFactor = 1.05;
}
var visiblebg = false;
function bgVisible() {
	if(!visiblebg){
		animbg.visible = true;
		visiblebg = true;
	}else{
		animbg.visible = false;
		visiblebg = false;
	}
}
var localTime:Float = 0;
function update(elapsed:Float) {
	//animbg.angle -= 0.5;
	localTime += elapsed;
	evev.iTime = localTime * 2;
}
function flashFunc(type:String, int:Int) {
	var bebe:Int = Std.parseInt(int);
	if(type == 'b'){
		colorShader.brightness = bebe;
	}else if(type == 'h'){
		colorShader.hue = bebe;
	}else if(type == 'c'){
		colorShader.contrast = bebe;
	}else if(type == 's'){
		colorShader.saturation = bebe;
	}
}
var brightnessTween:FlxTween;
var hueTween:FlxTween;
var contrastTween:FlxTween;
var saturationTween:FlxTween;
function tweenColor(type:String, int:Int, time:Int){
	//trace(type, int, time);
	var bebe:Int = Std.parseInt(int);
	var tete:Float = Std.parseFloat(time);
	if(type == 'b'){
		brightnessBlock = true;
		if (brightnessTween != null) brightnessTween.cancel();
		brightnessTween = FlxTween.tween(colorShader, {brightness: bebe},tete, {ease: FlxEase.cubeOut, onComplete: function (twn:FlxTween) {
			//brightnessTween.cancel();
			brightnessBlock = false;
		}});
	}else if(type == 'h'){
		hueBlock = true;
		if (hueTween != null) hueTween.cancel();
		hueTween = FlxTween.tween(colorShader, {hue: bebe},tete, {ease: FlxEase.cubeOut, onComplete: function (twn:FlxTween) {
			//hueTween.cancel();
			hueBlock = false;
		}});
	}else if(type == 'c'){
		contrastBlock = true;
		if (contrastTween != null) contrastTween.cancel();
		contrastTween = FlxTween.tween(colorShader, {contrast: bebe},tete, {ease: FlxEase.cubeOut, onComplete: function (twn:FlxTween) {
			//contrastTween.cancel();
			contrastBlock = false;
		}});
	}else if(type == 's'){
		saturationBlock = true;
		if (saturationTween != null) saturationTween.cancel();
		saturationTween = FlxTween.tween(colorShader, {saturation: bebe},tete, {ease: FlxEase.cubeOut, onComplete: function (twn:FlxTween) {
			//saturationTween.cancel();
			saturationBlock = false;
		}});
	}
}