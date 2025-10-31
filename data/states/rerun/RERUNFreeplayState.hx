import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxAxes;
import funkin.backend.system.Flags;
import funkin.backend.assets.AssetSource;
import funkin.backend.chart.Chart;
import funkin.savedata.FunkinSave;
import flixel.FlxObject;

/**
 * Array containing all of the songs' metadata.
 */
public var songs:Array<ChartMetaData> = [];
/**
 * Current song metadata
 */
public var curSong:Null<ChartMetaData>;
/**
 * Current song difficulties
 */
public var curDifficulties:Array<String>;
/**
 * songs[curSelected].metas.get(curDiffMetaIndices[curDifficulty])
 */
public var curDiffMetaKeys:Array<String> = [];
/**
 * Currently selected song
 */
public var curSelected:Int = 0;
/**
 * Currently selected difficulty
 */
public var curDifficulty:Int = 1;
/**
 * Currently selected coop/opponent mode
 */
public var curCoopMode:Int = 0;
/**
 * Text containing the score info (PERSONAL BEST: 0)
 */
public var scoreText:FlxText;
/**
 * Text containing the current difficulty (< HARD >)
 */
public var diffText:FlxText;
/**
 * Text containing the current coop/opponent mode ([KEYBINDS] Co-Op mode)
 */
public var coopText:FlxText;
/**
 * Currently lerped score. Is updated to go towards `intendedScore`.
 */
public var lerpScore:Float = 0;
/**
 * Destination for the currently lerped score.
 */
public var intendedScore:Int = 0;
/**
 * Assigned FreeplaySonglist item.
 */
public var songList:FreeplaySonglist;
/**
 * Black background around the score, the difficulty text and the co-op text.
 */
public var scoreBG:FlxSprite;
/**
 * Background.
 */
public var bg:FlxSprite;
/**
 * Whenever the player can navigate and select
 */
public var canSelect:Bool = true;
/**
 * Group containing all of the alphabets
 */
public var grpSongs:FlxTypedGroup<Alphabet>;
/**
 * Whenever the currently selected song is playing.
 */
public var curPlaying:Bool = false;
/**
 * Array containing all of the icons.
 */
public var iconArray:Array<HealthIcon> = [];
/**
 * FlxInterpolateColor object for smooth transition between Freeplay colors.
 */
var difficArrows:Array<FlxSprite> = [];
var songarrow:Array<FlxSprite> = [];	
private static var lastDifficultyName:String = '';
var camFollow:FlxObject;
var camFollowPos:FlxObject;
static var lastsong:String;

var colorTween:FlxTween;
var colorTween2:FlxTween;

var songNameTween:FlxTween;



