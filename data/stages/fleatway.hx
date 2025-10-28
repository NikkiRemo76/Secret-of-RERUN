import flixel.util.FlxGradient;

var lastFocused:Int = null;
var zoomin:FlxTween = null;
public var zoomAllow:Bool = true;

introLength = 0;

var colorShader = new CustomShader('adjustColor');
colorShader.brightness = 0;
colorShader.hue = 0;
colorShader.contrast = 0;
colorShader.saturation = 0;

var colorTween:FlxTween;
var cloudTween:FlxTween;
var sonicTween:FlxTween;

var camComic:FlxCamera = new FlxCamera();


//function onPlayerHit(e)
//{
//    e.note.splash = "pvz";
//}

var opponentZoom = 1;
var playerZoom = 0.5;

function onNoteHit(event)
	event.enableCamZooming = false;

function onCameraMove(_) if(zoomin == null && lastFocused != (lastFocused = curCameraTarget) && zoomAllow)
    zoomin = FlxTween.tween(FlxG.camera, {zoom: curCameraTarget == 0 ? opponentZoom : playerZoom}, (Conductor.stepCrochet * 14 / 1000), {ease: FlxEase.cubeOut, onComplete: function(_){
    	zoomin = null;
    	defaultCamZoom = FlxG.camera.zoom;
    }});
function postCreate() {
	camGame.alpha = 0;
	bgChange('1');

	camGame.addShader(colorShader);

	//FlxG.cameras.add(camComic, false);
	
    camComic.bgColor = new FlxColor(0x00000000);
	
	FlxG.cameras.remove(camHUD, false);
	FlxG.cameras.add(camComic, false);
	FlxG.cameras.add(camHUD, false);

	strumLines.members[0].characters[1].y = strumLines.members[1].characters[1].y;
	strumLines.members[1].characters[1].x -= 300;

	strumLines.members[2].characters[0].visible = false;

	gradi = FlxGradient.createGradientFlxSprite(1280, 1080, [FlxColor.TRANSPARENT, FlxColor.WHITE]);
	gradi.x = -12;
	gradi.y = -21;
	gradi.alpha = 1;
	gradi.updateHitbox();
    gradi.blend = 0;
	gradi.scrollFactor.set(0, 0);
	add(gradi);
	gradi.visible = false;

	gradiRender = new FunkinSprite().loadGraphic(gradi.pixels);
	gradiRender.updateHitbox();
	gradiRender.screenCenter();
	gradiRender.scrollFactor.set();
	gradiRender.blend = 0;
	gradiRender.color = 0xFE7673;
	gradiRender.zoomFactor = 0;
	insert(members.indexOf(smoke), gradiRender);

	comicbg = new FlxSprite(0,0);
	comicbg.makeGraphic(1280, 720, FlxColor.WHITE);
	comicbg.color = 0xe3c4ca;
    comicbg.scale.set(2, 2);
	comicbg.camera = camComic;
	comicbg.visible = false;
	comicbg.scrollFactor(0,0);
	comicbg.updateHitbox();
    comicbg.screenCenter();
	insert(members.indexOf(gf), comicbg);

	comic1 = new FlxSprite().loadGraphic(Paths.image('stages/fleatway/comic/comic1'));
    comic1.updateHitbox();
    comic1.screenCenter();
    comic1.camera = camComic;
	comic1.visible = false;
	comic1.antialiasing = true;
    insert(members.indexOf(gf), comic1);

	comic3 = new FlxSprite().loadGraphic(Paths.image('stages/fleatway/comic/comic3'));
    comic3.updateHitbox();
    comic3.screenCenter();
    comic3.camera = camComic;
	comic3.visible = false;
	comic3.antialiasing = true;
    insert(members.indexOf(gf), comic3);

	comic2 = new FlxSprite().loadGraphic(Paths.image('stages/fleatway/comic/comic2'));
    comic2.updateHitbox();
    comic2.screenCenter();
    comic2.camera = camComic;
	comic2.visible = false;
	comic2.antialiasing = true;
    insert(members.indexOf(gf), comic2);

	comic = new FlxSprite().loadGraphic(Paths.image('stages/fleatway/comic/comic'));
    comic.updateHitbox();
    comic.screenCenter();
    comic.camera = camComic;
	comic.visible = false;
	comic.antialiasing = true;
    insert(members.indexOf(gf), comic);
}

