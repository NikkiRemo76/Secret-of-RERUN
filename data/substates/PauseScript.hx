import funkin.ui.FunkinText;
import flixel.text.FlxText;
import flixel.text.FlxTextBorderStyle;
import funkin.backend.system.framerate.Framerate;
import funkin.backend.scripting.events.NameEvent;
import funkin.backend.scripting.EventManager;
import funkin.options.OptionsMenu;
import funkin.editors.charter.Charter;
import flixel.tweens.FlxTween.FlxTweenType;

var pauseCam = new FlxCamera();

var scroll, confirm, cancel, enter:FlxSound;

var blackboxDown = new FlxSprite();
var blackboxUp = new FlxSprite();

var texts:Array = [];

var grpMenuShit:FlxTypedGroup<Alphabet>;
var pitchSound;

//var aaaa = ['Resume', 'Options', 'Credits', 'Exit', "Exit to charter"];

var selectCall:NameEvent->Void;  // Mainly for extern stuff that aren't scripts  - Nex

heatShader = new CustomShader('heatShader');
ntscfilter = new CustomShader('NTSCFilter');
ntsc = new CustomShader('ntsc');
chromAbb = new CustomShader('chromAbb');

var songName = PlayState.SONG.meta.displayName;

function create(event) {
    //FlxTween.tween(Framerate.offset, {y: 60}, .5, {ease: FlxEase.cubeOut});
	// cancel default pause menu!!
	event.cancel();

	//menuItems = aaaa;

	cameras = [];

	menuItems.remove('Restart Song');
	menuItems.remove('Change Controls');
	menuItems.remove('Exit to menu');
	menuItems.remove('Exit to charter');
	menuItems.push('Credits');
	menuItems.push('Exit to menu');
	menuItems.push('Exit to charter');

	if (menuItems.contains("Exit to charter") && !PlayState.chartingMode)
			menuItems.remove("Exit to charter");

    confirm = FlxG.sound.load(Paths.sound('rerunMenu/confirmMenu'), .3);
    cancel = FlxG.sound.load(Paths.sound('rerunMenu/cancelMenu'), .3);
    scroll = FlxG.sound.load(Paths.sound('rerunMenu/scrollMenu'), .15);

	//pitchSound = FlxG.random.float(-5, 5);
	//trace(pitchSound);
	//pauseSound = FlxG.sound.load(Paths.sound('menu/new/pause'), .15);
	//pauseSound.pitch = pitchSound;
	//pauseSound.play();

    FlxG.cameras.add(pauseCam, false);
    pauseCam.bgColor = 0xFF000000;
    pauseCam.alpha = 0;
    FlxTween.tween(pauseCam, {alpha: 1, zoom: 1}, .5, {ease: FlxEase.cubeOut});

	trace(PlayState.SONG.meta.displayName);

	bgass = new FlxSprite(1280, 0);
	if(!Assets.exists(Paths.image('menus/pause/' + songName + '/assets/bg'))){
    	bgass.loadGraphic(Paths.image('menus/pause/Hide And Seek/assets/bg')); // Замените на свой спрайт
	}else{
		bgass.loadGraphic(Paths.image('menus/pause/' + songName + '/assets/bg')); // Замените на свой спрайт
	}
	bgass.setGraphicSize(1280);
	bgass.updateHitbox();
    bgass.screenCenter();
	bgass.antialiasing = true;
	if(songName == 'Hide and Seek'){
		bgass.shader = heatShader;
	}
	add(bgass);

	charass = new FlxSprite(0, 720);
	if(!Assets.exists(Paths.image('menus/pause/' + songName + '/assets/char'))){
    	charass.loadGraphic(Paths.image('menus/pause/Hide And Seek/assets/char')); // Замените на свой спрайт
	}else{
		charass.loadGraphic(Paths.image('menus/pause/' + songName + '/assets/char')); // Замените на свой спрайт
	}
	charass.setGraphicSize(1280);
	charass.updateHitbox();
    //charass.screenCenter();
	charass.antialiasing = true;
	add(charass);

	FlxTween.tween(charass, {y: 0}, 0.3, {ease: FlxEase.cubeOut});

	grpMenuShit = new FlxTypedGroup();
	add(grpMenuShit);

    var i:Float = 2;
	for(e in menuItems) {
		textaaaaaa = new FlxSprite(0, -350);
        FlxTween.tween(textaaaaaa, {y: (22 * 2) + (i * 9 * 18) - 350}, .5, {ease: FlxEase.backOut});
		if(!Assets.exists(Paths.image('menus/pause/' + songName + '/buttons/' + e))){
    		textaaaaaa.loadGraphic(Paths.image('menus/pause/Hide And Seek/buttons/' + e)); // Замените на свой спрайт
		}else{
			textaaaaaa.loadGraphic(Paths.image('menus/pause/' + songName + '/buttons/' + e)); // Замените на свой спрайт
		}
		grpMenuShit.add(textaaaaaa);
		texts.push(textaaaaaa);
		i++;
	}

	if(!Assets.exists(Paths.music("pause/" + songName))){
		event.music = "pause/Freaky";
	}else{
		event.music = "pause/" + songName;
	}

	if(songName == 'Munchiz'){
		//pauseCam.addShader(ntsc);
		pauseCam.addShader(chromAbb);
		pauseCam.addShader(ntscfilter);
		aasssasa = new FlxSprite(0, 720);
    	aasssasa.loadGraphic(Paths.image('menus/pause/Hide And Seek/assets/char')); // Замените на свой спрайт
		aasssasa.visible = false;
		add(aasssasa);
		FlxTween.tween(aasssasa, {x: 0.5}, 5, {ease: FlxEase.expoInOut, type: FlxTweenType.PINGPONG});
	}

	//infoTxt= new FlxText(430, 25, 0, 'Composers: ' + PlayState.SONG.meta.customValues.composer + '\nChart:' + PlayState.SONG.meta.customValues.chart + '\nArt:' + PlayState.SONG.meta.customValues.art + '\nCode:' + PlayState.SONG.meta.customValues.code, 8);
	//infoTxt.scrollFactor.set();
	//infoTxt.setFormat(Paths.font("joystix monospace.otf"), 150, FlxColor.WHITE, FlxText.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	//infoTxt.scale.set(0.12, 0.12);
	//infoTxt.alignment = 'right';
	//infoTxt.updateHitbox();
	//add(infoTxt);

	cameras = [pauseCam];

	changeSelection(0);
}