function create() {
    FlxG.sound.playMusic(Paths.music('menus/FPmenu'), 0);
	FlxG.sound.music.fadeIn(2, 0, 0.7);

    songList = FreeplaySonglist.get();
	songs = songList.songs;

    //trace(songs);

	for(k=>s in songs) {
		if (s.displayName == Options.freeplayLastSong) {
			curSelected = k;
		}
	}

	updateCurSong();

    grid = new FlxBackdrop(Paths.image('menus/fp/squares'),FlxAxes.XY);
	grid.scrollFactor.set();
	grid.velocity.x = 20;
	grid.scale.set(2,2);
	grid.active = true;
	add(grid);

	redgradient = new FlxSprite().loadGraphic(Paths.image('menus/fp/grad'));
	redgradient.y = FlxG.height - redgradient.height;
	redgradient.scrollFactor.set();
	redgradient.setGraphicSize(1280);
	redgradient.updateHitbox();
	redgradient.alpha = 0;
	add(redgradient);

	sonicbg = new FlxBackdrop(Paths.image('menus/fp/sonicsonic'),FlxAxes.Y);
	sonicbg.setGraphicSize(0,720);
	sonicbg.updateHitbox();
	sonicbg.scrollFactor.set();
	sonicbg.x = FlxG.width - 510;
	sonicbg.velocity.y = -20;
	sonicbg.active = true;
	add(sonicbg);

	sonicvign = new FlxSprite().loadGraphic(Paths.image('menus/fp/sonicsonic_shadow'));
	sonicvign.setGraphicSize(0,720);
	sonicvign.updateHitbox();
	sonicvign.screenCenter(FlxAxes.Y);
	sonicvign.x = FlxG.width - 510;
	sonicvign.scrollFactor.set();
	add(sonicvign);

	divider = new FlxSprite().loadGraphic(Paths.image('menus/fp/divider'));
	divider.setGraphicSize(0,720);
	divider.updateHitbox();
	divider.screenCenter(FlxAxes.Y);
	divider.scrollFactor.set();
	divider.x = sonicbg.x - 10;
	add(divider);

    tempsong = new FlxText(100,90,0,songs[curSelected].displayName,28);
	tempsong.scrollFactor.set();
	add(tempsong);	

    imggrp = new FlxTypedGroup<FlxSprite>();		
	add(imggrp);

	frame = new FlxSprite(75,40).loadGraphic(Paths.image('menus/fp/border_silverer'));
	frame.scrollFactor.set();
	frame.setGraphicSize(600);
	frame.updateHitbox();
	add(frame);

	// difficbg = new FlxSprite(0,0).loadGraphic(Paths.image('menus/fp/difficulty_bar2'));
	// difficbg.scale.set(0.4,0.4);
	// difficbg.updateHitbox();
	// difficbg.scrollFactor.set();
	// difficbg.x = frame.x + (frame.width - difficbg.width)/2;
	//add(difficbg);

	modelgrp = new FlxTypedGroup<FlxSprite>();
	add(modelgrp);

	scoreText = new FlxText(0, 575 - 10, 0, "", 38);
	scoreText.setFormat(Paths.font("vcr.ttf"), 38, FlxColor.WHITE, 'center');
	scoreText.scrollFactor.set();
	add(scoreText);

	missText = new FlxText(0, 625- 10, 0, "Misses: ", 38);
	missText.setFormat(Paths.font("vcr.ttf"), 38, FlxColor.WHITE, 'center');
	missText.scrollFactor.set();
	//add(missText);

	timeText = new FlxText(0, 675- 10, 0, "Time: ", 38);
	timeText.setFormat(Paths.font("vcr.ttf"), 38, FlxColor.WHITE, 'center');
	timeText.scrollFactor.set();
	//add(timeText);

	diffText = new FlxText(0,32, 0, "", 30);
	diffText.font = Paths.font('NiseGenesis.TTF');
	diffText.scrollFactor.set();
	//add(diffText);

	// var arrowL = new FlxSprite().loadGraphic(Paths.image('menus/fp/arrowD'));
	// arrowL.angle = -90;
	// //add(arrowL);
	// //difficArrows.push(arrowL);

	// var arrowR = new FlxSprite().loadGraphic(Paths.image('menus/fp/arrowD'));
	// arrowR.angle = 90;
	//add(arrowR);
	//difficArrows.push(arrowR);

	//for (i in difficArrows) {
	//	i.scrollFactor.set();
	//	i.y = 40;
	//	i.scale.set(0.5,0.5);
	//	i.updateHitbox();
	//}

	//var arrowU = new FlxSprite().loadGraphic(Paths.image('menus/fp/arrowD'));
	//add(arrowU);
	//songarrow.push(arrowU);
//
	//var arrowD = new FlxSprite().loadGraphic(Paths.image('menus/fp/arrowD'));
	//arrowD.angle = 180;
	//add(arrowD);
	//songarrow.push(arrowD);

	for (i in songarrow) {
		i.scale.set(2,2);
		i.updateHitbox();
		i.x = 250;
	}

	if(curSelected >= songs.length) curSelected = 0;
	sonicbg.color = songs[curSelected].color;
	redgradient.color = songs[curSelected].color;
	intendedColor = sonicbg.color;
	intendedColor = redgradient.color;

	if(curSelected >= songs.length) curSelected = 0;
	if(lastDifficultyName == '')
	{
		lastDifficultyName = CoolUtil.defaultDifficulty;
	}
	//curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));

	//CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
	for (i in 0...songs.length)
	{
		var img:FlxSprite = new FlxSprite(75, 40);
		if(Assets.exists(Paths.image('menus/fp/art/' + songs[i].displayName))){
			img.loadGraphic(Paths.image('menus/fp/art/' + songs[i].displayName));
		}else{
			img.loadGraphic(Paths.image('menus/fp/art/placehold'));
		}
		
		img.setGraphicSize(600,346);
		img.updateHitbox();
		img.scrollFactor.set();
		img.ID = i;
		imggrp.add(img);

		//trace('menus/fp/3d/black/' + songs[i].displayName + 'Freeplay3DBlack');

		//var models = new FlxSprite(0, i * 600);
		//if (FunkinSave.getSongHighscore(songs[i], 'normal').score != 0)
		//	models.frames = Paths.getSparrowAtlas('menus/fp/3d/' + songs[i].displayName + 'Freeplay3D');
//
		//else
		//	models.frames = Paths.getSparrowAtlas('menus/fp/3d/black/' + songs[i].displayName + 'Freeplay3DBlack');
		//
//
		//models.animation.addByPrefix('idle','spin',8);
		//models.animation.play('idle');
		//models.pixelPerfectRender = true; //floombo i stg u better start putting padding on ur spritesheets
		//models.ID = i;
		//modelgrp.add(models);

		/*var songLowercase:String = Paths.formatToSongPath(songs[curSelected].displayName);
		var poop:String = Highscore.formatSong(songLowercase, curDifficulty);
		trace(poop);
		PlayState.SONG = Song.loadFromJson(poop, songLowercase);
		var cad = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song)); //bad causes lag spike
		trace('songlong' + FlxStringUtil.formatTime(Math.floor(cad.length / 1000), false));*/

		
		Paths.currentModDirectory = songs[i].folder;
	}

    camFollow = new FlxObject(0, 0, 1, 1);
	camFollowPos = new FlxObject(0, 0, 1, 1);
	add(camFollow);
	add(camFollowPos);
	FlxG.camera.follow(camFollowPos, null, 1);

    //trace(Options.freeplayLastSong);
    

	// songtitle = new FlxSprite(0,FlxG.height).loadGraphic(Paths.image('menus/fp/names/third_'));
	// songtitle2 = new FlxSprite(0,FlxG.height).loadGraphic(Paths.image('menus/fp/names/party2'));
	// songtitle.setGraphicSize(Std.int(600/1.5));
	// songtitle.updateHitbox();
	// songtitle2.setGraphicSize(Std.int(songtitle.width - 50));
	// songtitle2.updateHitbox();
	// songtitle.scrollFactor.set();
	// songtitle2.scrollFactor.set();
	// add(songtitle);
	// add(songtitle2);
// 
	// title = new FlxSprite(0,FlxG.height).loadGraphic(Paths.image('menus/fp/names/ep_1'));
	// gear = new FlxSprite(0,FlxG.height).loadGraphic(Paths.image('menus/fp/names/ep_gear'));
	// gear.centerOrigin();
// 
	// eyes = new FlxSprite(0,FlxG.height).loadGraphic(Paths.image('menus/fp/names/ep_eyes'));
	// title.scale.set(0.5,0.5);
	// gear.scale.set(0.5,0.5);
	// eyes.scale.set(0.5,0.5);
	// title.updateHitbox();
	// gear.updateHitbox();
	// eyes.updateHitbox();
// 
	// title.scrollFactor.set();
	// gear.scrollFactor.set();
	// eyes.scrollFactor.set();
	// add(title);
	// add(gear);
	// add(eyes);

	songNamePlaceholder = new FlxText(0,32, 0, "", 30);
	songNamePlaceholder.setFormat(Paths.font('NiseGenesis.TTF'), 24, FlxColor.WHITE, 'center');
	songNamePlaceholder.scrollFactor.set();
	songNamePlaceholder.updateHitbox();
	add(songNamePlaceholder);

	powerjackTitle = new FlxSprite(0,FlxG.height).loadGraphic(Paths.image('menus/fp/names/grrsgrgsrgpopwerjack_logo'));
	powerjackTitle.setGraphicSize(Std.int(600/1.0));
	powerjackTitle.updateHitbox();
	powerjackTitle.scrollFactor.set();
	add(powerjackTitle);

	changeSelection(0);
	FlxTween.tween(redgradient, {alpha: 1}, 2, {ease: FlxEase.cubeOut});
}

