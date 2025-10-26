import flixel.ui.FlxBar;
import flixel.ui.FlxBarFillDirection;

var gameoverCam = new FlxCamera();
var songName = PlayState.SONG.meta.displayName;

var menuItem = [
    'retry',
    'exit'
];
var curSelected:Int = 0;

var banSongs = songName == 'Twisted' || songName == 'Stranger Danger' || songName == 'Powerjack';

function create(){
    //trace(banSongs);
    FlxG.cameras.add(gameoverCam, false);
    _parentState.persistentDraw = true;
    gameoverCam.bgColor = 0x00000000;
    cameras = [gameoverCam];

    if (Assets.exists(Paths.music('gameover/' + songName))) {
		gameoverMusic = FlxG.sound.load(Assets.getMusic(Paths.music('gameover/' + songName)), 1, true);
		gameoverMusic.persist = false;
		gameoverMusic.group = FlxG.sound.defaultMusicGroup;
		gameoverMusic.play();
	}else{
        gameoverMusic = FlxG.sound.load(Assets.getMusic(Paths.music('gameover/rerun')), 1, true);
		gameoverMusic.persist = false;
		gameoverMusic.group = FlxG.sound.defaultMusicGroup;
		gameoverMusic.play();
    }

    mainFrame = new FlxSprite();
    if(!Assets.exists(Paths.image('menus/gameovers/' + songName + '/main'))){
        mainFrame.loadGraphic(Paths.image('menus/gameovers/Hide And Seek/main'));
    }else{
        mainFrame.loadGraphic(Paths.image('menus/gameovers/' + songName + '/main'));
    }
    mainFrame.updateHitbox();
    mainFrame.screenCenter();
    add(mainFrame);

    if(!banSongs){

        timeBarBG = new FlxSprite();
        if(!Assets.exists(Paths.image('menus/gameovers/' + songName + '/bar'))){
            timeBarBG.loadGraphic(Paths.image('menus/gameovers/Hide And Seek/bar'));
        }else{
            timeBarBG.loadGraphic(Paths.image('menus/gameovers/' + songName + '/bar'));
        }
        timeBarBG.scale.set(0.8, 0.8);
        timeBarBG.updateHitbox();
        timeBarBG.screenCenter(FlxAxes.X);
        timeBarBG.y += 400;

        // ИСПРАВЛЕНИЕ: Правильное создание FlxBar
        timeBar = new FlxBar(timeBarBG.x + 50, timeBarBG.y + 9, FlxBarFillDirection.LEFT_TO_RIGHT, Std.int(timeBarBG.width - 100), Std.int(timeBarBG.height - 40));
        timeBar.createFilledBar(0xff000000, 0xFFf91c3f);
        // Устанавливаем значения вручную, так как instInfo может не работать
        timeBar.setRange(0, instLength);
        timeBar.value = 0;
        add(timeBar);
        add(timeBarBG);

        icon = new FlxSprite();
        if(!Assets.exists(Paths.image('menus/gameovers/' + songName + '/icon'))){
            icon.loadGraphic(Paths.image('menus/gameovers/Hide And Seek/icon'));
        }else{
            icon.loadGraphic(Paths.image('menus/gameovers/' + songName + '/icon'));
        }
    
    
        icon.scale.set(0.8, 0.8);
        icon.updateHitbox();
        icon.y = timeBar.y - icon.height + 20; // Размещаем над баром
        add(icon);
    }

    menuItems = new FlxGroup();
	add(menuItems);

    for(e in menuItem) {
        trace(e);
		var textaaaaaa = new FlxSprite(0,
                switch(songName){
                    case 'Hide and Seek': 
                        e == 'retry' ? 450 : 560;
                    case 'Twisted': 
                        e == 'retry' ? 500 : 600;
                    case 'Stranger Danger': 
                        e == 'retry' ? 500 : 600;
                    case 'Powerjack':
                        e == 'retry' ? 500 : 600;
                    default:
                        e == 'retry' ? 450 : 560;
                }
            );
        //FlxTween.tween(textaaaaaa, {y: (22 * 2) + (e * 9 * 18) - 350}, .5, {ease: FlxEase.backOut});
		if(!Assets.exists(Paths.image('menus/gameovers/' + songName + '/menuAssets'))){
            textaaaaaa.frames = Paths.getFrames('menus/gameovers/Hide And Seek/menuAssets');
		}else{
            textaaaaaa.frames = Paths.getFrames('menus/gameovers/' + songName + '/menuAssets');
		}
		textaaaaaa.animation.addByPrefix('idle', e + "0000", 5);
		textaaaaaa.animation.addByPrefix('selected', e + "0001", 5);
		textaaaaaa.animation.play('idle');
        textaaaaaa.scale.set(0.7, 0.7);
        textaaaaaa.updateHitbox();
        textaaaaaa.screenCenter(FlxAxes.X);
        switch(songName){
            case 'Hide and Seek': 
                textaaaaaa.x -= 25;
            case 'Twisted': 
                textaaaaaa.x -= 25;
            case 'Stranger Danger': 
                textaaaaaa.x -= 75;
            case 'Powerjack': 
                textaaaaaa.x -= e == 'retry' ? 75 : 90;
            default:
                textaaaaaa.x -= 25;
        }
        menuItems.add(textaaaaaa);
		textaaaaaa.ID = e == 'retry' ? 0 : 1;

        trace(textaaaaaa.ID);
	}

    changeItem(0);

    gameoverCam.scroll.y = -800;

    FlxTween.tween(gameoverCam.scroll, {y: 0}, 2, {ease: FlxEase.expoOut});

    switch(songName){
        case 'Hide and Seek': 
            mainFrame.x -= 40;
            mainFrame.setGraphicSize(1100);
        case 'Twisted': 
            mainFrame.x -= 100;
            mainFrame.setGraphicSize(900);
        case 'Stranger Danger': 
            mainFrame.x -= 145;
            mainFrame.y -= 40;
            mainFrame.setGraphicSize(900);
        case 'Powerjack': 
            mainFrame.x -= 145;
            mainFrame.y -= 30;
            mainFrame.setGraphicSize(900);
        default:
            mainFrame.setGraphicSize(1100);
    }

    menuItems.forEach((spr:FlxSprite) -> {
        trace(spr.ID);
		spr.animation.play(spr.ID == 0 ? "selected" : "idle");
	});
}
function changeItem(val:Int = 0)
{
    //FlxG.sound.play(Paths.sound("scrollMenu"), 0.7);
	curSelected += val;
	if (curSelected >= menuItem.length)
		curSelected = 0;
	if (curSelected < 0)
		curSelected = menuItem.length - 1;
	// there was code using FlxTween but its sucks so im using Lerp instead
    trace(curSelected);

    menuItems.forEach((spr:FlxSprite) -> {
        trace(spr.ID);
		spr.animation.play(spr.ID == curSelected ? "selected" : "idle");
	});
}

function update(elapsed:Float) {
    // ОБНОВЛЯЕМ ЗНАЧЕНИЕ БАРА ВРУЧНУЮ
    if(!banSongs){
        if (instInfo != null) {
            timeBar.value = instInfo.time;
        }
    }
    
    // ОБНОВЛЯЕМ ПОЗИЦИЮ ИКОНКИ КАЖДЫЙ КАДР
    updateIconPosition();

    if(controls.UP_P){
        changeItem(-1);
    }
	if(controls.DOWN_P){
        changeItem(1);
    }

    if(controls.ACCEPT){
        goToState();
    }
}

function updateIconPosition() {
    // Правильный расчет позиции
    if(!banSongs){
        var percentage:Float = timeBar.value / timeBar.max;
        var fillPosition:Float = timeBar.x + (percentage * timeBar.width);
    
    
        icon.x = fillPosition - (icon.width / 2);
    }
}

function goToState()
{
	var daChoice:String = menuItem[curSelected];
	switch (daChoice)
	{
		case 'retry':
			FlxG.resetState();
		case 'exit':
			FlxG.switchState(new FreeplayState());
	}		
}