function destroy() FlxG.cameras.remove(pauseCam);

var canDoShit = true;
var time:Float = 0;
function update(elapsed) {
	time += elapsed;

	if(songName == 'Munchiz'){

	chromAbb.amount = aasssasa.x;

	}

	ntscfilter.uFrame = time;
	ntsc.iTime = time;
	heatShader.iTime = time;
	//var curText = texts[curSelected];
	//hand.setPosition(curText.x - 30, curText.y + (textaaaaaa.height - hand.height) - 8);
	//hand.x -= hand.x % 6;
	//hand.y -= hand.y % 6;

	if (!canDoShit) return;
	var oldSec = curSelected;
	if (controls.DOWN_P) changeSelection(1, false);
	if (controls.UP_P) changeSelection(-1);

	if (controls.ACCEPT) {
		var option = menuItems[curSelected];

        if (option == "Exit to menu") cancel.play();
        else confirm.play();

        //FlxTween.tween(Framerate.offset, {y: 0}, .5, {ease: FlxEase.cubeOut});
		if (option == "Resume" || option == "Restart Song") {
			canDoShit = false;
            FlxTween.tween(pauseCam, {alpha: 0}, .5, {ease: FlxEase.cubeOut});
            new FlxTimer().start(.65, function(tmr:FlxTimer){
                selectOption();
            });
		}else if (option == "Exit to menu" || option == "Change Options"){
            canDoShit = false;
            selectOption();
        }else selectOption();
	}
}

function selectOption() {
	var event = EventManager.get(NameEvent).recycle(menuItems[curSelected]);
	if (selectCall != null) selectCall(event);
	pauseScript.call("onSelectOption", [event]);
	if (event.cancelled) return;
	switch (event.name)
	{
		case "Resume":
			close();
		case "Restart Song":
			parentDisabler.reset();
			game.registerSmoothTransition();
			FlxG.resetState();
		case "Change Controls":
			persistentDraw = false;
			openSubState(new KeybindsOptions());
		case "Change Options":
			FlxG.switchState(new OptionsMenu((_) -> FlxG.switchState(new PlayState())));
		case "Exit to charter":
			FlxG.switchState(new Charter(PlayState.SONG.meta.name, PlayState.difficulty, PlayState.variation, false));
		case "Exit to menu":
			if (PlayState.chartingMode && Charter.undos.unsaved)
				game.saveWarn(false);
			else {
				if (Charter.instance != null) Charter.instance.__clearStatics();
				// prevents certain notes to disappear early when exiting  - Nex
				game.strumLines.forEachAlive(function(grp) grp.notes.__forcedSongPos = Conductor.songPosition);
				CoolUtil.playMenuSong();
				FlxG.switchState(PlayState.isStoryMode ? new StoryMenuState() : new FreeplayState());
			}
	}
}

function changeSelection(change){
	scroll.stop();
    scroll.play();

	curSelected += change;

	if (curSelected < 0) curSelected = menuItems.length - 1;
	if (curSelected >= menuItems.length) curSelected = 0;

	//for(numbers in menuItems.length){
	//	numbers[curSelected].color = 0xff0000;
	//}
	//trace(curSelected);
	//trace(menuItems.length);
}