/*function changeSelection(change:Int = 0, playSound:Bool = true)
{
	if(playSound) FlxG.sound.play(Paths.sound('rerunMenu/scrollMenu'), 0.4);
	curSelected += change;
	if (curSelected < 0)
		curSelected = songs.length - 1;
	if (curSelected >= songs.length)
		curSelected = 0;
	modelgrp.forEach(function (g:FlxSprite) {
		if (g.ID == curSelected) {
			camFollow.setPosition(g.getGraphicMidpoint().x - 390, g.getGraphicMidpoint().y - 25);
			FlxTween.tween(songarrow[0], {y: g.y - 40},0.2, {ease: FlxEase.cubeOut}); //temp
			FlxTween.tween(songarrow[1], {y: g.y + g.height - 50},0.2, {ease: FlxEase.cubeOut});
		}
	});
	var newColor:Int = songs[curSelected].color;
	if(newColor != intendedColor) {
		if(colorTween != null) {
			colorTween.cancel();
			colorTween2.cancel();
		}
		intendedColor = newColor;
		colorTween = FlxTween.color(sonicbg, 0.5, sonicbg.color, intendedColor, {
			onComplete: function(twn:FlxTween) {
				colorTween = null;
			}
		});
		colorTween2 = FlxTween.color(redgradient, 0.5, sonicbg.color, intendedColor, {onComplete: function (twn:FlxTween) {
			colorTween2 = null;
		}});
	}
	imggrp.forEach(function (pic:FlxSprite) {
		if (pic.ID == curSelected) 
			pic.visible = true;
		else
			pic.visible = false;
	});
	#if !switch
	intendedScore = FunkinSave.getSongHighscore(songs[curSelected].displayName, curDifficulty).score;
	intendedRating = FunkinSave.getSongHighscore(songs[curSelected].displayName, curDifficulty).accuracy;
	#end
	Paths.currentModDirectory = songs[curSelected].folder;
	PlayState.storyWeek = songs[curSelected].week;
	CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
	var diffStr:String = WeekData.getCurrentWeek().difficulties;
	if(diffStr != null) diffStr = diffStr.trim(); //Fuck you HTML5
	if(diffStr != null && diffStr.length > 0)
	{
		var diffs:Array<String> = diffStr.split(',');
		var i:Int = diffs.length - 1;
		while (i > 0)
		{
			if(diffs[i] != null)
			{
				diffs[i] = diffs[i].trim();
				if(diffs[i].length < 1) diffs.remove(diffs[i]);
			}
			--i;
		}
		if(diffs.length > 0 && diffs[0].length > 0)
		{
			CoolUtil.difficulties = diffs;
		}
	}
    tempsong.text = songs[curSelected].displayName;
	
	if(CoolUtil.difficulties.contains(CoolUtil.defaultDifficulty))
	{
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)));
	}
	else
	{
		curDifficulty = 0;
	}
	var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
	//trace('Pos of ' + lastDifficultyName + ' is ' + newPos);
	if(newPos > -1)
	{
		curDifficulty = newPos;
	}
	if (lastsong != songs[curSelected].displayName) { //haha what?
		trace('wtf');
	}
	remove(songname);			
	songname = new FreeplaySongNames(songs[curSelected].displayName);
	trace(songname);
	add(songname);
	lastsong = songs[curSelected].displayName;
}*/

