import openfl.display.BlendMode;
import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;
import funkin.backend.MusicBeatState;
import funkin.backend.MusicBeatTransition;

MusicBeatTransition.script = 'data/scripts/transition';

shaderREDVHS = new CustomShader("title/DistortionVhsRedShader");
shaderREDVHS.time = 1;
glitchA = new CustomShader("title/glitchA");

shader2 = new CustomShader("title/NTSCFilter");
scaryShaderBG = new CustomShader("title/ScaryShaderBG");
highContrast = new CustomShader("title/shader");

var camBG:FlxCamera = new FlxCamera();
var camMenu:FlxCamera = new FlxCamera();
var camCars:FlxCamera = new FlxCamera();

MusicBeatState.skipTransIn = true;

function create() {

	FlxG.cameras.add(camBG, false);
    camBG.bgColor = new FlxColor(0x00000000);

	FlxG.cameras.add(camCars, false);
    camCars.bgColor = new FlxColor(0x00000000);

    FlxG.cameras.add(camMenu, false);
    camMenu.bgColor = new FlxColor(0x00000000);

    bg = new FlxSprite().makeGraphic(FlxG.width * 3, FlxG.height * 3, 0xff8f0000);
	bg.screenCenter();
	bg.camera = camBG;
	add(bg);
	//bg.visible = false;

	camBG.addShader(scaryShaderBG);
	camBG.addShader(shaderREDVHS);
	camBG.addShader(shader2);
	camBG.addShader(glitchA);
	camBG.addShader(highContrast);
	camMenu.addShader(highContrast);

	bg2 = new FlxSprite().makeGraphic(FlxG.width * 3, FlxG.height * 3, 0xff160000);
	bg2.screenCenter();
	bg2.camera = camCars;
	bg2.blend = 2;
	add(bg2);

	intro = new FunkinSprite(0, 0, Paths.image('menus/title/rerunIntro'));
	intro.addAnim('idle','introRerun', 15, false);
	intro.playAnim('idle');
	intro.setGraphicSize(1280);
	intro.updateHitbox();
	intro.screenCenter();
	intro.x -= 40;
	intro.y += 10;
	intro.camera = camMenu;
	add(intro);

	title2 = new FlxSprite().loadGraphic(Paths.image('menus/title/secret of'));
    //title2.setGraphicSize(1280);
	title2.scale.set(0.5, 0.5);
	title2.updateHitbox();
	title2.screenCenter();
	title2.camera = camMenu;
	title2.alpha = 0;
	add(title2);

    title = new FlxSprite().loadGraphic(Paths.image('menus/title/logo'));
    title.setGraphicSize(1280);
	title.updateHitbox();
	title.screenCenter();
	title.camera = camMenu;
	add(title);
	title.visible = false;

    vg = new FlxSprite().loadGraphic(Paths.image('menus/vignette'));
	vg.screenCenter();
    vg.scale.set(1.2, 1.2);
	vg.camera = camBG;
	add(vg);

	FlxG.sound.playMusic(null, 0);
	FlxG.sound.play(Paths.sound('rerunMenu/intro'), 1);

	new FlxTimer().start(1.2, (_) -> [
        FlxG.sound.playMusic(Paths.music('menus/Menu'), 1),
		camMenu.flash(0xff0000, 1),
		title.visible = true,
		camBG.visible = true,
		bg2.visible = false,
		intro.visible = false,
		new FlxTimer().start(2, (_) -> [
			FlxTween.tween(title2, {"scale.y": 0.7, "scale.x": 0.7}, 1.5, {ease: FlxEase.backOut}),
			FlxTween.tween(title2, {alpha: 1}, 1.5, {ease: FlxEase.backOut}),
			FlxTween.tween(title, {y: 140}, 1.5, {ease: FlxEase.backOut})
		])
    ]);
}

var transitioning:Bool = false;
var localTime:Float = 0;
function update(elapsed:Float) {
	//animbg.angle -= 0.5;
	localTime += elapsed;

	if (controls.DEV_ACCESS) {
		openSubState(new EditorPicker());
	}
	if (controls.SWITCHMOD) {
		openSubState(new ModSwitchMenu());
	}

    if (controls.ACCEPT) {
		if (!transitioning){
            transitioning = true;
			//trace("m,dms,hdsjklljhvkdlhvgjkfdlvnjkfdojn");
			FlxG.sound.play(Paths.sound("menu/confirm"), 0.7);
			camMenu.flash(0xff0000, 1);
			//CoolUtil.playMenuSFX("menu/confirm");
			new FlxTimer().start(1.4, (_) -> FlxG.switchState(new MainMenuState()));
		}
	}

    shaderREDVHS?.time = localTime / 2;

	// у него нет itime
	//shader2.iTime = localTime;
	glitchA.iTime = localTime;
	scaryShaderBG.iTime = localTime;
}