function bgChange(values) {
	switch (values) {
		case '1': 
			strumLines.members[0].characters[0].visible = true;
			strumLines.members[1].characters[0].visible = true;
			strumLines.members[0].characters[1].visible = false;
			strumLines.members[1].characters[1].visible = false;
			strumLines.members[0].characters[2].visible = false;
			strumLines.members[1].characters[2].visible = false;
			opponentZoom = 1;
			playerZoom = 0.5;
			zoomAllow = true;
			sky.visible = true;
			bg1.visible = true;
			bg2.visible = true;
			bg3.visible = true;
			bg4.visible = true;
			bgFight.visible = false;
			smoke.visible = true;
			bg5.visible = true;
			fg2.visible = false;
			skyp3.visible = false;
			fog.visible = false;
			stagep3.visible = false;
			cloud.visible = false;
		case '2': 
			strumLines.members[0].characters[0].visible = false;
			strumLines.members[1].characters[0].visible = false;
			strumLines.members[0].characters[1].visible = true;
			strumLines.members[1].characters[1].visible = true;
			strumLines.members[0].characters[2].visible = false;
			strumLines.members[1].characters[2].visible = false;
			zoomAllow = false;
			sky.visible = false;
			bg1.visible = false;
			bg2.visible = false;
			bg3.visible = false;
			bg4.visible = false;
			bgFight.visible = true;
			smoke.visible = true;
			bg5.visible = false;
			fg2.visible = true;
			skyp3.visible = false;
			fog.visible = false;
			stagep3.visible = false;
			cloud.visible = false;
		case '3': 
			strumLines.members[0].characters[0].visible = false;
			strumLines.members[1].characters[0].visible = false;
			strumLines.members[0].characters[1].visible = false;
			strumLines.members[1].characters[1].visible = false;
			strumLines.members[0].characters[2].visible = true;
			strumLines.members[1].characters[2].visible = true;
			remove(strumLines.members[1].characters[2]);
			insert(members.indexOf(strumLines.members[0].characters[2]), strumLines.members[1].characters[2]);
			remove(cloud);
			insert(members.indexOf(strumLines.members[1].characters[2]), cloud);
			strumLines.members[0].characters[2].zoomFactor = 0.8;
			pissaura.zoomFactor = 0.8;
			remove(pissaura);
			insert(members.indexOf(strumLines.members[0].characters[2]), pissaura);
			pissaura.blend = 0;
			strumLines.members[1].characters[2].color = 0x000000;
			opponentZoom = 0.4;
			playerZoom = 0.8;
			zoomAllow = true;
			sky.visible = false;
			bg1.visible = false;
			bg2.visible = false;
			bg3.visible = false;
			bg4.visible = false;
			bgFight.visible = false;
			smoke.visible = false;
			bg5.visible = false;
			fg2.visible = false;
			skyp3.visible = true;
			fog.visible = true;
			stagep3.visible = true;
			cloud.visible = true;
			strumLines.members[1].characters[2].alpha = 0;
	}
}

function sonicFade(){
	sonicTween = FlxTween.tween(strumLines.members[1].characters[2], {alpha: 1}, 2, {ease: FlxEase.cubeOut, onComplete: function(_){
    	cloudTween = null;
    }});
}

function cloudFade(){
	colorTween = FlxTween.color(strumLines.members[1].characters[2], 2, 0xff000000, 0xffffffff, {ease: FlxEase.cubeOut, 
		onComplete: function(twn:FlxTween) {
			colorTween = null;
		}
	});
	cloudTween = FlxTween.tween(cloud, {alpha: 0}, 2, {ease: FlxEase.cubeOut, 
		onComplete: function(_){
    	cloudTween = null;
    }});
}

var brightnessBlock = false;
var hueBlock = false;
var contrastBlock = false;
var saturationBlock = false;

function update(elapsed:Float) {
	if(!brightnessBlock)colorShader.brightness = FlxMath.lerp(colorShader.brightness, 0, 0.05);
	//if(!hueBlock)colorShader.hue = FlxMath.lerp(colorShader.hue, 0, 0.01);
	//if(!contrastBlock)colorShader.contrast = FlxMath.lerp(colorShader.contrast, 0, 0.01);
	//if(!saturationBlock)colorShader.saturation = FlxMath.lerp(colorShader.saturation, 0, 0.01);

	strumLines.members[0].notes.forEach(function(n){
	//	trace(n);
	});
}
function beatHit(curBeat:Int) {
	if(curBeat % 1 == 0 && !brightnessBlock){
        colorShader.brightness += 30;
        //trace('section');
		//colorShader.contrast = 5000;
    }
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
function stepHit(curStep:Int) {
	switch (curStep) {
		case 16:
			camGame.alpha = 1;
        case 1416: 
            comic.visible = true;
			comic1.visible = true;
			comic2.visible = true;
			comic3.visible = true;
			comicbg.visible = true;
			comicbg.setPosition(0,0);
			comic.setPosition(0,0);
			comic1.setPosition(0,0);
			comic2.setPosition(0,0);
			comic3.setPosition(0,0);
			comic2.alpha = 0;
			FlxTween.tween(comic2, {alpha: 1}, 2, {ease: FlxEase.cubeOut});
			FlxTween.tween(camComic.scroll, {x: 0, y: 100},0.5, {ease: FlxEase.cubeOut});
		case 1448: 
			FlxTween.tween(camComic.scroll, {x: 1100, y: 100},0.5, {ease: FlxEase.cubeOut});
		case 1472: 
			FlxTween.tween(camComic.scroll, {x: 0, y: 800},0.5, {ease: FlxEase.cubeOut});
		case 1480: 
			FlxTween.tween(camComic.scroll, {x: 800, y: 800},0.5, {ease: FlxEase.cubeOut});
		case 1496: 
			FlxTween.tween(camComic.scroll, {x: 500, y: 1750},0.5, {ease: FlxEase.cubeOut});
			FlxTween.tween(camComic, {zoom: 0.6},0.5, {ease: FlxEase.cubeOut});
		case 1512: 
			FlxTween.tween(camComic, {zoom: 5}, 4, {ease: FlxEase.cubeOut});
			FlxTween.tween(comic1, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
			FlxTween.tween(comic2, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
			FlxTween.tween(comic3, {alpha: 0}, 0.5, {ease: FlxEase.cubeOut});
    }
}