function updateCurSong() {
	var song = songs[curSelected];
	if (song == null) curSong = null;
	else if ((curSong = song.metas.get(curDiffMetaKeys[curDifficulty])) == null)
		curSong = song;
}

function update(elapsed:Float){
    var shiftMult:Int = 1;
	if(FlxG.keys.pressed.SHIFT) shiftMult = 3;
    
    var upP = controls.UP_P;
	var downP = controls.DOWN_P;
	var accepted = controls.ACCEPT;
	var space = FlxG.keys.justPressed.SPACE;
	var ctrl = FlxG.keys.justPressed.CONTROL;

    var lerpVal:Float = CoolUtil.bound(elapsed * 7.5, 0, 1);
    camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

    if(songs.length > 1)
	{
		if (upP)
		{
			changeSelection(-shiftMult, true);
			holdTime = 0;
		}
		if (downP)
		{
			changeSelection(shiftMult, true);
			holdTime = 0;
		}

		if(controls.UI_DOWN || controls.UI_UP)
		{
			var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
			holdTime += elapsed;
			var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

			if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
			{
				changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
				//changeDiff();
			}
		}

		if(FlxG.mouse.wheel != 0)
		{
			FlxG.sound.play(Paths.sound('rerunMenu/scrollMenu'), 0.2);
			changeSelection(-shiftMult * FlxG.mouse.wheel, false);
			//changeDiff();
		}
	}
    if (controls.BACK)
	{
        if(colorTween != null) {
			colorTween.cancel();
		}
		FlxG.sound.play(Paths.sound('rerunMenu/cancelMenu'));
		FlxG.switchState(new MainMenuState());
	}
    if (accepted)
	{
		//persistentUpdate = false;
		PlayState.loadSong(songs[curSelected].displayName, 'normal');
		FlxG.switchState(new PlayState());
	}

	switch (songs[curSelected].displayName) {
		case 'Enterprice':
			if (!tes2) {
				tes2 = true;
				new FlxTimer().start(0.1, function (t:FlxTimer) {
					tes2 = false;
					gear.angle += 5;

				});
			}
		case '':
	}

}
function changeSelection(change:Int = 0, playSound:Bool = true)
{
	if(playSound) FlxG.sound.play(Paths.sound('rerunMenu/scrollMenu'), 0.4);
	curSelected += change;
	if (curSelected < 0)
		curSelected = songs.length - 1;
	if (curSelected >= songs.length)
		curSelected = 0;
	modelgrp.forEach(function (g:FlxSprite) {
		if (g.ID == curSelected) {
            camFollow.x = g.getGraphicMidpoint().x - 390;
            camFollow.y = g.getGraphicMidpoint().y - 25;
			FlxTween.tween(songarrow[0], {y: g.y - 40},0.2, {ease: FlxEase.cubeOut}); //temp
			FlxTween.tween(songarrow[1], {y: g.y + g.height - 50},0.2, {ease: FlxEase.cubeOut});
		}
	});
    tempsong.text = songs[curSelected].displayName;
	var newColor:Int = songs[curSelected].color;
	if(newColor != intendedColor) {
		if(colorTween != null) {
			colorTween.cancel();
			colorTween2.cancel();
		}
		intendedColor = newColor;
		colorTween = FlxTween.color(sonicbg, 0.5, sonicbg.color, intendedColor, {
			onComplete: function(twn:FlxTween) {
				colorTween = null;
			}
		});
		colorTween2 = FlxTween.color(redgradient, 0.5, sonicbg.color, intendedColor, {onComplete: function (twn:FlxTween) {
			colorTween2 = null;
		}});
	}
	imggrp.forEach(function (pic:FlxSprite) {
		if (pic.ID == curSelected) 
			pic.visible = true;
		else
			pic.visible = false;
	});
	#if !switch
	intendedScore = FunkinSave.getSongHighscore(songs[curSelected].displayName, curDifficulty).score;
	intendedRating = FunkinSave.getSongHighscore(songs[curSelected].displayName, curDifficulty).accuracy;
	#end
	Paths.currentModDirectory = songs[curSelected].folder;
	PlayState.storyWeek = songs[curSelected].week;

	if (lastsong != songs[curSelected].displayName) { //haha what?
		trace('wtf');
	}
	//remove(songname);			
	//songname = new FreeplaySongNames(songs[curSelected].displayName);
	//add(songname);
	lastsong = songs[curSelected].displayName;

	songTitleChange(songs[curSelected].displayName);

    Options.freeplayLastSong = songs[curSelected].displayName;
}

