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

function onNoteCreation(e)
    e.noteSprite = 'game/notes/NOTE_ASSETS'; // replaces default noteskin

function onStrumCreation(e)
    e.sprite = 'game/notes/NOTE_ASSETS'; // same as above

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

	strumLines.members[0].characters[1].y = strumLines.members[1].characters[1].y;
	strumLines.members[1].characters[1].x -= 300;

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

	comixbg = new FlxSprite(0,0);
	comixbg.makeGraphic(1280, 720, FlxColor.WHITE);
	comixbg.updateHitbox();
    comixbg.screenCenter();
	comixbg.color = 0xe3c4ca;
    comixbg.scale.set(2, 2);
	comixbg.camera = camHUD;
	comixbg.visible = false;
	insert(members.indexOf(gf), comixbg);

	comix = new FlxSprite().loadGraphic(Paths.image('stages/fleatway/comix'));
    //comix.scale.set(0.8,0.8);
    comix.updateHitbox();
    comix.screenCenter();
    comix.camera = camHUD;
	comix.visible = false;
	comix.antialiasing = true;
    insert(members.indexOf(gf), comix);
}

function bgChange(values) {
	switch (values) {
		case '1': 
			strumLines.members[0].characters[0].visible = true;
			strumLines.members[1].characters[0].visible = true;
			strumLines.members[0].characters[1].visible = false;
			strumLines.members[1].characters[1].visible = false;
			strumLines.members[0].characters[2].visible = false;
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
		case '2': 
			strumLines.members[0].characters[0].visible = false;
			strumLines.members[1].characters[0].visible = false;
			strumLines.members[0].characters[1].visible = true;
			strumLines.members[1].characters[1].visible = true;
			strumLines.members[0].characters[2].visible = false;
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
		case '3': 
			strumLines.members[0].characters[0].visible = false;
			strumLines.members[1].characters[0].visible = false;
			strumLines.members[0].characters[1].visible = false;
			strumLines.members[1].characters[1].visible = false;
			strumLines.members[0].characters[2].visible = true;
			opponentZoom = 0.5;
			playerZoom = 1;
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
	}
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
        case 1380: 
            comix.visible = true;
			comixbg.visible = true;
			FlxTween.tween(comix, {x: 0, y: -100},0.5, {ease: FlxEase.cubeOut});
		case 1388: 
			FlxTween.tween(comix, {x: 300, y: -800, 'scale.x': 1.2, 'scale.y': 1.2},0.4, {ease: FlxEase.cubeOut});
		case 1392: 
			FlxTween.tween(comix, {x: -1100, y: -100, 'scale.x': 1, 'scale.y': 1},0.5, {ease: FlxEase.cubeOut});
		case 1400: 
			FlxTween.tween(comix, {x: -800, y: -800, 'scale.x': 0.8, 'scale.y': 0.8},0.5, {ease: FlxEase.cubeOut});
			FlxTween.tween(comix, {alpha: 0},1.5, {ease: FlxEase.cubeOut});
			FlxTween.tween(comixbg, {alpha: 0},1.5, {ease: FlxEase.cubeOut});
    }
}