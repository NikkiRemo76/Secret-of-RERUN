import flixel.ui.FlxBar;
import flixel.text.FlxTextBorderStyle;

var ratingFC:String = '';

var sicks:Int = 0;
var goods:Int = 0;
var bads:Int = 0;
var shits:Int = 0;

var scoreTxtTween:FlxTween;

var songName = PlayState.SONG.meta.displayName;

function postCreate(){
    for(i in [healthBar, healthBarBG, scoreTxt, missesTxt, accuracyTxt, iconP1]) remove(i);
    doIconBop = false;

    rerunBarBG = new FlxSprite(24, 571.5).loadGraphic(Paths.image('game/ui/healthBars/'+songName+'/hpframe'));
    rerunBarBG.camera = camHUD;
    rerunBarBG.y -= 75/2;

    healthBar = new FlxBar(rerunBarBG.x + 65, rerunBarBG.y + 109, FlxBar.LEFT_TO_RIGHT, 561, 29, this, 'health', 0, maxHealth);
    healthBar.createImageBar(Paths.image('game/ui/healthBars/'+songName+'/empty'), Paths.image('game/ui/healthBars/'+songName+'/fill'));
    healthBar.camera = camHUD;
    healthBar.numDivisions = 400;
    healthBar.updateHitbox();

    scoreTxt2 = new FlxText(healthBar.x + 70, rerunBarBG.y + 47, 0, "S: 0 | M: 0 | R: ?", 20);
    scoreTxt2.setFormat(Paths.font("NiseSegaSonic.ttf"), 20, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    scoreTxt2.camera = camHUD;
    scoreTxt2.borderSize = 1.25;

    add(healthBar);
    add(rerunBarBG);
    add(scoreTxt2);

    healthBar.antialiasing = true;
    rerunBarBG.antialiasing = true;
    scoreTxt2.antialiasing = true;
}

function update(elapsed:Float) {
    rerunBarBG.alpha = healthBarBG.alpha;
    healthBar.alpha = healthBarBG.alpha;
    scoreTxt2.alpha = scoreTxt.alpha;
}

function onPlayerHit(_){
    if(!_.note.isSustainNote){
        var hitWindow = Options.hitWindow;
        var noteDiff = Math.abs(Conductor.songPosition - _.note.strumTime);

        if (noteDiff > hitWindow * 0.9)
        {
            shits += 1;
        }
        else if (noteDiff > hitWindow * 0.75)
        {
            bads += 1;
        }
        else if (noteDiff > hitWindow * 0.2)
        {
            goods += 1;
        }
        else if (noteDiff < hitWindow * 0.2)
        {
            sicks += 1;
        }
    }

}

function postUpdate(){
    iconP2.scale.set(lerp(iconP2.scale.x, 0.6, 0.33), lerp(iconP2.scale.y ,0.6, 0.33));
    iconP2.setPosition(healthBar.x - 57, healthBar.y - 85);
}

function onRatingUpdate(){
    if (sicks > 0) ratingFC = "SFC";
    if (goods > 0) ratingFC = "GFC";
    if (bads > 0 || shits > 0) ratingFC = "FC";
    if (misses > 0 && misses < 10) ratingFC = "SDCB";
    else if (misses >= 10) ratingFC = "Clear";

    scoreTxt2.text = 'S: ' + songScore
    + ' | M: ' + misses
    + ' | R: ' + (accuracy < 0 ? '?' : "(" + CoolUtil.quantize(accuracy * 100, 100) + "%) - " + ratingFC);

    if(scoreTxtTween != null) scoreTxtTween.cancel();
    scoreTxt2.scale.x = 1.075;
    scoreTxt2.scale.y = 1.075;
    scoreTxtTween = FlxTween.tween(scoreTxt2.scale, {x: 1, y: 1}, 0.2);
}

function onDadHit() iconP2.scale.set(0.8, 0.8);

function beatHit() iconP2.scale.set(0.8, 0.8);