var framex:Float = 75;
var framewth:Float = 600;
var frameheight:Float = 352;
var gear:FlxSprite;
var tes2 = false;

function songTitleChange(songNameSet){
	powerjackTitle.visible = false;
	songNamePlaceholder.visible = false;
	if(!songNameTween == null){
		songNameTween.stop();
	}
	
	switch (songNameSet) {
		case 'Powerjack':
			powerjackTitle.visible = true;
			powerjackTitle.setPosition(0,FlxG.height);
			songNameTween = FlxTween.tween(powerjackTitle, {y: frameheight + 58},0.2, {ease: FlxEase.expoOut});
			powerjackTitle.x = framex + (framewth - powerjackTitle.width)/2;
		default :
			songNamePlaceholder.visible = true;
			songNamePlaceholder.text = songNameSet;
			songNamePlaceholder.updateHitbox();
			songNamePlaceholder.setPosition(0,FlxG.height);
			songNameTween = FlxTween.tween(songNamePlaceholder, {y: frameheight + 100},0.4, {ease: FlxEase.expoOut});
			songNamePlaceholder.x = framex + (framewth - songNamePlaceholder.width)/2;
	}
}

class FreeplaySonglist {
	public var songs:Array<ChartMetaData> = [];

	public function new() {}

	public function getSongsFromSource(source:funkin.backend.assets.AssetSource, useTxt:Bool = true) {
		var songsFound:Array<String> = null;
		if (useTxt) {
			var oldPath = Paths.txt('freeplaySonglist');
			var newPath = Paths.txt('config/freeplaySonglist');
			if (Paths.assetsTree.existsSpecific(newPath, "TEXT", source)) songsFound = CoolUtil.coolTextFile(newPath);
			else if (Paths.assetsTree.existsSpecific(oldPath, "TEXT", source)) {
				Logs.warn("data/freeplaySonglist.txt is deprecated and will be removed in the future. Please move the file to data/config/", DARKYELLOW, "FreeplaySonglist");
				songsFound = CoolUtil.coolTextFile(oldPath);
			}
		}
		if (songsFound == null) songsFound = Paths.getFolderDirectories("songs", false, source);
		if (songsFound.length > 0) {
			for (s in songsFound) songs.push(Chart.loadChartMeta(s, source == AssetSource.fromString('mods')));
			return false;
		}
		return true;
	}

	public static function get(useTxt:Bool = true) {
		var songList = new FreeplaySonglist();

		switch(Flags.SONGS_LIST_MOD_MODE) {
			case 'prepend':
				songList.getSongsFromSource(AssetSource.fromString('mods'), useTxt);
				songList.getSongsFromSource(AssetSource.fromString('source'), useTxt);
			case 'append':
				songList.getSongsFromSource(AssetSource.fromString('source'), useTxt);
				songList.getSongsFromSource(AssetSource.fromString('mods'), useTxt);
			default /*case 'override'*/:
				if (songList.getSongsFromSource(AssetSource.fromString('mods'), useTxt))
					songList.getSongsFromSource(AssetSource.fromString('source'), useTxt);
		}

		return songList;
	}
}